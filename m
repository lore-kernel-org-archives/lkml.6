Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F177C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1720869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="SKf+lX2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeL1SvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:51:23 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34452 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbeL1SvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:51:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id CD005D50
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 18:51:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GUTvsq7P6koi for <linux-kernel@vger.kernel.org>;
        Fri, 28 Dec 2018 12:51:20 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id A15E1D2D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 12:51:20 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id s3so20206167iob.15
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 10:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BKmAowL9CrGWw001NSvJtihXWXDshTIblf7Rok4lT+E=;
        b=SKf+lX2PJakHOLfeEZyYiQPqtZ2EyxWauTxKtioXYN45kSKia0u5BxYp70raqIBd00
         5fpUDNimW2K+3H6SRfNzrXAfafK44Dxj/XzphZ7k6WpvLfIkrLDfbYQp26pvC9FUj0/O
         5kRo4zy+OAMOidJxavNUGd2DsofPahGD1/hu6ux4eNjbA3xBzlegrpCpe0uwgwuZREzy
         xuDCdbFwtglUxdD2Q8FhhG06EzUG8dOVGuXU2qkEnTOaywXEdPQI7q1oa/lL3Eb9edfp
         uAddl4Y9dK+Akidmv27g5VPtdkVceNyr8XHEMy1H0iu+WIpJBx4JEHgLYuEpHZ+5ah+v
         q8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BKmAowL9CrGWw001NSvJtihXWXDshTIblf7Rok4lT+E=;
        b=J5LyIiEgBay1JZ4Txr6d7O1CVN61t/EFs65q18P6zYX3C+ExYJfHR3phz5+nVpkSp2
         YE4NX4kaPgjMWCQR+6ffFFpQBGlsR+Xh3IQQusqucLeOW1EfFwUvNktcxFfOtiwf3p5M
         DVdmra4OBSiJlDPTFvY9NmdV786h48eNkQnJvKI2/PtssPwNOECMJtJC2BTkhnf7AO4o
         Z8Q3CcD6bmOv1kXHtze9weiF7OKhKgiFkRPYVrn9eRHe9NWyaIah7c+hEpuMYaejooUv
         en4AXXdMwcUbZ+ycAX45lsRXYuEfzccFjmSfhP+jggS5dquGo1GKcC9gOF0R70KtY9Sh
         BNPQ==
X-Gm-Message-State: AJcUukfAAZ5b2TiZwQuH/xgQN8YoW8KOr0+qj6TSKu6fXAfaoUiIzjcX
        X5Ro1oEaXi3yQ+istJNmOhRRPUWwJE/ByGZC4DpVyrWBtd+/annmn219wIWzbKBikmxwtsaN7lz
        Z+CZMHebRt53ggVrq/6SKZF/MJ5Lj
X-Received: by 2002:a5d:8d18:: with SMTP id p24mr1765057ioj.223.1546023080240;
        Fri, 28 Dec 2018 10:51:20 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5dolxj3j7NBrvJfJRJz7xeln8Oz7Oq/6VgGfKgwhzJIuoTkiZV35HoZIXp2jyDRr7I4pJhHg==
X-Received: by 2002:a5d:8d18:: with SMTP id p24mr1765048ioj.223.1546023080017;
        Fri, 28 Dec 2018 10:51:20 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id z10sm19098372ioh.20.2018.12.28.10.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 10:51:19 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Erik Andren <erik.andren@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: gspca: mt9m111: Check write_bridge for timeout
Date:   Fri, 28 Dec 2018 12:51:10 -0600
Message-Id: <20181228185110.8579-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mt9m111_probe, m5602_write_bridge can timeout and return a negative
error value. The fix checks for this error and passes it upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/usb/gspca/m5602/m5602_mt9m111.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
index c9947c4a0f63..8fac814f4779 100644
--- a/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
+++ b/drivers/media/usb/gspca/m5602/m5602_mt9m111.c
@@ -199,7 +199,7 @@ static const struct v4l2_ctrl_config mt9m111_greenbal_cfg = {
 int mt9m111_probe(struct sd *sd)
 {
 	u8 data[2] = {0x00, 0x00};
-	int i;
+	int i, rc = 0;
 	struct gspca_dev *gspca_dev = (struct gspca_dev *)sd;
 
 	if (force_sensor) {
@@ -217,16 +217,18 @@ int mt9m111_probe(struct sd *sd)
 	/* Do the preinit */
 	for (i = 0; i < ARRAY_SIZE(preinit_mt9m111); i++) {
 		if (preinit_mt9m111[i][0] == BRIDGE) {
-			m5602_write_bridge(sd,
+			rc |= m5602_write_bridge(sd,
 				preinit_mt9m111[i][1],
 				preinit_mt9m111[i][2]);
 		} else {
 			data[0] = preinit_mt9m111[i][2];
 			data[1] = preinit_mt9m111[i][3];
-			m5602_write_sensor(sd,
+			rc |= m5602_write_sensor(sd,
 				preinit_mt9m111[i][1], data, 2);
 		}
 	}
+	if (rc < 0)
+		return rc;
 
 	if (m5602_read_sensor(sd, MT9M111_SC_CHIPVER, data, 2))
 		return -ENODEV;
-- 
2.17.1

