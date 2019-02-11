Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FD9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C50F217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="isiWo2Y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbfBKUSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:18:34 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:9419 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfBKUSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:18:30 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61d8910000>; Tue, 12 Feb 2019 04:18:26 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 12:18:26 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 11 Feb 2019 12:18:26 -0800
Received: from DRBGMAIL104.nvidia.com (10.18.16.23) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 20:18:22 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by DRBGMAIL104.nvidia.com
 (10.18.16.23) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 20:18:21 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 20:18:20 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2631.namprd12.prod.outlook.com (20.176.255.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 20:18:16 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 20:18:15 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "peda@axentia.se" <peda@axentia.se>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V18 2/6] i2c: tegra: add bus clear Master Support
Thread-Topic: [PATCH V18 2/6] i2c: tegra: add bus clear Master Support
Thread-Index: AQHUv+CBmuT/TkSWHkeDVsjV+R6JNKXaj1EAgAB+O5A=
Date:   Mon, 11 Feb 2019 20:18:15 +0000
Message-ID: <BYAPR12MB3398A2CABD430EA15FE15CC3C2640@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-2-git-send-email-skomatineni@nvidia.com>
 <20190211124431.kys66uzp5hwa5ret@ninjato>
In-Reply-To: <20190211124431.kys66uzp5hwa5ret@ninjato>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2631;6:WnQe+TYNX7INWWYjuZ+lNI08FaRl2GiZgE9GmX79vQ1o2rWK4dS3cL+2A4vEh5R77rjNEbknuPPsOslPhw0tFD8/bfVTFHA7EbW8HIGNnLw0NUg0bqu3JcB4tTDnk9+FkccLvhGpOLySknkZa7bq/6+d5sMq8aagSaPv9sngnv6PFi8UoUWcC3qjLF8Kx//7km52BPhlvUJEzOaT0Fmd4Tg5ME25wUuECGc/27ZIMLbgrrzNagKNSjeZvZoNefQGaM8VoFRZAzPFEWXPqrG86NLgbDFUmaSn45I6JDkMvZecDPWnakbY35cMoHhQi9CFCaHcPpWU0YvB0XdOKTYjuZU2vBUD4Do8vuRXX9hDpnGDAp0XYpu0OaWpTC1R3zRvIdf20z9/Xv7V4B4p+Vmq+eaHZXZE98V5kusQUG+LQwqTGYcxgV2ywfi5wDJovw6CsvTh0dZgY3MLLej7Bi9HHg==;5:CZ/dR54+8Iwh8OI78BcjTbHAy9kx1Lk+vFG3QZD5QYEfme0QVtdIJBimrgRvXIKTwf5/cXCIojCnbhIrBIzgHhrqgDEcXHV6J5FaO8cN9QrfMd+q2bNh1s9WfWeS2nOSZX4zV71GV1Pp5IDYquyGYs8YICMZQt7UaVXE8HDo+bo0AFZf/ZYs7dF7olByv1KWes7NIN7WQ2UFWehLKgKiog==;7:kM6yP6x0ql7h6NZ5Xow5n1FleSaeFDQL3Z7hE625+1cj6aTwdaQCoZUlOMfrbTH0APjntHMWRFfbGvbKcJ9F171VrN4LNSxbqxf2F0GqlfUtXmDsfbwLUYFbDCcmERaOw4LE7p8IokhpR+T0pBF8Lg==
x-ms-office365-filtering-correlation-id: 4dcd042c-47f1-45a7-b030-08d6905e0e40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2631;
x-ms-traffictypediagnostic: BYAPR12MB2631:
x-microsoft-antispam-prvs: <BYAPR12MB2631348DA5D7D14B10DA3ACAC2640@BYAPR12MB2631.namprd12.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(229853002)(9686003)(478600001)(68736007)(14454004)(2906002)(6116002)(3846002)(305945005)(55016002)(74316002)(7736002)(26005)(6436002)(4326008)(25786009)(71190400001)(106356001)(71200400001)(105586002)(99286004)(186003)(7696005)(6916009)(102836004)(76176011)(476003)(66066001)(446003)(5024004)(14444005)(86362001)(6506007)(33656002)(11346002)(486006)(316002)(54906003)(81166006)(81156014)(53936002)(6246003)(97736004)(8936002)(8676002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2631;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 14bVt/Zo0NSd6us0UhpPSE1jd3Ugz2E8P0NvT+WKeJnW/DnV+CXIDm1Dt9tKQHkTezdT65EA7BLEVYJKMwfDJwET7euVWGob2osEIDy3zVd+L1zyP3Nr2Cwxl80o5GedE2NvhvuhNZaIUMey4UbakhcrtQASqBly3TAlOFA99fQ0YpWITV+5A6eUsIN027c2M9zF4Q4KZUjITIysge14I9oM93036itqeKwQxv14ItMcm+Mig7zlsAFw9XgpV8T5+ar2mXtx/uHWapvL8bsr2duSxaZl8/lN0A9OXXCc47/HH96C0YNtd7YSjUqJVGld6yfa1mEzKzM46Rfeqt3+iAbiySXUd27HKSXKBN9G0FLsP4t2gAIOo3mDtQSF3oTEFGW4QqWyk4SPLAAf72duRTS+YXpP70eGl0Ypo30KUks=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcd042c-47f1-45a7-b030-08d6905e0e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 20:18:15.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549916306; bh=SFBj+GdHZ+m77WdYRGtFl6VyUufJmfVlkKZjDpFmVh4=;
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
        b=isiWo2Y9bZygx64ByFiIvDTjW3t2fl2Bk8QOPIN3mirKs7YmTSCQHSbwNmNWeDmse
         KAPTP+AA3C9j8iNXnZBDAOTC6uMaGd+Q8Bk8bAQ2y1peGL7Qz/G2UMZrx7TREEs1bG
         zwzFurJvE/5farNIBAjBO4KAoqMlTZ7smhla71l4z6kcTvKuuoW1/BvQrR7A73MoJ/
         jdyyuEjz0yGxTI9B3cOs+0IEuarCrV0096Q3JjYE1FIJWZySwhi7SS6zGamB80Hqp9
         mho+G2t6g4Kt1HAu+8Pl8rChMp8QDtl39IbU+cm5ofF2igyVdRKfVYWv7aXPwVwud6
         ojw4zmOEasqFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Bus clear feature of Tegra I2C controller helps to recover from bus=20
> > hang when I2C master loses the bus arbitration due to the slave device=
=20
> > holding SDA LOW continuously for some unknown reasons.
> >=20
> > Per I2C specification, the device that held the bus LOW should release=
=20
> > it within 9 clock pulses.
> >=20
> > During bus clear operation, Tegra I2C controller sends 9 clock pulses=20
> > and terminates the transaction with STOP condition.
> > Upon successful bus clear operation, bus goes to idle state and driver=
=20
> > retries the transaction.
> >=20
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>
> We have a bus recovery infrastructure in the core. Tying your code into i=
t should be easy. You probably just need a 'struct i2c_bus_recovery_info', =
populate the 'recover_bus' callback with 'tegra_i2c_issue_bus_clear()', and=
 attach this struct to the 'struct adapter' if the IP core supports bus rec=
overy, otherwise leave it empty.
> Then, you can...
>
> > +static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev) {
> > +	int err;
> > +	unsigned long time_left;
> > +	u32 reg;
> > +
> > +	if (i2c_dev->hw->supports_bus_clear) {
>
>... remove the if here because the core will check for a valid i2c_bus_rec=
overy_info...
>
> > @@ -759,6 +818,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev=
 *i2c_dev,
> >  		return 0;
> > =20
> >  	tegra_i2c_init(i2c_dev);
> > +	/* start recovery upon arbitration loss in single master mode */
> > +	if (i2c_dev->msg_err =3D=3D I2C_ERR_ARBITRATION_LOST) {
> > +		if (!i2c_dev->is_multimaster_mode)
> > +			return tegra_i2c_issue_bus_clear(i2c_dev);
>
>... and use simply i2c_recover_bus() here.
>
> This will help making bus recovery use consistent across drivers.
>
>
OK, Will update to use i2c_bus_recovery_info

Sowjanya
