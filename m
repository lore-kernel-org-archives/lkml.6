Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04008C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1DA2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OltG0tVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1DA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeJLUiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:38:16 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:46991 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:38:16 -0400
X-IronPort-AV: E=Sophos;i="5.54,372,1534834800"; 
   d="scan'208";a="19404043"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Oct 2018 06:05:54 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 12 Oct 2018 06:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E7w7OEzGT3AazUHTBwUL/+ncVfGIuyrNNejDEic6H8=;
 b=OltG0tVo6V2UmhzuYgnJmT23RvJS2GI2VoRwqi0eyxWQXg8wyHzaVgxVNGzdzfvQSUJKgf5cBbBqbR0O9VCpWvAq1A5G1F9yJONnz5EFLQ6VPUfwz1WkemVoxWaRi75jiVCzKVCeMbNWW6HCb4eS2ni/P74kPCymPrknlJys0y8=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0616.namprd11.prod.outlook.com (10.163.159.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Fri, 12 Oct 2018 13:05:50 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff%6]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 13:05:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>
CC:     <mark.rutland@arm.com>, <linux-pwm@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <shc_work@mail.ru>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull
 mode
Thread-Topic: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull
 mode
Thread-Index: AQHUYiWuPxymrtUSmUOBVwlQPFCphKUblDoA
Date:   Fri, 12 Oct 2018 13:05:50 +0000
Message-ID: <f4a1f9e3-b3a8-2847-f13e-bb07dab400e6@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
 <20181012121552.GE31561@ulmo>
