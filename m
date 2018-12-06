Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34FBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9E820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aenzkpYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9E820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeLFSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:41:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46250 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeLFSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:41:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so579640pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=aenzkpYvHUhNUpyXAme2uQ3V/EXrKlnQA8rURBLlOkHsn9tYjl5GkmybdoUD9K2GgN
         G37Q64LOB4ZKu2sue4xUOhvOeuEmG46SmCpVuZhEdJxR63T/QLdN8rLr9fiWbyuMd5Jm
         0HsilvmTtfIBT/QBcUh9o2qEUSfdiW4dKzSGb7XuAMX7eaBz1dzjqwlJG7nEX+iWPemK
         664ddgM//PLwH6v9zkkZfemN0CaRbZBPRXhwkc1MiwP+R3wK5e6yJMSGY1t7V9JHgk+t
         HDi3RGApuONW9gwNprPjlwpSAwnyZqpCDLxFDrvKLH3HIGxqygBp8n2LNJa0o/mP5Ah5
         Du4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w2N1lFnP7lwgyibZCv3zxC5CB8Y6AOTQeCb4v428osI=;
        b=WLuGmH9MdR5wK1NrHdQ0hUUh6anGd6E5WtqI2ciGltCOGzTYA3vc6CVieaYhmkkoHk
         NgEc7ZQ+fkeg56XZAkYQmbaBvm5dUdU8zZL8qBoaS7XDD1P+VruCxjeA89aVVCoul7OR
         6pwP4/QVmJtf1X/JRLFSXP3Ee0F6VGZbxEKerdnbUWcQpkjvx5WRSLpslLxgme+gtwaZ
         mV16EJ/ttXkvmha3bqzTwtSJtNiamFwI+VMCYQGMevOhS9/qBEYOAJZsNJyBCrXegPHt
         ouQ6MwNV0gA62tIm5hlI+36LjbggvqUvpu8iZI+UlW0yKjVVSODBsEHIhRhMbL+UTmYK
         pVbg==
X-Gm-Message-State: AA+aEWZFRe5XxJJmirrQiIzSnziMIxWTwZ8uiphQztMZYbzmcWL9gsQN
        LK4kQSOU/qq+tE5KJ+4o130=
X-Google-Smtp-Source: AFSGD/U5qV1ExnFHXQcR9PwlEZvKxNelc+OQM7eEHu1JRTs7JEb8sLXoA+WeSuh+reYXA+2ge8l+Lg==
X-Received: by 2002:a63:bc02:: with SMTP id q2mr25260007pge.116.1544121686098;
        Thu, 06 Dec 2018 10:41:26 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
        by smtp.gmail.com with ESMTPSA id r8sm1220470pgr.48.2018.12.06.10.41.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:41:25 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:15:13 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 8/9] xen/gntdev.c: Convert to use vm_insert_range
Message-ID: <20181206184513.GA32415@jordon-HP-15-Notebook-PC>
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

