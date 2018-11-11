Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF98C20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF98C20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeKKVum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:50:42 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:56911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbeKKVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:50:42 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W0q-1fPBCS2EFm-016xot; Sun, 11 Nov 2018 13:01:38 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] hwmon: rpi: Fix initial notify
Date:   Sun, 11 Nov 2018 13:01:11 +0100
Message-Id: <1541937671-26385-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HEVIdEl0kizgBdNf0M5wstvyz7s6HdToU1mddQPsbGgHjkiBWSZ
 SKazwNvgO6cbViYoUW17vGwM+wtH3UvfMleX6l3XXOJUwGoJIZP7C9iMFyqzOhl1AlaWRQ+
 nGjpMnsO6ZoiSjYhxMPB911ALciozsvmmLqnauqOofp2A/Y1/Tcfzfrv2IhQJICMhDSNaco
 akAN1etmFdi29Cdupykhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tzezqudV+18=:I+avf+CPQCA+RPEHvwv55R
 iJN07WrrHGCkxDyTa1k+J8anYCg6oDlByPsB4O51GNXOi1XH2wPejZd6QJflDwV0IjWsd1mfU
 xmQwbUh5YsPt6czgCadtNhv89tCiiHGxGyLiNjZpXICCRYxcY9szc+T27wAi6tAeQsahSk7Zc
 P7+RqK/K3qtckuZiInGDWLzDvbMkItVWmxB/86m6NH4QbXCqJo/m0F6yZWCq1t/ocW/NmK9nH
 3sFSBLGNA+DGHqRLq1Tp+a+Xf1XuQlWwVYusgY3z9tNBdbTG9fQhBwac+oBJ+ZnF8S5WtdcSk
 T31iv44dd2DkPTXqRuzSBWKnMQIZbabtWOYI9paJgywle7kdbJJlWx/kHONkEeKdjM7+MCUVn
 9iAWGJiu9tZ+i+FxYqUlLGOlZZW/sJiXzizD+WQYXdDiNh9lU2926j9Ydc+vF5fF1DzwaLsTf
 7cvqwTu8gBFVOffZhsHT5+loV6D5WvJjY3JUPmhraz4ioeagBG6+s34gN3LtPYnUYNJO/Cd3Z
 CLnkDRAoKUNCeqhqsifSzcy49XV5h8YPrkSBWWBek7gAzU/DVI1mXLgcESMoe77NdlLeCqLUm
 0W+phul1X1/9/WPqPkr6j9E7MjgIbo7XcPtmy+treFmpnZWz5766NVHRJ+RPCN9RVFocCcILy
 +n2ryGG9Llo5cGCbUU+eSWsigfVGTGmQzvatSRpt262UKg3EyZrqtedY+GLnKMMvAqra/GKvs
 0SObqg+2lnFLxgOSq/dM7hz7QuKk2JFmfuuXu0T+aMTpc9ZZx90sE6kMjBz8cF+hBFutqehUk
 10cHzngQFaS21pN/PQ2gpU1ZlGFfqQ3gEjQz8zF7KGhTS5FiYY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case an under-voltage happens before probing the driver wont
write the critical warning into the kernel log. So don't init
of last_throttled during probe and fix this issue.

Fixes: 74d1e007915f ("hwmon: Add support for RPi voltage sensor")
Reported-by: "Noralf Trønnes" <noralf@tronnes.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/raspberrypi-hwmon.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
index be5ba46..0d04572 100644
--- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -115,7 +115,6 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpi_hwmon_data *data;
-	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -124,11 +123,6 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
 	/* Parent driver assure that firmware is correct */
 	data->fw = dev_get_drvdata(dev->parent);
 
-	/* Init throttled */
-	ret = rpi_firmware_property(data->fw, RPI_FIRMWARE_GET_THROTTLED,
-				    &data->last_throttled,
-				    sizeof(data->last_throttled));
-
 	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, "rpi_volt",
 							       data,
 							       &rpi_chip_info,
-- 
2.7.4

