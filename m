Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ABDC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9D22075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYU37E3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9D22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeJXGBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41128 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeJXGBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id c16so2330434lfj.8;
        Tue, 23 Oct 2018 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=zu6YpzsO3OPxEg4tClPcjQ9+ceDNkNmVTbJmyduztxw=;
        b=IYU37E3Goc1gepM+z7hog9RH6DIyAowZ3kap0+WnwznOQYEPQmswmAxSGL4JWRQEyS
         CVrhUhp6EhYzB/yceyWg6J016IiEWahMGlmmJJMR8SB9NsCkUaysR15IMkJiU9XU5A4x
         MYbPNGz5r322XE/6vXeNUMLtZBrdp5hnW7p6Gu6ioi4MnKP5t0mRajj05ORcpQyv+vrY
         Z6ynoOqJzxtr0/3c7DGuoeWYCgLGwyy1UvRU4MZvg/8f07ITGGyeJcCceomGyRisd/Gm
         odqfJ5zXkKMEu4gInslFJueixysz3Std4Mztz2zYPYKLbOawgJ0QCO9GrluxawhCBR6S
         qfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=zu6YpzsO3OPxEg4tClPcjQ9+ceDNkNmVTbJmyduztxw=;
        b=crftDCqQwhJ+0wIzD2LLL7RmapJSlutlzFJ1oBrFX42OUkPTfTs9sl0IIMIt4jLIKU
         9pSA9Y8WNekCPvSEt9rIBpP9eJhoFrctByxsQ4O9J+3ILVS2hmtj3qzaqwUCZ34crpkH
         xIMDxowFGdIlfc6yVXn7i/amNiNzKCNBemwmj++evZY1IMEl2izpBjYI0Fzl6zkvXVCl
         Z4z844S4CGH42VV3HH11UEFL+/Ysbyenkpoumg3M6iIOxN1oJFgPJZxM98E1vAn9r8UK
         /g1DkbPMo0fF0+/ytJv8ukrDgq0EmsAEpQisVhJlGWCf+cuvY4FPikik2iLjz7E59wAm
         mGvg==
X-Gm-Message-State: ABuFfojuUOw8daixpmtVrKz1fJUULBo9vKZ3CVZ1jzMmdnsSF7u1HoXw
        4wZiIQEdWVIYXVIrzrYPHiM=
X-Google-Smtp-Source: ACcGV60Pq7KtfnwIP2lKFjHQF4lR+JAvWyiJuqcEsOhPvZE+obfCKGmgt17NFjnFkz3993bVkhoNew==
X-Received: by 2002:a19:690d:: with SMTP id e13mr9045976lfc.84.1540330558395;
        Tue, 23 Oct 2018 14:35:58 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:35:57 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] prmem: linker section for static write rare
Date:   Wed, 24 Oct 2018 00:34:48 +0300
Message-Id: <20181023213504.28905-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a section and a label for statically allocated write rare
data.

The label is named "__write_rare_after_init".
As the name implies, after the init phase is completed, this section
will be modifiable only by invoking write rare functions.

NOTE:
this needs rework, because the current write-rare mechanism works
only on x86_64 and not arm64, due to arm64 mappings.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: linux-arch@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++++
 include/linux/cache.h             | 17 +++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d7701d466b60..fd40a15e3b24 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -300,6 +300,25 @@
 	. = __start_init_task + THREAD_SIZE;				\
 	__end_init_task = .;
 
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
@@ -320,6 +339,7 @@
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
2.17.1

