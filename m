Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE12208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gidEjeZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE12208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLFSmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:42:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36880 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:41:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so568932plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QkAoEj0L9qsuE5G4ssoKQbBfw8UWUhYAoif7GyqYqTE=;
        b=gidEjeZSbgItFGgWuJFdFe/ifliMLckszZaKhuDF0zT/ioQ/oR6cL7ETSduh8Iu7Ik
         nS1fUixG86BlJLDTz1MwqqLTuw9w3Ln38dTpDkXEWmtIOCQex1iam9lHoAbBENd9Bj4N
         DB4oeLz+ZVvBocvnc+0Iff/c+zSLTVwDJQ7NTOSjuFH1bbVlk82jqaugJMfPoMbGvfTj
         gqJG68rpZMa6/x5sl++Db1yULJskHuJuSMOhe656RDv6HOhIt5hgIMwL+ZSAQfMvR9U0
         U7FElxxBVFgtH/SYb7JK+Qwm/bqeDstaOWXtmI1Rw1ueeRLaDLZBGqHc8VtU4GDS3vRI
         RSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QkAoEj0L9qsuE5G4ssoKQbBfw8UWUhYAoif7GyqYqTE=;
        b=QZi/SbzuudGFrYGTVMWOTZa0IlNmrFvBXoX6GiL+kIEJdNx2ZtGYGTJTgeXd4Cbxd0
         Q7GwCEiLRa6JOY0R15ZseI7txy/e+mLenthDkifu0SPZgd4f04w4n/m2lqlI+dPkw8kN
         87BkPFvyUs1/j0ByQbQhcs2cuvqLEZEJRhWJDbkrN6pVFv+32y5Ra+/bJcOwf7TZ66hy
         BUkkj0J9kRmkf/aLHC4hsY02y0IXxIZbHG8nzMRlWWFBLU2CzHFQ8hgyzpRSreW0Ct/n
         gyUV+CjAi67VPX8SND//qLq81/CAsPaAXBuzQClfNNcC1jnfIUSUAS39qD46ayIMitmy
         z27A==
X-Gm-Message-State: AA+aEWYiJ+rJdjCbgxlxGqfHEP8mhfxQwAmqj9HitvHPAeNkiyNJ8hhp
        VHh40MHBEAomkPgyA0eCh0g=
X-Google-Smtp-Source: AFSGD/WPPXRIO+khmBGTNbV0MDnldPRG23ivTHyBZ4IX8eX79jqs4heYiOhzo6Y54/NC8l3kR3/n+w==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr28133182pla.47.1544121719014;
        Thu, 06 Dec 2018 10:41:59 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
        by smtp.gmail.com with ESMTPSA id 184sm1407299pfe.106.2018.12.06.10.41.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:41:58 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:15:45 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range
Message-ID: <20181206184545.GA847@jordon-HP-15-Notebook-PC>
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

