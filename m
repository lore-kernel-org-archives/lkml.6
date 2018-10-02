Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D84C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A62206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNXdbbDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A62206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeJBT41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35721 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeJBT4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so2183356wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNEOFJA3qECaqXrpJm2EBhk28wiALQ2kw33CEUTdhdg=;
        b=nNXdbbDg2VNy5SHxXbN+Ptyr1KLwmnSsBGGhJxCoeFHxmaR8fTh5dfCJuPuP2R7XcN
         027ftARciHcerS2ELQQ0Z978f0Ec52kSHFCKqN2p00S/HUmL+4/+FNQ+Ee04V1jiecR8
         HhckI+hYniaDUvRkL6ovrPKMPRzVpN0yqJRFIQYoJAbvkk98v1trRnIA9bACjz2T0htl
         sjhh3se+0ylvvlL4j4oFlIEkdCL/ALFEN07VsuQFmvaytb4hkV7XgiiEkG2pDFVbjLFm
         LQf987ZWYE7Z3lM2zVMpcuPdTXS7FNh6OcL7SSEDcP9l9TyEXua3IFp0e1iBvQrZGJ4M
         iEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNEOFJA3qECaqXrpJm2EBhk28wiALQ2kw33CEUTdhdg=;
        b=BU7ookjCaTt+2QFUNYNrirthO/qSJBPRpGhGc0BEjhMKCQQz8YuAYjrguGlDk+GoB5
         6ZUO0xGKGjBGarPbVcJj3IQjEhfCtN99RkjyufVAZli9yvBZTWQfQHbJ1WjJIlDBRCS+
         UnV0Q5YRJOcR44m8jut6W/8HjH1htW0GAYIGXePKrG7fmvwGXYxOR+Q2hvTeEEUJ9DT4
         91+8HrLK9Vru9wm+RxF3NdG9YARmKY3oPJ8hxdFxSH9dmc3JgaO0kqrIDQbC00hs/FF7
         86pfFQ3/ggfFWzuta/pFlSvOOaEJgVg3yLwQAfZdffw66nw01XNTaY+hY11zaWy4+L/d
         jHWA==
X-Gm-Message-State: ABuFfoig2LREefn9WRB8hXmNY38vOkKgkpPaBgyusid4EWorAmKEfOzI
        JK/+SqtRvkBdcOkH7FK99J7m7Q==
X-Google-Smtp-Source: ACcGV62jbjfhc53LoCFPGDSIPFzkIzlh2/mWrosWETT93RgqVUF8Im7cl/cWkkH9GjoPBnJtS3XIfQ==
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr11253044wrb.283.1538485976256;
        Tue, 02 Oct 2018 06:12:56 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id v10-v6sm17458681wrp.0.2018.10.02.06.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 06:12:55 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v7 7/8] arm64: update Documentation/arm64/tagged-pointers.txt
Date:   Tue,  2 Oct 2018 15:12:42 +0200
Message-Id: <47a464307d4df3c0cb65f88d1fe83f9a741dd74b.1538485901.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the changes in Documentation/arm64/tagged-pointers.txt.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..ae877d185fdb 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -17,13 +17,21 @@ this byte for application use.
 Passing tagged addresses to the kernel
 --------------------------------------
 
-All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+Some initial work for supporting non-zero address tags passed to the
+kernel has been done. As of now, the kernel supports tags in:
 
-This includes, but is not limited to, addresses found in:
+  - user fault addresses
 
- - pointer arguments to system calls, including pointers in structures
-   passed to system calls,
+  - pointer arguments (including pointers in structures), which don't
+    describe virtual memory ranges, passed to system calls
+
+All other interpretations of userspace memory addresses by the kernel
+assume an address tag of 0x00. This includes, but is not limited to,
+addresses found in:
+
+ - pointer arguments (including pointers in structures), which describe
+   virtual memory ranges, passed to memory system calls (mmap, mprotect,
+   etc.)
 
  - the stack pointer (sp), e.g. when interpreting it to deliver a
    signal,
@@ -33,11 +41,7 @@ This includes, but is not limited to, addresses found in:
 
 Using non-zero address tags in any of these locations may result in an
 error code being returned, a (fatal) signal being raised, or other modes
-of failure.
-
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
-strongly discouraged.
+of failure. Using a non-zero address tag for sp is strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
 address tags may suffer impaired or inaccurate debug and profiling
-- 
2.19.0.605.g01d371f741-goog

