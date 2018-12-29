Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409A320811
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="f4k62QkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbeL2AIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 19:08:09 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11979 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeL2AIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 19:08:09 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c26badb0000>; Fri, 28 Dec 2018 16:07:55 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 28 Dec 2018 16:08:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 28 Dec 2018 16:08:06 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 29 Dec
 2018 00:08:06 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.51) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Sat, 29 Dec 2018 00:08:06 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2642.namprd12.prod.outlook.com (20.176.176.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 00:08:04 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%2]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 00:08:02 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Preetham Chandru <pchandru@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad drive
 strength config
Thread-Topic: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad
 drive strength config
Thread-Index: AQHUl+5YYsymyNLskEeJX8dbpAyxrqWTJ92AgAG7hPA=
Date:   Sat, 29 Dec 2018 00:08:02 +0000
Message-ID: <BN7PR12MB2836C77E851E7AC4BCD38BF0C2B00@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
 <20181227213353.GA8110@bogus>
In-Reply-To: <20181227213353.GA8110@bogus>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2642;6:6B+4janMtQG2qt9eHjnNsvLIZklgH02EZcuygHRPue+jN1YY0p8KPHzeZFP4hy18TWXahYuNCPtGEKG6tRvPWI58RvsJ7Mg8AFhxG/2xjS7fyqfZwkCwnz2wvr+hgVfNys5tgmhw/wYPXpdqiUs6kabMvZic1zpSFISj5pZot/z7LXYtCx9ozocdcxEzh5IMPVGhZItV2ZPvaVb1adWb9T4NLuMeQu+X+00vt4MzcC5o/gtwmXeiacwbkdINsk2VWgZp3qTBab+8BYCu6niiTYjspHYKQObRcoCq16fy1G8DaKCBlg/Riw8ao8gDIOjXzGGWIJopOrqKRplPmwR5EcOJUncyALHE4BbKinq9p4CT5F797cLo0QkYGpouEU9XyNwWMVLB1EVVCGRR5OMxHaXgfb5AQ2J3g9JkDoq/iAngVMaKtnw3HrCwgMVXk4rkqCKDrs5u+t8qOTW05d/eKQ==;5:80waqTyKWO3nE/YxBuL7CvaQp97UZtl0RC1CN+vPkAhvCYsT2NLgQK+bKnktVu4SAX5ghmufnOAq4XcSOZthk3Rap2qQl/chTdI1md4ZxNOhELIqHX54ZSWWrmLx2fkllX2SQuPTciSGN23ctiQngnBRLJxNZUuw+AIm7hTTtA8=;7:QnfGWnALjvP7zrzgwL4ZiV7JRtFwxZnZq9pqYKoELSBRr8Eex/0i1ME7cYVbuvtg4Ct8epIct6hKI3GFHW/fvXYFOwLwZb8ZSHDkI9ihjociMVgX7Uiev4Q7XrOhYWWYjHVKt9TWYXT7SaMV7RtPvA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(33656002)(25786009)(7696005)(106356001)(256004)(14444005)(186003)(81156014)(4326008)(39060400002)(6246003)(55016002)(105586002)(102836004)(76176011)(305945005)(74316002)(7736002)(9686003)(26005)(68736007)(81166006)(8936002)(229853002)(53936002)(6506007)(8676002)(316002)(486006)(3846002)(6116002)(11346002)(14454004)(446003)(54906003)(86362001)(97736004)(99286004)(476003)(478600001)(5660300001)(71190400001)(6436002)(2906002)(6916009)(71200400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2642;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 0cc991b8-cf68-43ce-2467-08d66d21b350
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2642;
x-ms-traffictypediagnostic: BN7PR12MB2642:
x-microsoft-antispam-prvs: <BN7PR12MB2642DDFFBC17D77AB71047A6C2B00@BN7PR12MB2642.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2642;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2642;
x-forefront-prvs: 09011458FC
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hYWKUZa9hSuBM5E1yseeltnAZR5d7W8fDV4NfwA0phQoDmfYYKaCoIjMjD510sg/9z6sbXC2EMWDnm/Ppnp6bJwXZhIGBzHRLO5Sn9zPpzfDPip+Lv4JXqrPNHALdM/DpqcZj+Hej/sR5G4Oyn6NUKk4Tb/TqnSIgKhxcyy1wOlRcovF7DldcgUMhsmtLiY2at/mNDDydNhyOjzGYoP64s0KB+yCRLOO5zlkHB5OhCvsxlEt0u0XGhuBpkpiWfz1RzFlLjS5Seah80SjdB+atjt9gzeeZgLy9Xk3QiuurLzriIISUHeIPmoNSSjkv9GN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc991b8-cf68-43ce-2467-08d66d21b350
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 00:08:02.7819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2642
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546042075; bh=sAu3rZE/SJQZmhMy2D0w49Gucvm0Y08TFSkggpdFxyA=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-exchange-antispam-report-cfa-test:x-forefront-prvs:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=f4k62QkUIvr5kpwlVg5dw3yF5axII0YTLjDH8ducj9PukzMvjMvjGDKqzmXhrIka1
         8NAAYszCaHgJWypK+7aGg8NarFg3wVbtbMgEXzJkuIfE832n07fLeneyl3cjCJrNoX
         vSnw2Ev+zs3GPLTigeJmc98u+EV0g+IMDfMvCHsdFYPL6V3Y8V+X0M/sJQv+f875kl
         kg48N9xg1ozbGhKyLRWRL2AQD0DcRtb019dV+we7j5fJt3IvQBowX83YdCqzbiiGn4
         EddMLDNalDGwfm4+gts9q16eB6mWvvmErxER5N6/ZonEY4w9IbjCTOStZferKs+5Yz
         VyKFwLxAd8LLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
>> Tegra210 sdmmc which has pad configuration registers in the pinmux=20
>> reigster domain.
>
> typo
>
>>=20
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6=20
>> +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git=20
>> a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt=20
>> b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
>> index 32b4b4e41923..2cecdc71d94c 100644
>> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
>> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>>  	bus-width =3D <8>;
>>  };
>> =20
>> -Optional properties for Tegra210 and Tegra186:
>> +Optional properties for Tegra210, Tegra186 and Tegra194:
>
>Adding Tegra194, but this patch concerns Tegra210...
Yes this is mainly part of Tegra210 Patch but pinctrls sdmmc-1v8 and sdmmc-=
3v3
also applies for Tegra194 and since it was not mentioned, added Tegra194 as=
 well.
Does adding Tegra194 in this should come as separate patch?
>
>>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>>    for controllers supporting multiple voltage levels. The order of name=
s
>>    should correspond to the pin configuration states in pinctrl-0 and
>>    pinctrl-1.
>> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable=20
>> +for
>
>These are in addition to the previous values?
Yes these are additional pinctrl states for pad drive settings which are in=
 pinmux
Domain and are applicable during calibration process.
>
>> +  Tegra210 where pad config registers are in the pinmux register=20
>> + domain  for pull-up-strength and pull-down-strength values=20
>> + configuration when  using pads at 3V3 and 1V8 levels.
>>  - nvidia,only-1-8-v : The presence of this property indicates that the
>>    controller operates at a 1.8 V fixed I/O voltage.
>>  - nvidia,pad-autocal-pull-up-offset-3v3,
>> --
>> 2.7.4
>>=20

Thanks & Regards,
sowjanya
