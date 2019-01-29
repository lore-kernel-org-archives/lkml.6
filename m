Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A5D20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="aQdtwq9r";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="U7QxeHps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfA2J4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:56:05 -0500
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:38396 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfA2J4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:56:05 -0500
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T9sILj030742
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to :
 subject : date : message-id; s=pp;
 bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
 b=aQdtwq9rBPZ/IWQi3fWgltcLA2PaTKVp3eYkd77TfLFU+wml9JoJlgC61u4tnx0UbbtF
 6tYvwcO0JxVF95+ZnfcCOMgCR7At+hPcHeoQCyE3yHSoQaJZBi6s4DJXeU80ACeNb90J
 8AIFjDKqjMg4vaDaEDdr6H66/8kjpUAcuv+s1/DSunIYWKzkdAw2IWf57xrE+GcMQt4p
 CUQVbmC/fubcxP8nCQyprsPbMgFKOMjN6fr4nt+b5zr2Fyz+jpzkQXMMj4LhYzyeZOE1
 yEi+rsCjokrQ0LYL1pwsB5bHBfPkLQ7XdnOdkVz+cTrlLV2Lk4/gEk35WHoKu/dc+XRI uw== 
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        by mx08-00252a01.pphosted.com with ESMTP id 2q8cwk9f8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:56:02 +0000
Received: by mail-wr1-f70.google.com with SMTP id l1so7818947wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:subject:date:message-id;
        bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
        b=U7QxeHpsZ0MgSR8wEehTzPKpMPChsHCI3WuB40S+LYyRoUdtfaYQiq8ZorqWEKvp9p
         Yb2+b2yP4UBY3MS0+VUkdR1lnbMhH4mefpvBOZR7xwQu0HhISS7rF4dXB2qb6qR++MS3
         GI4tfOUKGauxcBvYIifGRYO8aEHN7HP4i4zFmfTetXXATPA87WFm3MH3s4drp9SmEQM8
         fSMY1udzRP/jvLkdia+WLb7MBqGuhxRVOzWyvjQIYDYkd+n/BtDzX0pw9ibjLk507+zS
         RSxlqInkZxtGSWC5H6okWfCmjoapyJcJ+S2TuxC1aRBTdsY7Ieh21GDGS2c/9pK18AdW
         pymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=k+E40Tzc8px8cxD6PUEgzTs1U0d15EV2t5awtuJLmnk=;
        b=mwePmEFHVwfKnAKrRZaN7pWzZ6rrNz2OEzkcLCfZBIrVE5gtkFFIf8HQaDypn4iUrO
         6uTkLORNL//MIlnY//0jfW5h9MNlGDkzLOptJ4v3QLtOeRLH6rtQeTAfzG/cIazTPzVE
         Mliu/SrvY/jtQM3xQ/rpbu1MpAFzVOqtEWgm0T8B2zjVifI+nVmHy1N0xEmiQMokPGMM
         NaFTC8Zj3U9IzgKEX75BkUo7E5od4rJm8NJXtX3zszJOL+gwibhDZxbokbp9KKE3/BYJ
         Y+B0y9u7BSVpCusiD2K98Kmi8nGsijbfPYHQP5LAnvhPz2sD1btJ38LNR/BcXoJbwsht
         hO4A==
X-Gm-Message-State: AJcUukcrShBoP9ha4D/MgduJrZr367yHw8NsnZJWtGgfumW0iylPjqGu
        4RzCl4MmjcEBstiiv1IY1qKGxFL9cAmqOrcMlro5FaoYkFUdbVEOXEXjlouv5zzisGJAWCt6oCu
        /TYx91dCDjfexKIJ1YpYHyN8x
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr24199324wrw.135.1548755761657;
        Tue, 29 Jan 2019 01:56:01 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5U9ylZum2D6Wh7giVvVEQFjPMHrJTEm/hXb39NLipI3jQ2EJGiMhmgfsuEX7105kxhos18kA==
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr24199301wrw.135.1548755761417;
        Tue, 29 Jan 2019 01:56:01 -0800 (PST)
Received: from localhost.localdomain (cust51-dsl50.idnet.net. [212.69.50.51])
        by smtp.gmail.com with ESMTPSA id h131sm2775062wmd.17.2019.01.29.01.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 01:56:00 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Elwell <phil@raspberrypi.org>, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date:   Tue, 29 Jan 2019 09:55:57 +0000
Message-Id: <1548755757-79270-1-git-send-email-phil@raspberrypi.org>
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

