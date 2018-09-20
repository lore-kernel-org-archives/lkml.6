Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC88A21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="cdQIvt1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC88A21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbeITSW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:22:59 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:4794 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387404AbeITSW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:22:59 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 04/F3-27351-60593AB5; Thu, 20 Sep 2018 12:39:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfXcuO4mnjjPxaWjBoCLdGc6ClmX
  3DwYV0afIpI552kbbHDuTNJCWJTTtYmo6pfLSTF2mYFFpNzSl0lqU3e1iJmFLu1iIRUY7O8vq
  2+99f8/5P897eChMcZdUUnyWnbdZOJOKDMWj9HktLHnsVEr8yFCErrLTS+hu1Awh3bPRMULX2
  3ac1NU+uS/T5V3tlC8nkxtPNqLk1oqX8uQWj5NM/toycwO+mTBa0jKythEG38MuZH06hmV1Ol
  vlDvTdieWjUApnmjH46GwIHBRMoQwKPC9w6fAawQ3fXpSPplAko4aB8maZyNOZTVDu+Rkowph
  WGTRfaMNEEcGshJ6+A8GiVdDUNIwkToTeGhchMs7Mhvr9NwNMM6lQWO+SS91OI+hplIqmMBr4
  /MjrFxSFmBh49DhavMaYKHg+WBnIB4YB95V7mMSR8P7tr8CniNkKDt/x4L0a7j4ZRBKroGvfU
  1ziGHhQWYDEvsBcl4NjLFcuiXXw8Oh9QhK3EJRO3CElEQtHcmuDqTpwF+QFk5aAt/9ikE1woq
  iDkDgRxt1VwdCZ4Dn0BpdC2zGozf8YHCkazvQVYYVIU/HP6yRWQ9XlUVLiODhd/QGrCPyxcLh
  dPohXIdyDdGk2o95gN3NGE6uNj2e12gRWu2g+m7AgXsPtZjkNn8nu4gU7q9VwuwSNkG3ebkrX
  WHh7C/KvVrq1/fMlVL1f34FmUDJVJP14uCZFMTUtIz3bwAmGrbZMEy90oGiKUgGdUHIqRRFu4
  /V81g6jyb+ffzRQYarp9L5iv6YFK2cWjHpJdSOWcuc6XZgCt2RYeGUUrRYzGLHIkGmZjPiz5Q
  9QjDKCRiEhIYowK28zG+3/ex+KopAqgu4SW4UZLfbJTj7/EDL/EF9rq8Qh7NxfpXSgwm/q7qT
  voXWjOy2Jxj7zSE96HH1w/tKQAvX4L++A4cDZtTFhi+llG73XZ6v3zO2f9qosEp2b53Y1vSv7
  1Lt3Tfm0bGdCT07bHOv5K90rlrq2zOoanshd2Pij/Vplzk5oPewbr1O6wtsIVXGDt6T06EHPy
  3Diy2oH8NfeJ9nWp6aqcMHAaWMxm8D9BlOkF43gAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-21.tower-268.messagelabs.com!1537447173!7549402!1
X-Originating-IP: [23.103.133.178]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20416 invoked from network); 20 Sep 2018 12:39:34 -0000
Received: from mail-he1eur04lp0178.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (23.103.133.178)
  by server-21.tower-268.messagelabs.com with AES256-SHA256 encrypted SMTP; 20 Sep 2018 12:39:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GciN6tb32u39jZbB+uQY0hy/gknJq0EXGAafP39Xd7A=;
 b=cdQIvt1srfOcEGALy7NyCANWU1FXenzAr07+xxXWRe6ekDHkiJehoynW6uYGOzwAZRU2yv+F3SCNlYZxrcGuXJuXEuq+Msg8TXgaDEm4KLrtRnyJglitpcjwIcHS/w6kbWGXctb0fR0Wv4S9ncm7Q+KjYLxauC8r7COeAEp4qZs=
Received: from DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM (20.176.239.91) by
 DB7PR10MB1897.EURPRD10.PROD.OUTLOOK.COM (52.134.101.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Thu, 20 Sep 2018 12:39:22 +0000
Received: from DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f814:e2d0:5720:652b]) by DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f814:e2d0:5720:652b%2]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 12:39:22 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Roy Im <roy.im.opensource@diasemi.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH V6 3/3] Input: new da7280 haptic driver
Thread-Topic: [RESEND PATCH V6 3/3] Input: new da7280 haptic driver
Thread-Index: AQHUUAqHgVFFr40VvkySplbhm2vKUKT4U30AgABIvNA=
Date:   Thu, 20 Sep 2018 12:39:22 +0000
Message-ID: <DB7PR10MB216981FCE60933238212D10E85130@DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1537353304.git.Roy.Im@diasemi.com>
 <16c97389790bb9d37d247d18d0b51fdccc64e56a.1537353304.git.Roy.Im@diasemi.com>
 <20180920003510.GA228805@dtor-ws>