In-Reply-To: <20181012121552.GE31561@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0002.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::12) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0616;6:BU/eFEI2itwTz57gYe1240b/mDlkq3TGSc7CIePtT6MoY4MRl1huz3v3eIsXw1VBn4ag/aRapfqARDL4qd0Y4tlrd2EBF1r3uVItqi2bRB8O5OjC//UniJHDTYw51Ak9vIOhitklq1oUwXtps3IGSJ4WU2M1cdROrfbjyRt+HMeniu3PXMncD+dLpRLSlJU0A6mx+uVBKf1jq29h1K2PddJvBhlZB1OZHbi0cuu8/CR6Fiss229s3EBA2mWda7qoI7/CyBVuomw+SlXpbXfSLHlwOuGVVfyxF8I2dt9CiLE8AbzntMWJ7eeYVg/NF3wDiETcISy+ppyrKofJEjbkSiY5aaWYy+b2B4VPLvx4o88YUhlhwPtg+or+vQXjlcSvjrU9ufjM8Wl/Gh2p5wGDv83cWyhy+bH4Jz9R0TXIlWgf2GgsGG/HyOjulfjqv+58yNpBMK10TWr/5al7lQDl+g==;5:GvfUzt6nyV7ym38SbW9LFsLRXW6t/XisyGndrm2eOUGRYn18ncl5iwEQ3CWGcjs6OYI2TKlIg4AVG6dng6n2LFhM0jk6lYPEoYKgSaxG7k7B5er6M+nU1o74gPf7gV0qYxht1jxDckmi/Jr6rHyOHdtCt6fLgrHId6c6wzEOV7g=;7:phruU2bza9fGYd5Iq3Ok0z+oAVxGH0fL/hesuy/0dNg3vSK+/QzLtOGiFI8a1PsBE0x/7FHmLj4EZf6LtPeIVjc8oqCTYHs7MBq9HooCeICZ/ksK9tivQd2LGU1uguQK2MqZMFP8sJCFHTyJnuL69pqQ8h7oDaNzNHisbzoAPsz8eiDFseMkPYaNDTwwfWV10/n4dZD+jcfzrLxH7xyGAwvR1QnNYYShQ1g8uVRfInPt6ScpxL9LH7aalg7x7aWa
x-ms-office365-filtering-correlation-id: dab36c79-039f-4e77-c72a-08d630436e75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0616;
x-ms-traffictypediagnostic: BY2PR11MB0616:
x-microsoft-antispam-prvs: <BY2PR11MB06166D8DE37BB4AA78143B8487E20@BY2PR11MB0616.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991067);SRVR:BY2PR11MB0616;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0616;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(189003)(2900100001)(31686004)(386003)(6506007)(6306002)(6512007)(31696002)(5250100002)(76176011)(53546011)(2616005)(102836004)(2906002)(68736007)(256004)(575784001)(26005)(86362001)(6436002)(53936002)(316002)(7416002)(52116002)(14454004)(54906003)(8676002)(39060400002)(81156014)(81166006)(105586002)(8936002)(6116002)(3846002)(36756003)(106356001)(186003)(5660300001)(1720100001)(6486002)(229853002)(6246003)(72206003)(99286004)(478600001)(217873002)(71190400001)(476003)(7736002)(25786009)(486006)(966005)(11346002)(446003)(71200400001)(66066001)(6916009)(305945005)(97736004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0616;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7uLVxwjh+beaxYWOlWGUj2XCBBDRl4o8knGRj9KHNkY39h1rFn1dSD20GxrIeRBzbQCRvv4FjJcwLO1DDPDi4C/6cN6gYBq10nTgUxB8e3qGItAAZhKx9Tdxarefr3XkpHVK4UU57icpFEoCfmdP/aAg7iuRh7MQPwHHMDDpTPflYn75dgwBjI2vpD+vn5ghzdeiTfm8K1KUhmuS3CAayOnsucCYG6qAzUiF5rMleUrIS/pHlCwFYe35k8Am36ui9hmrMPVp2hUpKNdAVLWXl1Tt+wENT+/UbHOrN9H7xeFNcmU8tBzkUBn1TXfjWn0ymrvEF7litgTK5Od2MOGf40GnmrWDyv5UpMjDDdMCxYU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2122BCBB722E1A45B16B7E23800C80D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dab36c79-039f-4e77-c72a-08d630436e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 13:05:50.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0616
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.10.2018 15:15, Thierry Reding wrote:
> On Tue, Aug 28, 2018 at 04:01:25PM +0300, Claudiu Beznea wrote:
>> Add documentation for PWM push-pull mode.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
>>  Documentation/pwm.txt                         | 16 ++++++++++++++++
>>  include/dt-bindings/pwm/pwm.h                 |  1 +
>>  3 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentati=
on/devicetree/bindings/pwm/pwm.txt
>> index 7c8aaac43f92..6a60c0fca112 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
>> @@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of f=
lags (defined in
>>  - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM chann=
els
>>  with two outputs); if not specified, the default for PWM channel will b=
e
>>  used
>> +- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels wit=
h
>> +two outputs); if not specified the default for PWM channel will be used
>=20
> What if somebody has this in the DT:
>=20
> 	PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL
>=20
> which one takes precedence, or do we reject it?

The first valid one will be selected.

In patch 1/1 from this series, changes added to of_pwm_xlate_with_flags()
function, there is this code:

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

And since the modes bits are defined as follows:

enum {
	PWMC_MODE_NORMAL_BIT,
	PWMC_MODE_COMPLEMENTARY_BIT,
	PWMC_MODE_PUSH_PULL_BIT,
	PWMC_MODE_CNT,
};

in your proposed scenario: PWM_MODE_COMPLEMENTARY | PWM_MODE_PUSH_PULL
the PWM_MODE_COMPLEMENTARY mode will be selected since it is the first
valid one.

>=20
> Wouldn't it be preferable to either move the modes into an extra field
> within the flags field, or perhaps even add another field?

This approach was proposed in version 2 of this series and based on the
discussions I had with Rob Herring [1] I decided to use the remaining space
from cell specific to PWM flags.

Thank you,
Claudiu Beznea

[1] https://lkml.org/lkml/2018/1/22/655

>=20
> I guess since Rob's already acked this, that concern may be unfounded.
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
