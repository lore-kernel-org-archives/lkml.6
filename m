Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFE721479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EOtFMWKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFE721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeKVCTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:19:35 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43831 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeKVCTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:19:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="23091206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Nov 2018 08:44:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 21 Nov 2018 08:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG5wEf+ZPNIdRkWjqXUFh6tbX6j6LsAzQWI7JVatwpc=;
 b=EOtFMWKPDgIuNWFwEjfYJpGn4ANl8ID7SifhuTlq/a7GLOI3L/ENZE3Rw7oWISSicPLp5RFxPyyrrn3mhS0OyJvTyH12GCSwNQPvKj2xbUvTsiOK7FwblZTrR8M46i6QjZ3xxEuENmOMX7KufmrJmwJQD+Ne9oGSwVnWtVmkQCY=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2355.namprd11.prod.outlook.com (10.173.203.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Wed, 21 Nov 2018 15:44:32 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%4]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 15:44:32 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
Thread-Topic: [PATCH 3/3] regulator: mcp16502: add regulator driver for
 MCP16502
Thread-Index: AQHUe0QrcREzl+A6dEyfXafqi5KdhqVN+tiAgAxw4wA=
Date:   Wed, 21 Nov 2018 15:44:31 +0000
Message-ID: <03b902d9-49a8-9acd-6f98-048f117b1e93@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181113174539.GB2089@sirena.org.uk>
In-Reply-To: <20181113174539.GB2089@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:803:1::16) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2355;6:iJPwBQSzWcyV8XW6vCOL7ozXakdydAKv8ijht3wj2/D52XWTtmQ6aAhCkWCJYT54kmhwozGIew2DYIY+BAXFq0RhNquFunnukJI3ZcrmUJRDCD8r8rm3ERQ5nYiAkS+MZh7Mam4gT85L4faxhOfdmc9xK4wWB9XS7pfvhg3ecKoJyrMBSP4SjDDlbR15Kq+mRQdDbPgpNM0EbqCELnbjQhuGgtQBaL0BqpWZgTp6/yhVKfWZIfsTuGMuF9tjBtJxepzyojt/z9fjQgrFsQ2quxEozJjaL6QyMX8knEti6/X96WtFICL5cgKX1lcIpLNDlv1uqzcjfZfQpEiFVCb4If87wnuvRxQUgKbLt7SHtM+dMoiyfJFpT1SAugHkbbIa6VMvSUe2jhxB/QE5DI88U6dCFylg46QD7LD5LZLFghZc4pQymWGCoEddn62vBJebBJPBhrSbo697644EllMFvA==;5:P5mKxn745JvFugjmlhHg1xvq3mOwbcaqcL0MeJ1idDY030qz8MHsphignHM2IvLjBuTi6lxmD5IiNOS+Tz9wASETdbREG/jZ5qZAfEs/APEurmNNBqtLGcU/j0d0LXzOymfCpJfNswaNAugY01PKI69xGKAUh0b3qiCCffEGHpg=;7:hob5RKJXu+Akv4AKEmp3nMbE2HOIIGBRAMGXLloZijVwXTAPZU4Qp4wm0gtINY0TvyjN8opfUYDei/SAoXJj6jF851ttnf1bM4cHYsGIHueg/y6E6rDoAYlP7Y0vkhun5bLU2oLXO6q5ZO5qHFoj0A==
x-ms-office365-filtering-correlation-id: 8282533c-c6a3-4ec4-6796-08d64fc83a5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2355;
x-ms-traffictypediagnostic: BN6PR1101MB2355:
x-microsoft-antispam-prvs: <BN6PR1101MB2355CCA3D54000212CFEB4F0EDDA0@BN6PR1101MB2355.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2355;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2355;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(6512007)(68736007)(8676002)(76176011)(36756003)(6916009)(6486002)(486006)(11346002)(14444005)(446003)(6436002)(476003)(2616005)(25786009)(8936002)(7736002)(66066001)(2906002)(31686004)(305945005)(81166006)(72206003)(31696002)(4326008)(5660300001)(86362001)(478600001)(229853002)(81156014)(316002)(39060400002)(186003)(54906003)(3846002)(6246003)(6116002)(345774005)(52116002)(386003)(6506007)(105586002)(102836004)(71190400001)(71200400001)(53546011)(99286004)(2900100001)(14454004)(97736004)(256004)(53936002)(26005)(106356001)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2355;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6qqkmw3EcfhUBSyB9RlNpvN7fIjvT+d8toCjsfRsnJSAr7X6QHbQR22+TrvVyTq4OI+FNETZeBdK+ZE2gTWkzncBm23HPAzrckgwFNWnNkCk0r0diIiP7cEZcxgpSSq7vEcMaxQC31SC+hrx3V4Ewdd+pKa7Fj3zGhIECvQiLoDv2f30NqXGSZAVp1Rd9+pvbUzrlJTONWm4rqgXITBH55NugXYUGWa7rGWwEi0tZyENfZLNnjAgeVshYXIe4h0+Fpfljcia+CKiUUi9WeFwEzFlnEMmoIOxYH9s+Croi+SIw07trbr9djQVL0fE4XFbX7IN18YHJ0bGDrOMib5CZzs7+tIsLce7W7+dJaqEy5E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <31C8C535EDB1C846BBC8B1F2AAF4901C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8282533c-c6a3-4ec4-6796-08d64fc83a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 15:44:31.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2355
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thank you for your review. While working on the next version I realized tha=
t
the implementation should change a bit. The mcp16502 PMIC has separate=20
registers
for each of its operating modes (Performance, Active, Low-power, Hibernate)=
.
So, it is possible to setup the values for Low-power (Linux standby) and
Hibernate (Linux suspend-to-ram) and these values would not be affected by
changes made during runtime (which are made to the ACTIVE registers).

