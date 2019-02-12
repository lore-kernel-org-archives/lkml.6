Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831BBC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC012186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfBLObx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:31:53 -0500
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:59070 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbfBLObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:31:51 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2019 09:31:50 EST
Received: from jax4mhob17.registeredsite.com (jax4mhob17.registeredsite.com [64.69.218.105])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x1CEQ2eC011866
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:26:03 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.205])
        by jax4mhob17.registeredsite.com (8.14.4/8.14.4) with ESMTP id x1CEQ0KV149509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:26:00 -0500
Received: (qmail 28747 invoked by uid 0); 12 Feb 2019 14:26:00 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 12 Feb 2019 14:26:00 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] iio/gyro/bmg160: Use millidegrees for temperature scale
Date:   Tue, 12 Feb 2019 15:25:49 +0100
Message-Id: <1549981549-19786-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard unit for temperature is millidegrees Celcius, whereas this driver
was reporting in degrees. Fix the scale factor in the driver.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/gyro/bmg160_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 63ca316..ad7f8cb 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -585,8 +585,9 @@ static int bmg160_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val2 = 500000;
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = 500;
+			*val2 = 0;
+			return IIO_VAL_INT;
 		case IIO_ANGL_VEL:
 		{
 			int i;
-- 
1.9.1

