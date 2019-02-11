Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71157C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253A9218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KEeWnknn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfBKQXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:23:43 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2329 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBKQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:23:42 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61a18f0000>; Mon, 11 Feb 2019 08:23:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 08:23:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Feb 2019 08:23:40 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 16:23:39 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 16:23:39 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 16:23:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3608.namprd12.prod.outlook.com (20.178.197.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Mon, 11 Feb 2019 16:23:37 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 16:23:37 +0000
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
Subject: RE: [PATCH V18 6/6] i2c: tegra: add i2c interface timing support
Thread-Topic: [PATCH V18 6/6] i2c: tegra: add i2c interface timing support
Thread-Index: AQHUv+CHS8iiD7Agv0Wp9axF0O15H6XalJQAgAA0TeA=
Date:   Mon, 11 Feb 2019 16:23:37 +0000
Message-ID: <BYAPR12MB339842E44F370110CFA582FEC2640@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-6-git-send-email-skomatineni@nvidia.com>
 <20190211130322.2kpoky3scnqnxulw@ninjato>
In-Reply-To: <20190211130322.2kpoky3scnqnxulw@ninjato>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3608;6:5nLh7RgDh4ihxLDe4o3iDGPX3vnKoPDHraItKASQzVSpvQYX3UEhGMOAo+1TS/TVwSuCSkNQmlRq6Uz8Nvqyf0KGzw/NYe8qNYJlX/FAyYAFxUHbabTt53SA/rZV/6XexYAjnGMlOwjGr/w60MEmc6NiwGvR1RYtz2K35h/J3mwWq1KVOYWKSYBB+ZSpZ8GR1UPwAEZHVFLNkc1NQvB+9u4HOnt7FTRNfsNTC9XzC+z39XB2B4TqmuE4701YStlTwhDmogyhUFk2fqeiTeWrQw90Ge1H90dWhZxYBcheGX/ZJ4NBlIWMiEKfYil522eEXGr0rIUgkYgHhnsJwdhtrMYqbyU3qLnCHFFbxVaYGJvQc6+IqzBtLvnn4UKyv2NRIMuAXmYobjlj8z21vlcPvcX3TSWUlJuQZw4Z4kGt5z6THEHraECn5gU+XYSMw3PFhKauvmBoRCVSkNJH0VxvWQ==;5:BZ4w+NhassCLVIQgmc76gdVQvzyxHYaSwiD8axgU4RaLkT+/cxax8PoluewtkhfC027VcUE+QsQEfxtYQpvirrWqr1+Nkedz9PQR7UaDFUq76JbIe7VoDXlxoE0ICpTH1gYma9I0q00Vnt9TTOvI1WRjvwDwXdAp6ag3JT1ymSiCj+vewFkXbz7nS2o8ntkpb3pyjSppc7K4oCU8ou0/pw==;7:1yuptr36fKF7BjFPxuZeBcFPOnNQLGTWm3gQ8Dg5UYL+EEMpYB/vhTggZC2rkDtdq/cijDYIPEuR9mbXzBlgmPhTi5siyx2JujaXGLQN3Dc/P0u7bZzLUH+W0lqBhzEGv+u8V5f7EyEMNbq/hG70Qg==
x-ms-office365-filtering-correlation-id: c41d3c79-cc9e-4810-49ca-08d6903d46fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3608;
x-ms-traffictypediagnostic: BYAPR12MB3608:
x-microsoft-antispam-prvs: <BYAPR12MB3608AD85A42A8A2F3E4DAC7EC2640@BYAPR12MB3608.namprd12.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(6506007)(102836004)(14454004)(186003)(71200400001)(9686003)(53936002)(6246003)(26005)(66066001)(71190400001)(6436002)(25786009)(256004)(55016002)(106356001)(105586002)(7696005)(33656002)(76176011)(8936002)(229853002)(305945005)(3846002)(6116002)(81156014)(81166006)(86362001)(7736002)(478600001)(476003)(68736007)(8676002)(97736004)(99286004)(74316002)(446003)(6916009)(11346002)(54906003)(316002)(486006)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3608;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1kxBg4U3q1e14XNIXoKGvswt5Ny+2fmyQ/ZmJFCp5NJQ+v3b6qHUIITcCeICd/ctH5r7nJya5NJ6LJ99luLg/gqbniJfMzrV+Y6mcNRBctQGVWdtoeIQAALOb2Ytz/XztaLEcmiumw172CJTmCDC0CwZiz+4G4gTChe/spPOoJ0rcf7pm372NZJNqF2OVLvZRlnL9Zozklc926+0ZYvIPKoWr+0rwJoyS4W4676ZlKXsTsRAaJdSIounbADldU2+ChOjnMOsxRud1EIr8gKXv2NI2MrInRGly6gdIApPaOhYvZNNVklXR8H04G87IOx1lUP4jjJhZpNXkmG8OfMYEdDpXjVFEEQ3+BIywyI2ysGgQqQEhnqZr8+Z7fzX17iMPO8nfhLu0BTkDPf7d1dJ3YC0Rr5rjJ4bdBRXeipH3Qc=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c41d3c79-cc9e-4810-49ca-08d6903d46fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 16:23:37.5637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3608
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549902223; bh=TyJxQ37NfELI1jRm5UbbuCIv5rxYrbxE5inlI/NNqQQ=;
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
        b=KEeWnknnqqfuK7nPvNscDyYvN2i5L1KxYbxN/Nsjkywp1ILLFrBRH8+UpB5dqe+Nz
         jm2j7/YFlKrWdX3ItTj+AU6MKCwacIXv8UfCpsOhmiIKCy5etdMFbPSjfLbFoA2MJJ
         k79wLW05Z/VpBywhNvqWAFooVjzvjrSua6ssPNUzkaCR+y+vrGp/AYoa+TCRH4n54u
         36ackSGM3zIJLr/jEYbajNKe03vu61V/Gg8wn7+dzNSpjrXglJXmlwwru46LDNB2ln
         JayMthqkCYcxA2SHVwtjlxFc6qv9UuqBw09yc8Tw3Fl4Zxrn0HuW5oWPdyE50y0Drn
         i2y7RnuZ3yuKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 08, 2019 at 10:59:42AM -0800, Sowjanya Komatineni wrote:
> > This patch adds I2C interface timing registers support for proper bus=20
> > rate configuration along with meeting the I2C spec setup and hold=20
> > times based on the tuning performed on Tegra210,
> > Tegra186 and Tegra194 platforms.
> >=20
> > I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field and=20
> > Tegra I2C controller design uses them as a part of internal clock=20
> > divisor.
> >=20
> > I2C_INTERFACE_TIMING_1 register contains the setup and hold times for=20
> > start and stop conditions.
> >=20
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > Tested-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>
> Are you aware that we also have DT bindings for various I2C timing values=
? They are usually board dependent and not so much SoC dependent.
> Please check here:
>
> Documentation/devicetree/bindings/i2c/i2c.txt
>
> (Oops, I noticed 'i2c-sda-hold-time-ns' is missing from the docs. Will fi=
x that ASAP)
>
> Just saying. The patch here is fine for me. DT support could be added lat=
er, if you want that.
>
Hi Wolfram,
Yes I looked into those and the reason I added them as part of hw_feature i=
nside driver are
1. property is in-terms of ns for fall time but the value we program in int=
erface timing is not exact ns time
2. Below are the timing parameters need to be programmed for tegra I2C and =
I don't see equivalent property for each of those
     TSU_STA : Setup time for repeated START condition
     THD_STA : Hold time for (repeated) START condition
     TSU_STO : Setup time for STOP condition
     TBUF: Bus free time b/w STOP and START conditions
3. All above Timing configuration settings are different for different spee=
d modes (STD/FM & FM+/HS Mode)=20
4. All tegra platforms of specific Tegra chip has the same timing configura=
tion at-least for now so added this info as part of hw feature inside the d=
river.

Sowjanya