In-Reply-To: <20180920003510.GA228805@dtor-ws>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.100.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR10MB1897;6:VOoaLPDhUQN/X2jub0a57B07hKebb+MMT+CJpqTb/5sqFumdz0iiPCfsRpECcqvol5rvo0+EMEQqQufinlO3wFibSL8IKUdXzZGegs5864md7Lu+1PWB7mbGFMgW+oH9/6Sh0OlOZX/hWsjxT6gSVpOzOJ0h8hjl5iadNAUaD5DC17sJ8xGuH8qpQtT2TtYTb8b16M9UcrCmVDlZQJG9SAYLqd8Wp4FE4pz86A4t8dCgSoCO+dsm/5jeqHPvZEXIo1stsYODzE0BzdcRH5jRJGfEuKLehBoSjCrA8Sg7SQWM4iqlnNZQsmXHLiWPkOmBf32FKFGip4t0POyBF3Eyr2ORtlgx5UXhNwf/+bCeLnB+9pGuzTuOwD5RJ3PlaVSCffBha++XfFd4UKtKqak6Il0Zei4zU58snqq36sV2ToOzQpMwHutOO1Y3qlaChYGVk7dVvuSstBSRTD9VbiOfpg==;5:AC0X4IJyctXNCvoWCszomnDGQ08aTYjSQoR3wGw7M9X7bUEhrqzB2M68NWw2M+dtWX0iEU/IZYaU6hd3+q/YXkFIQPe2kp7sqZZ5jQlDzBg6PSOQxXQoXp8xmUk1a472A3O1u5feVUebFP2kYR34By29rXKi1TrHKv1pdCDRHvA=;7:OwjBHWu7QmwaPmkY2CsMOp3L4Jv59JS/1//Tub0W4s6NXvNGLPTQG0SiEL1metyCs0eBqEcr7f5fr0j5Q01Wve7hBhY5/3FwDG+HGD3XUgkVFLCsaW5OPKNsH70JoCfn/ZiqbqE5CctPbwXBkdNzSMswTa/bd0jLqwznf7X8YnXe6rYpCOM1HVajTYIjf/FxoyOms4uHQWYjvqIr1sYeoOdsIlZgleAbipLsnoGiBtcDPi2HLtZgEwNcoYDhfFzw
x-ms-office365-filtering-correlation-id: 38fc6815-1bb8-496b-8f4d-08d61ef617b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR10MB1897;
x-ms-traffictypediagnostic: DB7PR10MB1897:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c,ExtAddr
x-microsoft-antispam-prvs: <DB7PR10MB1897BB177516571D753A1133A2130@DB7PR10MB1897.EURPRD10.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB7PR10MB1897;BCL:0;PCL:0;RULEID:;SRVR:DB7PR10MB1897;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39850400004)(376002)(346002)(199004)(189003)(478600001)(6506007)(476003)(6246003)(53546011)(5250100002)(53946003)(39060400002)(9686003)(11346002)(4326008)(2900100001)(305945005)(7736002)(86362001)(55016002)(229853002)(71200400001)(71190400001)(16200700003)(316002)(66066001)(106356001)(54906003)(6436002)(186003)(26005)(486006)(105586002)(575784001)(446003)(33656002)(14454004)(102836004)(110136005)(68736007)(8676002)(5660300001)(74316002)(3846002)(5024004)(25786009)(14444005)(8936002)(99286004)(2906002)(6116002)(97736004)(76176011)(81156014)(7696005)(256004)(53936002)(81166006)(217873002)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB1897;H:DB7PR10MB2169.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eYt6aaOAdBpVgQiwGUQ1anv9Zu9Qi3vqiYG7v+zdLVtSJzzeRR3yBw3RM+WTtwLIMPRSslGeSyPkxL54s5zRk4ldqg0TwYREHH2VxLf8UlYkK4tVg4c2ABkdupDaY9pAWkW+tCXC4BOhf+5Jv4CuZn4Q/gyPeNBj0Nf1qzype7VcnCErC1k/dMgbU0Cd2flEl4XwGVGwxTnNl/RkAGQkzlQc+cZEIyXa9qRRzCMBhlY3VKNclbad8LeoUaYZyvEVwSnnldLGvywUHxKrsHPFXHb0DyPZyV1uHo/2zIfFN0LT1mukech3Vi/4sAp787hKzCO1tJltv/1CnAh+MWp0GeNgzWxkHEAJNPNnfoPfXAs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fc6815-1bb8-496b-8f4d-08d61ef617b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 12:39:22.6225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thursday, September 20, 2018 9:35 AM, Dmitry wrote:
>=20
> Hi Roy,
>=20
> On Wed, Sep 19, 2018 at 07:35:04PM +0900, Roy Im wrote:
> >
> > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> > multiple mode and integrated waveform memory and wideband support.
> > It communicates via an I2C bus to the device.
> >
> > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> >
> > ---
> > v6: No changes.
> > v5: Fixed errors in Kconfig file.
> > v4: Updated code as dt-bindings are changed.
> > v3: No changes.
> > v2: Fixed kbuild error/warning
> >
> >
> >  drivers/input/misc/Kconfig  |   13 +
> >  drivers/input/misc/Makefile |    1 +
> >  drivers/input/misc/da7280.c | 1438 +++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/input/misc/da7280.h |  412 +++++++++++++
> >  4 files changed, 1864 insertions(+)
> >  create mode 100644 drivers/input/misc/da7280.c
> >  create mode 100644 drivers/input/misc/da7280.h
> >
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index ca59a2b..751cac6 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -851,4 +851,17 @@ config INPUT_SC27XX_VIBRA
> >  	  To compile this driver as a module, choose M here. The module will
> >  	  be called sc27xx_vibra.
> >
> > +config INPUT_DA7280_HAPTICS
> > +	tristate "Dialog Semiconductor DA7280 haptics support"
> > +	depends on INPUT && I2C
> > +	select INPUT_FF_MEMLESS
> > +	select REGMAP_I2C
> > +	help
> > +	  Say Y to enable support for the Dialog DA7280 haptics driver.
> > +	  The haptics can be controlled by i2c communication,
> > +	  or by PWM input, or by GPI.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called da7280.
> > +
> >  endif
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index 9d0f9d1..d941348 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -25,6 +25,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+=3D cma3000_d0x.o
> >  obj-$(CONFIG_INPUT_CMA3000_I2C)		+=3D cma3000_d0x_i2c.o
> >  obj-$(CONFIG_INPUT_COBALT_BTNS)		+=3D cobalt_btns.o
> >  obj-$(CONFIG_INPUT_CPCAP_PWRBUTTON)	+=3D cpcap-pwrbutton.o
> > +obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+=3D da7280.o
> >  obj-$(CONFIG_INPUT_DA9052_ONKEY)	+=3D da9052_onkey.o
> >  obj-$(CONFIG_INPUT_DA9055_ONKEY)	+=3D da9055_onkey.o
> >  obj-$(CONFIG_INPUT_DA9063_ONKEY)	+=3D da9063_onkey.o
> > diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
> > new file mode 100644
> > index 0000000..041a9f4
> > --- /dev/null
> > +++ b/drivers/input/misc/da7280.c
> > @@ -0,0 +1,1438 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * DA7280 Haptic device driver
> > + *
> > + * Copyright (c) 2018 Dialog Semiconductor.
> > + * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/workqueue.h>
> > +#include "da7280.h"
> > +
> > +/* uV unit for voltage rate */
> > +#define DA7280_VOLTAGE_RATE_MAX		6000000
> > +#define DA7280_VOLTAGE_RATE_STEP	23400
> > +#define DA7280_NOMMAX_DFT		0x6B
> > +#define DA7280_ABSMAX_DFT		0x78
> > +
> > +#define DA7280_IMPD_MAX			1500000000
> > +#define DA7280_IMPD_DEFAULT		22000000
> > +
> > +#define DA7280_IMAX_DEFAULT		0x0E
> > +/* uA unit step and limit for IMAX*/
> > +#define DA7280_IMAX_STEP		7200
> > +#define DA7280_IMAX_LIMIT		252000
> > +
> > +#define DA7280_RESONT_FREQH_DFT		0x39
> > +#define DA7280_RESONT_FREQL_DFT		0x32
> > +#define DA7280_MIN_RESONAT_FREQ_HZ	50
> > +#define DA7280_MAX_RESONAT_FREQ_HZ	300
> > +#define DA7280_MIN_PWM_FREQ_KHZ		10
> > +#define DA7280_MAX_PWM_FREQ_KHZ		250
> > +
> > +#define DA7280_SEQ_ID_MAX		15
> > +#define DA7280_SEQ_LOOP_MAX		15
> > +#define DA7280_GPI1_SEQ_ID_DEFT	0x0
> > +
> > +#define DA7280_SNP_MEM_SIZE		100
> > +#define DA7280_SNP_MEM_MAX		DA7280_SNP_MEM_99
> > +
> > +#define IRQ_NUM				3
> > +
> > +#define DA7280_SKIP_INIT		0x100
> > +
> > +enum da7280_haptic_dev_t {
> > +	DA7280_LRA	=3D 0,
> > +	DA7280_ERM_BAR	=3D 1,
> > +	DA7280_ERM_COIN	=3D 2,
> > +	DA7280_DEV_MAX,
> > +};
> > +
> > +enum da7280_op_mode {
> > +	DA7280_INACTIVE		=3D 0,
> > +	DA7280_DRO_MODE		=3D 1,
> > +	DA7280_PWM_MODE		=3D 2,
> > +	DA7280_RTWM_MODE	=3D 3,
> > +	DA7280_ETWM_MODE	=3D 4,
> > +	DA7280_OPMODE_MAX,
> > +};
> > +
> > +struct da7280_gpi_ctl {
> > +	u8 seq_id;
> > +	u8 mode;
> > +	u8 polarity;
> > +};
> > +
> > +struct da7280_haptic {
> > +	struct regmap *regmap;
> > +	struct input_dev *input_dev;
> > +	struct device *dev;
> > +	struct i2c_client *client;
> > +	struct pwm_device *pwm_dev;
> > +	bool	legacy;
> > +	int pwm_id;
> > +	struct work_struct work;
> > +
> > +	bool suspend_state;
> > +	unsigned int magnitude;
> > +
> > +	u8 dev_type;
> > +	u8 op_mode;
> > +	u16 nommax;
> > +	u16 absmax;
> > +	u32 imax;
> > +	u32 impd;
> > +	u32 resonant_freq_h;
> > +	u32 resonant_freq_l;
> > +	u8 bemf_sense_en;
> > +	u8 freq_track_en;
> > +	u8 acc_en;
> > +	u8 rapid_stop_en;
> > +	u8 amp_pid_en;
> > +	u8 ps_seq_id;
> > +	u8 ps_seq_loop;
> > +	struct da7280_gpi_ctl gpi_ctl[3];
> > +	bool mem_update;
> > +	u8 snp_mem[DA7280_SNP_MEM_SIZE];
> > +	const struct attribute_group **attr_group;
> > +};
> > +
> > +static bool da7280_volatile_register(struct device *dev, unsigned int =
reg)
> > +{
> > +	switch (reg) {
> > +	case DA7280_IRQ_EVENT1:
> > +	case DA7280_IRQ_EVENT_WARNING_DIAG:
> > +	case DA7280_IRQ_EVENT_SEQ_DIAG:
> > +	case DA7280_IRQ_STATUS1:
> > +	case DA7280_TOP_CTL1:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +static const struct regmap_config da7280_haptic_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D DA7280_SNP_MEM_MAX,
> > +	.volatile_reg =3D da7280_volatile_register,
> > +};
> > +
> > +static int da7280_haptic_mem_update(struct da7280_haptic *haptics)
> > +{
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	/* It is recommended to update the patterns
> > +	 * during haptic is not working in order to avoid conflict
> > +	 */
> > +	ret =3D regmap_read(haptics->regmap, DA7280_IRQ_STATUS1, &val);
> > +	if (ret)
> > +		return ret;
> > +	if (val & DA7280_STA_WARNING_MASK) {
> > +		dev_warn(haptics->dev,
> > +			 "Warning! Please check HAPTIC status.\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	/* Patterns are not updated if the lock bit is enabled */
> > +	val =3D 0;
> > +	ret =3D regmap_read(haptics->regmap, DA7280_MEM_CTL2, &val);
> > +	if (ret)
> > +		return ret;
> > +	if (~val & DA7280_WAV_MEM_LOCK_MASK) {
> > +		dev_warn(haptics->dev,
> > +			 "Please unlock the bit first\n");
> > +		return -EACCES;
> > +	}
> > +
> > +	/* Set to Inactive mode to make sure safety */
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CTL1,
> > +				 DA7280_OPERATION_MODE_MASK,
> > +				 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_bulk_write(haptics->regmap, val,
> > +			haptics->snp_mem, DA7280_SNP_MEM_MAX - val + 1);
> > +}
> > +
> > +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics)
> > +{
> > +	struct pwm_args pargs;
> > +	u64 period_mag_multi;
> > +	unsigned int pwm_duty;
> > +	int ret;
> > +
> > +	pwm_get_args(haptics->pwm_dev, &pargs);
> > +	period_mag_multi =3D
> > +		(u64)(pargs.period * haptics->magnitude);
> > +	if (haptics->acc_en)
> > +		pwm_duty =3D
> > +			(unsigned int)(period_mag_multi >> 16);
> > +	else
> > +		pwm_duty =3D
> > +			(unsigned int)((period_mag_multi >> 16)
> > +				+ pargs.period) / 2;
> > +
> > +	ret =3D pwm_config(haptics->pwm_dev,
> > +			 pwm_duty, pargs.period);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to configure pwm : %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D pwm_enable(haptics->pwm_dev);
> > +	if (ret) {
> > +		pwm_disable(haptics->pwm_dev);
> > +		dev_err(haptics->dev,
> > +			"failed to enable haptics pwm device : %d\n", ret);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void da7280_haptic_enable(struct da7280_haptic *haptics)
> > +{
> > +	int ret =3D 0;
> > +
> > +	switch (haptics->op_mode) {
> > +	case DA7280_DRO_MODE:
> > +		/* the valid range check when acc_en is enabled */
> > +		if (haptics->acc_en && haptics->magnitude > 0x7F)
> > +			haptics->magnitude =3D 0x7F;
> > +		else if (haptics->magnitude > 0xFF)
> > +			haptics->magnitude =3D 0xFF;
> > +
> > +		/* Set driver level
> > +		 * as a % of ACTUATOR_NOMMAX(nommax)
> > +		 */
> > +		ret =3D regmap_write(haptics->regmap,
> > +				   DA7280_TOP_CTL2,
> > +				   haptics->magnitude);
> > +		if (ret) {
> > +			dev_err(haptics->dev,
> > +				"i2c err for driving level set : %d\n",
> > +				ret);
> > +			return;
> > +		}
> > +		break;
> > +	case DA7280_PWM_MODE:
> > +		if (da7280_haptic_set_pwm(haptics))
> > +			return;
> > +		break;
> > +	case DA7280_RTWM_MODE:
> > +		/* PS_SEQ_ID will be played
> > +		 * as many times as the PS_SEQ_LOOP
> > +		 */
> > +	case DA7280_ETWM_MODE:
> > +		/* Now users are able to control the GPI(N)
> > +		 * assigned to GPI_0, GPI1 and GPI2 accordingly
> > +		 * please see the datasheet for details.
> > +		 * GPI(N)_SEQUENCE_ID will be played
> > +		 * as many times as the PS_SEQ_LOOP
> > +		 */
> > +		break;
> > +	default:
> > +		dev_err(haptics->dev,
> > +			"Invalid Mode(%d)\n", haptics->op_mode);
> > +		return;
> > +	}
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CTL1,
> > +				 DA7280_OPERATION_MODE_MASK,
> > +				 haptics->op_mode);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"i2c err for op_mode setting : %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	if (haptics->op_mode =3D=3D DA7280_PWM_MODE ||
> > +	    haptics->op_mode =3D=3D DA7280_RTWM_MODE) {
> > +		ret =3D regmap_update_bits(haptics->regmap,
> > +					 DA7280_TOP_CTL1,
> > +					 DA7280_SEQ_START_MASK,
> > +					 DA7280_SEQ_START_MASK);
> > +		if (ret)
> > +			dev_err(haptics->dev,
> > +				"i2c err for sequence triggering : %d\n", ret);
> > +	}
> > +}
> > +
> > +static void da7280_haptic_disable(struct da7280_haptic *haptics)
> > +{
> > +	int ret;
> > +
> > +	/* Set to Inactive mode */
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CTL1,
> > +				 DA7280_OPERATION_MODE_MASK, 0);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"i2c err for op_mode off : %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	switch (haptics->op_mode) {
> > +	case DA7280_RTWM_MODE:
> > +	case DA7280_ETWM_MODE:
> > +		ret =3D regmap_update_bits(haptics->regmap,
> > +					 DA7280_TOP_CTL1,
> > +					 DA7280_SEQ_START_MASK, 0);
> > +		if (ret) {
> > +			dev_err(haptics->dev,
> > +				"i2c err for RTWM or ETWM mode off : %d\n",
> > +				ret);
> > +			return;
> > +		}
> > +		break;
> > +	case DA7280_DRO_MODE:
> > +		ret =3D regmap_write(haptics->regmap,
> > +				   DA7280_TOP_CTL2, 0);
> > +		if (ret) {
> > +			dev_err(haptics->dev,
> > +				"i2c err for DRO mode off : %d\n",
> > +				ret);
> > +			return;
> > +		}
> > +		break;
> > +	case DA7280_PWM_MODE:
> > +		pwm_disable(haptics->pwm_dev);
> > +		break;
> > +	default:
> > +		dev_err(haptics->dev,
> > +			"Invalid Mode(%d)\n", haptics->op_mode);
> > +		break;
> > +	}
> > +}
> > +
> > +static void da7280_haptic_work(struct work_struct *work)
> > +{
> > +	struct da7280_haptic *haptics =3D
> > +			container_of(work, struct da7280_haptic, work);
> > +
> > +	if (haptics->magnitude)
> > +		da7280_haptic_enable(haptics);
> > +	else
> > +		da7280_haptic_disable(haptics);
> > +}
> > +
> > +static int da7280_haptic_play(struct input_dev *dev, void *data,
> > +			      struct ff_effect *effect)
> > +{
> > +	struct da7280_haptic *haptics =3D input_get_drvdata(dev);
> > +
> > +	if (effect->u.rumble.strong_magnitude > 0)
> > +		haptics->magnitude =3D effect->u.rumble.strong_magnitude;
> > +	else if (effect->u.rumble.weak_magnitude > 0)
> > +		haptics->magnitude =3D effect->u.rumble.weak_magnitude;
> > +	else
> > +		haptics->magnitude =3D 0;
> > +
> > +	schedule_work(&haptics->work);
> > +
> > +	return 0;
> > +}
> > +
> > +static int da7280_haptic_open(struct input_dev *dev)
> > +{
> > +	struct da7280_haptic *haptics =3D input_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CTL1,
> > +				 DA7280_STANDBY_EN_MASK,
> > +				 DA7280_STANDBY_EN_MASK);
> > +	if (ret)
> > +		dev_err(haptics->dev,
> > +			"Failed to open haptic, i2c error : %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static void da7280_haptic_close(struct input_dev *dev)
> > +{
> > +	struct da7280_haptic *haptics =3D input_get_drvdata(dev);
> > +	int ret;
> > +
> > +	cancel_work_sync(&haptics->work);
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CTL1,
> > +				 DA7280_OPERATION_MODE_MASK, 0);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	if (haptics->op_mode =3D=3D DA7280_DRO_MODE) {
> > +		ret =3D regmap_write(haptics->regmap,
> > +				   DA7280_TOP_CTL2, 0);
> > +
> > +		if (ret)
> > +			goto error_i2c;
> > +	}
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CTL1,
> > +				 DA7280_STANDBY_EN_MASK, 0);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	return;
> > +
> > +error_i2c:
> > +	dev_err(haptics->dev, "DA7280-haptic i2c error : %d\n", ret);
> > +}
> > +
> > +static u8 da7280_haptic_of_mode_str(struct device *dev,
> > +				    const char *str)
> > +{
> > +	if (!strcmp(str, "LRA"))
> > +		return DA7280_LRA;
> > +	else if (!strcmp(str, "ERM-bar"))
> > +		return DA7280_ERM_BAR;
> > +	else if (!strcmp(str, "ERM-coin"))
> > +		return DA7280_ERM_COIN;
> > +
> > +	dev_warn(dev, "Invalid string - set to default\n");
> > +	return DA7280_LRA;
> > +}
> > +
> > +static u8 da7280_haptic_of_gpi_mode_str(struct device *dev,
> > +					const char *str)
> > +{
> > +	if (!strcmp(str, "Single-pattern"))
> > +		return 0;
> > +	else if (!strcmp(str, "Multi-pattern"))
> > +		return 1;
> > +
> > +	dev_warn(dev, "Invalid string - set to default\n");
> > +	return 0;
> > +}
> > +
> > +static u8 da7280_haptic_of_gpi_pol_str(struct device *dev,
> > +				       const char *str)
> > +{
> > +	if (!strcmp(str, "Rising-edge"))
> > +		return 0;
> > +	else if (!strcmp(str, "Falling-edge"))
> > +		return 1;
> > +	else if (!strcmp(str, "Both-edge"))
> > +		return 2;
> > +
> > +	dev_warn(dev, "Invalid string - set to default\n");
> > +	return 0;
> > +}
> > +
> > +static u8 da7280_haptic_of_volt_rating_set(u32 val)
> > +{
> > +	u32 voltage;
> > +
> > +	voltage =3D val / DA7280_VOLTAGE_RATE_STEP + 1;
> > +
> > +	if (voltage > 0xFF)
> > +		return 0xFF;
> > +	return (u8)voltage;
> > +}
> > +
> > +static void da7280_of_to_pdata(struct device *dev,
> > +			       struct da7280_haptic *haptics)
> > +{
> > +	struct device_node *np =3D dev->of_node;
> > +	char dt_gpi_str1[] =3D "dlg,gpi0-seq-id";
> > +	char dt_gpi_str2[] =3D "dlg,gpi0-mode";
> > +	char dt_gpi_str3[] =3D "dlg,gpi0-polarity";
> > +	unsigned int mem[DA7280_SNP_MEM_SIZE];
> > +	const char *of_str;
> > +	u32 of_val32;
> > +	int i;
> > +
> > +	if (!of_property_read_string(np, "dlg,actuator-type", &of_str))
> > +		haptics->dev_type =3D
> > +			da7280_haptic_of_mode_str(dev, of_str);
> > +	else /* if no property, then use the mode inside chip */
> > +		haptics->dev_type =3D DA7280_DEV_MAX;
>=20
> Nothing says that this device can only be used in OF systems. Please
> switch to generic device properties:
>=20
> 	if (!device_property_read_string(dev, "dlg,actuator-type", &of_str))
> 		...
>=20

I will switch to them in V7

> > +
> > +	if (of_property_read_u32(np, "dlg,op-mode", &of_val32) >=3D 0)
> > +		if (of_val32 && of_val32 < DA7280_OPMODE_MAX)
> > +			haptics->op_mode =3D of_val32;
> > +		else
> > +			haptics->op_mode =3D DA7280_DRO_MODE;
> > +	else
> > +		haptics->op_mode =3D DA7280_DRO_MODE;
> > +
> > +	if (of_property_read_u32(np, "dlg,nom-microvolt", &of_val32) >=3D 0)
> > +		if (of_val32 < DA7280_VOLTAGE_RATE_MAX)
> > +			haptics->nommax =3D
> > +				da7280_haptic_of_volt_rating_set(of_val32);
> > +		else
> > +			haptics->nommax =3D DA7280_SKIP_INIT;
> > +	else /* if no property, then use the value inside chip */
> > +		haptics->nommax =3D DA7280_SKIP_INIT;
> > +
> > +	if (of_property_read_u32(np, "dlg,abs-max-microvolt", &of_val32) >=3D=
 0)
> > +		if (of_val32 < DA7280_VOLTAGE_RATE_MAX)
> > +			haptics->absmax =3D
> > +				da7280_haptic_of_volt_rating_set(of_val32);
> > +		else
> > +			haptics->absmax =3D DA7280_SKIP_INIT;
> > +	else
> > +		haptics->absmax =3D DA7280_SKIP_INIT;
> > +
> > +	if (of_property_read_u32(np, "dlg,imax-microamp", &of_val32) >=3D 0)
> > +		if (of_val32 < DA7280_IMAX_LIMIT)
> > +			haptics->imax =3D (of_val32 - 28600)
> > +					/ DA7280_IMAX_STEP + 1;
> > +		else
> > +			haptics->imax =3D DA7280_IMAX_DEFAULT;
> > +	else
> > +		haptics->imax =3D DA7280_IMAX_DEFAULT;
> > +
> > +	if (of_property_read_u32(np, "dlg,impd-micro-ohms", &of_val32) >=3D 0=
)
> > +		if (of_val32 <=3D DA7280_IMPD_MAX)
> > +			haptics->impd =3D of_val32;
> > +		else
> > +			haptics->impd =3D DA7280_IMPD_DEFAULT;
> > +	else
> > +		haptics->impd =3D DA7280_IMPD_DEFAULT;
> > +
> > +	if (of_property_read_u32(np, "dlg,resonant-freq-hz", &of_val32) >=3D =
0) {
> > +		if (of_val32 < DA7280_MAX_RESONAT_FREQ_HZ &&
> > +		    of_val32 > DA7280_MIN_RESONAT_FREQ_HZ) {
> > +			haptics->resonant_freq_h =3D
> > +				((1000000000 / (of_val32 * 1333)) >> 7) & 0xFF;
> > +			haptics->resonant_freq_l =3D
> > +				(1000000000 / (of_val32 * 1333)) & 0x7F;
> > +		} else {
> > +			haptics->resonant_freq_h =3D
> > +				DA7280_RESONT_FREQH_DFT;
> > +			haptics->resonant_freq_l =3D
> > +				DA7280_RESONT_FREQL_DFT;
> > +		}
> > +	} else {
> > +		haptics->resonant_freq_h =3D DA7280_SKIP_INIT;
> > +		haptics->resonant_freq_l =3D DA7280_SKIP_INIT;
> > +	}
> > +
> > +	if (of_property_read_u32(np, "dlg,ps-seq-id", &of_val32) >=3D 0)
> > +		if (of_val32 <=3D DA7280_SEQ_ID_MAX)
> > +			haptics->ps_seq_id =3D of_val32;
> > +		else
> > +			haptics->ps_seq_id =3D 0;
> > +	else /* if no property, set to zero as a default do nothing */
> > +		haptics->ps_seq_id =3D 0;
> > +
> > +	if (of_property_read_u32(np, "dlg,ps-seq-loop", &of_val32) >=3D 0)
> > +		if (of_val32 <=3D DA7280_SEQ_LOOP_MAX)
> > +			haptics->ps_seq_loop =3D of_val32;
> > +		else
> > +			haptics->ps_seq_loop =3D 0;
> > +	else /* if no property, then do nothing */
> > +		haptics->ps_seq_loop =3D 0;
> > +
> > +	/* GPI0~2 Control */
> > +	for (i =3D 0; i < 3; i++) {
> > +		dt_gpi_str1[7] =3D '0' + i;
> > +		if (of_property_read_u32(np, dt_gpi_str1, &of_val32) >=3D 0)
> > +			if (of_val32 <=3D DA7280_SEQ_ID_MAX)
> > +				haptics->gpi_ctl[i].seq_id =3D of_val32;
> > +			else
> > +				haptics->gpi_ctl[i].seq_id =3D
> > +					DA7280_GPI1_SEQ_ID_DEFT + i;
> > +		else /* if no property, then do nothing */
> > +			haptics->gpi_ctl[i].seq_id =3D
> > +				DA7280_GPI1_SEQ_ID_DEFT + i;
> > +
> > +		dt_gpi_str2[7] =3D '0' + i;
> > +		if (!of_property_read_string(np, dt_gpi_str2, &of_str))
> > +			haptics->gpi_ctl[i].mode =3D
> > +				da7280_haptic_of_gpi_mode_str(dev, of_str);
> > +		else
> > +			haptics->gpi_ctl[i].mode =3D 0;
> > +
> > +		dt_gpi_str3[7] =3D '0' + i;
> > +		if (!of_property_read_string(np, dt_gpi_str3, &of_str))
> > +			haptics->gpi_ctl[i].polarity =3D
> > +				da7280_haptic_of_gpi_pol_str(dev, of_str);
> > +		else
> > +			haptics->gpi_ctl[i].polarity =3D 0;
> > +	}
> > +
> > +	haptics->bemf_sense_en =3D
> > +		of_property_read_bool(np, "dlg,bemf-sens-enable");
> > +	haptics->freq_track_en =3D
> > +		of_property_read_bool(np, "dlg,freq-track-enable");
> > +	haptics->acc_en =3D
> > +		of_property_read_bool(np, "dlg,acc-enable");
> > +	haptics->rapid_stop_en =3D
> > +		of_property_read_bool(np, "dlg,rapid-stop-enable");
> > +	haptics->amp_pid_en =3D
> > +		of_property_read_bool(np, "dlg,amp-pid-enable");
> > +
> > +	if (of_property_read_u32_array(np, "dlg,mem-array",
> > +				       &mem[0], DA7280_SNP_MEM_SIZE) >=3D 0) {
> > +		haptics->mem_update =3D 1;
> > +		for (i =3D 0; i < DA7280_SNP_MEM_SIZE; i++) {
> > +			if (mem[i] > 0xff)
> > +				haptics->snp_mem[i] =3D 0x0;
> > +			else
> > +				haptics->snp_mem[i] =3D (u8)mem[i];
> > +		}
> > +	} else {
> > +		haptics->mem_update =3D 0;
> > +	}
> > +}
> > +
> > +static irqreturn_t da7280_irq_handler(int irq, void *data)
> > +{
> > +	struct da7280_haptic *haptics =3D data;
> > +	u8 events[IRQ_NUM];
> > +	int ret;
> > +
> > +	/* Check what events have happened */
> > +	ret =3D regmap_bulk_read(haptics->regmap,
> > +			       DA7280_IRQ_EVENT1,
> > +			       events, IRQ_NUM);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	/* Empty check due to shared interrupt */
> > +	if ((events[0] | events[1] | events[2]) =3D=3D 0x00)
> > +		return IRQ_HANDLED;
> > +
> > +	if (events[0] & DA7280_E_SEQ_FAULT_MASK) {
> > +		/* Stop first if Haptic is working
> > +		 * Otherwise, the fault may happen continually
> > +		 * even though the bit is cleared.
> > +		 */
> > +		ret =3D regmap_update_bits(haptics->regmap,
> > +					 DA7280_TOP_CTL1,
> > +					 DA7280_OPERATION_MODE_MASK, 0);
> > +		if (ret)
> > +			goto error_i2c;
> > +	}
> > +
> > +	/* Clear events */
> > +	ret =3D regmap_write(haptics->regmap,
> > +			   DA7280_IRQ_EVENT1, events[0]);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	return IRQ_HANDLED;
> > +
> > +error_i2c:
> > +	dev_err(haptics->dev, "da7280 i2c error : %d\n", ret);
> > +	return IRQ_NONE;
> > +}
> > +
> > +static int da7280_init(struct da7280_haptic *haptics)
> > +{
> > +	int ret, i;
> > +	unsigned int val =3D 0;
> > +	u32 v2i_factor;
> > +	u8 mask =3D 0;
> > +
> > +	/* If device type is DA7280_DEV_MAX,
> > +	 * then just use default value inside chip.
> > +	 */
> > +	if (haptics->dev_type =3D=3D DA7280_DEV_MAX) {
> > +		ret =3D regmap_read(haptics->regmap, DA7280_TOP_CFG1, &val);
> > +		if (ret)
> > +			goto error_i2c;
> > +		if (val & DA7280_ACTUATOR_TYPE_MASK)
> > +			haptics->dev_type =3D DA7280_ERM_COIN;
> > +		else
> > +			haptics->dev_type =3D DA7280_LRA;
> > +	}
> > +
> > +	/* Apply user settings */
> > +	if (haptics->dev_type =3D=3D DA7280_LRA) {
> > +		if (haptics->resonant_freq_l !=3D DA7280_SKIP_INIT) {
> > +			ret =3D regmap_write(haptics->regmap,
> > +					   DA7280_FRQ_LRA_PER_H,
> > +					   haptics->resonant_freq_h);
> > +			if (ret)
> > +				goto error_i2c;
> > +			ret =3D regmap_write(haptics->regmap,
> > +					   DA7280_FRQ_LRA_PER_L,
> > +					   haptics->resonant_freq_l);
> > +			if (ret)
> > +				goto error_i2c;
> > +		}
> > +	} else if (haptics->dev_type =3D=3D DA7280_ERM_COIN) {
> > +		ret =3D regmap_update_bits(haptics->regmap,
> > +					 DA7280_TOP_INT_CFG1,
> > +					 DA7280_BEMF_FAULT_LIM_MASK, 0);
> > +		if (ret)
> > +			goto error_i2c;
> > +
> > +		ret =3D regmap_update_bits(haptics->regmap,
> > +					 DA7280_TOP_CFG4,
> > +					 DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
> > +					 DA7280_V2I_FACTOR_FREEZE_MASK,
> > +					 DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
> > +					 DA7280_V2I_FACTOR_FREEZE_MASK);
> > +		if (ret)
> > +			goto error_i2c;
> > +
> > +		haptics->acc_en =3D 0;
> > +		haptics->rapid_stop_en =3D 0;
> > +		haptics->amp_pid_en =3D 0;
> > +	}
> > +
> > +	/* Should be set to 0 only
> > +	 * in custom waveform and wideband operation
> > +	 */
> > +	if (haptics->op_mode >=3D DA7280_RTWM_MODE)
> > +		haptics->bemf_sense_en =3D 0;
> > +
> > +	mask =3D DA7280_ACTUATOR_TYPE_MASK |
> > +			DA7280_BEMF_SENSE_EN_MASK |
> > +			DA7280_FREQ_TRACK_EN_MASK |
> > +			DA7280_ACCELERATION_EN_MASK |
> > +			DA7280_RAPID_STOP_EN_MASK |
> > +			DA7280_AMP_PID_EN_MASK;
> > +
> > +	val =3D (haptics->dev_type ? 1 : 0)
> > +			<< DA7280_ACTUATOR_TYPE_SHIFT |
> > +		(haptics->bemf_sense_en ? 1 : 0)
> > +			<< DA7280_BEMF_SENSE_EN_SHIFT |
> > +		(haptics->freq_track_en ? 1 : 0)
> > +			<< DA7280_FREQ_TRACK_EN_SHIFT |
> > +		(haptics->acc_en ? 1 : 0)
> > +			<< DA7280_ACCELERATION_EN_SHIFT |
> > +		(haptics->rapid_stop_en ? 1 : 0)
> > +			<< DA7280_RAPID_STOP_EN_SHIFT |
> > +		(haptics->amp_pid_en ? 1 : 0)
> > +			<< DA7280_AMP_PID_EN_SHIFT;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CFG1, mask, val);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	if (haptics->nommax !=3D DA7280_SKIP_INIT) {
> > +		ret =3D regmap_write(haptics->regmap,
> > +				   DA7280_ACTUATOR1,
> > +				   haptics->nommax);
> > +		if (ret)
> > +			goto error_i2c;
> > +	}
> > +
> > +	if (haptics->absmax !=3D DA7280_SKIP_INIT) {
> > +		ret =3D regmap_write(haptics->regmap, DA7280_ACTUATOR2,
> > +				   haptics->absmax);
> > +		if (ret)
> > +			goto error_i2c;
> > +	}
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_ACTUATOR3,
> > +				 DA7280_IMAX_MASK,
> > +				 haptics->imax);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	v2i_factor =3D
> > +		haptics->impd * (haptics->imax + 4) / 1610400;
> > +	ret =3D regmap_write(haptics->regmap,
> > +			   DA7280_CALIB_V2I_L,
> > +			   v2i_factor & 0xff);
> > +	if (ret)
> > +		goto error_i2c;
> > +	ret =3D regmap_write(haptics->regmap,
> > +			   DA7280_CALIB_V2I_H,
> > +			   v2i_factor >> 8);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_TOP_CTL1,
> > +				 DA7280_STANDBY_EN_MASK,
> > +				 DA7280_STANDBY_EN_MASK);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	if (haptics->mem_update) {
> > +		ret =3D da7280_haptic_mem_update(haptics);
> > +		if (ret)
> > +			goto error_i2c;
> > +	}
> > +
> > +	/* Set  PS_SEQ_ID and PS_SEQ_LOOP */
> > +	val =3D haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> > +		haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
> > +	ret =3D regmap_write(haptics->regmap,
> > +			   DA7280_SEQ_CTL2, val);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	/* GPI(N) CTL */
> > +	for (i =3D 0; i < 3; i++) {
> > +		val =3D haptics->gpi_ctl[i].seq_id
> > +				<< DA7280_GPI0_SEQUENCE_ID_SHIFT |
> > +			haptics->gpi_ctl[i].mode
> > +				<< DA7280_GPI0_MODE_SHIFT |
> > +			haptics->gpi_ctl[i].polarity
> > +				<< DA7280_GPI0_POLARITY_SHIFT;
> > +		ret =3D regmap_write(haptics->regmap,
> > +				   DA7280_GPI_0_CTL + i, val);
> > +		if (ret)
> > +			goto error_i2c;
> > +	}
> > +
> > +	/* Clear Interrupts */
> > +	ret =3D regmap_write(haptics->regmap, DA7280_IRQ_EVENT1, 0xff);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_IRQ_MASK1,
> > +				 DA7280_SEQ_FAULT_M_MASK
> > +				 | DA7280_SEQ_DONE_M_MASK, 0);
> > +	if (ret)
> > +		goto error_i2c;
> > +
> > +	haptics->suspend_state =3D 0;
>=20
> 	haptics->suspend_state =3D false;
>=20

