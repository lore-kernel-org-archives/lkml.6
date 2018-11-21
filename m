Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A66C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D10221479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuqwvCeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D10221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeKVAX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:23:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34680 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbeKVAX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:23:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so5644826plo.1;
        Wed, 21 Nov 2018 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=bCS9yRoap5lSFPEZzERHCkUHT9HEPOkVXZIfX7zFhU8=;
        b=UuqwvCeofMnVHNzrbjvIyIINDWyE+DhyWLMhXw3aSwNR8WtbhE5kQ2MPyJdPC+RV2W
         ck/kwRz2fMPdJOv9glgxyCcfJ2EdVEaeBRNRwSlyrCiXCfoS0Xela2pw9UV1HCfMIq2f
         36OkJKVzFUpJXg5tXC47IxwU3+CcGfA5Q47H2SicETm0/trAMk54JZQQDbK8IniQWOsm
         msqoJdMVq26oK2xheUMOSZ4LHYtAjsbKxW4qqF4jhRhFFJ14bbAAkK3QIjnIYFjetfZc
         gLnbX4e9VgtJ3UpuefvgVEBzfK6FyakcWXBXyhg/1zQXBeUB+c6BhRdcM3Uyt2pRlFld
         qbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=bCS9yRoap5lSFPEZzERHCkUHT9HEPOkVXZIfX7zFhU8=;
        b=e5+320Fuys+qx/Wryr5q348FUmXk+EzqqO5L9KDnA9AnHhrBOpB3LqS+Vji9z20YMx
         Sby2cr2+i/H8KFjr/jPP7Ofw8OJ6DGFf/evNjxXSkBSONkbgQffMHsTmxaKslEBXIF88
         YyZ7GAUfkKtZuNjlcBfeCGLg326/HbaTPqs7YYOlY+g2rtC1GT/NHeu2Vy32t74XFPzU
         wpq50zqsBq3tBfPBBpQb8cYrm3k0+MKraTRnW7k0ISNKw9R2bCYC93DXPy/UkjneWLMu
         ygAhY1s//w3yjVK1lODoF4wx0O+8Wo7khvGA6LYh871L/FNzAvoue1NH95erhxr40NXh
         sRYQ==
X-Gm-Message-State: AA+aEWbDMve5Nd7p9R4MQ4ZmipoTRk20UFMS2ob+W58YCsnnSYCa9xk4
        gr7dxUvXsP2QHbFMJ3lF4rk=
X-Google-Smtp-Source: AFSGD/UtiAowMex+eTh/6w6uIdl/06dnkH0vHSbBYI3kw8IQmgZihWX3VFtqil6KwMCSS9VmqX2C6g==
X-Received: by 2002:a63:4044:: with SMTP id n65mr5888031pga.90.1542808137132;
        Wed, 21 Nov 2018 05:48:57 -0800 (PST)
Received: from sabyasachi ([45.116.191.194])
        by smtp.gmail.com with ESMTPSA id 139sm38383001pfb.127.2018.11.21.05.48.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 05:48:56 -0800 (PST)
Message-ID: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com>
X-Google-Original-Message-ID: <20181121134852.GA3645@sabyasachi.linux@gmail.com>
Date:   Wed, 21 Nov 2018 19:18:52 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        jthumshirn@suse.de
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] scsi/mvsas/mv_init.c: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/scsi/mvsas/mv_init.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 3ac3437..495bddb 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 	/*
 	 * alloc and init our DMA areas
 	 */
-	mvi->tx = dma_alloc_coherent(mvi->dev,
+	mvi->tx = dma_zalloc_coherent(mvi->dev,
 				     sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
 				     &mvi->tx_dma, GFP_KERNEL);
 	if (!mvi->tx)
 		goto err_out;
-	memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
-	mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
+	mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
 					 &mvi->rx_fis_dma, GFP_KERNEL);
 	if (!mvi->rx_fis)
 		goto err_out;
-	memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
 
-	mvi->rx = dma_alloc_coherent(mvi->dev,
+	mvi->rx = dma_zalloc_coherent(mvi->dev,
 				     sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
 				     &mvi->rx_dma, GFP_KERNEL);
 	if (!mvi->rx)
 		goto err_out;
-	memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
 	mvi->rx[0] = cpu_to_le32(0xfff);
 	mvi->rx_cons = 0xfff;
 
-	mvi->slot = dma_alloc_coherent(mvi->dev,
+	mvi->slot = dma_zalloc_coherent(mvi->dev,
 				       sizeof(*mvi->slot) * slot_nr,
 				       &mvi->slot_dma, GFP_KERNEL);
 	if (!mvi->slot)
 		goto err_out;
-	memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
 
 	mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
 				       TRASH_BUCKET_SIZE,
-- 
2.7.4

