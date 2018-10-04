Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1343EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B1B214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dn9D75iB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B1B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJDPjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:39:51 -0400
Received: from mail-ve1eur01on0057.outbound.protection.outlook.com ([104.47.1.57]:48000
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbeJDPju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUgmdCtOz6AAZItbvy6kd0cpayPXQYSM856j4X6YDxs=;
 b=dn9D75iBbrrVpqvJPaLCcYGiy5ZJdaMeE9SRJkxiYkM+SxPS0AHn7tCqJHIwRkiNIA19kAsq1iRvIv6cfhYcpXRfjIzUF2eas3VUg3IEmX+CDJVYCRM7A7anOjPKVJH0ULCFkCq2ozLMvxjxLrW2t0j0+6YDnQZj6LblRQiNci8=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1552.eurprd04.prod.outlook.com (10.164.84.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 08:47:33 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 08:47:33 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Vignesh R <vigneshr@ti.com>, Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "juliensu@mxic.com.tw" <juliensu@mxic.com.tw>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>,
        "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>
Subject: RE: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
Thread-Topic: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
 mt35xu512aba
Thread-Index: AQHUWzpebO9UjE7y3ESdBwkaF5y7X6UOpRKggAAPOICAAAUCUA==
Date:   Thu, 4 Oct 2018 08:47:33 +0000
Message-ID: <VI1PR04MB103837831B8BFEC2F7FD12E799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
        <20181003165603.2579-2-vigneshr@ti.com>
        <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181004093925.2961d881@bbrezillon>
In-Reply-To: <20181004093925.2961d881@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1552;6:lgTL8l5HWw2MIQ6pgolz2wyBjya1O5qp9NL+UMqA/lIEcWvJsIYkSBrET24GL3zt2XS9lSlWCgVEWJKq2Bu63zFCZ/tkFJ61SL8Ec2kvDbPTDA/w1ecV8nYr27xrV4I/b82HXIQ87NRdq6/qbm86rHR1rirNUNfHlBfoWNpRRezZOrweIj3iPh3Koa4Lwuy0XLOjJTXWK+J4LlxR2ig4jE95yBVtLhOZhzIIYvFxP+eNFrJ7Nj6E7kZqq9b5oSt36ZusNDQNRzK5Z4Yrayip3actXrywc+IlD/1AH7svAcbPJEjTKwfFZ43ZKHpXw9NXfOwBz0sY+ww2HdF8+7pmswqUgs0bLH15y8g2mqNnoxABYEyVF5EAsRbtFU/XAdWXvtP429UW1efUg5/hq28o74MaKflEFG2ylfziiTH0QttwgtcR5ZvbLc+pqQZCvSEulDXGy931uNICD4dJHlunhw==;5:ZHtU6jdEMHPtGCkqppDfRSuN7BY6jOvXLVrShCNNaVWpJuSx78BA/kE66Xonh6MkMuzB/0hc62HcWWqHDOjRgCrYyFD1lufYPnTvDgoEj/cwEjWYsaguTlHWPn/oAL+Tv0EkEw7htuZuWyef4QmAluwcehLqnPvvOAbl00kBZ2w=;7:gq+AtUri6rZeLrKlBn1Z1fnb1vSZp7sCWTtKLWVsceasm6LwztieJ5leQ1Pw3h4qX+oxMpI11FTg1ohcFD+cmInHzB6mkoS3AQ1a5O3jcQFoJhOVYHwmXHx5uGHx1qrDxA3PlKYb6v3j3ulpATltg6qZEUT3SQI4a6+ev7z9rl9gm8JVCTCSeTGcwjGhZHJOSdHaS5ecF4RVoHatbfyNFhm/ovrxhTj5LusT2WulyQQLLWEfWEcBYf2UFRN0JLAk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0f001ab1-432d-47ac-0e3a-08d629d6071b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1552;
x-ms-traffictypediagnostic: VI1PR04MB1552:
x-microsoft-antispam-prvs: <VI1PR04MB155288839873D707FF25898699EA0@VI1PR04MB1552.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(31051911155226)(45079756050767)(189930954265078)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:VI1PR04MB1552;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1552;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(13464003)(26005)(68736007)(71200400001)(256004)(6306002)(86362001)(53936002)(3846002)(14454004)(97736004)(8676002)(55016002)(9686003)(71190400001)(316002)(81166006)(305945005)(54906003)(8936002)(6116002)(6436002)(93886005)(2906002)(229853002)(33656002)(81156014)(102836004)(6916009)(25786009)(66066001)(14444005)(105586002)(6246003)(7416002)(39060400002)(7736002)(4326008)(55236004)(186003)(476003)(6506007)(2900100001)(446003)(5660300001)(45080400002)(53546011)(486006)(11346002)(7696005)(76176011)(478600001)(74316002)(106356001)(99286004)(5250100002)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1552;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wuGc5C6EpFu68vmueB/oHq6MoDTsqxxpcU9UV1lD/iNBkDVYNHEBI1onZ0dzvccyHStEXqSGfCjJmqhg303+3G6xAXZFJNZ3seYG5ys2LjhmGdFTSv5Vx/unVeYj18WqdPKv+91ahihP+JzPSPqQfA+pS/4eTZhaKsrcCVSmc3xnIK9ns8qWxX/f6moHlOhOTVEYOIb9cH301j8RIrx7c44q+wQ9C37cZtenM4dsfyP7x6mY7Hvbgym518HdtpJFY9X7u7XxU5zclcBoYfGx7BjoDUbn7rUAlkHwqGguFnnpL4ksIvEN4MIKL+lsKh/o2MQpWzbJ9m1Nnc+sJmzsp0xgJC52Zs8l6Dt+ZJrvexk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f001ab1-432d-47ac-0e3a-08d629d6071b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 08:47:33.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, October 4, 2018 1:09 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Vignesh R <vigneshr@ti.com>; Marek Vasut <marek.vasut@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; Brian Norris <computersforpeace@gmail.com>;
> Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>; linux-
> mtd@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; juliensu@mxic.com.tw; zhengxunli@mxic.com.tw;
> masonccyang@mxic.com.tw
> Subject: Re: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
> mt35xu512aba
>=20
> +Julien, Zhengxunli and Mason from Macronix
>=20
> Hi Yogesh,
>=20
> On Thu, 4 Oct 2018 06:51:41 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Vignesh,
> >
> > > -----Original Message-----
> > > From: Vignesh R [mailto:vigneshr@ti.com]
> > > Sent: Wednesday, October 3, 2018 10:26 PM
> > > To: Boris Brezillon <boris.brezillon@bootlin.com>; Marek Vasut
> > > <marek.vasut@gmail.com>; Rob Herring <robh+dt@kernel.org>
> > > Cc: Brian Norris <computersforpeace@gmail.com>; Yogesh Narayan Gaur
> > > <yogeshnarayan.gaur@nxp.com>; Linux ARM Mailing List <linux-arm-
> > > kernel@lists.infradead.org>; linux-mtd@lists.infradead.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Vignesh R
> > > <vigneshr@ti.com>
> > > Subject: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
> > > mt35xu512aba
> > >
> > > Micron's mt35xu512aba flash is an Octal flash that has x8 IO lines.
> > > It supports read/write over 8 IO lines simulatenously. Add support
> > > for Octal read mode for Micron mt35xu512aba.
> > > Unfortunately, this flash is only complaint to SFDP JESD216B and
> > > does not seem to support newer JESD216C standard that provides auto
> > > detection of Octal mode capabilities and opcodes. Therefore, this
> > > capability is manually added using new SPI_NOR_OCTAL_READ flag.
> > >
> >
> > Thanks for sending the patch-set of adding octal support.
> > If possible, can you share the MT35x datasheet?
> >
> > I also have the patch ready in which I have added support for Read (1-1=
-8 and
> 1-8-8) protocol and Write (1-1-8 and 1-8-8).
> > Also have added support of Octal in driver/spi/spi.c framework.
> >
> > IMO, we would collaborate our patches.
>=20
> Looks like we are of stepping on each others toes here (see this branch [=
1]). I
> guess it's not a problem if we agree on who is working on what.
>=20
> Yogesh, you already sent "spi: add flags for octal I/O data transfer" [3]=
 which is
> only adding the new OCTAL flags but is not patching spi.c and spi-mem.c t=
o take
> those new flags into account. Here is my version of this patch [2] (it's =
still
> missing an update of SPI_MEM_MAX_BUSWIDTH). Let me know what you want
> to do (rework your version to address the problem or take mine).
>=20
I haven't said that I have sent the patches. My patches are ready and neede=
d to be sent for review.
In these patches,  I am adding support for X-X-X protocol for octal support=
 and integrating them with spi  and flash m25p80 interface.

Would send the patches by today evening for review.

Regards
Yogesh Gaur

> Regarding other patches in [2], they're mainly here to add support for X-=
X-X and
> DTR modes and get the m25p80 logic integrated in spi-nor.c so that we can
> really check which NOR operations are supported by the SPI controller.
>=20
> Regards,
>=20
> Boris
>=20
> [1]https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ith
> ub.com%2Fbbrezillon%2Flinux%2Fcommits%2Fspi-
> nor%2Focto&amp;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C3ad
> 4b6f2a4c9470e98f308d629cc8362%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636742355682081158&amp;sdata=3DvXg7nwZ6dLrUxoNw9t41GYMp
> oPdNWUWhLM6wZPmrIec%3D&amp;reserved=3D0
> [2]https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ith
> ub.com%2Fbbrezillon%2Flinux%2Fcommit%2F9854a8fdd23f64e79859fd07a71d4
> a1c57b812f2&amp;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C3ad
> 4b6f2a4c9470e98f308d629cc8362%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636742355682081158&amp;sdata=3DyEZqGYprHS8q2wuisFLpHg8bMj
> uuWDrl3ggWlA8LRoc%3D&amp;reserved=3D0
> [3]https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
at
> chwork.ozlabs.org%2Fpatch%2F894916%2F&amp;data=3D02%7C01%7Cyogeshnar
> ayan.gaur%40nxp.com%7C3ad4b6f2a4c9470e98f308d629cc8362%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636742355682081158&amp;sdata=3Dt
> 5DFvXgDOlyLn7pMieue9BB5q24DNiJMywGvNrWAYOo%3D&amp;reserved=3D0