I will fix this in v7

> > +	return 0;
> > +
> > +error_i2c:
> > +	dev_err(haptics->dev, "haptic init - I2C error : %d\n", ret);
> > +	return ret;
> > +}
> > +
> > +/* Valid format for ps_seq_id
> > + * echo X > ps_seq_id
> > + * ex) echo 2 > /sys/class/..../ps_seq_id
> > + * 0 <=3D X <=3D 15.
> > + */
> > +static ssize_t ps_seq_id_store(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       const char *buf,
> > +			       size_t count)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	long val =3D 0xff;
> > +	int ret;
> > +
> > +	if (kstrtol(&buf[0], 0, &val) < 0)
> > +		goto err;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_SEQ_CTL2,
> > +				 DA7280_PS_SEQ_ID_MASK,
> > +				 (val & 0xf) >> DA7280_PS_SEQ_ID_SHIFT);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to update register : %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	haptics->ps_seq_id =3D val & 0xf;
> > +
> > +	return count;
> > +
> > +err:
> > +	dev_err(dev, "Invalid input\n");
> > +	return count;
> > +}
> > +
> > +static ssize_t ps_seq_id_show(struct device *dev,
> > +			      struct device_attribute *attr,
> > +			      char *buf)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	ret =3D regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to read register : %d\n", ret);
> > +		return ret;
> > +	}
> > +	val =3D (val & DA7280_PS_SEQ_ID_MASK)
> > +		>> DA7280_PS_SEQ_ID_SHIFT;
> > +
> > +	return sprintf(buf, "ps_seq_id is %d\n", val);
> > +}
> > +
> > +/* Valid format for ps_seq_loop
> > + * echo X > ps_seq_loop
> > + * ex) echo 2 > /sys/class/..../ps_seq_loop
> > + * 0 <=3D X <=3D 15.
> > + */
> > +static ssize_t ps_seq_loop_store(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 const char *buf,
> > +				 size_t count)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	long val =3D 0xff;
> > +	int ret;
> > +
> > +	if (kstrtol(&buf[0], 0, &val) < 0)
> > +		goto err;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_SEQ_CTL2,
> > +				 DA7280_PS_SEQ_LOOP_MASK,
> > +				 (val & 0xF) << DA7280_PS_SEQ_LOOP_SHIFT);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to update register : %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	haptics->ps_seq_loop =3D (val & 0xF);
> > +
> > +	return count;
> > +err:
> > +	dev_err(dev, "Invalid input value!\n");
> > +	return count;
> > +}
> > +
> > +static ssize_t ps_seq_loop_show(struct device *dev,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	int ret;
> > +	unsigned int val;
> > +
> > +	ret =3D regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to read register : %d\n", ret);
> > +		return ret;
> > +	}
> > +	val =3D (val & DA7280_PS_SEQ_LOOP_MASK)
> > +				>> DA7280_PS_SEQ_LOOP_SHIFT;
> > +
> > +	return sprintf(buf, "ps_seq_loop is %d\n", val);
> > +}
> > +
> > +/* Valid format for GPIx_SEQUENCE_ID
> > + * echo X Y > gpi_seq_id
> > + * ex) echo 2 15 > /sys/class/..../gpi_seq_id
> > + * 0 <=3D X < 3, 0<=3D Y <=3D 15.
> > + */
>=20
> Sysfs attributes should ideally be one value per file. Sounds like you
> want 4 attributes here for individual GPIs?
>=20

