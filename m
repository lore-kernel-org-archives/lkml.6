Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB7EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8080520865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKten0Rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8080520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeKYUNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:13:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38886 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbeKYUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:13:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id k198so15427359wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TdR8mmJdImJ7ph0ciJmTC6f01Q2YSOFZoLIgnhGE7c=;
        b=TKten0Rvj1y+rU08cgy7RJSEpdpKU8Vomwfvzl+8J8LET67JEXCxFslmHFs6kHnr2V
         hQRySUSBT/GgFxeqUvt0OCMFq/SGUnMW8dlV7QEpXZN2U1wyJtg+prcrKXKT1L2kwBsp
         9m7Dxt2tZCkXHiw8DRDXdSZ+SlmWC/SWvG21qexxG2KIWzE/7ZZE2ecPZNLk9x+hdLyZ
         SMVuh03TeyV7FkhDFUBjEwuB6y5+aA4jvsmq30CP6ppkUUmtn8NvWiSpi3KNqiqeoJRG
         tGcCDjtvvhKrOK9+kU1Dd76dfP/muZCRSan0j7xpfVUumJ753nqrJpNpyfRHTz8rVDzy
         XAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TdR8mmJdImJ7ph0ciJmTC6f01Q2YSOFZoLIgnhGE7c=;
        b=Ms+lw/Am5EMdzK3WUJnj0W3AuW8aw2vm1ME4HIJ/TMgnC5VseGR/SHV2TjYOG+cQ7F
         6w1HBL8qs1CyA2ba7E/4TiTy7HD5vnVBI0hnYY6k3jxpz/uCGMsDQ8+IWgTXOL8FHbRu
         nHwgQu6xXNAGPSsR6im5F2EijFSptFhDrLuj5DiN/yVqSs1G5toBiz3CGysCRTWOkbxQ
         WkWyp3PuvPpwfeHXqPWVHTVKH4CuARp1SCUdxFxt9A1QFFVMXjScCyZBjdHvBxdaJXqt
         lAU3IvSVfai5VKOWpGflMMX1ugWnxk69u9LCsWKoVJZ9au6+wztc8zjvzyVQyK47reGf
         OC/g==
X-Gm-Message-State: AA+aEWYeDxX6jjTLPi23v/mnQeGABA/Ynuzpfa07c4rCq2XEGADo/Ugp
        GtyjuzCv5Hdz5+4jq1ObRoI=
X-Google-Smtp-Source: AFSGD/VHYxB0H8ueowGz6wF6GximfDokNwVRsxRGUAZkKnTfbiDryZ8IVCcjaHtPwsINvWdZGdo1zg==
X-Received: by 2002:a1c:2c3:: with SMTP id 186mr4438145wmc.112.1543137760337;
        Sun, 25 Nov 2018 01:22:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a125-v6sm9764614wmf.8.2018.11.25.01.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 01:22:39 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux@wolf-entwicklungen.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: pi433: fix potential null dereference
Date:   Sun, 25 Nov 2018 10:22:25 +0100
Message-Id: <20181125092225.10188-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for successful call to cdev_alloc() to avoid
potential null dereference. Issue reported by smatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 786478671190..d72de2105053 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1245,6 +1245,10 @@ static int pi433_probe(struct spi_device *spi)
 
 	/* create cdev */
 	device->cdev = cdev_alloc();
+	if (!device->cdev) {
+		dev_dbg(device->dev, "allocation of cdev failed");
+		goto cdev_failed;
+	}
 	device->cdev->owner = THIS_MODULE;
 	cdev_init(device->cdev, &pi433_fops);
 	retval = cdev_add(device->cdev, device->devt, 1);
-- 
2.19.2

