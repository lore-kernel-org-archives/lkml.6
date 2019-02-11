Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B285C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC1F2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896591;
	bh=w1zqwxMjaFBqHZh3kCmHe+fQQ63XD4ZVW5BBBBKFCiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gGZWIrD7byfdt1ilf0cxUPsHfRGc+I8Snn5C9qmYnyszsGw9clGFxDdr23p8FoIWB
	 4r6O2UvUI4bWKS4WCQZDrJVY2qKzoV9ExjVle6BtL7eyBemNX4DaPjQFg2RR0mkwep
	 YOxQEObPDNuqzmu5NoInYK5ImK6XZ4aBvURBkLIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbfBKOtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbfBKOtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:49:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BCF20700;
        Mon, 11 Feb 2019 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896586;
        bh=w1zqwxMjaFBqHZh3kCmHe+fQQ63XD4ZVW5BBBBKFCiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gk0m06nB7nUgbb/GFVpw5pYZ3Rk2TEoOLUS7Dcbx7v98t01r/jS4ylDVibpLjZbqC
         zHRhu8bCAu4mrGunkSPZlKpJwK9poKEnQ7YtBE0Wau4NzIMRmFGzHWvBHlC9ltIlrV
         qEKD8tsZeKZWvtb/U7gLNTNOdiXnvOya78dBLyVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 234/313] thermal: bcm2835: enable hwmon explicitly
Date:   Mon, 11 Feb 2019 15:18:34 +0100
Message-Id: <20190211141909.079048486@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d56c19d07e0bc3ceff366a49b7d7a2440c967b1b ]

By defaul of-based thermal driver do not enable hwmon.
This patch does this explicitly, so that the temperature can be read
through the common hwmon sysfs.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 23ad4f9f2143..24b006a95142 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -27,6 +27,8 @@
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
 
+#include "../thermal_hwmon.h"
+
 #define BCM2835_TS_TSENSCTL			0x00
 #define BCM2835_TS_TSENSSTAT			0x04
 
@@ -275,6 +277,15 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tz);
 
+	/*
+	 * Thermal_zone doesn't enable hwmon as default,
+	 * enable it here
+	 */
+	tz->tzp->no_hwmon = false;
+	err = thermal_add_hwmon_sysfs(tz);
+	if (err)
+		goto err_tz;
+
 	bcm2835_thermal_debugfs(pdev);
 
 	return 0;
-- 
2.19.1



