Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E332080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS+vMYZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E332080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeKSA7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:59:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42157 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKSA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:59:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so9109818pfr.9;
        Sun, 18 Nov 2018 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=3YXTA49iFOqBLtV+cMoZtlWCLhi/r+r6GjOw4BxVfu0=;
        b=JS+vMYZotla8t+ychqXMjRDJl4H3leAMJSWZ9YINCw/G8OF9+wvpMWTmL+nUQbwE9C
         amZYke/HNI4hsvM4hPp4OXIaFYtDbA77TYRh3qyPhSIiBU4vb3pMNX0JMTdk/kGT7v4w
         q/wJhR8t8K4K0zJBcA8yUJHbiStW8pllQi3kdafEbQLzvK5XZ6EezztZPeaedrVMAbUr
         92c7W7v1Zk/wRnGeUN5/zu1Ro+WUNDPiSD+BLiNpW17Ujqoio9+bPLZ8dZgAs4divmKu
         TXE2vEpdf0x1guR4BDMaWhsd0JDXA3iguPdkPH5y9yUzhYT+qqaM+egZso1MLYexfld0
         iZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=3YXTA49iFOqBLtV+cMoZtlWCLhi/r+r6GjOw4BxVfu0=;
        b=F+x6k0/JXa2wcQ2twIkF6R80Um3K3HGv+GGF/GjD5e1IT4JWD5IsHu/W61kdX0Vw29
         gfMg7YUwQbNvFYLbTACRgZQ/vli/6GKIaT8K3HDbtnjtXKiHa5DRYtHtBRRPm47Uq1XH
         fMxsjaqR+nLyc4pJqrJJ84W7GK8sThBCf8lxuZjO8SWdHwsnGsl+v3J8fqe6BLC7gnqh
         D6HYxqjj026onrQ/ENTg35GDviWc8f5A8GyptMgPJ31aou4pOKLZgSzQRA1OZKNwDrXU
         hNdVUbhcyOOR31adqKBm0K445F8T0+wneR0lmNlG9rUeRPLneSG6nqTEltZXG5EyGBff
         gHBA==
X-Gm-Message-State: AGRZ1gL/nwD+tcbYM3wu0T4eXEhOKytnj3GOeVNqDTEtZ7z37piVYfV8
        Yyko5R0Tq5/ygrfxiziT6nc=
X-Google-Smtp-Source: AJdET5eLWWrQJ336e1/ozoruEIn29OPfIui3rYbAOFjhEutOxAWJjegUZJ3igJsSrhLwKsqpujG2Gw==
X-Received: by 2002:a63:9845:: with SMTP id l5mr16826749pgo.142.1542551932766;
        Sun, 18 Nov 2018 06:38:52 -0800 (PST)
Received: from sabyasachi ([45.116.191.228])
        by smtp.gmail.com with ESMTPSA id f22-v6sm45104867pff.29.2018.11.18.06.38.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:38:51 -0800 (PST)
Message-ID: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
X-Google-Original-Message-ID: <20181118143848.GA4276@sabyasachi.linux@gmail.com>
Date:   Sun, 18 Nov 2018 20:08:48 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] scsi/lpfc/lpfc_sli.c: Use dma_zalloc_coherent
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
 drivers/scsi/lpfc/lpfc_sli.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 783a154..3491ff7 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -6229,7 +6229,7 @@ lpfc_sli4_ras_dma_alloc(struct lpfc_hba *phba,
 			goto free_mem;
 		}
 
-		dmabuf->virt = dma_alloc_coherent(&phba->pcidev->dev,
+		dmabuf->virt = dma_zalloc_coherent(&phba->pcidev->dev,
 						  LPFC_RAS_MAX_ENTRY_SIZE,
 						  &dmabuf->phys,
 						  GFP_KERNEL);
@@ -6240,7 +6240,6 @@ lpfc_sli4_ras_dma_alloc(struct lpfc_hba *phba,
 					"6187 DMA Alloc Failed FW logging");
 			goto free_mem;
 		}
-		memset(dmabuf->virt, 0, LPFC_RAS_MAX_ENTRY_SIZE);
 		dmabuf->buffer_tag = i;
 		list_add_tail(&dmabuf->list, &ras_fwlog->fwlog_buff_list);
 	}
-- 
2.7.4

