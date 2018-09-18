Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D3ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AA721471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lnj+GEf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AA721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbeIROwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:52:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIROwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:52:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so727076pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=Lnj+GEf9yzZasOKq2IBmSzWeKh+3usnJKw+W6pOgBMnTym8yNxDDX5M98mftWqMotP
         MJzpXVP8z3QVr1YDlpgLnwTTGblNfxj/m5Aiuwyj0oxlOEUogZNs9QlXVJ2zlUyh0tlI
         PuPF6i7Dda0C8DWxotLXbKpMmwjGr1+1DenInFQK7EFycQzmh4DSSx/+L+bh7T63TOw1
         o757FDzKcWffl7hEFRL16v9dnsJDCuzyW4e9PoECh7CZfBy6txaMIS+cD2j/zzhXl8RP
         Uj2fyTo+b5wRZI0vXfH+GTMpBWuZvta53ov+lepFKIQ0deDTSnxpIxDKu+PSeSnhz9Oy
         KhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=aSI7tDOUNJhgsR20VXCALILq6eikTMVxITEgpiCk+M3Fe8VgTNkVbwMml/H0jxJ+uk
         DK29P++EhQa5UWbC23du3BpTedeXHL+1qnkjdSMEVt4z/vCwIWouZpm7pqbxXVvNs7GQ
         BAIfyy9uElioOL1qt0HT3sQkELr8DFBpk17aAVAQZrNbkuakuD1uoHV4E4UOe4/NRAK7
         usm6cRx55vBIWvXI7oShxs9qx5278Rxc13axqQJzN6dbbYAaceHhYj4kwXyU+Z+cpaey
         hlIsez2ZJWEyt8MZ1Lw+oeGWhf33OzuCNGIii1q/69n6TIi1f+sdMJ0VxLuhzgb/aUgl
         D7uQ==
X-Gm-Message-State: APzg51CLHOHB2jaHF7ruJNkEJfocwBiqbePs2BjX3PBzvRXvXPP+3GtD
        iFK6huOE4L2+eog1UmpnqmQ=
X-Google-Smtp-Source: ANB0VdZWO7s/Ow2oeyrreBfrwu0QDN9Kp4/nmeUPKcs2w99dw8tuFFkVklB3c7KT+1APWvQoZwsjyQ==
X-Received: by 2002:a63:931b:: with SMTP id b27-v6mr27020099pge.143.1537262457428;
        Tue, 18 Sep 2018 02:20:57 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id 1-v6sm29932877pfm.145.2018.09.18.02.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:20:56 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     vincentc@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com
Subject: [PATCH 5/5] RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
Date:   Tue, 18 Sep 2018 17:19:17 +0800
Message-Id: <9fc325660fb1e0ef9133705f7c05784dcc12c0c2.1537260207.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537260207.git.zongbox@gmail.com>
References: <cover.1537260207.git.zongbox@gmail.com>
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

