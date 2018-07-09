Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E341C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0D12087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtgzlADw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0D12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754581AbeGIN4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:56:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35637 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeGIN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:56:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so8757262ljg.2;
        Mon, 09 Jul 2018 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lz9n33k6zDjpf5y3OZAwtxvxwQxZJ33mT7WTAFWVG+w=;
        b=WtgzlADw9ZDPfND1dVhKV1NHGmzErrduPLYcPqnqN5hqxKrb4av7X33RbUwC+92T22
         pr/29Hg9fvVzkKD8Om7EdihtR8ifvsxYDd7BDShhhHBJ/MFSL6mJTqthtWVviDZ0h/Kt
         5oy/V5j7R3DuwV53PaRoXcpjopSiYyMBqoWmvmOved7XSFoAJ0XnBOyvlKtSV6A51nX2
         29s12SEDgec3Bji2Tw8d6m1USiH4QFElniHY2EeySkuMZYw1XiTceB7OKKGHs7AobdCW
         XNoy+zh9VmWoQgLaP0yeIm8XrRNaYg9Ep0Nsrp2JjI146fY8zW+ZYO9zv1HRhqkOWr7Y
         dlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lz9n33k6zDjpf5y3OZAwtxvxwQxZJ33mT7WTAFWVG+w=;
        b=CtB+5Jc/rm+lzUkjBcZsqX53zSHvVpyuZ88PrFx29YU9J4kD8rorzCpaoOh+ZM6J0L
         znsTy1EVDDP6gRN5saTw39nBGtnkC+YoLSCTKzGv1f/64kpSxTpWgmUHWkIOGyBnywtw
         BswBBJTEJ7rZm7CbDnqe/EQJ9h5PjzNxvKAqJxm9a2JiFOrib67QIRkf5VwcXj5qWKJa
         AFtwdC15oQCKYRH+E7YQP2XmiNrQP/o1dT0p5sw/1/HY7ODOuFi/6+u6yw78iwi4Thvb
         E4tIRMfi7kjO7VJmOvC38j7QLlifHuHlqXSq3nHOBZK8+Q959LtJ+vqXA3er/DlCcx2B
         Xvqw==
X-Gm-Message-State: APt69E2g87u0yhK1wUhQdsi/EDG1emxBEU2kNABKnRMvnJ3Uga+4hHXJ
        bRHootT/bRHNXoapQ0GpwLw=
X-Google-Smtp-Source: AAOMgpfWY6L3kH6IZ/Ncy4sqTzfSx22QBrwZP4kQPox+1ONxHIXvN+mcyJ6umwp7EHnzuYMmveIn4A==
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr5205532ljj.139.1531144603232;
        Mon, 09 Jul 2018 06:56:43 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g12-v6sm4076662lfe.1.2018.07.09.06.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 06:56:42 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated() method
Date:   Mon,  9 Jul 2018 16:57:13 +0300
Message-Id: <20180709135713.8083-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180709135713.8083-1-fancer.lancer@gmail.com>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adaptive ioremap_wc() method is now available (see "mips: mm:
Create UCA-based ioremap_wc() method" commit). We can use it for
UCA-featured MMIO transactions in the kernel, so we don't need
it platform clone ioremap_uncached_accelerated() being declard.
Seeing it is also unused anywhere in the kernel code, lets remove
it from io.h arch-specific header then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Singed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
---
 arch/mips/include/asm/io.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index babe5155a..360b7ddeb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -301,15 +301,11 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 	__ioremap_mode((offset), (size), boot_cpu_data.writecombine)
 
 /*
- * These two are MIPS specific ioremap variant.	 ioremap_cacheable_cow
- * requests a cachable mapping, ioremap_uncached_accelerated requests a
- * mapping using the uncached accelerated mode which isn't supported on
- * all processors.
+ * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
+ * requests a cachable mapping with CWB attribute enabled.
  */
 #define ioremap_cacheable_cow(offset, size)				\
 	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
-#define ioremap_uncached_accelerated(offset, size)			\
-	__ioremap_mode((offset), (size), _CACHE_UNCACHED_ACCELERATED)
 
 static inline void iounmap(const volatile void __iomem *addr)
 {
-- 
2.12.0

