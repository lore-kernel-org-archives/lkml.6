Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2F3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F840206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hP1JxaYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391295AbfBMPh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:37:57 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51504 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfBMPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:37:56 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="26491894"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 08:37:41 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 08:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhzqqUO0n2i3lSSWyUNYxrnOP/yuy3RkAw4MoWqLu3c=;
 b=hP1JxaYYlks87yzwUnuE+aGPvUO0/qWsRY5PqKAPsjcurTTFCYO9PXaFvRo7/GlcIihJMW9QGMe76tT/eWtsEtjwXnBfXI4GLaq3GElMJZq8ajEFZlugFKpPotRVRDvojNHeXlUi7zarBG4D86tIrbWbO1Cvc0vN/Wi3yTu1uOY=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1918.namprd11.prod.outlook.com (10.175.54.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 15:37:14 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 15:37:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Topic: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUo2hjF9SHYVC+/UyvQjeBLKSGN6WhLe0AgDDVQoCADBnwAA==
Date:   Wed, 13 Feb 2019 15:37:14 +0000
Message-ID: <213f33f4-319f-46ec-61b8-e42067725e51@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <20190205224906.GD1372@mithrandir>
In-Reply-To: <20190205224906.GD1372@mithrandir>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0067.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::20) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190213173704088
x-originating-ip: [213.233.103.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 464a0540-c395-47e5-8e6d-08d691c920a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1918;
x-ms-traffictypediagnostic: MWHPR11MB1918:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?Windows-1252?Q?1;MWHPR11MB1918;23:UqLbNOTDO+mDmxoxke5kdhy7QyCgoJGhgRFgh?=
 =?Windows-1252?Q?GLKA8qAgHD6cuxb+PoT1FKaCRWBXajrGeLnfRKEeS3FRgF1VZhW0MHCC?=
 =?Windows-1252?Q?6XsMFAZBoVSP1n3v7DFfTPrpyt5pc4O+SFgcvnUtY+5yCPFWU8pgjXUK?=
 =?Windows-1252?Q?eoL8FBbWMFPAtYm++i7f9DP8Ji4QDbc4sii1ckewtRy+OrTgSZdTpROr?=
 =?Windows-1252?Q?VlNDMl128moB8s6YTOL58rOSmcw8ktGcXIt6nXMI6NwPlTHdGZat5RVM?=
 =?Windows-1252?Q?qYAWynfF+36tW6Zsm+Hdw/mTkOvwIajz3y8D1LLgJ4mPp2cU+UZZsDw7?=
 =?Windows-1252?Q?oWmo75EGXCobRrvf1xLTQwEupSxl9jsG79g/0s6rumT0sg/k+T8LCReg?=
 =?Windows-1252?Q?vrr7RhyzIr8sOv3jjQ2YCMQUNIwR9DKN04TZW0Aev+2H5Or+UyNDMdEZ?=
 =?Windows-1252?Q?4RY56dKu7g1kpSz2CjO4V1PgnelF8fej71qdfZ2NJVowY/eglj27jajC?=
 =?Windows-1252?Q?Z1Bb1jySi6hFpsvmyQxc+c7gq3sMZZshlwmB82aHC3kploB/x5twWOof?=
 =?Windows-1252?Q?P/wierghKpotxnKMXyCh5YkcPwvVCU2AqSJYTTaXsLy/gLeGfnj2mkLo?=
 =?Windows-1252?Q?pEywuHw/QuS2P1uJ+SkznI/jV/MPpKqcVLauxaLURlv3Q5TAYsV0nC/6?=
 =?Windows-1252?Q?4bIc7dOfozYZRuHphZGR98JFmggfLRgEwKwSyjELCCUxWLxknrVOgZuz?=
 =?Windows-1252?Q?ik0w9FpIoBO9hjwDHBp3ihhC104g7+nyjs/MVKv5hPLc7ErGX5a1ZUQu?=
 =?Windows-1252?Q?vAxu+J9eH/h9mZl9iGslHUw9QRp91vUM9y3W+7ybcaoJUHfQb5AmAEnN?=
 =?Windows-1252?Q?XPz9FuJXH7qIQVRu0gaa7ujj46UbBcw3di17FcarThEn8LycM+M3RqMJ?=
 =?Windows-1252?Q?SR8D7sZ6/kbL06ueTK5jg5O2GJv6LKh6+rd7ZbiOYCJP7KCO/6usZhjz?=
 =?Windows-1252?Q?whAsGTK0z7jRu80Ed9fRL3ivx0TkVqBJhAE2c4Hyz+4h0V4lAVpOPvOz?=
 =?Windows-1252?Q?i1lCNMqlut/5HoV0W6be124/fG6osVQ6682qW1UU0jX8n9DJlIaAglbL?=
 =?Windows-1252?Q?FNuEAZqOktzRpQ3j1AEh/uKAF9onPdIMvWr7fQM6c/kdT6kHQ/2IGDMs?=
 =?Windows-1252?Q?PvIKzueKs5Y3zPb5JzDWVdvMtWrkmVLG/O0yci/lWGbtyd35mH+19e6Q?=
 =?Windows-1252?Q?Ttqe8pjr9Z+d8iX2ZPDpB/zm40OucBqyOb6VQ/P2zFaHWoW2xQ6f4Fn5?=
 =?Windows-1252?Q?7PQQXqFSBFLqg2HP3hsO6DyXMCY+IwDqBY2S8Q1SGELUsEkVAFIbzAx4?=
 =?Windows-1252?Q?7lLNUj4fUm7G6FjmOf1aSVE/VDVKRrdX5xpZqpDB1ZoGtHSzjF7vtmjA?=
 =?Windows-1252?Q?Ss6wnjX8V61k3FJWkENWoVjK9vJ4VZECsBfDLBeS6m4viwnEKQVQ/SoB?=
 =?Windows-1252?Q?7qhXzM=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB191850576658B6A7017AC48487660@MWHPR11MB1918.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(51444003)(189003)(199004)(316002)(6512007)(6246003)(6436002)(93886005)(6486002)(2616005)(71190400001)(71200400001)(36756003)(4326008)(229853002)(26005)(25786009)(476003)(486006)(110136005)(11346002)(97736004)(186003)(54906003)(6306002)(446003)(105586002)(66066001)(106356001)(53936002)(86362001)(99286004)(31686004)(53546011)(6506007)(386003)(81156014)(81166006)(8936002)(14454004)(6116002)(3846002)(66574012)(76176011)(52116002)(8676002)(72206003)(102836004)(966005)(7736002)(478600001)(305945005)(68736007)(2906002)(256004)(14444005)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1918;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CDXmumnyo/+a568uUfGkmJcReG+Mk6Cn61BYHKXH1WSZSoQDN0Kyt1Rxqo5JXtkW5WO4Hm2LcJ1HHYbf9JcIT7FTxw5jKVT31e+bF38qlviJUTSUPwZZNVALMeT6Zmis7Wye8TTiilKiqpCUnDUjno6vXPtTYoUXmDXyA53dw3TpdvqETDhMAnTAHegfsmXIEntB3ljSkXsSUqVpmqan5bcZi2PAwzXFESUqZmXCD9M0nCZlAFGVhKtH4ivClgTvSpkKaBfKBxCXK5ZmuUPeVKvlD9Zr9GtPPqKT4lb22syTwOUV26BTB0hAXTTS7hMj8SVVQc1cmUFFymQo0wj8oWjHW8HbuuJfWrgp04HqJPjBexHDCqtgWWt86cNywKZR5bHsC78mVRbVfq8mVX6nkZSHHGfBVcfrkbH5LYF5d1g=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FB59CEC9DEC16749BDCB6CA623E254FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 464a0540-c395-47e5-8e6d-08d691c920a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 15:37:10.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1918
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.02.2019 00:49, Thierry Reding wrote:
> On Sat, Jan 05, 2019 at 10:05:22PM +0100, Uwe Kleine-K=F6nig wrote:
>> Hello,
>>
>> On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.com w=
rote:
>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>
>>> Add basic PWM modes: normal and complementary. These modes should
>>> differentiate the single output PWM channels from two outputs PWM
>>> channels. These modes could be set as follow:
>>> 1. PWM channels with one output per channel:
>>> - normal mode
>>> 2. PWM channels with two outputs per channel:
>>> - normal mode
>>> - complementary mode
>>> Since users could use a PWM channel with two output as one output PWM
>>> channel, the PWM normal mode is allowed to be set for PWM channels with
>>> two outputs; in fact PWM normal mode should be supported by all PWMs.
>>
>> I still think that my suggestion that I sent in reply to your v5 using
>> .alt_duty_cycle and .alt_offset is the better one as it is more generic.
>> A word about that from Thierry before putting the mode into the pwm API
>> would be great.
>>
>> I don't repeat what I wrote there assuming you still remember or are
>> willing to look it up at
>> e.g. https://www.spinics.net/lists/linux-pwm/msg08174.html (in the 2nd h=
alf
>> of my mail).
>=20
> The problem I see with .alt_duty_cycle and .alt_offset is that they
> provide too much flexibility in my opinion. There may be some variance
> in how the values are computed for the different modes and that just
> leads to additional code required in drivers to figure out what exactly
> the user wanted.

