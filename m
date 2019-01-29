Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB79AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BCF2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="TFpy7ecx";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="LXSBpit2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfA2JLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:11:19 -0500
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:35730 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbfA2JLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:11:18 -0500
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T947iZ028931
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to :
 subject : date : message-id; s=pp;
 bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
 b=TFpy7ecxszSfnsP2Igc6YS3diYf9H8xG0lTpPILCIX5el5mH6SISWeWYGG/dweALv+19
 Sfbq77ojp/LB2c4KgzL/ncJIAX+9we8wFqUbeZVWt29+2lFd1C4NLLOiY4213vYh9V1L
 crVUIzhKvZ4Fd3nDOH3LVDCcVE76gMnsTzFw8N97NMNf/E5Pt4MIBCbshUkpdGoYLPd4
 1+fGbxujT3+TM6ICzHpUF0zcBKSgKDi6KloKDrJNvD4wDN1nFXYngpiIN0dCxQlyqigk
 hnVRwMOQKVHE6MZaZKAZjMRBMYYlhfNcjEgeIC12ckMh/FJjiGb3vcrnAAGcfl1DE85H Yw== 
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        by mx08-00252a01.pphosted.com with ESMTP id 2q8cwk9efe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:11:16 +0000
Received: by mail-wr1-f72.google.com with SMTP id z16so7697228wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:subject:date:message-id;
        bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
        b=LXSBpit2684nUOXVcQL8YvdeNrw2m4gf2aaXN3Mf5lP2vbcIgWBIUho4LM0HCJ5q8s
         yO20Qg8u0Fp4kU5vxdubULpuriXy2UV0CmwAm2uyivDWHDDYgUhVdqe4xmAO2Iq8vWEb
         pRunYTYNADVz70oQY+CbR63h4gQl/QfjpNuct1kFN6jL9RPlDNmiwA3MGWX61Q0CLcYZ
         3X4vcrUm59LO4krM6CMnCfJ0eoEUmMzk4q3OrjF6PNzzP9eDvtGpofgBdK3k0t5D2kyL
         ZbX2hZhxG/9Iv+59zQ1QjDMPShklQTTZ8veR3lC+djAS5Yjei+lQC0cBqYgT06bp4KER
         AsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
        b=RGwBgIKEdmO1liM68TSGdsMB5rxeRBbQdfKH/TR67+KpD52kb4hvhPg6vQhslv8csV
         l9fN6+aFrP9PVxtFGJtzF9pk6SfzvY+cMB+br5FEObdh67hfLcar5CG1ksx+m1Zwb+Lo
         DMnHRbxPIzZViO1TCwuCuxzjmMhhxs+OggpV7EGxLyxPihfYoJaApD+Sw0+hJOOerAuZ
         I/+0KOvm61sjeljDctStFp5DlxBYvR2joSjwSKPJGHDoq0NQcEEJl/MZxIeE/Kr4XDg1
         c4QKum+tnjByyfJ2Oei2qigikPQ1iX85QjYryyJFJ9QXHBfEQG1Cjpc6W7OkiloM6Hzo
         Ndyw==
X-Gm-Message-State: AJcUukcsIUtR6YFCBWNleTstx+vsLqjZDMbwG/UduMWkqhqf4KXK2YR2
        U97469mWzcE6V3gCNFK/52dI8f1hUTB1fUBKTayWqyxhDJXHk51mopY0mBdRy1EtjKWDyaH7WMh
        27o7onsk6tTLTYh0dvf6U4Kw7
X-Received: by 2002:a1c:4301:: with SMTP id q1mr20210608wma.44.1548753075621;
        Tue, 29 Jan 2019 01:11:15 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6nI537X+I6vWaG5Wt7GxeftOX3oRnd5cez5yssTJNm2UwWOTlPy9JR3fM/osVnXYylo/DlCA==
X-Received: by 2002:a1c:4301:: with SMTP id q1mr20210579wma.44.1548753075335;
        Tue, 29 Jan 2019 01:11:15 -0800 (PST)
Received: from localhost.localdomain (cust51-dsl50.idnet.net. [212.69.50.51])
        by smtp.gmail.com with ESMTPSA id t18sm381114wmd.40.2019.01.29.01.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 01:11:14 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Elwell <phil@raspberrypi.org>, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date:   Tue, 29 Jan 2019 09:10:48 +0000
Message-Id: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
dereference in bcm2835_thermal_debugfs. The driver makes use of the
implementation details of the thermal framework to retrieve a pointer
to its private data from a struct thermal_zone_device, and gets it
wrong - leading to the crash. Instead, store its private data as the
drvdata and retrieve the thermal_zone_device pointer from it.

Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 720760c..ba39647 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -119,8 +119,7 @@ static const struct debugfs_reg32 bcm2835_thermal_regs[] = {
 
 static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
 	struct debugfs_regset32 *regset;
 
 	data->debugfsdir = debugfs_create_dir("bcm2835_thermal", NULL);
@@ -266,7 +265,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	data->tz = tz;
 
-	platform_set_drvdata(pdev, tz);
+	platform_set_drvdata(pdev, data);
 
 	/*
 	 * Thermal_zone doesn't enable hwmon as default,
@@ -290,8 +289,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 static int bcm2835_thermal_remove(struct platform_device *pdev)
 {
-	struct thermal_zone_device *tz = platform_get_drvdata(pdev);
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
+	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
 	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
-- 
2.7.4

