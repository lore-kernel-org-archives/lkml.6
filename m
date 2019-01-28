Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6A3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8112171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gaireg.de header.i=@gaireg.de header.b="hNmXG3dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfA1Su2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:50:28 -0500
Received: from gaireg.de ([37.221.197.43]:36762 "EHLO gaireg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1Su1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:50:27 -0500
Received: from me.gaireg.de (unknown [194.8.217.178])
        by gaireg.de (Postfix) with ESMTPSA id E14413C8CE80;
        Mon, 28 Jan 2019 19:50:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gaireg.de; s=mail;
        t=1548701425; bh=7UFsrn5moslAQudTWKKZLys4BcG8++fMxXQq6NQ5D50=;
        h=From:To:Cc:Subject:Date;
        b=hNmXG3dRUMLj5xDhgyBH1F1SpPtkP6/7IK/abCU3FNDVubu4BgXOHaFc9xS0vVbvl
         2xotl4oAPCSSP7LVbqTfttMBBS+I2p6eQ9nl823UxQu0S7/kcGzbqoYQIWUSvHTZQ8
         tz8/ksKnIUOm5nLNNOyMAyhsiT/Iby7xUwCFyN6A=
From:   =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
To:     gaireg@gaireg.de
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        Martin Kelly <mkelly@xevo.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: add icm20602 bindings to mpu6050
Date:   Mon, 28 Jan 2019 19:50:02 +0100
Message-Id: <20190128185010.8275-1-gaireg@gaireg.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the invensense ICM-20602 to the compatible list of the mpu6050
driver

Signed-off-by: Randolph Maaßen <gaireg@gaireg.de>

---
Changes in v2:
- write i2c disable register using reg_set instead of define
- decide to write to i2c disable register based on reg_set instead of
  chip type
---
 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index 6ab9a9d196b0..268bf7568e19 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -11,6 +11,7 @@ Required properties:
 		"invensense,mpu9250"
 		"invensense,mpu9255"
 		"invensense,icm20608"
+		"invensense,icm20602"
  - reg : the I2C address of the sensor
  - interrupts: interrupt mapping for IRQ. It should be configured with flags
    IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
-- 
2.11.0

