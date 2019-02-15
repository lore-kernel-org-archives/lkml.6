Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5DD21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWuFZnGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfBOCo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:44:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35788 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfBOCo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:44:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so4193340plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=QWuFZnGW1rAFmlIYTR8KT5WNdvrhaezr0i4ZoVMqFLa54ofNW2h9D9a5ZzgYyp41MF
         rvXlFdLTe1vJbS+yYGRhKQFGPj+MKLD1iVlvMm9nhnIlH0nFQ5/bX/r3BgdjW2MtktLL
         fE5F7PKlj7zIDHLD10ydW/9+vyhDv6wCFhmmc9esTga8VDt9eB/q3GWtNUJB7Ih4v8gF
         hysNnNr3phiGvpEKd6M8VkY5G2p4IwHVd8tz8sNvMG5Yof71tMkfCzELiIvS7ATGGdrk
         f2Fjtt+lYU6DRmN0pNS3UaeqrhCqlzqJPjrNKTGR5zpPj8DyL7JWfrs3Bxalf9n153ai
         kn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=k7W2m5CceKkZdiKbklyP05SAACqcyF/akYb9emn0f1M77t8iACcJwxcMmCpJbPKwdD
         RVUMQfoFsSIXUsa2mI3zSsxCd8hs4jJuGsEHTjXT54oSWOc4k3gq7YLllDWmR5bmsD90
         QyYQpWjMT5Y3lTs7R/iqKqVzZy17HG5vWDVD5I1SJv8+QRdIRziJegecqIQzgyqHiIPu
         8hefnb1UDkJGNRyCsaewPZYvOxYP9vkhLynXkB0iIj/aYRVuW5Pum7Lwkd+SPZiVi6uZ
         wmcB0MC4OpKLKULekfKISfFAITzxJJFu3Yk+NvStutvGyEe3wKO0lHPLTbeMjUqpjKF6
         NRww==
X-Gm-Message-State: AHQUAuYKDvAKmVA1rJSO7KYkWn7JTR49kPG/A8pncpAPk0PMpnfPeopq
        DXbw0cQW+4M0qc1R/55foGs=
X-Google-Smtp-Source: AHgI3IYS4Rmfmmn4KPKMZ+5sCz/9GuQcTZN8Ld6ccRNBZU9OLJommfG+bJc6qfgdLMUnSbD4C9x9Pw==
X-Received: by 2002:a17:902:b190:: with SMTP id s16mr7726474plr.262.1550198696592;
        Thu, 14 Feb 2019 18:44:56 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
        by smtp.gmail.com with ESMTPSA id t5sm6861584pfb.60.2019.02.14.18.44.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 18:44:55 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:19:16 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 9/9] xen/privcmd-buf.c: Convert to use vm_map_pages_zero()
Message-ID: <20190215024916.GA26495@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages_zero() to map range of kernel
memory to user vma.

This driver has ignored vm_pgoff. We could later "fix" these drivers
to behave according to the normal vm_pgoff offsetting simply by
removing the _zero suffix on the function name and if that causes
regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d..d02dc43 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -166,12 +166,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_map_pages_zero(vma, vma_priv->pages,
+						vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

