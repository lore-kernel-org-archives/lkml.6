Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD8ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F11B2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QKSIl8hG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F11B2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJQUhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:37:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10917 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJQUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:37:41 -0400
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="18957628"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Oct 2018 05:42:03 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 17 Oct 2018 05:42:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzh4OSf6BLGvHGKLU4J4zX3aVTxWNa/CyGo5pueRov4=;
 b=QKSIl8hGZ5lX89q8/6UXCV2kL/CSk/k6lGlk9+JmxWr6588hTSDLh99Zj2VvsjfpJ8M3L3OheXYKgcGTMSAq1fr+jdOoZuzFqGAC4dcF3oqvuSRDBFjPo9OtW5+BNptE7FIQJ5Py2WrYmuMVHrd4cDzmjFCvREKf8L3c/4RZwas=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0583.namprd11.prod.outlook.com (10.163.159.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Wed, 17 Oct 2018 12:42:00 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff%6]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 12:42:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>
CC:     <mark.rutland@arm.com>, <linux-pwm@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <shc_work@mail.ru>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
Thread-Topic: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUZhbFBWZleLpAnEqNspqtIamAvw==
Date:   Wed, 17 Oct 2018 12:42:00 +0000
Message-ID: <139cc421-ac12-1262-bc32-763731528ccf@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
 <20181016122508.GH8852@ulmo>
In-Reply-To: <20181016122508.GH8852@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0164.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::12) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0583;6:JdopsFNAuQGuvJlue11X5NzacSHUJ3aJaPdp6AsZi+14UyEwgi8mH152F6jal1JisueYhtDjmlp1gQheiVz30+DhRQyBAbea9gr9VmltHt7bvD4a83S7CiM1i9y7Q+qXPJ3zYDP5qlpRVzRssg0BTxXBmo/Rkx81HWbRPi2eam47url6Zxltm87gmaMzTLvsHq0vvKRhAq5uZpV9AfxQ41GQeAW2qL7aWZDAyNxaCnUzxZkLDlbbman3Ya0Tut0C3qWKHXcPY0wsIEjP4VgiqlGG50LeyeNLYj3pYJXzMiqqlfZQCBLYlGIIowzLt3msTdK1LKERZUpwWzDc6ZRns9/ZFg4hqN7VXCgLOCjNSiEWfrXn0gierGiIrWyuDHTMV23dMMzQh3kLI3bJjObQuz6AFaKaIaKhfvmr61qYPEToOiO5SUaHscJfROXXY67gjsdBcJ78P/8NabQQRjbMYlZIG/LlUXQ1PfTJTASzlp0=;5:wODwl9BHrgcCABg9O4d30W3TKDaEagsPNva6MKnQrZXdnIb+Sqx39woQVQ7h37Zn88i9/bTgqJhgGkaaY26lNitePlG1ys7j0oG+42wb+g6Ua3PnAe5GnaX1e7PjjC8pgZnEys8naRimqbLwPjdpAqnQG++b30EJH0sH7i0dbM0=;7:Cs2ZcuoYfSHVqBc/ibxXMq4zM3tai/xRp+Y+2vef7BR9X/Hp1vOy0jUHEJNyPj1J41knIe1IBifzbM4vSi6Wyy/VAcDEBB8dvF7ICXyyDJyY1GNGdCyKG8ZWxBXTpNnUvS5+LVrpguRYzbvezIn28rajdcSlVVZJL+180FGPkXn/CjLjejePKJcJL8HjHJYqZ0gEXU6iGCqYZvSqYeWm9YDtsiI0ko0Nt9JRooDGySEiSy+dDsv+E57DCkk+3az7
x-ms-office365-filtering-correlation-id: 1e332220-0aab-41f4-3a4a-08d6342dee81
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0583;
x-ms-traffictypediagnostic: BY2PR11MB0583:
x-microsoft-antispam-prvs: <BY2PR11MB0583F036BE4F4F69A05706DD87FF0@BY2PR11MB0583.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(211171220733660)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0583;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0583;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(14454004)(305945005)(6512007)(7416002)(68736007)(102836004)(5660300001)(14444005)(97736004)(25786009)(53936002)(39060400002)(6246003)(217873002)(71190400001)(6306002)(36756003)(72206003)(4326008)(478600001)(5250100002)(256004)(71200400001)(66066001)(476003)(2616005)(105586002)(4744004)(966005)(7736002)(11346002)(486006)(6916009)(81166006)(6436002)(8676002)(6116002)(81156014)(446003)(3846002)(106356001)(2906002)(316002)(186003)(53546011)(1720100001)(2900100001)(8936002)(31686004)(54906003)(99286004)(229853002)(52116002)(26005)(86362001)(31696002)(76176011)(6486002)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0583;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PO+GaBE0+YAO+YRaHo1oght/gIHkDg9QKtLsrESKtfSxtVJ7TUTf2K1RKS8cIA4hx2HECQaU0TydAALHpuAXFoWCuF8s1rDZbi94qZ8YOhhvkSuB1QOoll4DxmKxnGApQQYnyozvKLefQdrj6TqdGZpIqmm2BKY1DlDh5+jYVJsV28byL0nRfxtSgeJ/FAYw2DPhokv4b53X5ri+MMz66DdVzMDRh7njd4Nx9kSkVESEhNKJJmp502IkUbS0Fuid9L6kNbcFqIATiucfHkpl2XWUKtxdNN4KtU/I7EFo+swoFYPKNk3tZbvHC4vRFysG1jEZg7awKVnj3U9UB0H3CSSAUJjyQyaE54fUhf3UuxU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CFEF1475EE1F8840ACB5C6A630E84E05@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e332220-0aab-41f4-3a4a-08d6342dee81
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 12:42:00.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0583
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.10.2018 15:25, Thierry Reding wrote:
> On Tue, Aug 28, 2018 at 04:01:18PM +0300, Claudiu Beznea wrote:
>> Add basic PWM modes: normal and complementary. These modes should
>> differentiate the single output PWM channels from two outputs PWM
>> channels. These modes could be set as follow:
>> 1. PWM channels with one output per channel:
>> - normal mode
>> 2. PWM channels with two outputs per channel:
>> - normal mode
>> - complementary mode
>> Since users could use a PWM channel with two output as one output PWM
>> channel, the PWM normal mode is allowed to be set for PWM channels with
>> two outputs; in fact PWM normal mode should be supported by all PWMs.
>>
>> The PWM capabilities were implemented per PWM channel. Every PWM control=
ler
>> will register a function to get PWM capabilities. If this is not explici=
tly
>> set by the driver a default function will be used to retrieve the PWM
>> capabilities (in this case the PWM capabilities will contain only PWM
>> normal mode). This function is set in pwmchip_add_with_polarity() as a
>> member of "struct pwm_chip". To retrieve capabilities the pwm_get_caps()
>> function could be used.
>>
>> Every PWM channel have associated a mode in the PWM state. Proper
>> support was added to get/set PWM mode. The mode could also be set
>> from DT via flag cells. The valid DT modes are located in
>> include/dt-bindings/pwm/pwm.h. Only modes supported by PWM channel could=
 be
