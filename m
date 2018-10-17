Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F04ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E0421526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Nb5hq/V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E0421526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJQUha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:37:30 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:64324 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQUha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:37:30 -0400
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="19638653"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Oct 2018 05:41:57 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 17 Oct 2018 05:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX2v2aVWoW/Cl6T0OXW7gOJiv0QorocdMFdwcdnTUz8=;
 b=Nb5hq/V0uXBnqvueOltzZzdzODCCjbA+ct7Vnc2P7hmVzeDTerTh4vqmjfmdHZpKp9C9H7UXfK8jVAGHiSa4RVIM1WYrfZJEUvDkQTgc7HNUuxgxchi/6mqGYBML7RNNaf8cfuiB8LELXia42B1DWA96sygWzq1xDlvpDuKE/Ds=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0583.namprd11.prod.outlook.com (10.163.159.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Wed, 17 Oct 2018 12:41:53 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff%6]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 12:41:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <linux-pwm@vger.kernel.org>,
        <treding@nvidia.com>, <shc_work@mail.ru>, <mark.rutland@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Thread-Topic: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Thread-Index: AQHUZhbA4B/bV0DVNEy7pNfotLXhTQ==
Date:   Wed, 17 Oct 2018 12:41:53 +0000
Message-ID: <fca49cff-f883-baf4-4bd3-80f45635bb5a@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
 <20181016120321.GG8852@ulmo>
In-Reply-To: <20181016120321.GG8852@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0179.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::27) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0583;6:LcHuZ4LvwXDrwdwyvesczUtbKZjwilkvq+mtFqMLNlVjNFxcgR/u4cufY9BvUJ3RgZAv1O+XlvbwOOiDPOeFYl4Krd/hEv+mccxxR8P+C5+VdtoWVVWEVMzqLdxlD9TKUY9OumXmRkVoKQO0Pib/Ib8uHTG458EBK5g+GvxP7kFb8uWPvPtNts0mo0UFAGiF+ctTTaC0w3jPtyOXzjeMWdj+GgxnnLk/Gmn64YaPiQpa94J44+kN10xkcbWIk4NIRnSZRfoaBk/j6gARaMSpRs2yRlo8DGBikTtsfuGfIENTSinQ7mbeRr+VzVxzCdbc4SQRMeTO1vteNaG8W9u6uot6gSc9RGNEZMN6c8dcFO4zYhc+nxJvYHui7lkfARemLw8bUdEpPcwpvZKLUky/ZsSfVX/JmV/T1SmH4NrA/aJ2zLjld4El3rXhhB9A19lGWaRcZcpaxc6KdLv2F5JJHSS/aAJ+19bir8Q7xzgKI80=;5:ppI6LdYYqBqHVWwLWCQOtDskXf32bXGyeQG34ilsd5yteHh3Kc7ltDPdbQvcKROT7nfMuYoEJpakRjaxT+9P2BV16Ud36t4wKDnk1jXKxNdEHrR6AnxHmQlt5KXW+QPVs4sW0u/mQqRLorBKuEWvoA2mlhBu4gO+zg1QyhwUC/M=;7:9OwLgxjUYKdwgWutXxAJjs4kwl0V3GeXm966FaL2SJn8NwMtgL2ReR4CwMboN1DWE0PeNumTDwVwXrWn3lRFY2XFuRAUtS2+hYmdD2eqxUIYgdj0mJEbbtjrkD484aWNdmgZALIfDeAvcAjm82Djcdq3qVpCE/XYxwS3WNCWKzWPO0q6fx/CTWOg3x36a0R/c3Lvcrd5xz8sDjS0VHnPRcN0TWWZ9hpzJYW1I/hOovEg+smTkK9Q77MsaH7J1j3k
x-ms-office365-filtering-correlation-id: bfedc7b7-1b34-4c30-a93b-08d6342dea01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0583;
x-ms-traffictypediagnostic: BY2PR11MB0583:
x-microsoft-antispam-prvs: <BY2PR11MB0583F2F5B352DFD15292155487FF0@BY2PR11MB0583.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0583;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0583;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(52314003)(14454004)(305945005)(6512007)(7416002)(68736007)(102836004)(5660300001)(14444005)(97736004)(25786009)(53936002)(39060400002)(6246003)(217873002)(71190400001)(6306002)(36756003)(72206003)(4326008)(478600001)(5250100002)(256004)(71200400001)(66066001)(476003)(2616005)(105586002)(966005)(7736002)(11346002)(486006)(81166006)(6436002)(8676002)(6116002)(81156014)(446003)(3846002)(106356001)(2906002)(316002)(186003)(53546011)(2900100001)(8936002)(31686004)(54906003)(99286004)(229853002)(52116002)(26005)(86362001)(31696002)(110136005)(76176011)(6486002)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0583;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rNZLwmk+ZGPoxppiA2DUrefuIyLxOQNgied8TRFyecJQNc3ptCu4XXZqBytV/vsAIqQrA9gLwlAxN3bwsKFjJ32vBQXqD/aMCGuya4gMhI15ZkavfAqccmMbm36XG+Lggi894AtAEGVMAWnGEpxr9nkn+c8LBV7xOacQ4OM11A4jovO08VU9aG9xE4CDhIEDQwWCXCQqu5RBX3AO5vq8IORVmU2tpyyk4P4wOhLGyAxTdTfQlMCKpC1P3NDft8oH/LR1ij0yH3wgafCesx/h1MGVti1tpdJD4s5FnwDDuy80q/9acV7i0TXlp+uhqVW2KKsyefeFQ85u3BTYPDZBPaVAeZU6jgRNKfkVfl7iB40=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <92A636DC92C2E84789D1F075F388771E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bfedc7b7-1b34-4c30-a93b-08d6342dea01
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 12:41:53.3923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0583
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.10.2018 15:03, Thierry Reding wrote:
> On Fri, Sep 14, 2018 at 06:20:48PM +0200, Nicolas Ferre wrote:
>> Thierry,
>>
>> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
>>> Hi,
>>>
>>> Please give feedback on these patches which extends the PWM framework i=
n
>>> order to support multiple PWM modes of operations. This series is a rew=
ork
>>> of [1] and [2].
>>
>> This series started with a RFC back on 5 April 2017 "extend PWM framewor=
k to
>> support PWM modes". The continuous work starting with v2 of this series =
on
>> January 12, 2018.
>>
>> Then Claudiu tried to address all comments up to v4 which didn't have an=
y
>> more reviews. He posted a v5 without comments since May 22, 2018. This
>> series is basically a resent of the v5 (as said in the $subject).
>>
>> We would like to know what is preventing this series to be included in t=
he
>> PWM sub-system. Note that if some issue still remain with it, we are rea=
dy
>> to help to solve them.
>>
>> Without feedback from you side, we fear that we would miss a merge windo=
w
>> again for no obvious reason (DT part is Acked by Rob: patch 5/9).
>=20
> First off, apologies for not getting around to this earlier.
>=20
> I think this series is mostly fine, but I still have doubts about the DT
> aspects of this. In particular, Rob raised a concern about this here:
>=20
> 	https://lkml.org/lkml/2018/1/22/655
>=20
> and it seems like that particular question was never fully resolved as
> the discussion veered off that particular topic.

