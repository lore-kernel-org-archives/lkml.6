Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EF9C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3531A2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 03:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg/TxZoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3531A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJWMU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:20:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41002 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:20:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id a19-v6so329460pfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 20:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vrLzbMQB2qosUS+SNjOskqaK6dqBKdQNnSmc8vqPpEg=;
        b=Hg/TxZoyb3XxkQu9cyZkYcnpZ6Ovo4EGOy+0Ox1FNF2+2cldy5hOrrHMY585377OU+
         /GrqVJySdXiHxwthrbOPCRWb5KWyvyuG5n/1vwWjL/XhzlRrpMysOhU3QmpAX8VBbobr
         SzmMxHtwUo6m/ayGBHcgu3qrMPVB0OV1iNU0ZXPvhnHAOX4KnZu5EGT/twN9APKmb2c6
         HeZzTfFe8AaD+9u2wJQG0rGlwUExRhFYzx69rTdKnYZhqdMDQxS0RGl/QNPLnRrMEbR1
         q2o4nyGQzMVgl45gzBzoJKV/fRCs4esedHcSpSzQQMKqrZUr6cA3VDEwYs6GrdGQ/qlc
         H+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vrLzbMQB2qosUS+SNjOskqaK6dqBKdQNnSmc8vqPpEg=;
        b=mTUrCSBGuc3vM4v3FU/m9Z4ZUJK+vfONPkTOpjCjqi/IobK2OE5HZIrQsQtvnfU2QQ
         uOBXAFGZ8ZO5sWKkvD66Q+1iKjBf30MyH9Fe0UriE06e08yrDbbulzyIRHybcSzIMFS0
         VFfu59IixRDScDN3qrjGaAOo8yOSQDG76HjcKlacmpJiLpX1qZh8v4pSawMvJnsVzCSi
         1yIYxE/M+pME8mHtTiAJhdVDYT3g2n1SRN+8RwR+KRpnSnHPQCAEe70Nw9z093/9dXm1
         hA9j7afP5ItBjCAHoUQDDbq7Vg9LALR58L5HvR2GQkT8QWZS8OFcWvctyMb21eJg3voN
         Yl/Q==
X-Gm-Message-State: AGRZ1gJvA3DKTCXj9cW6FbZpdB/FIVK9veisaEnIF8/lQ3lWzDwtunFl
        RqGDVnDDfDVS7xQIMBh5R78=
X-Google-Smtp-Source: AJdET5dot2rydcQ65AotXQ18iDrsB0AVl18JqDCOEE3LHffBNAiiSFeqcgQWZfpS/jNiWYPBs7O/sA==
X-Received: by 2002:a63:515b:: with SMTP id r27-v6mr9535006pgl.419.1540267136804;
        Mon, 22 Oct 2018 20:58:56 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.86])
        by smtp.gmail.com with ESMTPSA id j25-v6sm38276365pff.116.2018.10.22.20.58.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 20:58:55 -0700 (PDT)
Date:   Tue, 23 Oct 2018 09:32:22 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com
Subject: [PATCH] drm/drm_pci.c: Use dma_zalloc_coherent
Message-ID: <20181023040222.GA1540@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dma_alloc_coherent + memset with dma_zalloc_coherent.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/drm_pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 896e42a..1427879 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -61,15 +61,14 @@ drm_dma_handle_t *drm_pci_alloc(struct drm_device * dev, size_t size, size_t ali
 		return NULL;
 
 	dmah->size = size;
-	dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size, &dmah->busaddr, GFP_KERNEL | __GFP_COMP);
+	dmah->vaddr = dma_zalloc_coherent(&dev->pdev->dev, size, &dmah->busaddr,
+						GFP_KERNEL | __GFP_COMP);
 
 	if (dmah->vaddr == NULL) {
 		kfree(dmah);
 		return NULL;
 	}
 
-	memset(dmah->vaddr, 0, size);
-
 	/* XXX - Is virt_to_page() legal for consistent mem? */
 	/* Reserve */
 	for (addr = (unsigned long)dmah->vaddr, sz = size;
-- 
1.9.1

