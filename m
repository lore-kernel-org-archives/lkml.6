Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA22146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqwlFq7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBA22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbeKPB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:56:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44582 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbeKPB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:56:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so529035pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=io202K/f8USMQZXbIPPlFl1CkxJtDZmQ24ViVn7Bo2M=;
        b=FqwlFq7RXy+tYLQhDZXhKCbRPAkRmfn2V/LfWtK/qmLG+Vie8Ebzek8qsl9WCGr9QA
         0whTVQ3NWdP1mlPPtsMuVS01rpgpSMe39FgSof8wwl3pR3+Mu8h9fpqLlwo4nvV7MW3i
         NnUIQpSEuDi5MByoCRtFAGmyh5myCCSY5tUKZwPRtnGJLuWOiwzzw4YvpnCNxbj05mQg
         zZ3xjcfPFTA0ksT6ELqYnwZmGIgzc5iWvPBDTmi3L5l/raDs66ykKER5uzGdLMOX3/Gk
         4gjXFN4347PwqkoehvwTeJaAEpJdj2zpJgNtSWxkg8m5Rgrn73DMSuw+0iubNN0vzC6b
         /qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=io202K/f8USMQZXbIPPlFl1CkxJtDZmQ24ViVn7Bo2M=;
        b=FodozotxD3QUQpGEtodKM100/+Xuj8NHFYUy53PgPzcjhPPokqtIlqucg5/sFRvWQc
         1+yE31fPRwvY1R4Mu+0tE4zC1EUsU8MDhxJ8Bo2v90vyKgqT0cJKi5aH0NVLKQXA1Tov
         Ohos2vhRslT/qgQEFCvhg1sdiVHZalQAKIRI7L/LerEaYqVsogenlKVkjuRzl10bimNx
         Y+qi1N8aWuaPZ8sELRfJO9zf2ygCdJL0jHI1P+UXgk7g7rtSY+8KjAeEe+BYeN13U638
         ME5gXnfA0OZxBUkU5L49hCnW9hwq6qvucSLC16+zVot3DdH9r6oL7kdO3ZE1JGEqifh8
         0vTw==
X-Gm-Message-State: AGRZ1gJaSWJH7IG5TnRCF40WFIz4QzkuXQobl3NFRglVhxblittW8tuT
        TXqvnINOpncDxdWY/ZpgjNgAGH+f
X-Google-Smtp-Source: AJdET5fbf5V0Ydlq8wMOhTyby2SzmuPQM7mnUTR1SsYy9WXPx2SMZDGWG7EF0a46EpXzZq0230Srng==
X-Received: by 2002:a62:4886:: with SMTP id q6mr2284395pfi.182.1542296869041;
        Thu, 15 Nov 2018 07:47:49 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id i88-v6sm59478434pfi.66.2018.11.15.07.47.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:47:48 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:21:13 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 8/9] xen/gntdev.c: Convert to use vm_insert_range
Message-ID: <20181115155113.GA28021@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/xen/gntdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index b0b02a5..430d4cb 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	int index = vma->vm_pgoff;
 	int count = vma_pages(vma);
 	struct gntdev_grant_map *map;
-	int i, err = -EINVAL;
+	int err = -EINVAL;
 
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
@@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto out_put_map;
 
 	if (!use_ptemod) {
-		for (i = 0; i < count; i++) {
-			err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
-				map->pages[i]);
-			if (err)
-				goto out_put_map;
-		}
+		err = vm_insert_range(vma, vma->vm_start, map->pages, count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1

