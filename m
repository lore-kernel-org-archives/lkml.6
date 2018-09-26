Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4DEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDEC20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlpQoW6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDEC20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeIZOo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:44:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45303 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbeIZOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:44:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so5412851pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=nlpQoW6gTNn0ZvJ6d3TtBZiUM/dTyRg/qvqxtod61+lEcMu9xu3ryWfBe0YHMB2RJa
         3e0arhfbXSga29nBn5n4iAzoWkJiSTAI8yJGbLHp8THp0Tzs9S12z1ndhxXrGbBaRtoi
         OTtNLwvTftEWq1SB3fM450H0BnLUw9WKbs+oit5cHFcl/UBHZBTQwWzMql6NaS/yIGDC
         Sf7doqUJ/uR8LWqTqzBPmVdVbpVNngzn7k5Z5nWcgPxQKaunWeenhwlakMALH4E2Wrm7
         AxebaQHcOH/NgxOGnszKorbRPJFaKe3Wb/z53p/ehs3ZbQyZvOZPhHGj4BIlP2ceTj6U
         4Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=t3Gi1Kz5wN77iEhgEzO8nMoVEBbO91MvqFbfoaR2jsrlWiHx1LGpg0Khx8o1PwgD8A
         2ttIo1PueuqT742/97ioH8RtZ1EjV+5JtI/8/+D60d/lrtj6qLhhnjf1MRP6AAjGtTKc
         FnwauS+lxmzjjp4dc7U2STCARQyOogWG3uEQxfRswfkVto5OJRwt27aKdxdhIdBBV0sO
         wmCuz45Do1VSsX/rBd+TQ1m8HLC6jgdb/0TO6IqhAx0LlTTUun3Aq0/LXSlRdpEM/xAP
         EU84fmgLH780/KwOHrzWy1wHhcwLxodCiDAiHE/30LYfR7Rop8R9OQiqPFI9MC9pGyVe
         dgUQ==
X-Gm-Message-State: ABuFfohSxXqNT+1+Tk04gEvjLUn5ksb7rzrtTFhvLN87gkKpyWpbgzpW
        HpBM65IKNkhfC2X+hTKQmXA=
X-Google-Smtp-Source: ACcGV61DR9IMLqNAjTlLRYHT+XOmYQ0I2xkfogfqOQ6H+2d+c2ye8dLxgkfQ32da6MFrMpv+/W/6Kg==
X-Received: by 2002:a63:1566:: with SMTP id 38-v6mr4621863pgv.383.1537950786910;
        Wed, 26 Sep 2018 01:33:06 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id f15-v6sm5530764pgv.66.2018.09.26.01.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:33:06 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com, vincentc@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
Date:   Wed, 26 Sep 2018 16:31:14 +0800
Message-Id: <341d3a765c0078280eb99d49559b5f9a27b93fe4.1537949825.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537949825.git.zongbox@gmail.com>
References: <cover.1537949825.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincentc@andestech.com>

For 32bit, the upper 32-bit of phys_addr_t will be flushed to zero
after AND with PAGE_MASK because the data type of PAGE_MASK is
unsigned long. To fix this problem, the page alignment is done by
subtracting the page offset instead of AND with PAGE_MASK.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/ioremap.c b/arch/riscv/mm/ioremap.c
index 70ef272..bd2f2db 100644
--- a/arch/riscv/mm/ioremap.c
+++ b/arch/riscv/mm/ioremap.c
@@ -42,7 +42,7 @@ static void __iomem *__ioremap_caller(phys_addr_t addr, size_t size,
 
 	/* Page-align mappings */
 	offset = addr & (~PAGE_MASK);
-	addr &= PAGE_MASK;
+	addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-- 
2.7.4

