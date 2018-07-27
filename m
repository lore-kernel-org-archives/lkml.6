Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA75C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6999F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee4GiivE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6999F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeG0Ejb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:39:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42989 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0Ejb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:39:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so2366829pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to;
        bh=DKwR8wB/JGhKvrpw3kbdhFA7TgsmPyhd4BLxSc2XIRA=;
        b=Ee4GiivEaO5ua/Dgjw1ZUUwTYXwBK46lnwzuPPvyzz7ar7BH2hCW6ItOZWd7l7lEat
         ZVR6uxT4pX5UvtWWFFjyJ3z3MVODsrEHyzOWgh1YRIUOl3kGB8Ig4yViiD/Wh0ZlAsmI
         mktV4hhyEhjX8NnkkiQ1bbkDp7Zx6OsCmEruJC/5OM4FD8DwLsNzlkDcc4Tqmj85xad6
         DxxB9qi9ans0505+aObVcXkwZySDjuSG5SheOje4xgvPdT/fj/Ggcs7XUFXPqnZ82FgY
         pxhWuTMbFH8BfGJ68rTM+qWvi1nHdIY91AO5SfzW2m/ze8BuUqJFvzoFAnc/1yFsQaCC
         58dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to;
        bh=DKwR8wB/JGhKvrpw3kbdhFA7TgsmPyhd4BLxSc2XIRA=;
        b=NcJMfT56kRryf0Djzhru81mtGbUEQjxAW7scww+stPSJxFtWBMoTEv9R2ZJmYH88nq
         ym2eEyRl3piieqJhd8kaIth85N2tMjESQIRN6d1czH3BUQKNXDzaJqxyINxYSWcabyAy
         qkAiwoUOjfLUVSbQHh9dkmJasMOj8alQk5RQeGULHe7ob3v8c5SHgUz6U4UVZIyUgI9I
         ZTIUxz/wrsYUqU2aQ8WSELxj48qnPEE9h2cMgyHTaYBlvUnRkrHrzgAFHerNGtqyDewT
         g/GBaSqOyXHhwIpjolPKmVQljkFIJKfL8RxwXAUaTloyms9Uj7Xxz8Z57ln5oXViJuxc
         Zd3A==
X-Gm-Message-State: AOUpUlFkrs2f2E/hbJs3z8DocyI1F4BB7R3eRtdZ+zbONeqlefIHdp3s
        EzhYZDxSN6MiU7tyVvZdKJo=
X-Google-Smtp-Source: AAOMgpcxKpfUBZe/9d5vwApiURC8DnV7QRl+YGL+HYM4UyfF/8/M3jYHH5MzfC0pJnimrG2mSLycTg==
X-Received: by 2002:a63:c60:: with SMTP id 32-v6mr4354613pgm.155.1532661585919;
        Thu, 26 Jul 2018 20:19:45 -0700 (PDT)
Received: from localhost (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id 1-v6sm5371156pfk.134.2018.07.26.20.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:19:44 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:16:35 -0700
From:   rd_dunlab <rd.dunlab@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: [PATCH 1/4 v2] arc: fix build errors in arc/include/asm/delay.h
Message-ID: <15326613952848@infradead.org>
In-Reply-To: <15326613951079@infradead.org>
X-Mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in arch/arc/'s delay.h:
- add "extern unsigned long loops_per_jiffy;"
- add <asm-generic/types.h> for "u64"

In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
../arch/arc/include/asm/delay.h: In function '__udelay':
../arch/arc/include/asm/delay.h:61:12: error: 'u64' undeclared (first use in this function)
  loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
            ^~~

In file included from ../drivers/infiniband/hw/cxgb3/cxio_hal.c:32:
../arch/arc/include/asm/delay.h: In function '__udelay':
../arch/arc/include/asm/delay.h:63:37: error: 'loops_per_jiffy' undeclared (first use in this function)
  loops = ((u64) usecs * 4295 * HZ * loops_per_jiffy) >> 32;
                                     ^~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Elad Kanfi <eladkan@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Ofer Levi <oferle@mellanox.com>
---
v2: add extern for loops_per_jiffy instead of including <linux/delay.h>
	for it

 arch/arc/include/asm/delay.h |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20180723.orig/arch/arc/include/asm/delay.h
+++ linux-next-20180723/arch/arc/include/asm/delay.h
@@ -17,8 +17,11 @@
 #ifndef __ASM_ARC_UDELAY_H
 #define __ASM_ARC_UDELAY_H
 
+#include <asm-generic/types.h>
 #include <asm/param.h>		/* HZ */
 
+extern unsigned long loops_per_jiffy;
+
 static inline void __delay(unsigned long loops)
 {
 	__asm__ __volatile__(


-- 