I will add 4 attributes instead of this in v7.

> > +static ssize_t gpi_seq_id_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf,
> > +				size_t count)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	u8 gpi_num =3D 0xff;
> > +	long seq_id =3D 0xff;
> > +	int ret;
> > +
> > +	if (count < 4)
> > +		goto err;
> > +
> > +	if (buf[0] >=3D '0')
> > +		gpi_num =3D buf[0] - '0';
> > +	else
> > +		goto err;
> > +
> > +	if (buf[1] !=3D ' ')
> > +		goto err;
> > +
> > +	if (kstrtol(&buf[2], 0, &seq_id) < 0)
> > +		goto err;
> > +
> > +	if (gpi_num > 2 || seq_id > 0xf)
> > +		goto err;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_GPI_0_CTL + gpi_num,
> > +				 DA7280_GPI0_SEQUENCE_ID_MASK,
> > +				 seq_id << DA7280_GPI0_SEQUENCE_ID_SHIFT);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to update register : %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	haptics->gpi_ctl[gpi_num].seq_id =3D seq_id;
> > +
> > +	return count;
> > +
> > +err:
> > +	dev_err(dev, "Invalid format or values!\n");
> > +	return count;
> > +}
> > +
> > +static ssize_t gpi_seq_id_show(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       char *buf)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	int ret;
> > +	unsigned int val, i;
> > +
> > +	for (i =3D 0; i < 3; i++) {
> > +		ret =3D regmap_read(haptics->regmap,
> > +				  DA7280_GPI_0_CTL + i, &val);
> > +		if (ret) {
> > +			dev_err(haptics->dev,
> > +				"failed to read register : %d\n", ret);
> > +			return ret;
> > +		}
> > +		haptics->gpi_ctl[i].seq_id =3D
> > +			(val & DA7280_GPI0_SEQUENCE_ID_MASK)
> > +				>> DA7280_GPI0_SEQUENCE_ID_SHIFT;
> > +		val =3D 0;
> > +	}
> > +
> > +	return sprintf(buf,
> > +		"Seq ID\nGPI0 : %d\nGPI1 : %d\nGPI2 : %d\n",
> > +		haptics->gpi_ctl[0].seq_id,
> > +		haptics->gpi_ctl[1].seq_id,
> > +		haptics->gpi_ctl[2].seq_id);
> > +}
> > +
> > +/* Valid format for GPIx_MODE
> > + * echo X Y > gpi_mode
> > + * ex) echo 2 1 > /sys/class/..../gpi_mode
> > + * 0 <=3D X < 3, 0<=3D Y <=3D 1.
> > + */
> > +static ssize_t gpi_mode_store(struct device *dev,
> > +			      struct device_attribute *attr,
> > +			      const char *buf, size_t count)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	u8 gpi_num =3D 0xff, gpi_mode =3D 0xff;
> > +	int ret;
> > +
> > +	if (count < 3)
> > +		goto err;
> > +
> > +	if (buf[0] >=3D '0')
> > +		gpi_num =3D buf[0] - '0';
> > +	if (buf[2] >=3D '0')
> > +		gpi_mode =3D buf[2] - '0';
> > +
> > +	if (gpi_num > 2 || gpi_mode > 1)
> > +		goto err;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_GPI_0_CTL + gpi_num,
> > +				 DA7280_GPI0_MODE_MASK,
> > +				 gpi_mode << DA7280_GPI0_MODE_SHIFT);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to update register : %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	haptics->gpi_ctl[gpi_num].mode =3D gpi_mode;
> > +
> > +	return count;
> > +
> > +err:
> > +	dev_err(dev, "Invalid format!\n");
> > +	return count;
> > +}
> > +
> > +static ssize_t gpi_mode_show(struct device *dev,
> > +			     struct device_attribute *attr,
> > +			     char *buf)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	int ret;
> > +	unsigned int val, i;
> > +
> > +	for (i =3D 0; i < 3; i++) {
> > +		ret =3D regmap_read(haptics->regmap,
> > +				  DA7280_GPI_0_CTL + i, &val);
> > +		if (ret) {
> > +			dev_err(haptics->dev,
> > +				"failed to read register : %d\n", ret);
> > +			return ret;
> > +		}
> > +		haptics->gpi_ctl[i].mode =3D
> > +			(val & DA7280_GPI0_MODE_MASK)
> > +				>> DA7280_GPI0_MODE_SHIFT;
> > +		val =3D 0;
> > +	}
> > +
> > +	return sprintf(buf, "Mode\nGPI0 : %d\nGPI1 : %d\nGPI2 : %d\n",
> > +		haptics->gpi_ctl[0].mode,
> > +		haptics->gpi_ctl[1].mode,
> > +		haptics->gpi_ctl[2].mode);
> > +}
> > +
> > +/* Valid format for GPIx_MODE
> > + *  echo X Y > gpi_pol
> > + *  ex) echo 2 1 > /sys/class/..../gpi_pol
> > + *  0 <=3D X < 3, 0<=3D Y <=3D 2.
> > + */
> > +static ssize_t gpi_pol_store(struct device *dev,
> > +			     struct device_attribute *attr,
> > +			     const char *buf,
> > +			     size_t count)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	u8 gpi_pol =3D 0xff, gpi_num =3D 0xff;
> > +	int ret;
> > +
> > +	if (count < 3)
> > +		goto err;
> > +
> > +	if (buf[0] >=3D '0')
> > +		gpi_num =3D buf[0] - '0';
> > +	if (buf[2] >=3D '0')
> > +		gpi_pol =3D buf[2] - '0';
> > +
> > +	if (gpi_num > 2 || gpi_pol > 2)
> > +		goto err;
> > +
> > +	ret =3D regmap_update_bits(haptics->regmap,
> > +				 DA7280_GPI_0_CTL + gpi_num,
> > +				 DA7280_GPI0_POLARITY_MASK,
> > +				 gpi_pol << DA7280_GPI0_POLARITY_SHIFT);
> > +	if (ret) {
> > +		dev_err(haptics->dev,
> > +			"failed to update register : %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	haptics->gpi_ctl[gpi_num].polarity =3D gpi_pol;
> > +
> > +	return count;
> > +
> > +err:
> > +	dev_err(dev, "Invalid format or input values!\n");
> > +	return count;
> > +}
> > +
> > +static ssize_t gpi_pol_show(struct device *dev,
> > +			    struct device_attribute *attr,
> > +			    char *buf)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	int ret =3D 0;
> > +	unsigned int val, i;
> > +
> > +	for (i =3D 0; i < 3; i++) {
> > +		ret =3D regmap_read(haptics->regmap,
> > +				  DA7280_GPI_0_CTL + i, &val);
> > +		if (ret)
> > +			return ret;
> > +		haptics->gpi_ctl[i].polarity =3D
> > +			(val & DA7280_GPI0_POLARITY_MASK)
> > +			>> DA7280_GPI0_POLARITY_SHIFT;
> > +		val =3D 0;
> > +	}
> > +
> > +	return sprintf(buf, "Polarity\nGPI0 : %d\nGPI1 : %d\nGPI2 : %d\n",
> > +		haptics->gpi_ctl[0].polarity,
> > +		haptics->gpi_ctl[1].polarity,
> > +		haptics->gpi_ctl[2].polarity);
> > +}
> > +
> > +#define MAX_PTN_REGS DA7280_SNP_MEM_SIZE
> > +#define MAX_USER_INPUT_LEN (5 * DA7280_SNP_MEM_SIZE)
> > +struct parse_data_t {
> > +	int len;
> > +	u8 val[MAX_PTN_REGS];
> > +};
> > +
> > +static int da7280_parse_args(struct device *dev,
> > +			     char *cmd, struct parse_data_t *ptn)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	char *tok;		/* used to separate tokens */
> > +	const char ct[] =3D " \t";	/* space or tab delimits the tokens */
> > +	int tok_count =3D 0;	/* total number of tokens parsed */
> > +	int i =3D 0, val;
> > +
> > +	ptn->len =3D 0;
> > +
> > +	/* parse the input string */
> > +	while ((tok =3D strsep(&cmd, ct)) !=3D NULL) {
> > +		/* this is a value to be written to the register */
> > +		if (kstrtouint(tok, 0, &val) < 0) {
> > +			dev_err(haptics->dev,
> > +				"failed to read from %s\n", tok);
> > +			break;
> > +		}
> > +
> > +		if (i < MAX_PTN_REGS) {
> > +			ptn->val[i] =3D val;
> > +			i++;
> > +		}
> > +		tok_count++;
> > +	}
> > +
> > +	/* decide whether it is a read or write operation based on the
> > +	 * value of tok_count and count_flag.
> > +	 * tok_count =3D 0: no inputs, invalid case.
> > +	 * tok_count =3D 1: write one value.
> > +	 * tok_count > 1: write multiple values/patterns.
> > +	 */
> > +	switch (tok_count) {
> > +	case 0:
> > +		return -EINVAL;
> > +	case 1:
> > +		ptn->len =3D 1;
> > +		break;
> > +	default:
> > +		ptn->len =3D i;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static ssize_t
> > +patterns_store(struct device *dev,
> > +	       struct device_attribute *attr,
> > +	       const char *buf,
> > +	       size_t count)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	struct parse_data_t mem;
> > +	char cmd[MAX_USER_INPUT_LEN];
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (count > MAX_USER_INPUT_LEN)
> > +		memcpy(cmd, buf, MAX_USER_INPUT_LEN);
> > +	else
> > +		memcpy(cmd, buf, count);
> > +	/* chop of '\n' introduced by echo at the end of the input */
> > +	if (cmd[count - 1] =3D=3D '\n')
> > +		cmd[count - 1] =3D '\0';
> > +
> > +	if (da7280_parse_args(dev, cmd, &mem) < 0)
> > +		return -EINVAL;
> > +
> > +	memcpy(haptics->snp_mem, mem.val, mem.len);
> > +
> > +	ret =3D da7280_haptic_mem_update(haptics);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(ps_seq_id);
> > +static DEVICE_ATTR_RW(ps_seq_loop);
> > +static DEVICE_ATTR_RW(gpi_seq_id);
> > +static DEVICE_ATTR_RW(gpi_mode);
> > +static DEVICE_ATTR_RW(gpi_pol);
> > +static DEVICE_ATTR_WO(patterns);
> > +static struct attribute *da7280_sysfs_attr[] =3D {
> > +	&dev_attr_ps_seq_id.attr,
> > +	&dev_attr_ps_seq_loop.attr,
> > +	&dev_attr_gpi_seq_id.attr,
> > +	&dev_attr_gpi_mode.attr,
> > +	&dev_attr_gpi_pol.attr,
> > +	&dev_attr_patterns.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group da7280_attr_group =3D {
> > +	.attrs =3D da7280_sysfs_attr,
> > +};
> > +
> > +static const struct attribute_group *da7280_attr_groups[] =3D {
> > +	&da7280_attr_group,
> > +	NULL,
> > +};
> > +
> > +static int da7280_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct da7280_haptic *haptics;
> > +	unsigned int period2freq;
> > +	int ret;
>=20
> I'd prefer if we called this "error"/

I will change it to "error" in v7

>=20
> > +
> > +	haptics =3D devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> > +	if (!haptics)
> > +		return -ENOMEM;
> > +	haptics->dev =3D dev;
> > +
> > +	if (!client->irq) {
> > +		dev_err(dev, "No IRQ configured\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Handle DT data if provided */
> > +	if (client->dev.of_node)
> > +		da7280_of_to_pdata(&client->dev, haptics);
> > +
> > +	if (haptics->op_mode =3D=3D DA7280_PWM_MODE) {
> > +		/* Get pwm and regulatot for haptics device */
> > +		haptics->pwm_dev =3D devm_pwm_get(&client->dev, NULL);
> > +		if (IS_ERR(haptics->pwm_dev)) {
> > +			dev_err(dev, "failed to get PWM device\n");
> > +			return PTR_ERR(haptics->pwm_dev);
> > +		}
> > +
> > +		/*
> > +		 * FIXME: pwm_apply_args() should be removed when switching to
> > +		 * the atomic PWM API.
> > +		 */
> > +		pwm_apply_args(haptics->pwm_dev);
> > +
> > +		/* Check PWM Period, it must be in 10k ~ 250kHz */
> > +		period2freq =3D 1000000 / pwm_get_period(haptics->pwm_dev);
> > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > +			dev_err(dev, "Not supported PWM frequency(%d)\n",
> > +				period2freq);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	INIT_WORK(&haptics->work, da7280_haptic_work);
> > +	haptics->client =3D client;
> > +	i2c_set_clientdata(client, haptics);
> > +
> > +	haptics->regmap =3D
> > +		devm_regmap_init_i2c(client, &da7280_haptic_regmap_config);
> > +	if (IS_ERR(haptics->regmap)) {
> > +		ret =3D PTR_ERR(haptics->regmap);
> > +		dev_err(dev, "Failed to allocate register map : %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> > +					da7280_irq_handler,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>=20
> Do not hard-code trigger, let platform set it up as needed. Use
> IRQF_ONESHOT only.

I will fix this in v7

>=20
> > +					"da7280-haptics", haptics);
> > +	if (ret !=3D 0) {
> > +		dev_err(dev,
> > +			"Failed to request IRQ : %d\n", client->irq);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D da7280_init(haptics);
> > +	if (ret) {
> > +		dev_err(dev, "failed to initialize device\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Initialize input device for haptic device */
> > +	haptics->input_dev =3D devm_input_allocate_device(dev);
> > +	if (!haptics->input_dev) {
> > +		dev_err(dev, "failed to allocate input device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	haptics->input_dev->name =3D "da7280-haptic";
> > +	haptics->input_dev->dev.parent =3D client->dev.parent;
> > +	haptics->input_dev->open =3D da7280_haptic_open;
> > +	haptics->input_dev->close =3D da7280_haptic_close;
> > +	input_set_drvdata(haptics->input_dev, haptics);
> > +	input_set_capability(haptics->input_dev, EV_FF, FF_RUMBLE);
> > +
> > +	ret =3D input_ff_create_memless(haptics->input_dev, NULL,
> > +				      da7280_haptic_play);
>=20
> The device seems to be able to load a custom waveform into memory, why
> do you use input_ff_create_memless() instead if setting it up as
> FF_CUSTOM?

The device has many modes to start/enable haptic driver. Two modes are trig=
gered/enabled by only magnitude value without any memory like direct mode a=
nd PWM mode. So I have used the input_ff_create_memless() for that modes an=
d for the waveform memory modes I added the way to load waveform data by dt=
-binding property and sysfs file then it can be used easily and then they a=
re triggered by magnitude value as well and external GPI event, so I think =
it can be covered accordingly.=20

>=20
> > +	if (ret) {
> > +		dev_err(dev, "failed to create force-feedback\n");
> > +		return ret;
> > +	}
> > +
> > +#ifdef CONFIG_SYSFS
> > +	haptics->input_dev->dev.groups =3D da7280_attr_groups;
>=20
> These properties control behavior of hardware device, not input device
> abstraction, so they should be attached to the platform device.
>=20
> Please use devm_device_add_group() or devm_device_add_groups().
>=20

I will fix this in v7

> > +#endif
> > +
> > +	ret =3D input_register_device(haptics->input_dev);
> > +	if (ret)
> > +		dev_err(dev, "failed to register input device\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int __maybe_unused da7280_suspend(struct device *dev)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&haptics->input_dev->mutex);
>=20
>=20
>=20
> > +	if (haptics->suspend_state =3D=3D 0) {
>=20
> 	if (!haptics->suspend_state) ...
>=20
> But how exactly can we get here if we already in suspend state?
>=20
> Also, maybe we shoudl check if device is in fact opened by anyone?
>=20
> Also, I think you should cancel outstanding work, if any.
>=20

I will fix this in v7

> > +		ret =3D regmap_update_bits(haptics->regmap,
> > +					 DA7280_TOP_CTL1,
> > +					 DA7280_STANDBY_EN_MASK, 0);
> > +		if (ret)
> > +			dev_err(haptics->dev,
> > +				"I2C error : %d\n", ret);
> > +		else
> > +			haptics->suspend_state =3D 1;
>=20
> 						=3D true;
>=20

I will fix this in v7

> > +	}
> > +	mutex_unlock(&haptics->input_dev->mutex);
> > +	return ret;
> > +}
> > +
> > +static int __maybe_unused da7280_resume(struct device *dev)
> > +{
> > +	struct da7280_haptic *haptics =3D dev_get_drvdata(dev);
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&haptics->input_dev->mutex);
> > +	if (haptics->suspend_state) {
>=20
> How can we get here if we are not in suspend state.
>=20

I will fix this in v7

> > +		ret =3D regmap_update_bits(haptics->regmap,
> > +					 DA7280_TOP_CTL1,
> > +					 DA7280_STANDBY_EN_MASK,
> > +					 DA7280_STANDBY_EN_MASK);
> > +		if (ret)
> > +			dev_err(haptics->dev,
> > +				"i2c error : %d\n", ret);
> > +		else
> > +			haptics->suspend_state =3D 0;
>=20
> 			=3D false;
>=20

I will fix this in v7

> > +	}
> > +	mutex_unlock(&haptics->input_dev->mutex);
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id da7280_of_match[] =3D {
> > +	{ .compatible =3D "dlg,da7280", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, da7280_of_match);
> > +
> > +static const struct i2c_device_id da7280_i2c_id[] =3D {
> > +	{ "da7280", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, da7280_i2c_id);
> > +
> > +static SIMPLE_DEV_PM_OPS(da7280_pm_ops,
> > +		 da7280_suspend, da7280_resume);
> > +
> > +static struct i2c_driver da7280_driver =3D {
> > +	.driver		=3D {
> > +		.name	=3D "da7280",
> > +		.of_match_table =3D of_match_ptr(da7280_of_match),
> > +		.pm	=3D &da7280_pm_ops,
> > +	},
> > +	.probe	=3D da7280_probe,
> > +	.id_table	=3D da7280_i2c_id,
> > +};
> > +module_i2c_driver(da7280_driver);
> > +
> > +MODULE_DESCRIPTION("DA7280 haptics driver");
> > +MODULE_AUTHOR("Roy Im <Roy.Im.Opensource@diasemi.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/input/misc/da7280.h b/drivers/input/misc/da7280.h
> > new file mode 100644
> > index 0000000..d9310b6
> > --- /dev/null
> > +++ b/drivers/input/misc/da7280.h
> > @@ -0,0 +1,412 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * DA7280 Haptic device driver registers
> > + *
> > + * Copyright (c) 2017 Dialog Semiconductor.
> > + * Author: Roy Im <Roy.Im.Opensource@diasemi.com>
> > + */
> > +
> > +#ifndef _DA7280_REG_DEFS_H
> > +#define _DA7280_REG_DEFS_H
> > +
> > +#include <linux/bitops.h>
> > +
> > +/* Registers */
> > +
> > +#define DA7280_CHIP_REV                       0x00
> > +#define DA7280_IRQ_EVENT1                     0x03
> > +#define DA7280_IRQ_EVENT_WARNING_DIAG         0x04
> > +#define DA7280_IRQ_EVENT_SEQ_DIAG             0x05
> > +#define DA7280_IRQ_STATUS1                    0x06
> > +#define DA7280_IRQ_MASK1                      0x07
> > +#define DA7280_CIF_I2C1                       0x08
> > +#define DA7280_FRQ_LRA_PER_H                  0x0A
> > +#define DA7280_FRQ_LRA_PER_L                  0x0B
> > +#define DA7280_ACTUATOR1                      0x0C
> > +#define DA7280_ACTUATOR2                      0x0D
> > +#define DA7280_ACTUATOR3                      0x0E
> > +#define DA7280_CALIB_V2I_H                    0x0F
> > +#define DA7280_CALIB_V2I_L                    0x10
> > +#define DA7280_CALIB_IMP_H                    0x11
> > +#define DA7280_CALIB_IMP_L                    0x12
> > +#define DA7280_TOP_CFG1                       0x13
> > +#define DA7280_TOP_CFG2                       0x14
> > +#define DA7280_TOP_CFG3                       0x15
> > +#define DA7280_TOP_CFG4                       0x16
> > +#define DA7280_TOP_INT_CFG1                   0x17
> > +#define DA7280_TOP_INT_CFG6_H                 0x1C
> > +#define DA7280_TOP_INT_CFG6_L                 0x1D
> > +#define DA7280_TOP_INT_CFG7_H                 0x1E
> > +#define DA7280_TOP_INT_CFG7_L                 0x1F
> > +#define DA7280_TOP_INT_CFG8                   0x20
> > +#define DA7280_TOP_CTL1                       0x22
> > +#define DA7280_TOP_CTL2                       0x23
> > +#define DA7280_SEQ_CTL1                       0x24
> > +#define DA7280_SWG_C1                         0x25
> > +#define DA7280_SWG_C2                         0x26
> > +#define DA7280_SWG_C3                         0x27
> > +#define DA7280_SEQ_CTL2                       0x28
> > +#define DA7280_GPI_0_CTL                      0x29
> > +#define DA7280_GPI_1_CTL                      0x2A
> > +#define DA7280_GPI_2_CTL                      0x2B
> > +#define DA7280_MEM_CTL1                       0x2C
> > +#define DA7280_MEM_CTL2                       0x2D
> > +#define DA7280_ADC_DATA_H1                    0x2E
> > +#define DA7280_ADC_DATA_L1                    0x2F
> > +#define DA7280_POLARITY                       0x43
> > +#define DA7280_LRA_AVR_H                      0x44
> > +#define DA7280_LRA_AVR_L                      0x45
> > +#define DA7280_FRQ_LRA_PER_ACT_H              0x46
> > +#define DA7280_FRQ_LRA_PER_ACT_L              0x47
> > +#define DA7280_FRQ_PHASE_H                    0x48
> > +#define DA7280_FRQ_PHASE_L                    0x49
> > +#define DA7280_FRQ_CTL                        0x4C
> > +#define DA7280_TRIM3                          0x5F
> > +#define DA7280_TRIM4                          0x60
> > +#define DA7280_TRIM6                          0x62
> > +#define DA7280_TOP_CFG5                       0x6E
> > +#define DA7280_IRQ_EVENT_ACTUATOR_FAULT       0x81
> > +#define DA7280_IRQ_STATUS2                    0x82
> > +#define DA7280_IRQ_MASK2                      0x83
> > +#define DA7280_SNP_MEM_0                      0x84
> > +#define DA7280_SNP_MEM_99                     0xE7
> > +
> > +/* DA7280_CHIP_REV (Address 0x00) */
> > +#define DA7280_CHIP_REV_MAJOR_SHIFT		0
> > +#define DA7280_CHIP_REV_MAJOR_MASK		(15 << 0)
> > +#define DA7280_CHIP_REV_MINOR_SHIFT		4
> > +#define DA7280_CHIP_REV_MINOR_MASK		(15 << 4)
> > +
> > +/* DA7280_IRQ_EVENT1 (Address 0x03) */
> > +#define DA7280_E_SEQ_CONTINUE_SHIFT		0
> > +#define DA7280_E_SEQ_CONTINUE_MASK		BIT(0)
> > +#define DA7280_E_UVLO_SHIFT			1
> > +#define DA7280_E_UVLO_MASK			BIT(1)
> > +#define DA7280_E_SEQ_DONE_SHIFT			2
> > +#define DA7280_E_SEQ_DONE_MASK			BIT(2)
> > +#define DA7280_E_OVERTEMP_CRIT_SHIFT		3
> > +#define DA7280_E_OVERTEMP_CRIT_MASK		BIT(3)
> > +#define DA7280_E_SEQ_FAULT_SHIFT		4
> > +#define DA7280_E_SEQ_FAULT_MASK			BIT(4)
> > +#define DA7280_E_WARNING_SHIFT			5
> > +#define DA7280_E_WARNING_MASK			BIT(5)
> > +#define DA7280_E_ACTUATOR_FAULT_SHIFT		6
> > +#define DA7280_E_ACTUATOR_FAULT_MASK		BIT(6)
> > +#define DA7280_E_OC_FAULT_SHIFT			7
> > +#define DA7280_E_OC_FAULT_MASK			BIT(7)
> > +
> > +/* DA7280_IRQ_EVENT_WARNING_DIAG (Address 0x04) */
> > +#define DA7280_E_OVERTEMP_WARN_SHIFT            3
> > +#define DA7280_E_OVERTEMP_WARN_MASK             BIT(3)
> > +#define DA7280_E_MEM_TYPE_SHIFT                 4
> > +#define DA7280_E_MEM_TYPE_MASK                  BIT(4)
> > +#define DA7280_E_LIM_DRIVE_ACC_SHIFT            6
> > +#define DA7280_E_LIM_DRIVE_ACC_MASK             BIT(6)
> > +#define DA7280_E_LIM_DRIVE_SHIFT                7
> > +#define DA7280_E_LIM_DRIVE_MASK                 BIT(7)
> > +
> > +/* DA7280_IRQ_EVENT_PAT_DIAG (Address 0x05) */
> > +#define DA7280_E_PWM_FAULT_SHIFT		5
> > +#define DA7280_E_PWM_FAULT_MASK			BIT(5)
> > +#define DA7280_E_MEM_FAULT_SHIFT		6
> > +#define DA7280_E_MEM_FAULT_MASK			BIT(6)
> > +#define DA7280_E_SEQ_ID_FAULT_SHIFT		7
> > +#define DA7280_E_SEQ_ID_FAULT_MASK		BIT(7)
> > +
> > +/* DA7280_IRQ_STATUS1 (Address 0x06) */
> > +#define DA7280_STA_SEQ_CONTINUE_SHIFT		0
> > +#define DA7280_STA_SEQ_CONTINUE_MASK		BIT(0)
> > +#define DA7280_STA_UVLO_VBAT_OK_SHIFT		1
> > +#define DA7280_STA_UVLO_VBAT_OK_MASK		BIT(1)
> > +#define DA7280_STA_SEQ_DONE_SHIFT		2
> > +#define DA7280_STA_SEQ_DONE_MASK		BIT(2)
> > +#define DA7280_STA_OVERTEMP_CRIT_SHIFT		3
> > +#define DA7280_STA_OVERTEMP_CRIT_MASK		BIT(3)
> > +#define DA7280_STA_SEQ_FAULT_SHIFT		4
> > +#define DA7280_STA_SEQ_FAULT_MASK		BIT(4)
> > +#define DA7280_STA_WARNING_SHIFT		5
> > +#define DA7280_STA_WARNING_MASK			BIT(5)
> > +#define DA7280_STA_ACTUATOR_SHIFT		6
> > +#define DA7280_STA_ACTUATOR_MASK		BIT(6)
> > +#define DA7280_STA_OC_SHIFT			7
> > +#define DA7280_STA_OC_MASK			BIT(7)
> > +
> > +/* DA7280_IRQ_MASK1 (Address 0x07) */
> > +#define DA7280_SEQ_CONTINUE_M_SHIFT		0
> > +#define DA7280_SEQ_CONTINUE_M_MASK		BIT(0)
> > +#define DA7280_E_UVLO_M_SHIFT			1
> > +#define DA7280_E_UVLO_M_MASK			BIT(1)
> > +#define DA7280_SEQ_DONE_M_SHIFT			2
> > +#define DA7280_SEQ_DONE_M_MASK			BIT(2)
> > +#define DA7280_OVERTEMP_CRIT_M_SHIFT		3
> > +#define DA7280_OVERTEMP_CRIT_M_MASK		BIT(3)
> > +#define DA7280_SEQ_FAULT_M_SHIFT		4
> > +#define DA7280_SEQ_FAULT_M_MASK			BIT(4)
> > +#define DA7280_WARNING_M_SHIFT			5
> > +#define DA7280_WARNING_M_MASK			BIT(5)
> > +#define DA7280_ACTUATOR_M_SHIFT			6
> > +#define DA7280_ACTUATOR_M_MASK			BIT(6)
> > +#define DA7280_OC_M_SHIFT			7
> > +#define DA7280_OC_M_MASK			BIT(7)
> > +
> > +/* DA7280_CIF_I2C1 (Address 0x08) */
> > +#define DA7280_I2C_TO_ENABLE_SHIFT		6
> > +#define DA7280_I2C_TO_ENABLE_MASK		BIT(6)
> > +#define DA7280_I2C_WR_MODE_SHIFT		7
> > +#define DA7280_I2C_WR_MODE_MASK			BIT(7)
> > +
> > +/* DA7280_FRQ_LRA_PER_H (Address 0x0a) */
> > +#define DA7280_LRA_PER_H_SHIFT			0
> > +#define DA7280_LRA_PER_H_MASK			(255 << 0)
> > +
> > +/* DA7280_FRQ_LRA_PER_L (Address 0x0b) */
> > +#define DA7280_LRA_PER_L_SHIFT			0
> > +#define DA7280_LRA_PER_L_MASK			(127 << 0)
> > +
> > +/* DA7280_ACTUATOR1 (Address 0x0c) */
> > +#define DA7280_ACTUATOR_NOMMAX_SHIFT		0
> > +#define DA7280_ACTUATOR_NOMMAX_MASK		(255 << 0)
> > +
> > +/* DA7280_ACTUATOR2 (Address 0x0d) */
> > +#define DA7280_ACTUATOR_ABSMAX_SHIFT		0
> > +#define DA7280_ACTUATOR_ABSMAX_MASK		(255 << 0)
> > +
> > +/* DA7280_ACTUATOR3 (Address 0x0e) */
> > +#define DA7280_IMAX_SHIFT			0
> > +#define DA7280_IMAX_MASK			(31 << 0)
> > +
> > +/* DA7280_CALIB_V2I_H (Address 0x0f) */
> > +#define DA7280_V2I_FACTOR_H_SHIFT		0
> > +#define DA7280_V2I_FACTOR_H_MASK		(255 << 0)
> > +
> > +/* DA7280_CALIB_V2I_L (Address 0x10) */
> > +#define DA7280_V2I_FACTOR_L_SHIFT		0
> > +#define DA7280_V2I_FACTOR_L_MASK		(255 << 0)
> > +
> > +/* DA7280_CALIB_IMP_H (Address 0x11) */
> > +#define DA7280_IMPEDANCE_H_SHIFT		0
> > +#define DA7280_IMPEDANCE_H_MASK			(255 << 0)
> > +
> > +/* DA7280_CALIB_IMP_L (Address 0x12) */
> > +#define DA7280_IMPEDANCE_L_SHIFT		0
> > +#define DA7280_IMPEDANCE_L_MASK			(3 << 0)
> > +
> > +/* DA7280_TOP_CFG1 (Address 0x13) */
> > +#define DA7280_AMP_PID_EN_SHIFT			0
> > +#define DA7280_AMP_PID_EN_MASK			BIT(0)
> > +#define DA7280_RAPID_STOP_EN_SHIFT		1
> > +#define DA7280_RAPID_STOP_EN_MASK		BIT(1)
> > +#define DA7280_ACCELERATION_EN_SHIFT		2
> > +#define DA7280_ACCELERATION_EN_MASK		BIT(2)
> > +#define DA7280_FREQ_TRACK_EN_SHIFT		3
> > +#define DA7280_FREQ_TRACK_EN_MASK		BIT(3)
> > +#define DA7280_BEMF_SENSE_EN_SHIFT		 4
> > +#define DA7280_BEMF_SENSE_EN_MASK		BIT(4)
> > +#define DA7280_ACTUATOR_TYPE_SHIFT		5
> > +#define DA7280_ACTUATOR_TYPE_MASK		BIT(5)
> > +#define DA7280_EMBEDDED_MODE_SHIFT		7
> > +#define DA7280_EMBEDDED_MODE_MASK		BIT(7)
> > +
> > +/* DA7280_TOP_CFG2 (Address 0x14) */
> > +#define DA7280_FULL_BRAKE_THR_SHIFT		0
> > +#define DA7280_FULL_BRAKE_THR_MASK		(15 << 0)
> > +#define DA7280_MEM_DATA_SIGNED_SHIFT		4
> > +#define DA7280_MEM_DATA_SIGNED_MASK		BIT(4)
> > +
> > +/* DA7280_TOP_CFG3 (Address 0x15) */
> > +#define DA7280_VDD_MARGIN_SHIFT			0
> > +#define DA7280_VDD_MARGIN_MASK			(15 << 0)
> > +
> > +/* DA7280_TOP_CFG4 (Address 0x16) */
> > +#define DA7280_TST_CALIB_IMPEDANCE_DIS_SHIFT	6
> > +#define DA7280_TST_CALIB_IMPEDANCE_DIS_MASK	BIT(6)
> > +#define DA7280_V2I_FACTOR_FREEZE_SHIFT		7
> > +#define DA7280_V2I_FACTOR_FREEZE_MASK		BIT(7)
> > +
> > +/* DA7280_TOP_INT_CFG1 (Address 0x17) */
> > +#define DA7280_BEMF_FAULT_LIM_SHIFT		0
> > +#define DA7280_BEMF_FAULT_LIM_MASK		(3 << 0)
> > +#define DA7280_FRQ_LOCKED_LIM_SHIFT		2
> > +#define DA7280_FRQ_LOCKED_LIM_MASK		(63 << 2)
> > +
> > +/* DA7280_TOP_INT_CFG6_H (Address 0x1c) */
> > +#define DA7280_FRQ_PID_KP_H_SHIFT		0
> > +#define DA7280_FRQ_PID_KP_H_MASK		(255 << 0)
> > +
> > +/* DA7280_TOP_INT_CFG6_L (Address 0x1d) */
> > +#define DA7280_FRQ_PID_KP_L_SHIFT		0
> > +#define DA7280_FRQ_PID_KP_L_MASK		(255 << 0)
> > +
> > +/* DA7280_TOP_INT_CFG7_H (Address 0x1e) */
> > +#define DA7280_FRQ_PID_KI_H_SHIFT		0
> > +#define DA7280_FRQ_PID_KI_H_MASK		(255 << 0)
> > +
> > +/* DA7280_TOP_INT_CFG7_L (Address 0x1f) */
> > +#define DA7280_FRQ_PID_KI_L_SHIFT		0
> > +#define DA7280_FRQ_PID_KI_L_MASK		(255 << 0)
> > +
> > +/* DA7280_TOP_INT_CFG8 (Address 0x20) */
> > +#define DA7280_TST_FRQ_TRACK_BEMF_LIM_SHIFT     0
> > +#define DA7280_TST_FRQ_TRACK_BEMF_LIM_MASK      (15 << 0)
> > +#define DA7280_TST_AMP_RAPID_STOP_LIM_SHIFT     4
> > +#define DA7280_TST_AMP_RAPID_STOP_LIM_MASK      (7 << 4)
> > +
> > +/* DA7280_TOP_CTL1 (Address 0x22) */
> > +#define DA7280_OPERATION_MODE_SHIFT		0
> > +#define DA7280_OPERATION_MODE_MASK		(7 << 0)
> > +#define DA7280_STANDBY_EN_SHIFT			3
> > +#define DA7280_STANDBY_EN_MASK			BIT(3)
> > +#define DA7280_SEQ_START_SHIFT			4
> > +#define DA7280_SEQ_START_MASK			BIT(4)
> > +
> > +/* DA7280_TOP_CTL2 (Address 0x23) */
> > +#define DA7280_OVERRIDE_VAL_SHIFT		0
> > +#define DA7280_OVERRIDE_VAL_MASK		(255 << 0)
> > +
> > +/* DA7280_SEQ_CTL1 (Address 0x24) */
> > +#define DA7280_SEQ_CONTINUE_SHIFT		0
> > +#define DA7280_SEQ_CONTINUE_MASK		BIT(0)
> > +#define DA7280_WAVEGEN_MODE_SHIFT		1
> > +#define DA7280_WAVEGEN_MODE_MASK		BIT(1)
> > +#define DA7280_FREQ_WAVEFORM_TIMEBASE_SHIFT	2
> > +#define DA7280_FREQ_WAVEFORM_TIMEBASE_MASK	BIT(2)
> > +
> > +/* DA7280_SWG_C1 (Address 0x25) */
> > +#define DA7280_CUSTOM_WAVE_GEN_COEFF1_SHIFT	0
> > +#define DA7280_CUSTOM_WAVE_GEN_COEFF1_MASK	(255 << 0)
> > +
> > +/* DA7280_SWG_C2 (Address 0x26) */
> > +#define DA7280_CUSTOM_WAVE_GEN_COEFF2_SHIFT	0
> > +#define DA7280_CUSTOM_WAVE_GEN_COEFF2_MASK	(255 << 0)
> > +
> > +/* DA7280_SWG_C3 (Address 0x27) */
> > +#define DA7280_CUSTOM_WAVE_GEN_COEFF3_SHIFT	0
> > +#define DA7280_CUSTOM_WAVE_GEN_COEFF3_MASK	(255 << 0)
> > +
> > +/* DA7280_SEQ_CTL2 (Address 0x28) */
> > +#define DA7280_PS_SEQ_ID_SHIFT			0
> > +#define DA7280_PS_SEQ_ID_MASK			(15 << 0)
> > +#define DA7280_PS_SEQ_LOOP_SHIFT		4
> > +#define DA7280_PS_SEQ_LOOP_MASK			(15 << 4)
> > +
> > +/* DA7280_GPIO_0_CTL (Address 0x29) */
> > +#define DA7280_GPI0_POLARITY_SHIFT		0
> > +#define DA7280_GPI0_POLARITY_MASK		(3 << 0)
> > +#define DA7280_GPI0_MODE_SHIFT			2
> > +#define DA7280_GPI0_MODE_MASK			BIT(2)
> > +#define DA7280_GPI0_SEQUENCE_ID_SHIFT		3
> > +#define DA7280_GPI0_SEQUENCE_ID_MASK		(15 << 3)
> > +
> > +/* DA7280_GPIO_1_CTL (Address 0x2a) */
> > +#define DA7280_GPI1_POLARITY_SHIFT		0
> > +#define DA7280_GPI1_POLARITY_MASK		(3 << 0)
> > +#define DA7280_GPI1_MODE_SHIFT			2
> > +#define DA7280_GPI1_MODE_MASK			BIT(2)
> > +#define DA7280_GPI1_SEQUENCE_ID_SHIFT		3
> > +#define DA7280_GPI1_SEQUENCE_ID_MASK		(15 << 3)
> > +
> > +/* DA7280_GPIO_2_CTL (Address 0x2b) */
> > +#define DA7280_GPI2_POLARITY_SHIFT		0
> > +#define DA7280_GPI2_POLARITY_MASK		(3 << 0)
> > +#define DA7280_GPI2_MODE_SHIFT			2
> > +#define DA7280_GPI2_MODE_MASK			BIT(2)
> > +#define DA7280_GPI2_SEQUENCE_ID_SHIFT		3
> > +#define DA7280_GPI2_SEQUENCE_ID_MASK		(15 << 3)
> > +
> > +/* DA7280_MEM_CTL1 (Address 0x2c) */
> > +#define DA7280_WAV_MEM_BASE_ADDR_SHIFT		0
> > +#define DA7280_WAV_MEM_BASE_ADDR_MASK		(255 << 0)
> > +
> > +/* DA7280_MEM_CTL2 (Address 0x2d) */
> > +#define DA7280_WAV_MEM_LOCK_SHIFT		7
> > +#define DA7280_WAV_MEM_LOCK_MASK		BIT(7)
> > +
> > +/* DA7280_ADC_DATA_H1 (Address 0x2e) */
> > +#define DA7280_ADC_VDD_H_SHIFT			0
> > +#define DA7280_ADC_VDD_H_MASK			(255 << 0)
> > +
> > +/* DA7280_ADC_DATA_L1 (Address 0x2f) */
> > +#define DA7280_ADC_VDD_L_SHIFT			0
> > +#define DA7280_ADC_VDD_L_MASK			(127 << 0)
> > +
> > +/* DA7280_POLARITY (Address 0x43) */
> > +#define DA7280_POLARITY_SHIFT			0
> > +#define DA7280_POLARITY_MASK			BIT(0)
> > +
> > +/* DA7280_LRA_AVR_H (Address 0x44) */
> > +#define DA7280_LRA_PER_AVERAGE_H_SHIFT		0
> > +#define DA7280_LRA_PER_AVERAGE_H_MASK		(255 << 0)
> > +
> > +/* DA7280_LRA_AVR_L (Address 0x45) */
> > +#define DA7280_LRA_PER_AVERAGE_L_SHIFT		0
> > +#define DA7280_LRA_PER_AVERAGE_L_MASK		(127 << 0)
> > +
> > +/* DA7280_FRQ_LRA_PER_ACT_H (Address 0x46) */
> > +#define DA7280_LRA_PER_ACTUAL_H_SHIFT		0
> > +#define DA7280_LRA_PER_ACTUAL_H_MASK		(255 << 0)
> > +
> > +/* DA7280_FRQ_LRA_PER_ACT_L (Address 0x47) */
> > +#define DA7280_LRA_PER_ACTUAL_L_SHIFT		0
> > +#define DA7280_LRA_PER_ACTUAL_L_MASK		(127 << 0)
> > +
> > +/* DA7280_FRQ_PHASE_H (Address 0x48) */
> > +#define DA7280_PHASE_DELAY_H_SHIFT		0
> > +#define DA7280_PHASE_DELAY_H_MASK		(255 << 0)
> > +
> > +/* DA7280_FRQ_PHASE_L (Address 0x49) */
> > +#define DA7280_DELAY_SHIFT_L_SHIFT		0
> > +#define DA7280_DELAY_SHIFT_L_MASK		(7 << 0)
> > +#define DA7280_DELAY_SHIFT_FREEZE_SHIFT		7
> > +#define DA7280_DELAY_SHIFT_FREEZE_MASK		BIT(7)
> > +
> > +/* DA7280_FRQ_CTL (Address 0x4c) */
> > +#define DA7280_FREQ_TRACKING_FORCE_ON_SHIFT	0
> > +#define DA7280_FREQ_TRACKING_FORCE_ON_MASK	BIT(0)
> > +#define DA7280_FREQ_TRACKING_AUTO_ADJ_SHIFT	1
> > +#define DA7280_FREQ_TRACKING_AUTO_ADJ_MASK	BIT(1)
> > +
> > +/* DA7280_TRIM3 (Address 0x5f) */
> > +#define DA7280_REF_UVLO_THRES_SHIFT		3
> > +#define DA7280_REF_UVLO_THRES_MASK		(3 << 3)
> > +#define DA7280_LOOP_FILT_LOW_BW_SHIFT		5
> > +#define DA7280_LOOP_FILT_LOW_BW_MASK		BIT(5)
> > +#define DA7280_LOOP_IDAC_DOUBLE_RANGE_SHIFT	6
> > +#define DA7280_LOOP_IDAC_DOUBLE_RANGE_MASK	BIT(6)
> > +
> > +/* DA7280_TRIM4 (Address 0x60) */
> > +#define DA7280_LOOP_FILT_RES_TRIM_SHIFT		0
> > +#define DA7280_LOOP_FILT_RES_TRIM_MASK		(3 << 0)
> > +#define DA7280_LOOP_FILT_CAP_TRIM_SHIFT		2
> > +#define DA7280_LOOP_FILT_CAP_TRIM_MASK		(3 << 2)
> > +
> > +/* DA7280_TRIM6 (Address 0x62) */
> > +#define DA7280_HBRIDGE_ERC_HS_TRIM_SHIFT	0
> > +#define DA7280_HBRIDGE_ERC_HS_TRIM_MASK		(3 << 0)
> > +#define DA7280_HBRIDGE_ERC_LS_TRIM_SHIFT	2
> > +#define DA7280_HBRIDGE_ERC_LS_TRIM_MASK		(3 << 2)
> > +
> > +/* DA7280_TOP_CFG5 (Address 0x6e) */
> > +#define DA7280_V2I_FACTOR_OFFSET_EN_SHIFT		0
> > +#define DA7280_V2I_FACTOR_OFFSET_EN_MASK		BIT(0)
> > +#define DA7280_FRQ_PAUSE_ON_POLARITY_CHANGE_SHIFT	1
> > +#define DA7280_FRQ_PAUSE_ON_POLARITY_CHANGE_MASK	BIT(1)
> > +#define DA7280_DELAY_BYPASS_SHIFT			2
> > +#define DA7280_DELAY_BYPASS_MASK			BIT(2)
> > +
> > +/* DA7280_IRQ_EVENT_ACTUATOR_FAULT (Address 0x81) */
> > +#define DA7280_ADC_SAT_FAULT_SHIFT		2
> > +#define DA7280_ADC_SAT_FAULT_MASK		BIT(2)
> > +
> > +/* DA7280_IRQ_STATUS2 (Address 0x82) */
> > +#define DA7280_STA_ADC_SAT_SHIFT		7
> > +#define DA7280_STA_ADC_SAT_MASK			BIT(7)
> > +
> > +/* DA7280_IRQ_MASK2 (Address 0x83) */
> > +#define DA7280_ADC_SAT_M_SHIFT			7
> > +#define DA7280_ADC_SAT_M_MASK			BIT(7)
> > +
> > +/* DA7280_SNP_MEM_XX (Address 0x84 ~ 0xe7) */
> > +#define DA7280_SNP_MEM_SHIFT			0
> > +#define DA7280_SNP_MEM_MASK			(255 << 0)
>=20
> I do not think these definitions are of interest to anyone outside the
> driver itself, why don't you keep them in the .c file?
>=20

Although these definitions may not be of interest to users, those register =
definitions in a separate header are our preferred way and the header is lo=
cal to the same directory as the driver source, so it's not going to be pic=
ked up from standard include paths. They are created automatically so it wo=
uld help the maintainability if they are kept in their own file and also th=
ey are quite large data to keep them in the .c file. So, I would like to ke=
ep using the header file if you don't mind much.

> > +
> > +#endif
> > --
> > end-of-patch for RESEND PATCH V6
> >
>=20
> Thanks.
>=20
> --
> Dmitry
