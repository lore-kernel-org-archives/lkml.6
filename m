Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33760206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSZkZtXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbeLQUWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:22:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38084 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbeLQUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:22:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so6919772pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=YSZkZtXBTHutf0Vc6xE9hpWLdTQiV0LBpPh7E+tGHV4rn+ag0zPdwRG7EhkmCvu5/6
         yTflbIXQRwtDKRjaheKdvZczHREL9dDm0/E0PPXryDAWVQ1dDjNVkODJXONGFs+RsHmZ
         9HNE6lVp8ggq9J6oHg936hoELYz6z8wtqRf81Vvy/bMDI8ExoKDF7l1o68npz7cPk2Sy
         YC9Ch92Pwljml8KoQEwsMqimggKvRDSIjrVepRbxWARIW1NHzU1UMUrU/n5ktuoTHkdV
         BQryqdLvLjclBgcR19werYAe9q9hfgE3vV0axOgnsZFNEWZaRjI5QsFda/Y7dZWG1030
         9uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=rpFgzLUceXML6Xnjqm/VP2JDSOc3Qj8TdW0l5o0tEQAPgIaMRhgoa/Ujki95RqmK4h
         99vVtzs4P2L7eL21BorpbsEAu75LcLBXwNeQs9y79h0bcPgk5I+eP0BdFUI8AzzMVWoJ
         v8i3sP/KrrrdZheVsKzKHW6s5IzjFBlAjA3jSqtY1kYc4KjFzTVSCc25Fs5hj4Gfzdhl
         USlcby8vKrXR7QcMPq+o9PCmaQnFAeLRd13k8L1iAurzt/jWL3S7RfPUjewPIQqAYGX3
         eT5WqYxDmwKmpUpu5AU09mPNgFMoFl93AeCcQ8+9DV71xrGiIFNTyyQ+/1Xtg236MXcg
         N6yQ==
X-Gm-Message-State: AA+aEWaHXaiohvQMD/6s8Fj9gfxN0KI+POBFAMhqg9JCZ/K2WbAEg16e
        m9MpNb6V5jaZIBQqjoJnAZc=
X-Google-Smtp-Source: AFSGD/X+TrNR9f9V81XBDJgY79N2l38Sd7IjU/SS/fpnE4vfFVwlgbpFPPLma7Xyy+Ak6jm6z2ZBzw==
X-Received: by 2002:a63:62c4:: with SMTP id w187mr9217308pgb.230.1545078139265;
        Mon, 17 Dec 2018 12:22:19 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
        by smtp.gmail.com with ESMTPSA id h79sm24507341pfj.186.2018.12.17.12.22.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 12:22:18 -0800 (PST)
Date:   Tue, 18 Dec 2018 01:56:11 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 8/9] xen/gntdev.c: Convert to use vm_insert_range
Message-ID: <20181217202611.GA18060@jordon-HP-15-Notebook-PC>
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
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

