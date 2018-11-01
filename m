Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C91CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB447205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBBAoQOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB447205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeKANQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 09:16:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45328 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeKANQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 09:16:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id v5-v6so3760089pfm.12;
        Wed, 31 Oct 2018 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EodhFOsZNap0gDvJ5wabtGzaaP1v4TvIoj4MvGxyPAQ=;
        b=oBBAoQOgMUCoekwU1h/z2LKlTvlQlOKk8aRFy4La3XRjOKwvQxxzQtB0cXixl4AA/2
         tmiTTYyg5ngBTW2ehz9yj96A9wGknYkDcPrwoAcurDmRI9iqGWCfznURTrnNtMcasWjy
         VWN1TnrI0jwA2rzahpKYca8uB5vxxwHmnSHlQXrCaTmeTfcOlzyHud7OWoHrsA/GvniX
         1J6XBv+jKjobYvR9bJeuT9GnDX58V2a3gXMnnvV3JdZSK2sCp6Los9P80qm0VcKwdLOH
         MpXEy0UDvjtW6jEmvjhfpHHLW7plLZ93uVZ6aVR29ZPoFAZny1qYfQHr8moXIS9TZsj1
         BSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EodhFOsZNap0gDvJ5wabtGzaaP1v4TvIoj4MvGxyPAQ=;
        b=UuSk67eZNBAtLTASork9Gn1Dql0/YHXa8TgNBxIa3V+98R6vCdof36NbBz3A+xb8si
         BPlnf3WMAPAcLAT2gtMP5k0fxTrcgsQii2tUXyFaH08T/lMYHTqCHh6DMmIB2n9dWLyg
         z/AHS1lvwd/6Uc+4Q2UYAjAREKV2z3d2JoJciYA2GaJyszVQOTSbAAT4CfRHF1ux++K2
         UKZ5txNMHPn0ksi5D07wGNXUlZUSWMeZiK/2i8a9gyvGV/UzWiN74XpIMvlzXmoMS0H8
         jV1UMbK8iR2uKUd7gKTfBp/qZ7V8qluSychR8VaYjJVIe4vvQVFIN6DIJBWSUIQXCMxL
         U4+g==
X-Gm-Message-State: AGRZ1gKiwA+lb0cjhj/Iam0TvciNd9LdRaRnOXDBAl10r1j9tyirvgkQ
        Uc3QuzmKd6/w49Aym6kK4sE=
X-Google-Smtp-Source: AJdET5fl+qec++28R6c8W808UO+e/Jz8++lpknNZC2WmzOYiCVEre6/WgAhR8rWqd/KlE1A3toAh8Q==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr5795887pgf.58.1541045739396;
        Wed, 31 Oct 2018 21:15:39 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([103.227.96.201])
        by smtp.gmail.com with ESMTPSA id w16-v6sm8480703pga.65.2018.10.31.21.15.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Oct 2018 21:15:37 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:49:09 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        keescook@chromium.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: [PATCH] scsi/aic94xx/aic94xx_hwi.c: Use dma_pool_zalloc
Message-ID: <20181101041909.GA3241@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_pool_alloc + memset with dma_pool_zalloc

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/scsi/aic94xx/aic94xx_hwi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index 3b8ad55e59de..2bc7615193bd 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -1057,14 +1057,13 @@ static struct asd_ascb *asd_ascb_alloc(struct asd_ha_struct *asd_ha,
 
 	if (ascb) {
 		ascb->dma_scb.size = sizeof(struct scb);
-		ascb->dma_scb.vaddr = dma_pool_alloc(asd_ha->scb_pool,
+		ascb->dma_scb.vaddr = dma_pool_zalloc(asd_ha->scb_pool,
 						     gfp_flags,
 						    &ascb->dma_scb.dma_handle);
 		if (!ascb->dma_scb.vaddr) {
 			kmem_cache_free(asd_ascb_cache, ascb);
 			return NULL;
 		}
-		memset(ascb->dma_scb.vaddr, 0, sizeof(struct scb));
 		asd_init_ascb(asd_ha, ascb);
 
 		spin_lock_irqsave(&seq->tc_index_lock, flags);
-- 
2.17.1

