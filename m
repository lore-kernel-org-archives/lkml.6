Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2892083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GioNp5LJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2892083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJBM0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:26:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34294 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeJBM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:26:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so23967plr.1;
        Mon, 01 Oct 2018 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mWIRY+fxZKlf3hZ/+YCd2DIXt8CKPqagyhrO4MqaBQ0=;
        b=GioNp5LJkIjv+EgYrMlxUMUANrH5LEglfosNscqQ/XikkD6EFEqom6kKegkzMRIWrY
         V6Pr0fEp7BacMlANjJLO5DquNKWkmO30pzZCs1rfwPS4OqpJg7GfXTgBWeAUMmYbv5dJ
         rXEF+Mo5OTvHGk5d5owWuHrz2tkzofNY6ABV6zvtxzKA11EvMQyJ7CnSeMe+6ZlWVWGY
         6/QxbUhqjTIKonBWKQg9f6ftGtvoDbJ7GUmQsaU8pprAmLfQFtkNBN9RbgmtGm0+4A99
         FuEncHSFyihKZXIkUzsiHGSM4wrBmss0vT7MjZL2V9mU7lBeUfbo/yhqkoXDTg4SQ8gl
         3wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mWIRY+fxZKlf3hZ/+YCd2DIXt8CKPqagyhrO4MqaBQ0=;
        b=IlUMdN5A+oPQy/Un/tf6sqTpXF+Vulx/fEgJaYXS9VrJ/jRUtGkxcHGe0LqGHRLNm+
         kolkna787Qq3YPgeh6E2KbO1Yh5msH3HAUsoD1FcnSX6XFRpePfjEIVJPHckUEkkV+uO
         9x1eg7K/dCjWeUlH01R+QhrUf9rW4s31vEzQheJjK3/Iw/Bak5PiAPG8OBIRRfmx/2kB
         T4A2mqm+M21xPRvIil6Iw001cNVz3eMhCnLzQ7L+cGU/FIpcg+HjzgYdCmkNH5eifBDE
         FNaKDHhYirdPJXrtjZ6fb/A6az7w2VhPY85LWzC0A0VGIrlzaDADbu38CWn3R89X1r7v
         tI7A==
X-Gm-Message-State: ABuFfoi1IqNQRnS3Bf83sD2QIAUcZZn+SlsEcVEYxOvemIK53Cr80etb
        HrH2EQhn8PaRo2fcBTlx0JUgdOay
X-Google-Smtp-Source: ACcGV622hA5z6LCYolUdmyZ6kPepDgNXojBZYiW82UrxpKDZebvpLfBuh+1zVZknesCUTrlxGnYE4A==
X-Received: by 2002:a63:61d0:: with SMTP id v199-v6mr13220970pgb.242.1538459087798;
        Mon, 01 Oct 2018 22:44:47 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.217.11])
        by smtp.gmail.com with ESMTPSA id o12-v6sm23807765pfh.20.2018.10.01.22.44.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 22:44:46 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:18:04 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, brajeswar.linux@gmail.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi/mpt3sas: Use dma_pool_zalloc
Message-ID: <20181002054804.GA11315@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_pool_alloc + memset with dma_pool_zalloc.

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 59d7844..d7ef671 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4516,7 +4516,7 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
 	i = 0;
 	do {
 		ioc->reply_post[i].reply_post_free =
-		    dma_pool_alloc(ioc->reply_post_free_dma_pool,
+		    dma_pool_zalloc(ioc->reply_post_free_dma_pool,
 		    GFP_KERNEL,
 		    &ioc->reply_post[i].reply_post_free_dma);
 		if (!ioc->reply_post[i].reply_post_free) {
@@ -4525,7 +4525,6 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
 			ioc->name);
 			goto out;
 		}
-		memset(ioc->reply_post[i].reply_post_free, 0, sz);
 		dinitprintk(ioc, pr_info(MPT3SAS_FMT
 		    "reply post free pool (0x%p): depth(%d),"
 		    "element_size(%d), pool_size(%d kB)\n", ioc->name,
@@ -4852,14 +4851,13 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
 			ioc->name);
 		goto out;
 	}
-	ioc->reply_free = dma_pool_alloc(ioc->reply_free_dma_pool, GFP_KERNEL,
+	ioc->reply_free = dma_pool_zalloc(ioc->reply_free_dma_pool, GFP_KERNEL,
 	    &ioc->reply_free_dma);
 	if (!ioc->reply_free) {
 		pr_err(MPT3SAS_FMT "reply_free pool: dma_pool_alloc failed\n",
 			ioc->name);
 		goto out;
 	}
-	memset(ioc->reply_free, 0, sz);
 	dinitprintk(ioc, pr_info(MPT3SAS_FMT "reply_free pool(0x%p): " \
 	    "depth(%d), element_size(%d), pool_size(%d kB)\n", ioc->name,
 	    ioc->reply_free, ioc->reply_free_queue_depth, 4, sz/1024));
-- 
1.9.1

