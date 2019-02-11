Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7BFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA733218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qte66Y+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfBKQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:26:09 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10014 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfBKQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:26:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61a1fc0001>; Mon, 11 Feb 2019 08:25:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 08:26:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 08:26:06 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 16:26:06 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.57) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 16:26:06 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3208.namprd12.prod.outlook.com (20.179.92.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 11 Feb 2019 16:26:04 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 16:26:04 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V18 4/6] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V18 4/6] i2c: tegra: Add DMA support
Thread-Index: AQHUv+CKof0gZiTp/0CPpdzRawDXOaXakkiAgAAHgYCAAAHpgIAAMOAg
Date:   Mon, 11 Feb 2019 16:26:04 +0000
Message-ID: <BYAPR12MB3398E24A9C3AC87F601DA1A2C2640@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-4-git-send-email-skomatineni@nvidia.com>
 <20190211125509.tnsgfl3yoobdpnmj@ninjato>
 <ed92df42-459e-26fd-ce4e-f4530bf30783@gmail.com>
 <20190211132851.pxrawigdgggoc32k@ninjato>
In-Reply-To: <20190211132851.pxrawigdgggoc32k@ninjato>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3208;6:r1q27cIi7isEwViRhf3BehOVLyYMxVCTxYvxZCO0rktCbqz+LJV4Ju/o+xk8G1Ua/dARRIazb+SiqylPZ+0RmFAPZw2gCtBdHnX4mNrNegv55zkPG83Y9FAmsdDX1T8pDOX6VDEZ3qQQDSG7yNPrKhFrg9r9D2OleIzR6zZEKzxE524JNkXLNvYF0tvH44PhE5sPmS6XBpTwSktk9dwu+SEtQdqt+pd7Uply5H1GnF17C1JXzi06evtMgPXTfHd/dq1g+mFX7E6YzmbfZ6IKKwoi7jhOoeTCj0fVbSYmy6OMyyRyzhSfsktrUZWMpwps8n58Po5vLnNICrvru7DiZo6dv3pF4QBbNbPmWLLbRaBPoqoZFuaw6VLqAjxLyurmxqVKEI3tac5GYphjWLgjut7xM1UXwYQHDm6lioLhc5F8d88AmHcS4UDPCUzlVz9k3kxGoACiixWxtXN7dJ7aaA==;5:vWvkSxH7OJsItHiSWiomN6uAcYwc+sFmYkJF9KVmnwXomymfyDaYeaEI/kOaiiWVKmtFIV9z0M9zUVWJzY0PGVf+VCz1bQRX5WCK5EAPV2NA0gBSZBvkU15eOhtHXWHTqA6KqNU2+pot1QOAaH/k9ulriIVVS0WU2hF8GttWVG3DZKmKA0WJuKYk2v9Rn5KKtMTDEaghT7bd8meU9XQYCA==;7:sooM+ICt3UOXm8tGFw9SAVuWzKRdFQBGxr/HAwoiuYUnGOtm86GSdx0IpLx4FRDDwwEn9OlAKHuq9hdhD2E41p74pXy9EptvnyxvchN/x9ZAG2MtFhlSONq/7ux6OaUwUZxrqoJ5nrdVC7b4J5pbiw==
x-ms-office365-filtering-correlation-id: 16df2cbd-1ed7-444d-9033-08d6903d9e57
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3208;
x-ms-traffictypediagnostic: BYAPR12MB3208:
x-microsoft-antispam-prvs: <BYAPR12MB3208DD84129B29D4F09D6E5FC2640@BYAPR12MB3208.namprd12.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(6246003)(14454004)(68736007)(7696005)(99286004)(6436002)(53936002)(106356001)(105586002)(71190400001)(71200400001)(256004)(14444005)(316002)(229853002)(110136005)(54906003)(486006)(478600001)(6506007)(86362001)(446003)(4326008)(305945005)(7736002)(74316002)(102836004)(26005)(25786009)(11346002)(8676002)(9686003)(97736004)(81156014)(8936002)(81166006)(476003)(3846002)(6116002)(76176011)(66066001)(2906002)(93886005)(186003)(55016002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3208;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t7Siu7R8Es4F/8oj5DU8V12K4HhIo/U0wqr6Yz5FMttUbDLw3YtVt35Ldjk+g9VG/9+CLOoSkya9EQCbUEJOZcsnTaJBMytFNwiojEOMCeo7kT+1nvXkmnd3IP8sZfvrjXB0xr6zsqG8Z5wzVd5ZX1R9dL0hWuAf89j3Q16/MFH8nuwCnsmCIk7oyq2oz0Cv5wUEMcchC7XqWn69++rKDnsiEf2c4+0a26AjI4HlaTiqqXsJ+j+m/XPTzFPp9mnVcIOoL80Gg2wiZDpEeKi+AuYWfECcBMwr4RkAh8G/SWmtfWExD0kteeeirAjk1yitV836ulAhponV77vSNrNm8cyXJIeAPTdZQF9z07YHE4QWVJm9v5oT/8mm28C13A7lzlCYWDNADRc0midA/+eLmTJ8WUG02H4DPeE4E1ez6k8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16df2cbd-1ed7-444d-9033-08d6903d9e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 16:26:04.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3208
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549902332; bh=VTGyPIuZ7DzrtsvSmM4mVALVZaP4BLfAQ/PIxFf8IjU=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=qte66Y+G2cYSPOIjqG/j4T3zPN5vvWEYNXecX0e4XO9Cs5C7JwMUDOTtUgcRojAcE
         1Njiz2dFz8nfD50H+l0Yu/DAp+rFDN4cRjdCMHXnNEeKX+h/uUtEagCaUNfB4/+5f1
         jI4nV9aCerpLXMfj2CHOfZkmINdeA20dRgRZK2TRUPfmcEKalV2RTZE0xZNa4UiOPa
         qKkxG0PvY6HO/ZBTOehsebT+Nhi2u6VkWzUH84hexJl8fPCeiMsKHD8t11Ctv7sgmA
         fi8fwsx2+rb4HbFEZuNQhG515KPAWRWeuhUMJFDePkPeDgl9k2chzjeBQ1E7GpnhJR
         Vuhi6I3WRUwRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I am not sure if you are aware of this document, so I mention it:
> > >=20
> > > Documentation/i2c/DMA-considerations
> > >=20
> > > I am not pushing you to use the i2c_get_dma_safe_msg_buf() helpers,=20
> > > just wanted to make sure you know about them. I am also fine with an=
=20
> > > incremental patch on top of this if you want to add usage of those=20
> > > helpers somewhen later.
> >=20
> > At least I was not aware of those helpers. It looks to me that the=20
> > approach of having a statically allocated buffer is more optimal than=20
> > having to allocate and map the buffer on each transfer.
>
> Can be argued, yes.
>
> > >>  /* Match table for of_platform binding */  static const struct=20
> > >> of_device_id tegra_i2c_of_match[] =3D {
> > >>  	{ .compatible =3D "nvidia,tegra194-i2c", .data =3D &tegra194_i2c_h=
w,=20
> > >> },
> > >> +	{ .compatible =3D "nvidia,tegra186-i2c", .data =3D &tegra186_i2c_h=
w,=20
> > >> +},
> > >>  	{ .compatible =3D "nvidia,tegra210-i2c", .data =3D &tegra210_i2c_h=
w, },
> > >>  	{ .compatible =3D "nvidia,tegra124-i2c", .data =3D &tegra124_i2c_h=
w, },
> > >>  	{ .compatible =3D "nvidia,tegra114-i2c", .data =3D &tegra114_i2c_h=
w,=20
> > >> },
> > >=20
> > > Shouldn't this be a seperate patch?
> >=20
> > I asked for this change and no, it shouldn't be a separate patch as it=
=20
> > adds "has_apb_dma =3D false" property for T186 that older Tegra's have=
=20
> > as "true". Without this change T186 uses tegra_i2c_hw_feature of T210,=
=20
> > see [0]. Hence this change is absolutely correct and appropriate for=20
> > this patch.
>
> Then please update the patch description to contain this information.
>
Will update commit message about the reason for adding has_apb_dma
>
>
> > > This should definately be a seperate patch. While I am all for=20
> > > taking it, are you sure it does not regress on older Tegra platforms?
> > >=20
> >=20
> > All the patches are tested on older Tegra's (T20/T30 specifically by
> > me) and we fixed several bugs that were regressing them over the few=20
> > versions of the patchset. I specifically asked for this change for=20
> > older Tegra's because the APBDMA driver (T20-T210) is getting=20
> > registered from the module-init level and hence I2C driver probe is=20
> > always getting deferred. I'm not sure that it's worth to factor out=20
> > this hunk into a separate patch as it's directly related to the DMA=20
> > support addition, maybe worth to mention why this is needed in the=20
> > commit message.
>
> At least, this, yes.
>
Will update commit message to reflect this...
>
>
