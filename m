Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CBAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4680B21532
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gdBsyed4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4680B21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeHIXKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:10:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45383 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHIXKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:10:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id f1-v6so3272501pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=CezYSWzNaDDeey7Nlq6gOe6nDCywDj5HS206DSSdmUY=;
        b=gdBsyed4mocE72r69d8VYo0YKc3oo55/oeql/XUwbP/BvRX1x71IkDbN+z5ByQdMWa
         XyzaDmlETp08tzthr8VuaZKhghggmgwKef24GjKL94hOEc9iwVufeyVH9ZUamyn+WW6H
         Ziv19bd+boM8VgGc4P0onXKEgxR9vXaxwyipDdQ2D/1VkQaNKYM3YjMivR37isY73iTj
         8dsUhSPpup/s42D9iCVxdQ8lyk9SLdJGzV5ITpefiTAWtGjDnTs+5QGoPEkx8tioKtyk
         51TwjPKSaS+C1dZdBS7TEBg+28e5axKMaexriHVFjsnwe3OssDctNM19XWHtIyxaQecc
         eB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=CezYSWzNaDDeey7Nlq6gOe6nDCywDj5HS206DSSdmUY=;
        b=e9Gl28bF693mhAqiXIM2Wbi/vqw9yQ7+xHZgNMzKWOqX1IZJuVrc3P9so4pxja8nJw
         KRrcdJZd4mi0PEVWPTTtdjbq6TVlQvF52RQjKxIzzRSw0gntFounwdj8u1OLprQF1OUl
         3mYXn9ATpglSSPqGgyo9i9ZRYV4VvNdhcxWn1zEP/gIEvj6ZKAriQ5DpI9NHIe+zTlNi
         o4O3LBowyfck8ndR3Ui+yT/MypKjRSGkO/+CT/hGhbnYapBiRmopXWiQLqMyl5PEGVZ8
         gvpK4cu5tFugrCMjTTzKm0YsFQZj9C7T8OhYAVHsZcFvGbqJbfpC7m53AyKuX11KVVt+
         ereA==
X-Gm-Message-State: AOUpUlFJfoUL7TlhNuJLnCPJ1jNRWjbfHSzmc5pUJvWPsiqiur4IzhF7
        9sOxbvkVT5Zv1AF3xEkp2Bsoxg==
X-Google-Smtp-Source: AA+uWPxzXI9zt6a9H3EY1mMKjFZvjZ1hqNzNJXXAtidmoCA4cyYlyfOWvT63jZmzf9XmCj2XvaDtZQ==
X-Received: by 2002:a63:5a5e:: with SMTP id k30-v6mr3615282pgm.123.1533847421076;
        Thu, 09 Aug 2018 13:43:41 -0700 (PDT)
Received: from localhost ([96.76.210.210])
        by smtp.gmail.com with ESMTPSA id g5-v6sm13831138pfc.77.2018.08.09.13.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:43:39 -0700 (PDT)
Subject: [PATCH v2 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Date:   Thu,  9 Aug 2018 13:25:23 -0700
Message-Id: <20180809202524.1702-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180809202524.1702-1-palmer@sifive.com>
References: <20180809202524.1702-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This would be necessary to make non-SMP builds work, but there is
another error in the implementation of our syscall linkage that actually
just causes sys_riscv_flush_icache to never build.  I've build tested
this on allnoconfig and allnoconfig+SMP=y, as well as defconfig like
normal.

CC: Christoph Hellwig <hch@infradead.org>
CC: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20180809055830.GA17533@infradead.org>
In-Reply-To: <20180809132612.GA31058@roeck-us.net>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/vdso.h |  2 --
 arch/riscv/kernel/sys_riscv.c | 10 ++++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 541544d64c33..ec6180a4b55d 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -38,8 +38,6 @@ struct vdso_data {
 	(void __user *)((unsigned long)(base) + __vdso_##name);			\
 })
 
-#ifdef CONFIG_SMP
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
-#endif
 
 #endif /* _ASM_RISCV_VDSO_H */
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index f7181ed8aafc..180da8d4e14a 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -48,7 +48,6 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 }
 #endif /* !CONFIG_64BIT */
 
-#ifdef CONFIG_SMP
 /*
  * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
  * having a direct 'fence.i' instruction available to userspace (which we
@@ -66,15 +65,22 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
 	uintptr_t, flags)
 {
+#ifdef CONFIG_SMP
 	struct mm_struct *mm = current->mm;
 	bool local = (flags & SYS_RISCV_FLUSH_ICACHE_LOCAL) != 0;
+#endif
 
 	/* Check the reserved flags. */
 	if (unlikely(flags & ~SYS_RISCV_FLUSH_ICACHE_ALL))
 		return -EINVAL;
 
+	/*
+	 * Without CONFIG_SMP flush_icache_mm is a NOP, which generates unused
+	 * variable warnings all over this function.
+	 */
+#ifdef CONFIG_SMP
 	flush_icache_mm(mm, local);
+#endif
 
 	return 0;
 }
-#endif
-- 
2.16.4

