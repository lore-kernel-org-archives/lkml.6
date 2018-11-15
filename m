Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9F622419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYIpEo6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9F622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbeKPBzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:55:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36595 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388606AbeKPBzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:55:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2010108pgm.3;
        Thu, 15 Nov 2018 07:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y4j6wPLX63MzLmcWwklKXfRUptmuKvg6BDhxbcvJLX8=;
        b=EYIpEo6I3fyTu/nA00GV24mLYL1fuyuGTfdcuVne5cPVJTlBojkjhL2OR9kMr1l6cn
         Scq7Xxv5VO8kmlGpTZK8sToz3x2SA8R2VUHT14wnAGRw97Fvv5Vqye1EyoXfC4hFsSRv
         CJPVbdMq6d7Zcx34sbWJLXEiOab4y8TidiIMUeAwXtXDI+n1ulichB4QJqC/gUokWoln
         hH6K/9J9Doub4q0HmhCejsxJoGlHkavlcqgMGD6pG06VxU/WW/pYmLIt6ns2RxPRzngf
         WULQgfNQRcnx+Sazxjc7zDpqv+SjhYgzIv6Rw51NzfPr07yFExwKQWZCiZybCes1Rk/2
         69GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y4j6wPLX63MzLmcWwklKXfRUptmuKvg6BDhxbcvJLX8=;
        b=dSOisbf5sbul4/vSEgdbhAw0SB6fOqVVMXQpXguhN0CwvoyB3y4v4TZAGwDYv2hHID
         7OwJqy6Z16fRwaYx79aIwmY++mdmCWkqjd+P1uARmElG8WuCZzUHrbaot7vwN2ykONGd
         MvrMx/MvPFamhHCFPhwnvybdjljqkz7FqHMiixrquCNTq+TIzQfKGDEpA2q6mmT084Sy
         ucICl/78Xm/vqJBYelXCCk/cSjLELMq/nJve31vFrWmom6bxcs1cfroKCr4kGUwNFqVE
         YGtYJpLbtYrRvcJ3A/a37MITss1Ex5fHBUKsRoG01upN+Sz+S8KzaRCYH8DRz6Pbz1JF
         qEYA==
X-Gm-Message-State: AGRZ1gKNu07eDQHcrePWILyNkq4i3tHSKBdv/Rl1DbibdcFwS3nKwS05
        wy2CO7ahYTE5fRn6K8jef+Q=
X-Google-Smtp-Source: AJdET5fKxAlomurtsT3Waf4QItnpyQmbkiTazNR0OLF+vbiHaETb9N5BF1yWp28J2QIaArlvH2Jy1Q==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr6206480pgh.265.1542296822885;
        Thu, 15 Nov 2018 07:47:02 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id j187-v6sm31083356pfc.43.2018.11.15.07.47.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:47:01 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:20:38 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        pawel@osciak.com, m.szyprowski@samsung.com,
        kyungmin.park@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 7/9] videobuf2/videobuf2-dma-sg.c: Convert to use
 vm_insert_range
Message-ID: <20181115155037.GA28004@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range to map range of kernel memory
to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 015e737..898adef 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -328,28 +328,19 @@ static unsigned int vb2_dma_sg_num_users(void *buf_priv)
 static int vb2_dma_sg_mmap(void *buf_priv, struct vm_area_struct *vma)
 {
 	struct vb2_dma_sg_buf *buf = buf_priv;
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
-	int i = 0;
+	unsigned long page_count = vma_pages(vma);
+	int err;
 
 	if (!buf) {
 		printk(KERN_ERR "No memory to map\n");
 		return -EINVAL;
 	}
 
-	do {
-		int ret;
-
-		ret = vm_insert_page(vma, uaddr, buf->pages[i++]);
-		if (ret) {
-			printk(KERN_ERR "Remapping memory, error: %d\n", ret);
-			return ret;
-		}
-
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
-
+	err = vm_insert_range(vma, vma->vm_start, buf->pages, page_count);
+	if (err) {
+		printk(KERN_ERR "Remapping memory, error: %d\n", err);
+		return err;
+	}
 
 	/*
 	 * Use common vm_area operations to track buffer refcount.
-- 
1.9.1

