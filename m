Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBC7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58142146F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="hBZjXa5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58142146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeGQJNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:13:33 -0400
Received: from onstation.org ([52.200.56.107]:58194 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbeGQJNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:13:33 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E348F149;
        Tue, 17 Jul 2018 08:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531816923;
        bh=ZUI01+98nIMgCybDiERvGWQTIx0A0XLXN8dstPFVKVo=;
        h=From:To:Cc:Subject:Date:From;
        b=hBZjXa5TW1idOo/yCn5oTbtHyPhSx/Ydza2mgL5hfU7KHpHpsKkrYoVgtxLAwATvI
         0ZvPF5RWf4UlIDSkT4LWqCZGRJ6hsg0X3Iz7sDbTvXKcs03tR1VLDodwg3+z4i6D3p
         PSN4wO8lV9F5vagij1zrCHZ2hygGXeerYf7wZG24=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: [PATCH v2 0/7] ARM: dts: qcom: msm8974-hammerhead: add more sensors
Date:   Tue, 17 Jul 2018 04:41:51 -0400
Message-Id: <20180717084158.23532-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for the gyroscope / accelerometer
(mpu6515), magnetometer (ak8963), temperature / pressure (bmp280), and
proximity / ALS (tsl2772) sensors to the LG Nexus 5 (hammerhead) phone.

Changes since v1:
- Correct mpu6050 patch based on feedback from Jonathan Cameron. See
  that patch for more details.
- Add support for proximity / ALS driver (tsl2772).

Brian Masney (7):
  iio: imu: mpu6050: add support for regulator framework
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
    mpu6515
  iio: tsl2772: add support for reading power settings from device tree
  dt-bindings: trivial: remove tsl2772
  iio: tsl2772: add support for regulator framework
  iio: tsl2772: add device tree binding for avago,apds9930
  ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for ALS /
    proximity

 .../bindings/iio/imu/inv_mpu6050.txt          |   1 +
 .../devicetree/bindings/iio/light/tsl2772.txt |  44 +++++++
 .../devicetree/bindings/trivial-devices.txt   |  10 --
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  83 +++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           |  22 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  73 +++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   3 +
 drivers/iio/light/tsl2772.c                   | 116 +++++++++++++++++-
 include/dt-bindings/iio/amstaos,tsl2772.h     |  24 ++++
 9 files changed, 363 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
 create mode 100644 include/dt-bindings/iio/amstaos,tsl2772.h

-- 
2.17.1

