Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F982C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA64E20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBK5v4eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA64E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbeLBGX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:23:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35473 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:23:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so4846207plo.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 22:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=jBK5v4eTeFUcYgaR+VLRi9deC6Tupa9Mqh0p6nmBGPzYYWw2U743+twg2EQuBBpceD
         JgfOJYhqiH2frDarCFg4yosdUP8Xn8XfB7jh+RN4O4NCn0/1yE8FMtJTK4kKjq7rZ2U6
         lSqGXiLyfwYVjNi4wZpH78wgwZSNG/TubSbCzTjLT+KR2qhliCcWtIGI3i6GjVtqSwKT
         u/uayvqLwk1peAvdSgMWAIXxqOFTN34B+E2B8iZOpQUKwxGGlU1LqYAo7YfQ6v06V9Qa
         EaWl8geGVUvW8EQsIRoYf9dYnZUrBrH+U8j+P9IvAKaM99rd1ol8BrbajXXKBYukaQpz
         Z12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=Go61EtRbynZuxFaoSins1WLqh54t6LG9IBO3Mi9B2dMBLjUn+bQR67+AwyTHeLW0n1
         RvS8QiJVZju7z28bPMsqBsTTGKC5YsAFbQkl9CMmX9k1umrUSnlvYLGMfKay/nZJX3YM
         6iMXz8b7IUO0GZ8030QvakjCAh9vIzFw2fUh60Hte7Z86+Vli3fpcQ9/EwmE68Yy057G
         fJUPdeExbL3Mzbb830k37chXdF1U5ocGP/95tzdCYNOol2zKbcDmsoBTgSdQQYSk4RCk
         /fIgTtTFUCsaKZuYBKe0SsX2l37jU3oCm2ho/Ra/WkdwWcFJus1GzzWQtCHY/4AZo0A0
         hJUw==
X-Gm-Message-State: AA+aEWbHHQZY3NFBOSNI0TcmLbOBjMayu+piIvAMlw6nMEt8IPoewlMM
        70fPchP4XFQ4KYGTC+HqeFViBF10
X-Google-Smtp-Source: AFSGD/U5NpFo3BqmiepkzNLs4Uga3ZdburK9tg+IUhPNMqIBo3/fxHs2QepB5StkiSWDXo/iRcM3xw==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr11611998plo.210.1543731832939;
        Sat, 01 Dec 2018 22:23:52 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id n70sm12795687pfi.185.2018.12.01.22.23.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:23:51 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:57:37 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 8/9] xen/gntdev.c: Convert to use vm_insert_range
Message-ID: <20181202062736.GA3240@jordon-HP-15-Notebook-PC>
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

