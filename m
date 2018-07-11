Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5153BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0431620936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="etIsGX73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0431620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeGKBSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:18:55 -0400
Received: from onstation.org ([52.200.56.107]:37622 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732309AbeGKBSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:18:55 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 206D2142;
        Wed, 11 Jul 2018 01:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531271384;
        bh=oGI4IypqPXvVbsKFhXRnahMc7RxmXOMOSn287LI4IwA=;
        h=From:To:Cc:Subject:Date:From;
        b=etIsGX73tNKyqUJj0bIK5pAAKEriFZwV/HI2nWWzw3FbadwKLz+V6TNefjFriNsG4
         3zo9sajQijf9wdgI+2F3TZQBTWeWP1Pwdn+Yu48enECgiEeL7eMTBq2a8bBEJT9TEa
         6bH7vNSURkY6kYYkcZmzapRsjfzg4Tv2o/oW3DJQ=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        masneyb@onstation.org
Subject: [PATCH 0/3] ARM: dts: qcom: msm8974-hammerhead: add support for mpu6515
Date:   Tue, 10 Jul 2018 21:09:29 -0400
Message-Id: <20180711010932.20313-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for the gyroscope / accelerometer
(mpu6515), magnetometer (ak8963), and temperature / pressure (bmp280)
sensors to the LG Nexus 5 (hammerhead) phone. Bindings for the MPU 6515
variant are added, along with regulator support to that driver in order
to correctly configure these drivers via device tree.

Brian Masney (3):
  iio: imu: mpu6050: add support for 6515 variant
  iio: imu: mpu6050: add support for regulator framework
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    mpu6515

 .../bindings/iio/imu/inv_mpu6050.txt          |  2 +
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 56 +++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 63 +++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  7 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  5 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  9 +++
 7 files changed, 147 insertions(+), 6 deletions(-)

-- 
2.17.1

