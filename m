Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF78C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A4F2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt8nidr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfBOCoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:44:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43567 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbfBOCoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:44:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so4085116pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=n/NDS47nz9uuNytg4LeJJ+li959uQqsTwzm1mhrxiWA=;
        b=Vt8nidr0rK41Os0HWq4+4aF062X7h4v6mHNSGJrNppzhNDwX047qRWP5LTYUmhuLuy
         Iqtt/oPfQUVesoOPfP5pR37mpT+P5HeBjY/N3FdmN8Wc13V9Ij1VlOFDdTG1KkCD9Y9h
         LQKENgYLW/iXqE4T1/ZrhykWcCV8gemdxOrir5XOiDFzPc11Wj4/BnVAjWyDbTbpt0ta
         VbW+K/iPDsPHPWxg6IhMue9P7ETAnU+10BQ5VBAg8a1B0RRapCC5H5wh6eFntrZbvsCk
         v7WtGBOaFUVs6JL1Q2xUIeJxfF53otn17DmHM7ufjAiDUwRCJGfexUeqg6ur38YrawW0
         RvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=n/NDS47nz9uuNytg4LeJJ+li959uQqsTwzm1mhrxiWA=;
        b=mOzVepukSoRFN9W4OirTJbo2MzfyFo1I+HF68L/N7+vS3xaa7U/8YcQfFTHvfe4D7E
         NotZ2S19SpjjWg3302rGoFkYXNLBHOEIgshPuDWLDcgmHfuWV+oArF3jwbUslLcX+rFp
         wDpg0P83ZLTKWGOPbDNyx1K4Uql9wDtw0a/pJFbzNQRc8vA9xwFJqyZNm1Efekui5iyQ
         meeZrKZqxrAEai8axwQslwvgIZLaAgwumIKsz1H2mQ2jyEcKpY6lYSZBjvLMEdLAUaRe
         T8WRmeqpNcFc77sFWOXF8CI4LkBDiRJ+1gxFWSWg6sIBle2je25opS4FZ3i3Bgu+eBf6
         mgVw==
X-Gm-Message-State: AHQUAuZ669TJInECKUgdPmKcUIw/aKisH3KQ5jCQSXlWhV6+Gsfm7SSq
        WacbDz9cMrtH5dYRFL+gHdE=
X-Google-Smtp-Source: AHgI3Ibcl+fzq90jisjOqRBP1UVmKB22vuwt6jwUdH2scf6jctjGOQhzTZ2VTYmiKE7rY4uCtAp5vQ==
X-Received: by 2002:a65:5003:: with SMTP id f3mr3127549pgo.39.1550198650905;
        Thu, 14 Feb 2019 18:44:10 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
        by smtp.gmail.com with ESMTPSA id u8sm6577915pfl.16.2019.02.14.18.44.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 18:44:10 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:18:31 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 8/9] xen/gntdev.c: Convert to use vm_map_pages()
Message-ID: <20190215024830.GA26477@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

map->count is passed to vm_map_pages() and internal API
verify map->count against count ( count = vma_pages(vma))
for page array boundary overrun condition.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5ee..5d64262 100644
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
+		err = vm_map_pages(vma, map->pages, map->count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1