>> set. If nothing is specified for a PWM channel, via DT, the first availa=
ble
>> mode will be used (normally, this will be PWM normal mode).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/pwm/core.c  | 124 +++++++++++++++++++++++++++++++++++++++++++++=
+++++--
>>  drivers/pwm/sysfs.c |  61 ++++++++++++++++++++++++++
>>  include/linux/pwm.h |  39 +++++++++++++++++
>>  3 files changed, 221 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 1581f6ab1b1f..59a9df9120de 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -136,6 +136,7 @@ struct pwm_device *
>>  of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_ar=
gs *args)
>>  {
>>  	struct pwm_device *pwm;
>> +	int modebit;
>> =20
>>  	/* check, whether the driver supports a third cell for flags */
>>  	if (pc->of_pwm_n_cells < 3)
>> @@ -154,9 +155,23 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const =
struct of_phandle_args *args)
>> =20
>>  	pwm->args.period =3D args->args[1];
>>  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
>> +	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);
>> =20
>> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
>> -		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>> +	if (args->args_count > 2) {
>> +		if (args->args[2] & PWM_POLARITY_INVERTED)
>> +			pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>> +
>> +		for (modebit =3D PWMC_MODE_COMPLEMENTARY_BIT;
>> +		     modebit < PWMC_MODE_CNT; modebit++) {
>> +			unsigned long mode =3D BIT(modebit);
>> +
>> +			if ((args->args[2] & mode) &&
>> +			    pwm_mode_valid(pwm, mode)) {
>> +				pwm->args.mode =3D mode;
>> +				break;
>> +			}
>> +		}
>> +	}
>> =20
>>  	return pwm;
>>  }
>> @@ -183,6 +198,7 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struc=
t of_phandle_args *args)
>>  		return pwm;
>> =20
>>  	pwm->args.period =3D args->args[1];
>> +	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);
>> =20
>>  	return pwm;
>>  }
>> @@ -250,6 +266,97 @@ static bool pwm_ops_check(const struct pwm_ops *ops=
)
>>  }
>> =20
>>  /**
>> + * pwm_get_caps() - get PWM capabilities of a PWM device
>> + * @chip: PWM chip
>> + * @pwm: PWM device to get the capabilities for
>> + * @caps: returned capabilities
>> + *
>> + * Returns: 0 on success or a negative error code on failure
>> + */
>> +int pwm_get_caps(struct pwm_chip *chip, struct pwm_device *pwm,
>> +		 struct pwm_caps *caps)
>> +{
>> +	if (!chip || !pwm || !caps)
>> +		return -EINVAL;
>> +
>> +	if (chip->ops && chip->ops->get_caps)
>> +		pwm->chip->ops->get_caps(chip, pwm, caps);
>> +	else if (chip->get_default_caps)
>> +		chip->get_default_caps(caps);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pwm_get_caps);
>=20
> I'm confused by the way ->get_default_caps() is used here. This always
> points at pwmchip_get_default_caps() if I understand correctly, so why
> bother with the indirection?

