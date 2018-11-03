Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E60C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C63E2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 05:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TufRfmfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C63E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeKCOfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 10:35:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37803 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKCOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 10:35:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so1859312pgq.4;
        Fri, 02 Nov 2018 22:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=UvUH25mrAM3Utue+k5STBHQeXDuVKu6z8BKR2fKN4ZE=;
        b=TufRfmfiC6qi/3wYSc8QZy0WdLb0DKMRtVPUvUbxy/jV8cBlksue6+c3h+dwXosske
         ATCs9f8DW1ENRBLIieXsMIDE0LNkdeM2kyAsN9TEXOlTL3u67d3mb2/tmYzNvwuP1e3e
         RxILlC1mxcftoc1HyyYKSgAsfZHSmaDOdFVYYnB42jYMUYmloM25VbI+qzm0cMvV46DG
         jE0+ejcomLBO9DASRXc/8mXLUP8U0IitxQ2wq/AbvnVsdlEKFwLm7eouTaSjujxFrpxP
         e7idD4dYoWxBMDv/MeCDMGSr2yxwU/G7yShjP9tgbbxrj9+czsvMne9EBxYQ8TlSBllN
         4CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=UvUH25mrAM3Utue+k5STBHQeXDuVKu6z8BKR2fKN4ZE=;
        b=EmoUQVTLCdrcxLSAUL+i3VjZZP0Al6GQ4gM0eJNz5YHRDe4qPjOgYYdbaJVv0j/50q
         UH8J057u16pMuEGHSUHTX//YrYuxxVXJv6KRtU5OyYZcIjK1v1OpxYs3DpMOfS1sfQ/E
         79jMCQ+lfCtWLVJW9O5seKdorZf34WtecBQnk8I9umj90jjzomBqKUm0o9hW3ywWBQ69
         1JJk/D6609RN4kGdj7Vc1dC0a7RBSRQnHF3RL1fF8NlpNDAESeSLlH91j7sFqyZ9a2Vf
         SWpRUZ0qKUSH7pte3wNavsczpjPi7sM7Dq+K+CyDheUb74YR2DbpgZelJ2EfF0zC0vqR
         sCRA==
X-Gm-Message-State: AGRZ1gLFk6r45KbnNXg3Y9yCf1ClG1sveCNKJte8myixAml1UADPxcte
        V+eVksdIFRj2rlsRoTWUjPE=
X-Google-Smtp-Source: AJdET5fSnjvdKY5UFUR10nWdVIjxFxbPAypyAvdIeRnAWozflrV2nGFHvPzL57Pptu9l2LQdRxOZsw==
X-Received: by 2002:a62:12d0:: with SMTP id 77-v6mr14471954pfs.140.1541222697753;
        Fri, 02 Nov 2018 22:24:57 -0700 (PDT)
Received: from sabyasachi ([45.116.191.230])
        by smtp.gmail.com with ESMTPSA id b29-v6sm64422395pfj.183.2018.11.02.22.24.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 22:24:56 -0700 (PDT)
Message-ID: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
X-Google-Original-Message-ID: <20181103052452.GA5924@sabyasachi.linux@gmail.com>
Date:   Sat, 3 Nov 2018 10:54:52 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     davem@davemloft.net, khandual@linux.vnet.ibm.com
Cc:     jrdr.linux@gmail.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] arch/sparc: Use kzalloc_node
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced kmalloc_node + memset with kzalloc_node

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/sparc/kernel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 40d008b..05eb016 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -108,10 +108,9 @@ int iommu_table_init(struct iommu *iommu, int tsbsize,
 	/* Allocate and initialize the free area map.  */
 	sz = num_tsb_entries / 8;
 	sz = (sz + 7UL) & ~7UL;
-	iommu->tbl.map = kmalloc_node(sz, GFP_KERNEL, numa_node);
+	iommu->tbl.map = kzalloc_node(sz, GFP_KERNEL, numa_node);
 	if (!iommu->tbl.map)
 		return -ENOMEM;
-	memset(iommu->tbl.map, 0, sz);
 
 	iommu_tbl_pool_init(&iommu->tbl, num_tsb_entries, IO_PAGE_SHIFT,
 			    (tlb_type != hypervisor ? iommu_flushall : NULL),
-- 
2.7.4