1/ If you are talking about this sentence:
"Yes, but you have to make "normal" be no bit set to be compatible with
everything already out there."

The current implementation consider that if no mode is provided then, the
old approach is considered, meaning the normal mode will be used by every
PWM in-kernel clients.

In of_pwm_xlate_with_flags() the pmw->args.mode is initialized with what
pwm_mode_get_valid() returns. In case of controllers which does not
implement something special for PWM modes the PWM normal mode will be
returned (pwmchip_get_default_caps() function has to be called in the end).
Otherwise the pwm->args.mode will be populated with what user provided as
input from DT, if what was provided from DT is valid for PWM channel.
Please see that pwm_mode_valid() is used to validate user input, otherwise
PWM normal mode will be used.

+	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);

-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm->args.polarity =3D PWM_POLARITY_INVERSED;
+
+		for (modebit =3D PWMC_MODE_COMPLEMENTARY_BIT;
+		     modebit < PWMC_MODE_CNT; modebit++) {
+			unsigned long mode =3D BIT(modebit);
+
+			if ((args->args[2] & mode) &&
+			    pwm_mode_valid(pwm, mode)) {
+				pwm->args.mode =3D mode;
+				break;
+			}
+		}
+	}


2/ If you are talking about this sentence:
"Thinking about this some more, shouldn't the new modes just be
implied? A client is going to require one of these modes or it won't
work right."

