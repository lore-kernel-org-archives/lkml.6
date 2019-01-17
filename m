Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D51AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E667320854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="zL+KZsmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfAQDrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:47:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44011 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfAQDrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:47:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so4110496pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 19:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55pVNeFKzPaW8QlgBj+2v+k8YuG65KRmocIt1/5rBWI=;
        b=zL+KZsmo+vMJ/aqnQFhGrZ9iIBj/VJ3wDIdM07bamAKu+mcqFx6bD+++8M98Ac44Ub
         4xfewk5bq1a9iB9E9FUOywmqGhqGL83cpkfmp3jUoEiyHnFwPyJEYT0tX5dW0H7nbYb0
         g2GbMrrdBk5mXPdhuqYo2qMPrDf7re4QcB9srUYEdhjjp85HyeY9L3v4pTdvNc/Nu9XQ
         +VD1cNh+4SyYDkZDUDjbU6KTdx5DRME/aSMRkltsXx3vyay75oZIB1IFgUrUNxp8cWyy
         uQpenNZAllC+kXO2V5QozetXqfHOiIhrtszbmFmQulLfURMKok2tHwt4qKqlKCFsZfe+
         tyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55pVNeFKzPaW8QlgBj+2v+k8YuG65KRmocIt1/5rBWI=;
        b=bw0I7/GZN9tZVYbs8M/dnCtZ3jCLzLGta9qgdjQ+0KomtxGP0VnFuf7vVErvdTo/6x
         W7Ueal1xPwz1n2sGqdO59y6YH35gFMdWxZGk2mnVBtVndbFScu9dUobZg5OMKL810xAv
         RSGNs/rBNwlkPKWThmsZgvIJYVNYpjeWfSvde8WWqRi0C8/B9/zVHxClMX91/WRgioUF
         EaSSL4WT/ie2j94FOUe8pJzP62zv8/4fZ5DwSQgLQ+og6RijRlTdfjODsm0il0pVIT4j
         uWP1EnaLGcLDACtGXbbCF29aWmIk5vciZe0NAAQjIJLqxPycERyPwQxw0PHSaQsXvGXC
         W70g==
X-Gm-Message-State: AJcUukep8np6oaBTZ3+nauEiLrrT7Hp2Gwi9RkvUIY+c1JIwewLX20Pc
        oLT0A26ErB0vp8wqGoQR8SzZuw==
X-Google-Smtp-Source: ALg8bN76BAmuTEO/FhBVOCKJM8WpBJiQElk+jmdxavFUJA5M+8BMG/9E6fg83xDuQUv4rBkvCPS0Pw==
X-Received: by 2002:a62:c21c:: with SMTP id l28mr13195449pfg.74.1547696870898;
        Wed, 16 Jan 2019 19:47:50 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id c13sm310421pfo.121.2019.01.16.19.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 19:47:50 -0800 (PST)
Subject: [PATCH 3/3] scsi: arcmsr: Update driver version to
 v1.40.00.10-20190116
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 17 Jan 2019 11:47:48 +0800
Message-ID: <1547696868.4339.24.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update driver version to v1.40.00.10-20190116.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index b98c632..6033bcc 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -49,7 +49,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.40.00.10-20181217"
+#define ARCMSR_DRIVER_VERSION		"v1.40.00.10-20190116"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096


