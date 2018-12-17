Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DEEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A32145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="W9bKr07O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbeLQODM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:03:12 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36803 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732663AbeLQODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:03:12 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="21595809"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 17 Dec 2018 07:03:10 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:03:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkDVdw4pM7L0XImxVe1LE1yhSvhJaw8JZ0VcmDO1fbA=;
 b=W9bKr07OTHUoHYf0/0C5n98FjybiYZGxMSbXfbJIv6S80ZNdg/cdlgzHAP0trtnJoeC3sMpBuRdGTpqfkxZgGfWmE87ngyWmtoFoMtBWL4q5kRkI6CVsy1nsmKuFwGAsxpQq2Vs5xa6b/VJQC+IBKpcIHB4sW/evR2yRXCArzEI=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0504.namprd11.prod.outlook.com (10.163.158.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:03:07 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:03:07 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh@kernel.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v6 0/9] extend PWM framework to support PWM modes
Thread-Topic: [PATCH v6 0/9] extend PWM framework to support PWM modes
Thread-Index: AQHUlhE8HNT3QU0iq0yzJwofK9n4eQ==
Date:   Mon, 17 Dec 2018 14:03:07 +0000
Message-ID: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0118.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5f::34) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0504;6:vzEqWCxt4bZzrPCTHK9K6LLBmArLGd80GCZ0f6sHIrpK1La3wKyMpDlFfu7dFfShGUOZp22Zj+zEhvooA+uKXRnrVd5kUt8eaJiums16s/koO+S7GJdGzgP1a+sFjpyee464tot8i9utXtczP2wruOIk5SBrPW5P4cmi+AQ52bWN0mZgB6FnKPL1ycrR14RVBX081Kt6SxLiWnRFsTgIdBbqsbp7IUaznJEXWWwKp3P3MO9T10cGyEMZnyYCQuR7Q4GJ0ffTv/OwDtDWzoJ7iehlQTF0AaX3/ElB27FovwvnqXTiW7JWaDRo7QqTdaGrt1sAn5pgGHSGTWqW07bnaBYsPpzFqzEWEnU+x+lqp7iyVpqLIa7a/NldzzFzwPOL5k3sFWnH0Ci5oTmMh25oyTWKOQ6crbm4bzc2oqruADVUKi+5niTm1TxjiS9R61wHDzgSV1Weby3OW/ISmzSuZg==;5:A+/pArgDi9c5HUpp6/kwQOx9E1Wm7FiH6Zk9E/P5WEjFmSs9yRAJlsq4ge565rmBrke02j66h/VriUKVl/BzAxgtBT+Yr1FX+DjEDFmQfn2MbwXNrEE1LrbNslJDgNMPbnAKIm2O+QxG6VP5EYoVhdUBU6DFFDsfD9ToGd4CRmM=;7:DfElVGQwdyeTN/1d7DePmo6ckwaDxT0ApfBg9HMBmnR0DMW1WLYQRXDOROJkf9fWYRe07qYBfyVOEgbgm6JJTxq1tPO3zNDeh1bY3CjK40l9jdJAgu5Z/DSqwXEiUi/EJn+95HEJHN+pe9bfbHXRqw==
x-ms-office365-filtering-correlation-id: 267ce637-71ce-4939-eb2b-08d664285e76
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0504;
x-ms-traffictypediagnostic: BY2PR11MB0504:
x-microsoft-antispam-prvs: <BY2PR11MB0504E5E261E51E86EF0557CE87BC0@BY2PR11MB0504.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(4982022)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0504;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0504;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(52116002)(476003)(186003)(106356001)(14454004)(5660300001)(2906002)(97736004)(99286004)(25786009)(86362001)(2616005)(71200400001)(71190400001)(6436002)(6486002)(3846002)(6116002)(316002)(110136005)(54906003)(66066001)(486006)(26005)(6512007)(8936002)(81166006)(8676002)(36756003)(105586002)(102836004)(53936002)(6306002)(966005)(72206003)(81156014)(305945005)(6506007)(386003)(68736007)(39060400002)(478600001)(107886003)(7736002)(256004)(4326008)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0504;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yd4bJaQPfhN6926HKxvJCXowYtuaZpZShLJV3KGv7Yf/AP2mSm32FqdRYf/WISgqPbtu+HU1ZZ0sn3MJbkQHRDyLbxKvq/ioVtjI1mZ6U7aqzAxREUMBXHiqAhRpHWtAF7CgF2fj0ewXugUJH4xr0caNB1EB2XhqlsMJDnbB3jRC0DW3ffw0LvGPTfqN+dRd7cXhl8Wl5WEVf/mHJu/s2jMF4CfSIS+WQlokLwoclkauv55bcVjO8+37oLFkZEjBASXmzUA9hLOtHPiwuMNYfwea13CAjMeNcfVe2waJ4wmJ5pMuXZ5R2AIg6SHKDyYn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 267ce637-71ce-4939-eb2b-08d664285e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:03:07.0179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0504
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series extends PWM framework with PWM modes.

