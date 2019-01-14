Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49305C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2392A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfANKFn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:05:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7654 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbfANKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:05:42 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0E9tvHe015568;
        Mon, 14 Jan 2019 11:05:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pybxxybt6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 11:05:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A695638;
        Mon, 14 Jan 2019 10:05:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5EDE02AE9;
        Mon, 14 Jan 2019 10:05:15 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 14 Jan
 2019 11:05:14 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 14 Jan 2019 11:05:14 +0100
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH RESEND v8 0/6] Introduce STPMIC1 PMIC Driver
Thread-Topic: [PATCH RESEND v8 0/6] Introduce STPMIC1 PMIC Driver
Thread-Index: AQHUq/CkwxI635FyyUaeSDhRKlEYzw==
Date:   Mon, 14 Jan 2019 10:05:14 +0000
Message-ID: <1547460290-21049-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
STMicroelectronics. 
The STPMIC1 regulators supply power to an application processor as well as 
to external system peripherals such as DDR, Flash memories and system
devices. It also features onkey button input and an hardware watchdog.
The STPMIC1 is controlled via I2C. 

Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
as parent.

STPMIC1 MFD and regulator drivers maybe mandatory at boot time.

Pascal Paillet (6):
  dt-bindings: mfd: document stpmic1
  mfd: stpmic1: add stpmic1 driver
  dt-bindings: input: document stpmic1 pmic onkey
  input: stpmic1: add stpmic1 onkey driver
  dt-bindings: watchdog: document stpmic1 pmic watchdog
  watchdog: stpmic1: add stpmic1 watchdog driver

 .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +++
 .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++++++
 .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 ++
 drivers/input/misc/Kconfig                         |  11 ++
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmic1_onkey.c                 | 198 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  16 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stpmic1.c                              | 213 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  12 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmic1_wdt.c                     | 139 ++++++++++++++
 include/dt-bindings/mfd/st,stpmic1.h               |  50 +++++
 include/linux/mfd/stpmic1.h                        | 212 ++++++++++++++++++++
 14 files changed, 955 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
 create mode 100644 drivers/input/misc/stpmic1_onkey.c
 create mode 100644 drivers/mfd/stpmic1.c
 create mode 100644 drivers/watchdog/stpmic1_wdt.c
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
 create mode 100644 include/linux/mfd/stpmic1.h

-- 
1.9.1