As explained at point 1, if there is no mode requested from DT the default
mode for channel will be used, which, in case of PWM controller which are
not implementing the new modes, will be PWM normal mode.

3/ If you are talking about:
"Also complementary mode could be accomplished with a single pwm output
and a board level inverter, right? How would that be handled when the
PWM driver doesn't support that mode?"
This complicates the things and I think it requires extra device tree
bindings to describe extra per-pwm channel capabilities. For the moment,
with this series I've stopped to only have the capabilities registered from
driver. My understanding is that this could be accomplished with extra
device tree bindings in PWM controller to describe PWM channels
capabilities. If you also want me to look into this direction please let me
know. And also, suggestions would be appreciated.

I know that Rob acked
> the DT parts of this, but I suspect that this might have been glossed
> over.

If this is about point 3 I've emphasize above I would like to have some
inputs from your side, if you agree with a behavior like having extra DT
bindings. The intention wasn't to left this over but to have a better
understanding of the subject. I'm thinking if it is ok to have modules
outside of the SoC that model a behavior that could not be controlled from
software (it could be only hardware) but to behave in a single way. Take
for instance this scenario:

- new DT bindings are implemented to specify this behavior per channel
- hardware modules are soldered outside of a PWM channel with one output
- the new DT bindings are not specified for the soldered PWM channel
- user enables this channel, it will have only normal mode available for it
to configure (because the new DT bindings were not provided)
- but the real output the user will see would be in complementary or even
push-pull mode.

>=20
> To restate the concern: these extended modes have special uses and none
> of the users in the kernel, other than sysfs, can use anything other
> than the normal mode. They may work fine with other modes, but only if
> they ignore the extras that come with them. Therefore I think it's safe
> to say that anyone who would want to use these modes would want to
> explicitly say so. For example the sysfs interface already does that by
> changing the mode only after the "mode" attribute is written. Any users
> for special use-cases would want to do the same thing, that is, drive a
> PWM in a specific mode, on purpose. You wouldn't have a "generic" user
> such as pwm-backlight or leds-pwm request anything other than the normal
> mode.
>=20
> So my question is, do we really need to represent these modes in DT? The
> series currently doesn't contain any patches that add users of these new
> modes. Are such patches available somewhere, or is the only user of this
> supposed to be sysfs?

For the moment, no, there is no in-kernel user for this, only sysfs. I had
in mind to adapt the use of these new mode for PWM regulator for scenarios
described in [1] page 2126. Anyway, since these patches doesn't introduce
any user other that sysfs it will not disturbed me to drop the changes. By
the time I or someone else will do some other changes that requires this,
the DT part should also be introduced.

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

>=20
> I'm hesitant to move forward with this as-is without seeing how it will
> be used.

For the moment only sysfs is supposed to use this.

The PWM specifier flags are somewhat abused by adding modes to
> them.=20

I see.

I think this hasn't been completely thought through, because the
> only reason to specify a mode is to actually set that mode.

Maybe it wasn't clear understand, with the current implementation if no
mode will be specified the default mode will be used. There is no impose to
specify a mode.

 But then the
> DT ABI allows a bitmask of modes to be requested via DT. I know that
> only the first of those modes will end up being used, but then why even
> allow it in the first place?

I had in mind that I will change the PWM regulator driver to work in
scenarios like the one specified in the link above.

>=20
> And again, even if we allow the mode to be specified in DT, how do the
> consumer drivers know that the correct mode was being set in DT.=20

PWM user will call at some point devm_pwm_get() which, in turn, will call
of_pwm_get() which in turn will initialize PWM args with inputs from DT.
After that PWM user will, at some point, apply a PWM state; if it is
initialized with PWM args initialized when devm_pwm_get() was called then
pwm_apply_state() would fail if no good mode is provided as input via DT.

Same thing happens if a bad period is provided via DT.

Let's
> say we have a consumer that requires the PWM to be driven in
> complementary mode. Should it rely on the DT to contain the correct
> specification for the mode? And if it knows that it needs complementary
> mode, why not just set that mode itself?

I'm thinking it's the same way as is with PWM period which could also be
provided from DT. In the end a bad period value could be provided from
device tree. E.g. Atmel PWM controller could generate PWM signals who's
periods could not be higher than ~0.6 seconds. If a bad value is provided
the pwm_apply_state() will fail.

Thank you,
Claudiu Beznea

That way there's no margin for
> error.


>=20
> Thierry
>=20
