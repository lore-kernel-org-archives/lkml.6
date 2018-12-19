Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D3BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5FD205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="zBny0wqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeLSIxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:53:48 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43438 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbeLSIxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:53:48 -0500
Received: by mail-io1-f67.google.com with SMTP id g17so3185164ioc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WgdFPlLFkxQ/SMzDT9mj9aSUL5NFG4zY5RYSkN5hQ6g=;
        b=zBny0wqgIMvX+4jx0R61m3BbKSNWuWtyyP3M9qRtRwG2A8L8rNfy7twXruFZaF4guC
         W7DMaXRinMlM/bVGCxZsPr17xgSUppYOEbdheiMYA2WWbzfoznWCZMHc8SEWwOmUF0aH
         g97Q5BFFw3fKFeNGUMOLcIfnJssUAFz/8aF4I2U3RZ0avit7rHZ7zSWOOln+kcV09Qdz
         96fVxukApFZX0NraRRyvycsX6dkGMdz8lv0B6Qw68u+MShIhk2y7lo7kQJuZe1iTClac
         nmgm63Ch1ivTjt9JBfhSufuRGuZ20RFx0zN02TItUl5Th71RQV0l+ZCMEDLffHgmgYjh
         mT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WgdFPlLFkxQ/SMzDT9mj9aSUL5NFG4zY5RYSkN5hQ6g=;
        b=qtmFPpZje2ATXMb63pjt6QRkljjEmwExBRIzzLYs/xxmwBn80YdAENhe1E7x5QXi20
         F5SuT4C5OW0NUk58sU3XzqEt35h/W2w2XXV2EinXeXIbusD0wD/Qv3kusD8tX1uECAp9
         QZxpqoOryXgZoLSj1iUqUHZbhwl/dxDHup80sXmS0jmQgjg8q7a/JxuBnGREeOu9XkS9
         xuJcXK30EBAfDS/8O1BWY7kJtwJd79kxS150U8DUb2eaRn9DipiHqIddRQ2kCJ6jwilW
         MPNDtU/6zHMpGqPgq4+xSOvUZ7bkJn2FnvYmYwZTy9zeJHr2haxlTwMTrncCklbksprH
         eXdA==
X-Gm-Message-State: AA+aEWbzNfNemqtwhsHaK7pIJXiayQDxxJwh+yM+89AVAYL8s40c/REi
        bJJALcrmeqLDdOs/MltolgNLkg==
X-Google-Smtp-Source: AFSGD/X5f4Abkn6+amqimBhCexsWKKnCxBrsL/EDSHHgH6KiQfmZjDbOzqPDxWGVFL2UsyEQjTaJoA==
X-Received: by 2002:a5e:8611:: with SMTP id z17mr17438309ioj.35.1545209627879;
        Wed, 19 Dec 2018 00:53:47 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id o21sm8354301ioa.71.2018.12.19.00.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:53:47 -0800 (PST)
Subject: [PATCH 9/12] scsi: arcmsr: Add an option of set dma_mask_64 for
 ACB_ADAPTER_TYPE_A
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:53:44 +0800
Message-ID: <1545209624.4457.41.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Add an option of set dma_mask_64 for ACB_ADAPTER_TYPE_A

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 8cc2134..45f1374 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -91,6 +91,10 @@ static int cmd_per_lun = ARCMSR_DEFAULT_CMD_PERLUN;
 module_param(cmd_per_lun, int, S_IRUGO);
 MODULE_PARM_DESC(cmd_per_lun, " device queue depth(1 ~ 128), default is 32");
 
+static int dma_mask_64 = 0;
+module_param(dma_mask_64, int, S_IRUGO);
+MODULE_PARM_DESC(dma_mask_64, " set DMA mask to 64 bits(0 ~ 1), dma_mask_64=1(64 bits), =0(32 bits)");
+
 static int set_date_time = 0;
 module_param(set_date_time, int, S_IRUGO);
 MODULE_PARM_DESC(set_date_time, " send date, time to iop(0 ~ 1), set_date_time=1(enable), default(=0) is disable");