The current patch series add the following PWM modes:
- PWM mode normal
- PWM mode complementary
- PWM mode push-pull

In the following description PWMx_y refers to output y of PWM with ID x.

Normal mode - for PWM channels with one output; output waveforms looks like
this:
              __      __      __      __                                   =
     =20
    PWMx   __|  |____|  |____|  |____|  |__                                =
     =20
             ^       ^       ^       ^                                     =
     =20

    Where '^' specifies the beginning of a period.

Since PWMs with more than one output per channel could be used as one
output PWM the normal mode is the default mode for all PWMs (if not specifi=
ed
otherwise).

Complementary mode - for PWM channels with two outputs; output waveforms
for a PWM channel in complementary mode looks line this:
              __      __      __      __                                   =
     =20
    PWMx_0 __|  |____|  |____|  |____|  |__                                =
     =20
           __    ____    ____    ____    __                                =
     =20
    PWMx_1   |__|    |__|    |__|    |__|                                  =
     =20
             ^       ^       ^       ^                                     =
     =20

    Where '^' specifies the beginning of a period.

Push-pull mode - for PWM channels with two outputs; output waveforms for a
PWM channel in push-pull mode with normal polarity looks like this:
              __              __                                           =
      =20
    PWMx_0 __|  |____________|  |__________                                =
      =20
                      __              __                                   =
      =20
    PWMx_1 __________|  |____________|  |__                                =
      =20
             ^       ^       ^       ^                                     =
      =20

    If polarity is inversed:
           __    ____________    __________                                =
      =20
    PWMx_0   |__|            |__|                                          =
      =20
           __________    ____________    __                                =
      =20
    PWMx_1           |__|            |__|                                  =
      =20
             ^       ^       ^       ^                                     =
      =20

    Where '^' specifies the beginning of a period.
=20
The PWM working modes are per PWM channel registered as PWM's capabilities.
The driver registers itself to PWM core a get_caps() function, in
struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
If this function is not registered in driver's probe, a default function
will be used to retrieve PWM capabilities. Currently, the default
capabilities includes only PWM normal mode.

PWM state has been updated to keep PWM mode. PWM mode could be configured
via sysfs. pwm_apply_state() will do the preliminary validation for PWM mod=
e
to be applied.

In sysfs, user could get PWM modes by reading mode file of PWM device:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# ls -l
total 0
-r--r--r-- 1 root root 4096 Oct 11 18:08 capture
-rw-r--r-- 1 root root 4096 Oct 11 18:14 duty_cycle
-rw-r--r-- 1 root root 4096 Oct 11 18:11 enable
-rw-r--r-- 1 root root 4096 Oct 11 18:14 mode
-rw-r--r-- 1 root root 4096 Oct 11 18:09 period
-rw-r--r-- 1 root root 4096 Oct 11 18:14 polarity
drwxr-xr-x 2 root root    0 Oct 11 18:08 power
-rw-r--r-- 1 root root 4096 Oct 11 18:08 uevent
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
normal complementary [push-pull]

The mode enclosed in bracket is the currently active mode.

The mode could be set, via sysfs, by writing to mode file one of the modes
displayed at read:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# echo normal > mode
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
[normal] complementary push-pull=20

The PWM push-pull mode could be usefull in applications like half bridge
converters (see [1], page 2126).

This series also add PWM modes support for Atmel/Microchip SoCs.

Thank you,
Claudiu Beznea

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

Changes in v6:
- get rid of DT changes;
- get rid of get_default_caps member of struct pwm_chip;
- remove struct pwm_chip argument of pwm_get_caps(); caps are retrieved
  in the context of a PWM device and at this moment the chip should be vali=
d;
  also, get rid of chip->ops check in pwm_get_caps();
- rename pwm_mode_get_valid() function to pwm_get_default_modebit();
- rename mode member of struct pwm_caps to modes_msk;
- rename pwm_mode_valid() function to pwm_supports_mode() and rename
  its mode argument to modebit to emphasize what should be passed to it;
- rename pwm_mode_desc() to pwm_get_mode_name() and avoid returning "invali=
d"
  string; pwm_get_mode_name() is called only with a valid modebit;
