Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC59CC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831062239C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZLKfodpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831062239C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHJBB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:01:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34738 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeHJBB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:01:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so3533144pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=o4H4JUA/I/YuFlf4T8T0G4dpIKpDacxMwA900eev+NM=;
        b=ZLKfodpEU8crr1rla7YQ1KfYGztUL6jqaimhknSMMdLwSEWECK4a00S93Bd1K5lM3+
         Py9XbwIOw3/aMwy2GIFGZZKaiuJcfji9bHMf7CwW8c85IHu+38H/dUdKcXZwtVd9e4zD
         N7KiIe1PVOnzYdVH/HA+LCcpF7Gz+qUlRxXtfH4fmTHY2Hi8tMQvM2EjjzwsMRGh89mQ
         7oSqR+az7+gEe/NeB9cIbGGlmh/OvGhCM6Et59yQHyQz/VELs7IFYMvRY53hLeYms8hg
         vL8o3HwxQyQsT4Ti0DWJ0dRB+66zUXmqyrHO9o/vUnWfDqD7KINip+Sk5hYFKLZIaZHO
         ELeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=o4H4JUA/I/YuFlf4T8T0G4dpIKpDacxMwA900eev+NM=;
        b=ubSGPYe80/f3ksf3dFwWbrfHJ6+U2cLSoY5aZkbiPZeYoVZfW+p8KjGoe67OLmbFh1
         fIyZi6GpEaJgQxS3d2zOBueBSM592GCI5Ty8eFpXEG9GToGqa0UCqN98obfAPVi5zcSU
         0zEc8flnSHUKUdDEUUTDHdGtCx1w1iI1KST/UT1pX43eBNuw2+vpkH7BgcENYfWWfZZp
         oU8YyVFO5AMYrTTNx5EIUHAQuwdSUOYSLnVr5GmGC6qt938oo9uifGUP6AX/OpknEUB0
         CzYIoW6oYXBCAHJYtOsmspELkRFEpkyWcLkbHQim+D6rKEoeZjc36Mb5qnsk4lJNH5DL
         +8Eg==
X-Gm-Message-State: AOUpUlEX3MoLgeQ6KbbsiPhxFg3zgRL12404CoXjNr9WzWTRpUCSb9WC
        nXa8pRNB72DfdbLhPE22N28IhQ==
X-Google-Smtp-Source: AA+uWPzUgZLpghRZ8+axtECkqCO3+fA6Anqv4eie3dQk8qmOka8IWizUisbbep5aJl3gqJzHRiTQ6A==
X-Received: by 2002:a62:4704:: with SMTP id u4-v6mr4210867pfa.76.1533854071081;
        Thu, 09 Aug 2018 15:34:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l84-v6sm13585357pfg.3.2018.08.09.15.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 15:34:30 -0700 (PDT)
Subject: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Date:   Thu,  9 Aug 2018 15:19:51 -0700
Message-Id: <20180809221952.24260-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180809221952.24260-1-palmer@sifive.com>
References: <20180809221952.24260-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        tklauser@distanz.ch, Arnd Bergmann <arnd@arndb.de>,
        Andrew Waterman <andrew@sifive.com>,
        linux@dominikbrodowski.net, dan.carpenter@oracle.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
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
 arch/riscv/kernel/sys_riscv.c | 12 ++++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

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
index f7181ed8aafc..568026ccf6e8 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -48,7 +48,6 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 }
 #endif /* !CONFIG_64BIT */
 
-#ifdef CONFIG_SMP
 /*
  * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
  * having a direct 'fence.i' instruction available to userspace (which we
@@ -66,15 +65,24 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
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
+	 * Without CONFIG_SMP flush_icache_mm is a just a flush_icache_all(),
+	 * which generates unused variable warnings all over this function.
+	 */
+#ifdef CONFIG_SMP
 	flush_icache_mm(mm, local);
+#else
+	flush_icache_all();
+#endif
 
 	return 0;
 }
-#endif
-- 
2.16.4

