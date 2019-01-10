Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C12C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477AC20874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qxaH0d4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfAJTT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:19:59 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:60411 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfAJTT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:19:59 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c379adb0000>; Fri, 11 Jan 2019 03:19:55 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 11:19:52 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 10 Jan 2019 11:19:52 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 19:19:51 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.57) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 10 Jan 2019 19:19:51 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2642.namprd12.prod.outlook.com (20.176.176.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 19:19:49 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%3]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 19:19:47 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V3 3/3] mmc: tegra: SDMMC pads auto-calibration
Thread-Topic: [PATCH V3 3/3] mmc: tegra: SDMMC pads auto-calibration
Thread-Index: AQHUot3iT26MK/BSWU6kkDZarmU1JKWopkQAgABCrSA=
Date:   Thu, 10 Jan 2019 19:19:47 +0000
Message-ID: <BN7PR12MB283603C485B9B4B04E742FFFC2840@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
 <1546462674-22856-3-git-send-email-skomatineni@nvidia.com>
 <20190110150602.GC25353@ulmo>
In-Reply-To: <20190110150602.GC25353@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2642;6:NneZlwWX8mi0Fn6mNnB4/WYQ4mXgG5kgkEB7SugukJoQKsSipXBGxUdiO8zznwHGW1T21ocQWlM6VewvO5jqfb56U7E5nbBuKTEwroQlK19gDviAn5l38gasMKF7UVNbzVuuWkS6hrMoaHmxW6oGQC2RSe28Oqfdwbq5CV4U4/+euUzDN7laz9iPWJ5R2iCMMlzP2KRFnAVNEV4sjfpYazLC2lS2qfzAru3vViDWSesdqWf5uKkpfx0etIBQjnE2pCjwJF4eTEav/G/pp/qSilyskYEtNrr3t20WT0Ailyowz379KDp1y5dIQCMlOwc2FdNaTZ+SGQELXDuCJyG1O+O0bNBlFi19aB+iCX8HoflT8dkQBiJwP2ubt/jXLgEn2Py3YdmN2FtZ3j92KuUOVaMwn/9fDNOeEQti7+0B/IKmc9BukyoAcHTibEd9H/uE6hoXQMQYnNR2YXFB3xim0w==;5:G8ZnpnLgxsZoBCeItv9axTxgSbDjasKduBmqMyCIRnL+e4k5Z0YAWlcqWM3O+gTnomV32dhFnNSLukn+0ZqWmXDWzK/iLWTs9u+wtmuATjAmUBWHH/2NbGISYL0TSjeA46tSFSCcGG1qtKr4Azkwzo2KNW12XZrtAVdwaqCfXL+lxMQmNklaShb8c4irO4w866MZUek9+MWsFFmtUXI+4A==;7:PC3tgDXafPr6YQAQg+o/lAi1gpRJRTZk8RalBa72JHQ7UL/1X3zb/o8imFFGwkKj4oFxHedl1xGEV0GfUZYzzmqZB5typsKdcK5mRh3N08X2lQ+oBMzJdVOCeplr9SUTikAfZIqAuYND8QxXPbBOuw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(14454004)(25786009)(4326008)(7736002)(446003)(39060400002)(305945005)(3846002)(476003)(6246003)(53936002)(55016002)(106356001)(54906003)(97736004)(86362001)(105586002)(6916009)(9686003)(478600001)(256004)(316002)(11346002)(74316002)(68736007)(6436002)(6506007)(7696005)(186003)(76176011)(66066001)(6116002)(26005)(486006)(81166006)(8936002)(71190400001)(71200400001)(229853002)(99286004)(8676002)(81156014)(567974002)(102836004)(2906002)(5660300001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2642;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 6cb84fb8-7e19-4c67-56f4-08d67730960d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2642;
x-ms-traffictypediagnostic: BN7PR12MB2642:
x-microsoft-antispam-prvs: <BN7PR12MB26422F721FE8187CE0460250C2840@BN7PR12MB2642.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wy2mlvjsE3jatqdu5tz/guB3KdCtrcDCxcbm+H2DV8fPk4ZthhUj1i0sXrUTlYVOvbunslP9taADsztxS4y+WMz7BGJe0ngzXrb5ilugFvokghM9G7NjUDoS6RLQlPmTAuqg1lt7G85IrnkbbCBZN4IyiPj032VndR1cSQiKAccDrWovhnSAPnktROzJH0i6ilf0LNJKosT09yMGpyzBmwTgRHRvrECYZLTVu+RUQFztSfh9fvt6Dwy1oyr6yh1YYGWFEWM7otSPSwro6VsMONkKWvh1DiiJ5qzraEQY3J1bv9QbUgGisEYijI72pbl20Oj9XhrrmVAqILF1cP7dGufL8ql614FXHa9TAawaxKlAiLzI4ohTfeffgkGqjPB0TNusNpOtKz+uDi6AiZKdMJFm49jHUNzkxk7h5PYCd51ztMJhDzORZHKW7DT5wVvp+MMsrGF7bjFX7QSHN6aIug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb84fb8-7e19-4c67-56f4-08d67730960d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 19:19:47.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2642
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547147995; bh=hhis5HiYx+8/aXXP9CANe3XZ7VxHCYy2OyC4IdYc/EA=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:received-spf:x-ms-exchange-senderadcheck:
         x-microsoft-antispam-message-info:spamdiagnosticoutput:
         spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=qxaH0d4vkWFus3wRIEHz/as1Bf0bJUJJrCX16SnO6VD9+fuX/DpajEC79PmAbuZxa
         /0aX1qaUGuzL92+7LhP/aCw9T8xbvYWt7lW7pIRJ5QlbNtHypfP7lbQd2pPOhKrChH
         lV2RmdmTc1Mr6oFyRcSwTQ6TlDu5nr6mg2IjXrYxVCibWCbCyZmm4YyRtPD0vxyoXX
         04olqYBp3ssh8CyCwylvFMMB5yLk9+HCtJW5A6zdX/0Yjz6FZEprZ892dUfHeKlPlE
         r2MciopFVNOuDp1IX6odjwoCBXiv/am9SPnx94+ohLR/sy9AUdUwB1ciL/kiC6AVjH
         cd9MZ20CSQsKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -805,6 +854,12 @@ static int tegra_sdhci_init_pinctrl_info(struct dev=
ice *dev,
>>  		return -1;
>>  	}
>> =20
>> +	tegra_host->pinctrl_state_1v8_drv =3D pinctrl_lookup_state(
>> +				tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");
>> +
>> +	tegra_host->pinctrl_state_3v3_drv =3D pinctrl_lookup_state(
>> +				tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");
>
>If this truly is optional, then I suggest we do something like this
>instead:

On tegra210, these settings are part of pinmux so using pinctrl to pinmux d=
evice node with existing properties pull-up and pull-down strength to confi=
gure timeout values.
On tegra186 and later, these settings are part of sdmmc controller itself s=
o using existing pullup and pulldown timeout properties within sdmmc device=
 node itself.

From sdhci driver perspective, if pinctrl state exists (which is the case o=
f tegra210), it uses it to configure drive settings otherwise (tegra186 & t=
egra194) it configures drive settings in pad register with in sdmmc domain =
itself.
So in away presence of sdmmc-1v8-drv and sdmmc-3v3-drv state is optional as=
 they apply only for tegra210.
From sdhci-tegra drive perspective,  it shouldn't return error on absence o=
f these states as these states are not used for tegra186 and tegra194 and i=
nstead use drive strengths time out properties.
Will add check in drive to return error on absence of both sdmmc-3v3-drv, s=
dmmc-1v8-drv pinctrl states along with drive settings properties with in sd=
mmc device node...

>
>	tegra_host->pinctrl_state_1v8_drv =3D pinctrl_lookup_state(...);
>	if (IS_ERR(tegra_host->pinctrl_state_1v8_drv)) {
>		err =3D PTR_ERR(tegra_host->pinctrl_state_1v8_drv);
>
>		if (err =3D=3D -ENODEV)
>			tegra_host->pinctrl_state_1v8_drv =3D NULL;
>		else
>			return err;
>	}
>
>With that we can use the much simpler condition everywhere:
>
>	if (tegra_host->pinctrl_state_1v8_drv)
>		...
>
>Thierry