- rename mode member of struct pwm_state to modebit to emphasize that it st=
ores
  a bitmask;
- use const arguments for pwm_get_default_modebit(), pwm_get_caps(),
  pwm_supports_mode() and get_caps() member of struct pwm_ops;
- change return type of pwm_ops::get_caps() to int;
- rename PWMC_MODE() macro to PWM_MODE_BIT();
- rename PWMC_MODE_<mode-name>_BIT enum members to PWM_MODE_<mode-name>;
- remove patches 2/9, 3/9, 4/9 from previous version since they were relate=
d
  to DT changes;
- use PWMx_y naming in documentation to emphasize it is talked about output
  y of PWM x;
- use 1/3 duty factor in waveforms from documentation patches;
- use '^' to emphasize the beginning of a new period in documentation patch=
es.

Changes in v5:
- solved kbuild errors by removing dummy functions for case where
  CONFIG_PWM is not defined; adopted this approach since the removed
  function are used only when CONFIG_PWM is defined (in PWM core
  and few drivers from drivers/pwm/ directory)

Changes in v4:
- removed changes related to pwm_config() as per maintainer proposals
- added pwm_mode_get_valid() to retrieve a valid PWM mode fror PWM device
  instead of using BIT(ffs(caps.mode) - 1) and changed drivers to use
  pwm_mode_get_valid() instead of pwm_get_caps() + BIT(ffs(caps.mode) - 1)
  (patches 2, 3, 4 from this series)
- renamed PWM_MODE() macro in PWMC_MODE() to avoid conflicts with
  pwm-sun4i.c driver ('C' stands for capability)
- removed pwm_caps_valid() function
- renamed PWM_DTMODE_COMPLEMENTARY and PWM_DTMODE_PUSH_PULL macros in
  PWM_MODE_COMPLEMENTARY and PWM_MODE_PUSH_PULL

Changes in v3:
- removed changes related to only one of_xlate function for all PWM drivers
- switch to PWM capabilities per PWM channel nor per PWM chip
- squash documentation and bindings patches as requeted by reviewer
- introduced PWM_MODE(name) macro and used a bit enum for pwm modes
- related to DT bindings, used flags cell also for PWM modes
- updated of_xlate specific functions with "state->mode =3D mode;"
  instructions to avoid pwm_apply_state() failures
- use available modes for PWM channel in pwm_config() by first calling
  pwm_get_caps() to get caps.modes
- use loops through available modes in mode_store()/mode_show() and also in
  of_pwm_xlate_with_flags() instead of "if else" instructions; in this way,
  the addition of a new mode is independent of this code sections
- use DTLI=3D1, DTHI=3D0 register settings to obtain push-pull mode wavefor=
ms
  for Atmel/Microchip PWM controller.

Changes in v2:
- remove of_xlate and of_pwm_n_cells and use generic functions to pharse DT
  inputs; this is done in patches 1, 2, 3, 4, 5, 6, 7 of this series; this =
will
  make easy the addition of PWM mode support from DT
- add PWM mode normal
- register PWM modes as capabilities of PWM chips at driver probe and, in c=
ase
  driver doesn't provide these capabilities use default ones
- change the way PWM mode is pharsed via DT by using a new input for pwms
  binding property


Claudiu Beznea (9):
  pwm: extend PWM framework with PWM modes
  pwm: clps711x: populate PWM mode in of_xlate function
  pwm: cros-ec: populate PWM mode in of_xlate function
  pwm: pxa: populate PWM mode in of_xlate function
  pwm: add PWM modes
  pwm: atmel: add pwm capabilities
  pwm: add push-pull mode support
  pwm: add documentation for pwm push-pull mode
  pwm: atmel: add push-pull mode support

 Documentation/devicetree/bindings/pwm/pwm.txt |  11 ++-
 Documentation/pwm.txt                         |  42 ++++++++-
 drivers/pwm/core.c                            | 125 ++++++++++++++++++++++=
+++-
 drivers/pwm/pwm-atmel.c                       | 118 +++++++++++++++++-----=
--
 drivers/pwm/pwm-clps711x.c                    |  10 ++-
 drivers/pwm/pwm-cros-ec.c                     |   1 +
 drivers/pwm/pwm-pxa.c                         |   1 +
 drivers/pwm/sysfs.c                           |  61 +++++++++++++
 include/dt-bindings/pwm/pwm.h                 |   2 +
 include/linux/pwm.h                           |  64 +++++++++++++
 10 files changed, 395 insertions(+), 40 deletions(-)

--=20
2.7.4