Yep, looking again at this it also looks ugly to me and I dont't remember
why I chose this approach. I looked over emails and so but didn't manage to
find the reason for this. I agree with you that there is no need to keep a
pointer in struct pwm_chip for this.

>=20
> I think it would be better to either export pwmchip_get_default_caps()
> as a default implementation of ->get_caps(), something like:
>=20
> 	void pwm_get_default_caps(struct pwm_chip *chip, struct pwm_device *pwm,
> 				  struct pwm_caps *caps)
> 	{
> 		...
> 	}
> 	EXPORT_SYMBOL_GPL(pwm_get_default_caps);
>=20
> This could be used by the individual drivers as the implementation if
> they don't support any modes.
>=20
> Another, probably simpler approach would be to just get rid of the
> chip->get_default_caps() pointer and directly call
> pwmchip_get_default_caps() from pwm_get_caps():
>=20
> 	int pwm_get_caps(...)
> 	{
> 		/*
> 		 * Note that you don't need the check for chip->ops because
> 		 * the core checks for that upon registration of the chip.
> 		 */
> 		if (chip->ops->get_caps)
> 			return chip->ops->get_caps(...);
>=20
> 		return pwm_get_default_caps(...);
> 	}
>=20
> And if we do that, might as well fold pwm_get_default_caps() into
> pwm_get_caps().

I am also in favor of this approach.

>=20
>> +/**
>> + * pwm_mode_get_valid() - get the first available valid mode for PWM
>> + * @chip: PWM chip
>> + * @pwm: PWM device to get the valid mode for
>> + *
>> + * Returns: first valid mode for PWM device
>> + */
>> +unsigned long pwm_mode_get_valid(struct pwm_chip *chip, struct pwm_devi=
ce *pwm)
>=20
> This is a little ambiguous. Perhaps pwm_get_default_mode()?


Ok, will change it to pwm_get_default_mode(). I placed pwm_mode in front of
every function in this patch to emphasize the functions are dealing with
PWM modes. But being inside PWM core and using this approach might be
confusing.

>=20
>> +/**
>> + * pwm_mode_valid() - check if mode is valid for PWM device
>> + * @pwm: PWM device
>> + * @mode: PWM mode to check if valid
>> + *
>> + * Returns: true if mode is valid and false otherwise
>> + */
>> +bool pwm_mode_valid(struct pwm_device *pwm, unsigned long mode)
>=20
> Again, this is slightly ambiguous because the name suggests that it
> merely tests a mode for validity, not that it is really supported by the
> given device. Perhaps something like pwm_supports_mode()?

Ok, understand. I'll use pwm_supports_mode() instead.

>=20
>> +const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
>> +{
>> +	static const char * const modes[] =3D {
>> +		"invalid",
>> +		"normal",
>> +		"complementary",
>> +	};
>> +
>> +	if (!pwm_mode_valid(pwm, mode))
>> +		return modes[0];
>> +
>> +	return modes[ffs(mode)];
>> +}
>=20
> Do we really need to be able to get the name of the mode in the context
> of a given PWM channel? Couldn't we drop the pwm parameter and simply
> return the name (pwm_get_mode_name()?) and at the same time remove the
> extra "invalid" mode in there? I'm not sure what the use-case here is,
> but it seems to me like the code should always check for supported modes
> first before reporting their names in any way.

Looking back at this code, the main use case for checking PWM mode validity
in pwm_mode_desc() was only with regards to mode_store(). But there is not
need for this checking since the same thing will be checked in
pwm_apply_state() and, in case user provides an invalid mode via sysfs the
pwm_apply_state() will fail.

To conclude, I will change this function in something like:

