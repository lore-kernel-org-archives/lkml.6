Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B09C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F35206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVK2wJsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F35206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJBT4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43287 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJBT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so2160331wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cq3vN6aPcQwtnG7Yk3tP2XwC690M9TeiFA6EGKo+spg=;
        b=wVK2wJsBGU5FIzxsuMJcgTdTL10q6LtoeL+UENspJKFgA0RDNTzi9Wn5gAyDr+6Szv
         RncY5kWukrU8NwSkp4uPffTL6eb+JtiBGH/Jp80QDfaMmzXGUpB7izMO5ZlGKrJ/c+NM
         S3mjkFvCJ3ABkch+sQLZcNPA/SdENdR9ieF/M8THE6aUPYbQYb7DD3n9cIvpFuI7qLT3
         +ZUu1kES5j/a2JYULJs6Ry0XZ+RqRXQI2jOIg5lPqOT26QlkW3W+kKGlm1f1B+9coovo
         V0zbhgSer4xnymtNsXnnPFCfur591TOZxRATREyyigBwTz3+tXsZi3uIwP51Q2Zc36uq
         h/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cq3vN6aPcQwtnG7Yk3tP2XwC690M9TeiFA6EGKo+spg=;
        b=Jtvj0Djov+gFVtt5ZOnMkdwqj56siPc0EdYd6lDwxDdvi17lTMjroPnOuqz7dmI29V
         B/JjGilw/GxrTm7We5vhN80WqsFS1qOHgsIZkl9GiJ6iDlBnpkevDDWo+CiqT4ImJ5Zt
         l8Z3fF/EsP/5bpBoW4eMN1+yQB2in70TfV6CUkXEEswXNhd174WYHw3gHOmWiA5Rkz0D
         546ak5nRdEbFDs15oX6o8dezhkvMbsNTOJZeupFh+bHqvxnr0ospdKvLSZxDTAXOGyCc
         WkuNbkC57taruazOYivRA+HBRvhjWVmbp3EDQUOzyDBTHNBi3w0qCINEEgPWVPAimbeh
         rM3Q==
X-Gm-Message-State: ABuFfohWDYIdyitpEsbovyyB/OiC2r0jgsYYPrYlitK3PAUJ/x92lyPe
        y/Fm+FjcMmmV/QqvHvvYagtbLw==
X-Google-Smtp-Source: ACcGV62AocYuBthFf3RuZ7M7TITSn4vXXnPKZ8bb2eLezWn89dGEtVrCS/4KW1hgHo/fTVInkvsQ6Q==
X-Received: by 2002:adf:db8e:: with SMTP id u14-v6mr10999323wri.217.1538485969081;
        Tue, 02 Oct 2018 06:12:49 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id v10-v6sm17458681wrp.0.2018.10.02.06.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 06:12:48 -0700 (PDT)
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
Subject: [PATCH v7 2/8] uaccess: add untagged_addr definition for other arches
Date:   Tue,  2 Oct 2018 15:12:37 +0200
Message-Id: <1ff6af9a9ab1f716d0ecbfcfe6788a02e21b7480.1538485901.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow arm64 syscalls accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel, the untagged_addr macro needs to be defined
for all architectures.

Define it as a noop for other architectures besides arm64.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..c045b4eff95e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -13,6 +13,10 @@
 
 #include <asm/uaccess.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) addr
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
-- 
2.19.0.605.g01d371f741-goog