This is also my feeling. And I don't know how many controllers support
having this. E.g. on the IP I'm working on (the Atmel one) the dead times
have limited values, so that it cannot model all the possible delays b/w
outputs.

>=20
> If we only provide the user with a means to say which mode they want to
> operate the PWM in they can just tell us and the driver doesn't have to
> guess which one was meant.
>=20
> It also makes validation easier. We can check for capabilites upfront by
> just comparing a list of supported modes. With .alt_duty_cycle and
> .alt_offset we'd actually need to run code to figure out whether or not
> the given set of values corresponds to a supported configuration.
>=20
>> Also I think that if the capabilities function is the way forward adding
>> support to detect availability of polarity inversion should be
>> considered. This would also be an opportunity to split the introduction
>> of the capabilities function and the introduction of complementary mode.
>> (But my personal preference would be to just let .apply fail when an
>> unsupported configuration is requested.)
>>
>>> +static int pwm_get_default_caps(struct pwm_caps *caps)
>>> +{
>>> +	static const struct pwm_caps default_caps =3D {
>>> +		.modes_msk =3D PWM_MODE_BIT(NORMAL),
>>> +	};
>>> +
>>> +	if (!caps)
>>> +		return -EINVAL;
>>> +
>>> +	*caps =3D default_caps;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * pwm_get_caps() - get PWM capabilities of a PWM device
>>> + * @pwm: PWM device to get the capabilities for
>>> + * @caps: returned capabilities
>>> + *
>>> + * Returns: 0 on success or a negative error code on failure
>>> + */
>>> +int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
>>> +{
>>> +	if (!pwm || !caps)
>>> +		return -EINVAL;
>>> +
>>> +	if (pwm->chip->ops->get_caps)
>>> +		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
>>> +
>>> +	return pwm_get_default_caps(caps);
>>
>> I'd drop pwm_get_default_caps (unless you introduce some more callers
>> later) and fold its implementation into pwm_get_caps.
>=20
> I think Claudiu and I may have talked past one another here. What I was
> suggesting was to make pwm_get_default_caps() an exported symbol so that
> drivers could use it if they didn't have extra capabilities. However, it
> seems like just handling that in pwm_get_caps() if ops->get_caps =3D=3D N=
ULL
> works just as well. I don't think it needs to be a different function in
> this case, but I don't mind if it is.
>=20
>>> +}
>>> +EXPORT_SYMBOL_GPL(pwm_get_caps);
>>> [...]
>>> @@ -53,12 +75,14 @@ enum {
>>>   * @period: PWM period (in nanoseconds)
>>>   * @duty_cycle: PWM duty cycle (in nanoseconds)
>>>   * @polarity: PWM polarity
>>> + * @modebit: PWM mode bit
>>>   * @enabled: PWM enabled status
>>>   */
>>>  struct pwm_state {
>>>  	unsigned int period;
>>>  	unsigned int duty_cycle;
>>>  	enum pwm_polarity polarity;
>>> +	unsigned long modebit;
>>
>> I fail to see the upside of storing the mode as 2^mode instead of a
>> plain enum pwm_mode. Given that struct pwm_state is visible for pwm
>> users a plain pwm_mode would at least be more intuitive.
>=20
> Agreed, we should have only the specific mode in the state and let the
> core deal with masks where necessary.

Good, I will rework this.

Thank you,
Claudiu Beznea

>=20
> Thierry
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
