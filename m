Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD93ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C062086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1wof77b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C062086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeKIAMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:12:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37672 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeKIAMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:12:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so1414734wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pjzuvui9d85lC6ebp/JjM8l8T1XFTIxfHxdlRMSnSU=;
        b=g1wof77b/ahW159tl/OaMLW0P96a0/zVeZFYRh5g6v6wbToBXd28iFvOASCK8yKV5Y
         xHNqterZqD2KmkFcVcFGm+gkEQeG54Jf/H+takvz8wjdH3wdoMPjV1aR/aoFl8xbW+mR
         3CDZOO7tD7iSEUdTMb+jOu+oyFpmUCbQR6pdxco9Vh1tL70iQ5jUycXJ0G3WmOgyULXv
         HP7R7bmaLmZ4EHXVI9J9sCIzpUalSy8bFlzRzUf2kwtLgyxlzPRWUrnL1K4XN9LUvolW
         Y96dsy0e/tD1Mz+ow6abkTbXTuAvzZ6CsMX4iIrftNJRgkfaRW/cIVRWqwbUc26iosdQ
         6XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pjzuvui9d85lC6ebp/JjM8l8T1XFTIxfHxdlRMSnSU=;
        b=Qly5a8xHOVfp2OHUU31XvXr8JDRpNSFqlWawrXPmDKq9fZKTafWStqNMOn/Pk8ScwZ
         qnnpPnZRoMYTKfo3AOkzoq1agE1yuy4pE8NRghGEWj4Syj1Fh4IUQOHLaWsS2lAy38DG
         08ndrIPQqKCRZRVlKY7duZe9L1cIeJMiwHRA6lrauJ0fP0bU9vB1/Zfks6jnImDn77a1
         4smQd4C5gFn+zXdHYgNxjLTXse+I6EsOu5qz7O9E10X04mKI6hdddEw5Nrz98KOPpYBJ
         jX0guKBwTT08iiWWdFwCoAJ7o8Zv+v5UcSRguSkLK2F5Yr/y9G85IIcteR8+lSFQIMc5
         Ec7g==
X-Gm-Message-State: AGRZ1gLzV7ndu2uGZKw8aAc1EsCkfBoHABdnyH7Mw7Ee31gDFsXdZOui
        hSRAW9yat9ztKvtTaLBiTOOG7MBYRCIG4A==
X-Google-Smtp-Source: AJdET5fJjnrcqJrwZDIF+kL6S1eyNF+VEauTvj/4nlfwZhoIa13mwXNXonwu4vWqr6lN/+fSYDs+KQ==
X-Received: by 2002:a1c:13d2:: with SMTP id 201-v6mr1411054wmt.58.1541687782962;
        Thu, 08 Nov 2018 06:36:22 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id k5-v6sm5421068wre.82.2018.11.08.06.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 06:36:22 -0800 (PST)
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
Subject: [PATCH v8 2/8] uaccess: add untagged_addr definition for other arches
Date:   Thu,  8 Nov 2018 15:36:09 +0100
Message-Id: <c9028422854fb5bfb79d798397b30d4701207062.1541687720.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
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
2.19.1.930.g4563a0d9d0-goog

