Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F0C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8CA2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPvhzGMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8CA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeLDMSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:18:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42147 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbeLDMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:18:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so14687990lja.9;
        Tue, 04 Dec 2018 04:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=T87JHThg7UO8QeA5V6fJftPPsz9yV1R5uLnw0cNr6IE=;
        b=TPvhzGMmuAy/Jp0MHlJaRrPY46SLLw9OCFu9x7y/7C3iLUWX6sx/58dG6VOnI9s+ii
         elacBrNvCv7bx6l6EpThFnTO1lCV5SGekhd1Rar+rEZeAsjGZG1rQgPJNAlpCG71eM/v
         g8HlTY1izmemrME/+NCDkGwZlyvNt7t/tAL+hhlDXceESY/ixa8cMheISX7krODoVRWi
         ivJSQ6f77thNBnNHiBa+rk2q22S/tvNKKkKNiS7pFv0accHWmF67oZwooIUS14bReL7d
         ZiT4VfsSj2pWQPKZc8Iz9bV2UxNpoteV0gCwF5BTUvU65TPJ5woU9c+oJ+7s3SUHY4hq
         HekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=T87JHThg7UO8QeA5V6fJftPPsz9yV1R5uLnw0cNr6IE=;
        b=gnGwFc5gyM0xnyy7TjW5PI4R49wi8fOGIDxWrbauWzxIR3PcoOK+xLyT9D3MFgOtbp
         7ZwjQE2Mg0TqE+5izctHm2/XKoIriZvWP6vbyKo0+4wyxuIfptGUCRJWo67LtwUV1OBG
         R175fNMiR2AVw1C/ElrP17hEcMyidT6fEyG7JmFL1gNaLKXWPt5RALFNmxzeNUFCZC6X
         xuhOjjDn2o9t+eds4BcMDxHP1yfTwQaSzkuOy+WeavUPRV6WwP2S/b1xyCsRwln36NXx
         XsHaas7wDl/+B283mQSprUED9tHeEayC84oJEE/ErNttrjY0aQAn6XC3T982UhgJ1G+H
         vApw==
X-Gm-Message-State: AA+aEWZ6NseDzl2JvOjJUwb4Dl/e3qD0rFrs7DsvrvjNnUApF8C33bEA
        oa71clUtuqvXcM/4IktYwlc=
X-Google-Smtp-Source: AFSGD/XfqQYN3wQyhBnGHV3cFZdJapmpbdPk784/DsTCfqnFrfRkG3qqaeqi2sFbGQh+z65PmwJTYA==
X-Received: by 2002:a2e:12d0:: with SMTP id 77-v6mr1051581ljs.132.1543925921312;
        Tue, 04 Dec 2018 04:18:41 -0800 (PST)
Received: from localhost.localdomain (91-156-179-117.elisa-laajakaista.fi. [91.156.179.117])
        by smtp.gmail.com with ESMTPSA id h3sm2899653lfj.25.2018.12.04.04.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 04:18:40 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] __wr_after_init: linker section and label
Date:   Tue,  4 Dec 2018 14:18:00 +0200
Message-Id: <20181204121805.4621-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204121805.4621-1-igor.stoppa@huawei.com>
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a section and a label for statically allocated write rare
data. The label is named "__wr_after_init".
As the name implies, after the init phase is completed, this section
will be modifiable only by invoking write rare functions.
The section must take up a set of full pages.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++++
 include/linux/cache.h             | 17 +++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..b711dbe6999f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -311,6 +311,25 @@
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
+/*
+ * Allow architectures to handle wr_after_init data on their
+ * own by defining an empty WR_AFTER_INIT_DATA.
+ * However, it's important that pages containing WR_RARE data do not
+ * hold anything else, to avoid both accidentally unprotecting something
+ * that is supposed to stay read-only all the time and also to protect
+ * something else that is supposed to be writeable all the time.
+ */
+#ifndef WR_AFTER_INIT_DATA
+#define WR_AFTER_INIT_DATA(align)					\
+	. = ALIGN(PAGE_SIZE);						\
+	__start_wr_after_init = .;					\
+	. = ALIGN(align);						\
+	*(.data..wr_after_init)						\
+	. = ALIGN(PAGE_SIZE);						\
+	__end_wr_after_init = .;					\
+	. = ALIGN(align);
+#endif
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -332,6 +351,7 @@
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
+		WR_AFTER_INIT_DATA(align) /* wr after init */	\
 		KEEP(*(__vermagic))	/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
diff --git a/include/linux/cache.h b/include/linux/cache.h
index 750621e41d1c..9a7e7134b887 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -31,6 +31,23 @@
 #define __ro_after_init __attribute__((__section__(".data..ro_after_init")))
 #endif
 
+/*
+ * __wr_after_init is used to mark objects that cannot be modified
+ * directly after init (i.e. after mark_rodata_ro() has been called).
+ * These objects become effectively read-only, from the perspective of
+ * performing a direct write, like a variable assignment.
+ * However, they can be altered through a dedicated function.
+ * It is intended for those objects which are occasionally modified after
+ * init, however they are modified so seldomly, that the extra cost from
+ * the indirect modification is either negligible or worth paying, for the
+ * sake of the protection gained.
+ */
+#ifndef __wr_after_init
+#define __wr_after_init \
+		__attribute__((__section__(".data..wr_after_init")))
+#endif
+
+
 #ifndef ____cacheline_aligned
 #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
 #endif
-- 
2.19.1