This means that the calls to suspend_set_* are not necessary to be made eac=
h
time the board suspends. My idea is to add three functions to the=20
regulator_ops
(setup_suspend_standby/mem/max) which would be called after the regulator i=
s
registered and which would set the values found inside the devicetree
in the regulator-state-standby/mem/disk subnodes.

However, I am not sure whether this is in fact a good idea or which is=20
the best
approach.

Other possible suggestions for this setup_suspend* functions:
- Break each function into smaller pieces(set_voltage, set_mode,=20
enable/disable)
- Add support for regmap helpers, which would mean adding reg and mask=20
members
 =A0 to regulator_desc. However, I am not sure which naming scheme you pref=
er
 =A0 (enable_suspend_mem_reg for example seems not to be a great idea).=20
Perhaps use
 =A0 arrays (e.g. enable_suspend[] and index it via PM_SUSPEND_*)?


Best regards,
Andrei

On 13.11.2018 19:45, Mark Brown wrote:
> On Tue, Nov 13, 2018 at 11:29:41AM +0000, Andrei.Stefanescu@microchip.com=
 wrote:
>
>> index 0000000..29c72d3
>> --- /dev/null
>> +++ b/drivers/regulator/mcp16502.c
>> @@ -0,0 +1,524 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MCP16502 PMIC driver
> Please make the entire comment a C++ comment so it looks more
> intentional.
>
>> +/*
>> + * This macro is useful for iterating over all regulators and accessing=
 their
>> + * registers in a generic way or accessing a regulator device by its id=
.
>> + */
>> +#define BASE(i) (((i) + 1) << 4)
> This macro name is likely to run into collisions at some point, a prefix
> would be better.
>
>> +static int mcp16502_update_regulator(struct regulator_dev *rdev,
>> +				     bool hibernate,
>> +				     unsigned int mask, unsigned int val)
>> +{
>> +	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
>> +	unsigned int reg =3D BASE(rdev_get_id(rdev));
>> +
>> +	reg +=3D (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;
> Please write this as a normal if statement to improve legibility.
>
>> +static int mcp16502_read(struct regulator_dev *rdev, bool hibernate,
>> +			 unsigned int mask)
>> +{
>> +	struct mcp16502 *mcp =3D rdev_get_drvdata(rdev);
>> +	unsigned int reg =3D BASE(rdev_get_id(rdev));
>> +	int ret, val;
>> +
>> +	reg +=3D (hibernate) ? OFFSET_MODE_HIB : OFFSET_MODE_A;
>> +
>> +	ret =3D regmap_read(mcp->rmap, reg, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return val & mask;
>> +}
> I'm not convinced that these custom read/write functions are adding much
> compared to just using the standard regmap helpers for things - they're
> adding a bunch of code instead of data.  If you need extra helpers for
> suspend mode just add those, I'm sure they'd be useful for other
> drivers.
>
>> +static unsigned int mcp16502_get_mode(struct regulator_dev *rdev)
>> +{
>> +	int val;
>> +
>> +	val =3D mcp16502_read(rdev, false, MCP16502_MODE_MASK);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	if (val =3D=3D MCP16502_MODE_FPWM)
>> +		return REGULATOR_MODE_NORMAL;
>> +	else if (val =3D=3D MCP16502_MODE_AUTO_PFM)
>> +		return REGULATOR_MODE_IDLE;
>> +
>> +	return REGULATOR_MODE_INVALID;
>> +}
> Please just write a switch statement to improve legibility.
>
>> +/*
>> + * mcp16502_is_enabled - regulator_ops is_enabled
>> + */
>> +static int mcp16502_is_enabled(struct regulator_dev *rdev)
>> +{
>> +	int val;
>> +
>> +	val =3D mcp16502_read(rdev, false, MCP16502_EN_MASK);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	return !!val;
>> +}
> This can use regulator_is_enabled_regmap().
>
>> +	if (mode !=3D REGULATOR_MODE_NORMAL && mode !=3D REGULATOR_MODE_IDLE)
>> +		return -EINVAL;
>> +
>> +	val =3D (mode =3D=3D REGULATOR_MODE_NORMAL) ? MCP16502_MODE_FPWM :
>> +						MCP16502_MODE_AUTO_PFM;
>> +
>> +	return mcp16502_update_regulator(rdev, hibernate, MCP16502_MODE_MASK,
>> +					 val);
> Again a switch statement would be clearer.
>
>> +static int mcp16502_get_status(struct regulator_dev *rdev)
>> +{
>> +	int mode =3D mcp16502_get_mode(rdev);
>> +
>> +	if (!mcp16502_is_enabled(rdev))
>> +		return REGULATOR_STATUS_OFF;
>> +	else if (mode =3D=3D REGULATOR_MODE_NORMAL)
>> +		return REGULATOR_STATUS_NORMAL;
>> +	else if (mode =3D=3D REGULATOR_MODE_IDLE)
>> +		return REGULATOR_STATUS_IDLE;
>> +
>> +	return REGULATOR_STATUS_UNDEFINED;
>> +}
> The _status() function should only be implemented if there's hardware
> support for reading back the actual status from the device, we already
> know what we set through software.
>
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mcp16502_suspend(struct device *dev)
>> +{
>> +	struct i2c_client *client =3D to_i2c_client(dev);
>> +	struct mcp16502 *mcp =3D i2c_get_clientdata(client);
>> +
>> +	mcp16502_gpio_set_mode(mcp, MCP16502_MODE_HIB);
>> +
>> +	return 0;
>> +}
> This will put the regulators into hibernate mode before the system has
> finished suspending which is likely to cause breakage - hibernate mode
> in the PMIC is expected to be triggered by the SoC as it shuts down.
>
>> +static int __init mcp16502_init(void)
>> +{
>> +	return i2c_add_driver(&mcp16502_drv);
>> +}
> module_i2c_driver.
