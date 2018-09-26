Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0DEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DDD20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ok0rOWGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DDD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeIZTWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:22:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60830 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:22:45 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QD9khO054304;
        Wed, 26 Sep 2018 08:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537967386;
        bh=SAjLsGIFLIi1p4wNRhbiinyMdtZBOloNauLFxQ4zXOc=;
        h=From:To:CC:Subject:Date;
        b=ok0rOWGUM2RwRHouWXhcsKtsgOblPboc/HSSOJ/evUAr51E8ikSplCgkF0hjAl0uM
         bebtDtJ72/S/EFONF3q0NTinIN/0X4Y/8IsX91prukTM9dmXDOH/Ka5emsV70BDty7
         6QxYh0knMx7pHxZRZu4pk5P3f2Wv3kzSdx/0Jfic=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9k3g021270;
        Wed, 26 Sep 2018 08:09:46 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 08:09:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 08:09:46 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QD9jAE003503;
        Wed, 26 Sep 2018 08:09:45 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.176.238])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8QD9jx11623;
        Wed, 26 Sep 2018 08:09:45 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 0/9] TI LMU and Dedicated LED drivers
Date:   Wed, 26 Sep 2018 08:09:12 -0500
Message-ID: <20180926130921.12329-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All

This is an attempt to create a common TI LMU code base that can be leveraged
by dedicate LED drivers.

This code is by no means complete as I am looking for comments on the
implementation and demonstrating the advantage of adding unique features within
a dedicated LED driver while using common code to perform common features.

Assuming that the implementation can be used the code will be debugged and the
DT bindings and TI-lmu code will be scrubbed.

Dan

Dan Murphy (8):
  dt-bindings: ti-lmu: Remove LM3697
  mfd: ti-lmu: Remove support for LM3697
  dt-bindings: leds: Add bindings for lm3697 driver
  leds: lm3697: Introduce the lm3697 driver
  dt-bindings: leds: Add support for the LM3633
  leds: lm3633: Introduce the lm3633 driver
  dt-bindings: leds: Add the LM3632 LED dt binding
  leds: lm3632: Introduce the TI LM3632 driver

Pavel Machek (1):
  leds: add TI LMU backlight driver

 .../devicetree/bindings/leds/leds-lm3632.txt  |  53 ++
 .../devicetree/bindings/leds/leds-lm3633.txt  |  69 +++
 .../devicetree/bindings/leds/leds-lm3697.txt  |  98 ++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  26 +-
 drivers/leds/Kconfig                          |  29 +
 drivers/leds/Makefile                         |   4 +
 drivers/leds/leds-lm3632.c                    | 547 ++++++++++++++++++
 drivers/leds/leds-lm3633.c                    | 430 ++++++++++++++
 drivers/leds/leds-lm3697.c                    | 389 +++++++++++++
 drivers/leds/ti-lmu-led-common.c              | 175 ++++++
 drivers/leds/ti-lmu-led-common.h              |  43 ++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/ti-lmu.c                          |  17 -
 include/linux/mfd/ti-lmu-register.h           |  44 --
 include/linux/mfd/ti-lmu.h                    |   1 -
 15 files changed, 1839 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3632.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3633.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
 create mode 100644 drivers/leds/leds-lm3632.c
 create mode 100644 drivers/leds/leds-lm3633.c
 create mode 100644 drivers/leds/leds-lm3697.c
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 drivers/leds/ti-lmu-led-common.h

-- 
2.19.0

