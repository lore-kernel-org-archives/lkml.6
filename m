Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CBFC282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6843A20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gaireg.de header.i=@gaireg.de header.b="aijAclXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfAVML5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:11:57 -0500
Received: from gaireg.de ([37.221.197.43]:48550 "EHLO gaireg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbfAVML4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:11:56 -0500
Received: from me.gaireg.de (unknown [194.8.217.178])
        by gaireg.de (Postfix) with ESMTPSA id CF1FB3C432A1;
        Tue, 22 Jan 2019 13:02:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gaireg.de; s=mail;
        t=1548158551; bh=tS1nsUg2kyh93EAJJNHlM2Tq9aBRi86I83CXMeiqe7E=;
        h=From:To:Cc:Subject:Date;
        b=aijAclXmlfLv+vv48Uenhze5+0PjuNj1SiapU4kBxijHUyVnV9PO9yliTu4g6kknU
         44DHGbx4Ecvzq2dAHnvmHKeijNiKNZfMFtyuTGfdWboaI/NY7SeZYTORcEAk2ADiVR
         7JwX9p46hQ/MxKOBPrX6t8wOjFwb0TeqWsWDe+/E=
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
        Martin Kelly <mkelly@xevo.com>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: imu: add icm20602 bindings to mpu6050
Date:   Tue, 22 Jan 2019 13:02:13 +0100
Message-Id: <20190122120221.27187-1-gaireg@gaireg.de>
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

