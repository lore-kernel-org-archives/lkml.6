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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7622082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhXPEcwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7622082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbeLBGYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:24:35 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41011 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBGYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:24:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so4818660plm.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 22:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QkAoEj0L9qsuE5G4ssoKQbBfw8UWUhYAoif7GyqYqTE=;
        b=NhXPEcwiMw1Jo0Yi0g97yLtSrgjmPBYmW2vb685ioI+U4hCQGjrF1FY5BLpoyPhG2J
         aUK/Za6Fh/zreav+EGci9N6H6yIIMZ+efw1GT2E+D78DGnWX1JQwYy2ispB3kuDU0tG+
         xUzPWz/+xnR6UuC8tUJ+XwhbHAGxt1er8Vj3nl/GgaDT6CNHr9/7ahNkvNZUK/S5Gq1L
         gr5iVu096dfzeK99TmuYocmpCw8kcKaSuWkguFSJWw2FXhFO5TH9Vkdezq6zXr7JtEIJ
         lF25ikfMrQW4LCt7tuE7lPEyYftBR/y143U7oi/ufYCkU4nNecNMZWxk13mIn3EdR/VS
         Lafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QkAoEj0L9qsuE5G4ssoKQbBfw8UWUhYAoif7GyqYqTE=;
        b=af4qZjOANxV4P/YDCtgGZQ9jV3VjJKNBUkXyoPhBgGG3Ye7gErMHHRaA6Qcyyf72H7
         EHgeK1xnf0DlREa4tnRM7H7S4fv9CrPh9TMZo6hNH4q4L6jVIl0M3Fvh/xZi2Oiz1gDr
         YpB2l4I5QzjlXbw5MFRJJwnmIvYC/zdgqAv/+aXoLvxViAsl5i+mLDJrHph/eVX5mSM6
         w+bUQLA3xsb7fY4ex6M+yE8YG+E+iqyGynWkdjWZMflacqDNyE+92VCIRY1wx4IDDeqz
         MTC/9QPYyRoD4dOdsygkhguwqajTjszs67QP/8b4FF33DvOojoTtpnu1eYp1Hq1k4y0s
         EUMg==
X-Gm-Message-State: AA+aEWYNWdTAD0U8Fj5sGOr0XPyXSBLfFaQQEqqIpPj9H80S0opPAIiM
        +aykaYz41M+4sqVP3rWXBNo=
X-Google-Smtp-Source: AFSGD/VHmonIx00YX3S79mkkjHjj09llEDbImZVH68eWMhHUiHmKjvuUEmzCzMegTtM0KXbGzxmF+w==
X-Received: by 2002:a17:902:4c85:: with SMTP id b5mr10986893ple.226.1543731872839;
        Sat, 01 Dec 2018 22:24:32 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id r83sm18648620pfc.115.2018.12.01.22.24.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:24:32 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:58:17 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range
Message-ID: <20181202062816.GA3256@jordon-HP-15-Notebook-PC>
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
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index df1ed37..8d8255b 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -180,12 +180,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_insert_range(vma, vma->vm_start, vma_priv->pages,
+				vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

