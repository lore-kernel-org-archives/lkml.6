Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1513C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA9720818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjgIrpxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA9720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeKJCb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:31:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40508 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeKJCb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:31:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id x2-v6so1170944pfm.7;
        Fri, 09 Nov 2018 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=6tWW9hFOVhc7fYqnEbfnW1Dt89h1hZSd01jz+18AOuU=;
        b=EjgIrpxbyzOzYGJcPD3M5KlMdWJtVxAKoUZPbxhzsvWXc9RDxhL3DE/4pBTHpc1Rf3
         SfR7XqUFvw/A6v/udnvOS/8OkAI8fZG5y9wDRdHsnUebKUTJ2si/F8EXHHcg21G9B7fl
         DMeJCo49CkokqjFqmysBoMuIjx3WyEP2dy4HQ+k9gjv5bCH7cji2HdqwK7pr+Kl8IQmv
         V1kiPydXVtELNjR1cF6I7ZsLYX8a+pNgERDLScrclqQV0tcr3zIDf/EPESbHO3ZUMi5s
         Xs4K2B+Pq9r9KwQg1ag0HLN/hDwJxiux20FdwPvrwHJrOCuV3d7/ZCjTBP5T6fowEEYr
         yaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=6tWW9hFOVhc7fYqnEbfnW1Dt89h1hZSd01jz+18AOuU=;
        b=LtGjU4oKxv/XpecbmK6PGxZ/KbJFI5y3RD6FRCryupaXVaaB2mbexcMjYDzvJ7siO9
         bLSs+1qfY340sM7qZ85zvLFaYt/TcVrpA5bA3MxnBgfsuKeaJeJan7rUVB1mxyKk7R74
         Wl97D0M39A/6+NzaVdGqtUjwIjCH54z+cXzWXrXa7E5+YgpNUFjmL/nYiHurdv/CV/h8
         vhjJrSi6a6jA64OuOe+9ObT/olsDkEeGQ6uWInfBrgqCkgeXAkdZzNSpm3pCliRqK5La
         WC8yCP3pWZidDuaks6985lBo2pzCHJZkWSt3MV7nlY7unFihIYASdHqtV7JmOx0UcN7L
         2+BA==
X-Gm-Message-State: AGRZ1gKmhxEi3W39pMRD1Rgr5l6/agiOMmzqptHP7cf+m6yhqCbRNdjX
        BNhjAYGYY2eT9RBCIQ/+WpY=
X-Google-Smtp-Source: AJdET5d4ZGGjsfo4aKLZ7SMTmG/okAe1EmFB9uCLm1LLTUJBqo+d4Hh/mhnVqzqmoTAJaST5KSJ5KQ==
X-Received: by 2002:a63:f412:: with SMTP id g18mr8150308pgi.262.1541782234039;
        Fri, 09 Nov 2018 08:50:34 -0800 (PST)
Received: from sabyasachi ([45.116.191.241])
        by smtp.gmail.com with ESMTPSA id t1-v6sm16089189pfm.169.2018.11.09.08.50.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 08:50:33 -0800 (PST)
Message-ID: <5be5bad9.1c69fb81.db750.d226@mx.google.com>
X-Google-Original-Message-ID: <20181109165028.GA13638@sabyasachi.linux@gmail.com>
Date:   Fri, 9 Nov 2018 22:20:29 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     swise@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     jrdr.linux@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] infiniband/hw/cxgb3/cxio_hal.c: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/infiniband/hw/cxgb3/cxio_hal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index dcb4bba..df4f7a3 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -291,13 +291,12 @@ int cxio_create_qp(struct cxio_rdev *rdev_p, u32 kernel_domain,
 	if (!wq->sq)
 		goto err3;
 
-	wq->queue = dma_alloc_coherent(&(rdev_p->rnic_info.pdev->dev),
+	wq->queue = dma_zalloc_coherent(&(rdev_p->rnic_info.pdev->dev),
 					     depth * sizeof(union t3_wr),
 					     &(wq->dma_addr), GFP_KERNEL);
 	if (!wq->queue)
 		goto err4;
 
-	memset(wq->queue, 0, depth * sizeof(union t3_wr));
 	dma_unmap_addr_set(wq, mapping, wq->dma_addr);
 	wq->doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
 	if (!kernel_domain)
-- 
2.7.4

