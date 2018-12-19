Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2889AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC90C21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t1EgaDe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeLSJsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:48:31 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:52832
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeLSJsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rB6iVvAA8lPxdg0C+3ePxxohblsc5L0V///vXY9ta0=;
 b=t1EgaDe6lgoxkoS3M/tV4ziX50cYtCe2lRKi8EG+5dEVxKI8Efr8Ch39Ob8amRGSxXbiiBU5TdO3VU34lWH7FHtuXdHEDgHHMyRvsaglJ0PArwVOI5sW3ZKyXYrkcYwOrqEbhK4KQmnhP7TuLHcn2N5g3AHfuaIrpV9snB3y3a8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4228.eurprd04.prod.outlook.com (52.134.126.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 09:48:25 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 09:48:25 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Topic: [PATCH V4 2/4] rtc: add i.MX system controller RTC support
Thread-Index: AQHUh4Xdr+AyS6mQK0O0uEwcLIV+4aWF4duAgAAMFQCAAAJJgA==
Date:   Wed, 19 Dec 2018 09:48:25 +0000
Message-ID: <AM0PR04MB42119CF2FB98AEDE02DC0FB980BE0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543455856-18021-1-git-send-email-Anson.Huang@nxp.com>
 <1543455856-18021-3-git-send-email-Anson.Huang@nxp.com>
 <20181219085429.GJ19816@piout.net>
 <DB3PR0402MB39167296BD1302130B537FD7F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167296BD1302130B537FD7F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4228;6:4rO1VdXaQ01spCiwYow2swmNIRSHAsVW3t4AUleXr++11XdqnOBH1mymxcwZbNAlf9jxqHDuh+/DfPXF6BCjCb/1WdvTrJjkPBrvXmUtiGAq8PMfOPQw6yK1HTqg4FzyanW+fQEr+HxDyFisLXOi9bgD3EmDNuDhUhvjwlojG9zAUpltK0gObA5O+fNR3PQHvsSL7cUZwxIYHyv1FTpEtZ4W36jDxyAdL7jmI+iyiAuIhcPxD/i0nCsw4NCy/dHL9cSnCnIBBvEcRGQTjFZ4oyjCHpTGqMCkqR5sRs8C+hOjS9MiLfN0Qa17+CIVoloBWSF+eNuT9bGuW8XND+PVQ/LVe3CYDf/EZWMPvoB7RrUMi2eUy7oc4V3oZLJGMFuGUib8i0Qmgxt0ZYxT2OOXbyPIEgdCxig4PbcVXnGrTDtnTCnGErSt0/PVHXzArpwGFJQ4kXndqC1E8jKHS5hAlg==;5:3EcLSCpIjAcPI6IjnNgDdqOzuiNbh7yyBsgXQMHnDG7Lz9SxaZpVloDamzv+usqTOyIEc5ltuiVDjd2OW2gfdNdw4nbAP1fr5DG9GW7tWH/70N3WR15OhkWtOBb9Vkic5Co2Ivloy7wvqq1p4lm5UmjKiyi6vi0vonE4CwTyIMk=;7:EL+IXO+RmasGRJdD4Y6VtV+rt8yth9RG9TH58OLJB4bRbxa8lq+Nl4Nw2vN+A8ALcuxCrB304VsnTocfjrzsnr/YVucWiONp8UZ1dgpCiB/Fy6NfMckwxvybZQZmFMWsd4pDSJiiTRRznw/9Rux8/Q==
x-ms-office365-filtering-correlation-id: ec8b1aa6-214b-46f7-7cc2-08d665971f55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4228;
x-ms-traffictypediagnostic: AM0PR04MB4228:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB42287521D57A4D10FC23412180BE0@AM0PR04MB4228.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4228;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4228;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(55016002)(7696005)(71200400001)(105586002)(4326008)(106356001)(26005)(6246003)(6306002)(6506007)(76176011)(9686003)(71190400001)(102836004)(8676002)(99286004)(7736002)(68736007)(93886005)(54906003)(8936002)(86362001)(81156014)(11346002)(486006)(81166006)(110136005)(476003)(44832011)(316002)(446003)(74316002)(7416002)(66066001)(5660300001)(186003)(33656002)(256004)(305945005)(97736004)(2906002)(229853002)(14454004)(6116002)(3846002)(6436002)(25786009)(478600001)(966005)(45080400002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4228;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ANXNloCANg7sfOR4Cic2mncLU1VvO23ONeflTE/FDVj0cJ9Wrupxq4ccvqoL6p3kSN8JtgkXQ+Gh89o2KIteHn+xFCzMdlJRw77Y53ghe9ZOCPdF1Qc+W3/KVzkX4n3woQvihQgEflUKRK1fwuVKoILgVXoruxV5IAJ5cZezNXT3BLJBo1EbDnm3JkC0552nqGBvbMNMzlWuJZGhAwCP6kSvHbWr5UOPP5+NHFCjubncap/SAIqyuzB1C2enoKc7ZdmNZ45L0j+ei1WqNaMHGz2t1pVi3qeJbcUlmYW3CULxZIeRtGqUyKpN7a6E/ViX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8b1aa6-214b-46f7-7cc2-08d665971f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 09:48:25.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> >
> > I applied it on my test branch and this makes sparc64-allyesconfig
> > fail
> > with:
> >
> >    drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_read_time':
> >    rtc-imx-sc.c:(.text+0x34): undefined reference to `imx_scu_call_rpc'
> >    drivers/rtc/rtc-imx-sc.o: In function `imx_sc_rtc_probe':
> >    rtc-imx-sc.c:(.text+0x90): undefined reference to `imx_scu_get_handl=
e'
>=20
> Maybe there are some changes on basic support of imx scu driver, I will r=
esend
> a patch set later, thanks.
>=20

This driver should depend on IMX_SCU which seems not got compiled.

Regards
Dong Aisheng

> Anson.
>=20
> >
> >
> >
> > --
> > Alexandre Belloni, Bootlin
> > Embedded Linux and Kernel engineering
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbo=
o
> > tl
> in.com&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C72b147643a3f
> >
> 44c258c208d6658f9cce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > %7C636808064818797711&amp;sdata=3D%2Bl5jGXX6wBYbOg5Zalg4CyxyZKj
> Ue
> > uzRSQEKO9TJnRI%3D&amp;reserved=3D0
