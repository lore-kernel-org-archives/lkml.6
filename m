Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F602156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F602156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbeGEPOx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:14:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754068AbeGEPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:47 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65F4Wv2023381;
        Thu, 5 Jul 2018 17:14:23 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k0dr4hrxg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 17:14:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A84C31;
        Thu,  5 Jul 2018 15:14:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A04626D4;
        Thu,  5 Jul 2018 15:14:22 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 17:14:21 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 17:14:21 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 0/8] Introduce STPMU1 PMIC Driver
Thread-Topic: [PATCH 0/8] Introduce STPMU1 PMIC Driver
Thread-Index: AQHUFHLZyl88Q2RyOUKEJjkUD58ETA==
Date:   Thu, 5 Jul 2018 15:14:21 +0000
Message-ID: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The goal of this patch-set is to propose a driver for the STPMU1 PMIC from 
ST Microelectronics. 
The STPMU1 regulators supply power to an application processor as well as 
to external system peripherals such as DDR, Flash memories and system
devices. It also features onkey button input and an hardware watchdog.
The STPMU1 is controlled via I2C. 

Main driver is drivers/mfd/stpmu1 that handle I2C regmap configuration and
irqchip. stpmu1_regulator, stpmu1_onkey and stpmu1_wdt need stpmu1 mfd
as parent.

stpmu1 mfd regulator drivers maybe mandatory at boot time.

*** BLURB HERE ***

pascal paillet (8):
  dt-bindings: mfd: document stpmu1 pmic
  mfd: stpmu1: add stpmu1 pmic driver
  dt-bindings: regulator: document stpmu1 pmic regulators
  regulator: stpmu1: add stpmu1 regulator driver
  dt-bindings: input: document stpmu1 pmic onkey
  input: stpmu1: add stpmu1 onkey driver
  dt-bindings: watchdog: document stpmu1 pmic watchdog
  watchdog: stpmu1: add stpmu1 watchdog driver

 .../devicetree/bindings/input/st,stpmu1-onkey.txt  |  31 +
 .../devicetree/bindings/mfd/st,stpmu1.txt          | 138 ++++
 .../bindings/regulator/st,stpmu1-regulator.txt     |  72 ++
 .../devicetree/bindings/watchdog/st,stpmu1-wdt.txt |  11 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmu1_onkey.c                  | 321 +++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stpmu1.c                               | 490 +++++++++++
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/stpmu1_regulator.c               | 919 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmu1_wdt.c                      | 177 ++++
 include/dt-bindings/mfd/st,stpmu1.h                |  46 ++
 include/linux/mfd/stpmu1.h                         | 220 +++++
 18 files changed, 2480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmu1.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmu1-wdt.txt
 create mode 100644 drivers/input/misc/stpmu1_onkey.c
 create mode 100644 drivers/mfd/stpmu1.c
 create mode 100644 drivers/regulator/stpmu1_regulator.c
 create mode 100644 drivers/watchdog/stpmu1_wdt.c
 create mode 100644 include/dt-bindings/mfd/st,stpmu1.h
 create mode 100644 include/linux/mfd/stpmu1.h

-- 
1.9.1
