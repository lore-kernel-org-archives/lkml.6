Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6590DECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83D42084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR/MWyDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83D42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeGTVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:05:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39545 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeGTVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:05:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so12080669lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=74SSK+YvwPJw8a7XuH/8OaCpBh2qG5nXP4WSsVG/Iko=;
        b=aR/MWyDnoJ93PqmpGLRZsAEgCdCOvopfPOSsPTdzVYKm8vgypRcAewRz/jhhqhBY3E
         g1qKIrIw1KFbCqHvcC+0v8ciJ3rfQvWi5XFtx+mCblGWPSUKP5AQoC4aiencCu1DkcVF
         6l2ZnoXJ5WePkFyBdDPEeeNVHuTGb4l0D+KZOwQrbROFbOKxBgvtMXg6hj/pt+ICd+a0
         xpvXGu+eCS8s/w/AkquTD0ebK/aJrwzxw3gQ/GgcO+lNyY4t3lkWg5nLLiRg+gq64YcX
         9tLKooDlnBi2isLp+N/hMUDxpOcR8t1iZZULZdsrZgrdrUyD/E8h86ciNL5j6InBfnuo
         ygJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=74SSK+YvwPJw8a7XuH/8OaCpBh2qG5nXP4WSsVG/Iko=;
        b=bK9gPcK9p334SYNF7RbRBd8crVQdvNeY1vblPYVWlX7wZeUnD9wOcWOGgzFc/m04W/
         4pgkSTHQ6Q2gv8jobf30bAKMLZvBZyWzdbGDxoYBLuybuJFY0YM8ILspz3m/odoKV2yA
         yTlx4X4bdWSeIJFzw6CuqCTMAmCkzXQIt1arMcOIVWmBFQIqia3Div2YuLQzjhwvDkuA
         ov4cJ61GOMvCV6yAGuDldix5+QDK1efB0RF/Nt4GHQ6Z4QH6s09gIELZEgnNcYUDgKSr
         oL0WRpK6JIfC1279L6KLYaeWxEh+D8kXfMEAYB3IgZX0iMP0bxcYnYhTh78xBSZb1Qjg
         bJNg==
X-Gm-Message-State: AOUpUlGY6Afyo2tAwMDLOmJBgshkDFQgeIGl/LPITZ+E9DC0VGd+vo7i
        2J/2r+92dIB2wmyMJnsxy44=
X-Google-Smtp-Source: AAOMgpfJZMq6Dsm/5tg/UOU4LmMweNrth9oTU5NZz94wnS+f1z80x3dgxp+Ac0VCosWp3lPMGlwXrw==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr2754544lji.17.1532117720798;
        Fri, 20 Jul 2018 13:15:20 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id z5-v6sm411894lff.96.2018.07.20.13.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 13:15:20 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     paul.burton@mips.com, jhogan@kernel.org, ralf@linux-mips.org
Cc:     hch@infradead.org, okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] mips: mm: Discard ioremap_cacheable_cow() method
Date:   Fri, 20 Jul 2018 23:14:27 +0300
Message-Id: <20180720201427.18845-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro substitution is the shortcut to map cacheable IO memory
with coherent and write-back attributes. Since it is entirely unused
by kernel, lets just remove it.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
CC: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Sergey.Semin@t-platforms.ru
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/asm/io.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index f613d1df66c0..cd170d920d55 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -300,13 +300,6 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 #define ioremap_wc(offset, size)					\
 	__ioremap_mode((offset), (size), boot_cpu_data.writecombine)
 
-/*
- * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
- * requests a cachable mapping with CWB attribute enabled.
- */
-#define ioremap_cacheable_cow(offset, size)				\
-	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
-
 static inline void iounmap(const volatile void __iomem *addr)
 {
 	if (plat_iounmap(addr))
-- 
2.12.0