if (mode =3D=3D PWM_MODE_NORMAL)
	return "normal";
else if (mode =3D=3D PWM_MODE_COMPLEMENTARY)
	return "complementary";
else if (mode =3D=3D PWM_MODE_PUSH_PULL)
	return "push-pull";
else
	return "invalid";

Please let me know if it is OK for you.

>=20
>> +/**
>>   * pwmchip_add_with_polarity() - register a new PWM chip
>>   * @chip: the PWM chip to add
>>   * @polarity: initial polarity of PWM channels
>> @@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>> =20
>>  	mutex_lock(&pwm_lock);
>> =20
>> +	chip->get_default_caps =3D pwmchip_get_default_caps;
>> +
>>  	ret =3D alloc_pwms(chip->base, chip->npwm);
>>  	if (ret < 0)
>>  		goto out;
>> @@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>>  		pwm->pwm =3D chip->base + i;
>>  		pwm->hwpwm =3D i;
>>  		pwm->state.polarity =3D polarity;
>> +		pwm->state.mode =3D pwm_mode_get_valid(chip, pwm);
>> =20
>>  		if (chip->ops->get_state)
>>  			chip->ops->get_state(chip, pwm, &pwm->state);
>> @@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
>>  	int err;
>> =20
>>  	if (!pwm || !state || !state->period ||
>> -	    state->duty_cycle > state->period)
>> +	    state->duty_cycle > state->period ||
>> +	    !pwm_mode_valid(pwm, state->mode))
>>  		return -EINVAL;
>> =20
>>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
>> @@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct p=
wm_state *state)
>> =20
>>  			pwm->state.enabled =3D state->enabled;
>>  		}
>> +
>> +		/* No mode support for non-atomic PWM. */
>> +		pwm->state.mode =3D state->mode;
>=20
> That comment seems misplaced. This is actually part of atomic PWM, so
> maybe just reverse the logic and say "mode support only for atomic PWM"
> or something. I would personally just leave it away.

Ok, sure. I will remove the comment. But the code has to be there to avoid
unassigned mode value for PWM state (normal mode means BIT(0)) and so to
avoid future PWM applies failure.

The legacy API has
> no way of setting the mode, which is indication enough that we don't
> support it.
>=20
>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>> index 56518adc31dd..a4ce4ad7edf0 100644
>> --- a/include/linux/pwm.h
>> +++ b/include/linux/pwm.h
>> @@ -26,9 +26,32 @@ enum pwm_polarity {
>>  };
>> =20
>>  /**
>> + * PWM modes capabilities
>> + * @PWMC_MODE_NORMAL_BIT: PWM has one output
>> + * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polari=
ties
>> + * @PWMC_MODE_CNT: PWM modes count
>> + */
>> +enum {
>> +	PWMC_MODE_NORMAL_BIT,
>> +	PWMC_MODE_COMPLEMENTARY_BIT,
>> +	PWMC_MODE_CNT,
>> +};
>> +
>> +#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)
>=20
> Why the C in the prefix? Why not just PWM_MODE_* for all of the above?

Well... PWM_MODE() macro was already took by pwm-sun4i.c driver at the time
I wrote this patch... So I choose to add extra C to this macro, "C" meaning
"constant" in my mind. I was not sure it was the best solution at that time
either.

>=20
>> +
>> +/**
>> + * struct pwm_caps - PWM capabilities
>> + * @modes: PWM modes
>=20
> This should probably say that it's a bitmask of PWM_MODE_*.

Ok, I'll update.

>=20
>> +struct pwm_caps {
>> +	unsigned long modes;
>> +};
>> +
>> +/**
>>   * struct pwm_args - board-dependent PWM arguments
>>   * @period: reference period
>>   * @polarity: reference polarity
>> + * @mode: reference mode
>=20
> As discussed in my reply to the cover letter, what is the use for the
> reference mode? Drivers want to use either normal or some other mode.
> What good is it to get this from board-dependent arguments if the
> driver already knows which one it wants or needs?

For the moment, no, there is no in-kernel user. Only sysfs. I was thinking
I would also adapt, e.g., the pwm-regulator driver to also make use of this
features in setups like the one described in [1], page 2126
(Figure 56-13: Half-Bridge Converter Application: No Feedback Regulation).
But, for the moment there is no in-kernel user.

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

>=20
>> @@ -300,6 +331,7 @@ struct pwm_chip {
>> =20
>>  	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>>  					const struct of_phandle_args *args);
>> +	void (*get_default_caps)(struct pwm_caps *caps);
>=20
> As mentioned above, I don't think we need this.

Ok, I'll update.

>=20
> Thierry
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
