Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178F21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GlXwMvNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7178F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDQRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:17:23 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:10592
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbeJDQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GtqnmCbsc5N5PuqvcbHgROarw+YTDrBIEZ9SfaxC4Q=;
 b=GlXwMvNRDW632UvrTWIpy73hYIW71u8V1/KuAZueD5Hs2NXOJY0Kr3YYKSOlT3vcp0gGSrsQs07V4xIYnd3j81w7i5sDdAG+Yo/92ndbqy4RW0/cfgntJLRQgUGbzOOZja7HeLWT9VWw0GqiiGP9Uk2xIbJkwhPFrGXvbY9F1ac=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (20.177.48.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Thu, 4 Oct 2018 09:24:57 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 09:24:57 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUW79YZxhjkV/EkkiB5uA/7QV9n6UOzuUAgAABlJA=
Date:   Thu, 4 Oct 2018 09:24:57 +0000
Message-ID: <VI1PR04MB1038ECE25B571117405A617799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181004111822.48ab1f5c@bbrezillon>
In-Reply-To: <20181004111822.48ab1f5c@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4798;6:fvlrKpNnm+fl4EpqVXiyHZBcuyWQdSJdLogCrTjBYcrsXoybpsehVZQ9sF8PWFfsqsGtVkTB8rw+hgunE8e1JMvuvSPj48sy50sfcpnnjfqGYxkduwNcyRA4jVvEzel4ZVFjW7fry4nvoE/XlKi/ZuJK0RGAaWRANY+tA7wIQDtMzrotJ6j1n3VfQaVsfsrZn1KcpRt82HuXVuDHJwBZM0kLxosghevVH0sgpWQHNPDouQZ9+6thmv3CTvF3O0WqMTWN1RglVuF848BBrxwMk/jNKyiEZzzXNGfMUS8akDIyjlJtwL0+GLAHnxjMFRtn9qskfSE8mmee8bclCyAXl9ut2tjkpAGhyH8ap8YlSMhcE+QGdYxrortDzclP+gRT5N9ygE4yc5eh/biNLOjoBTyvYwb6aOMa9tOHWpCxm+Q3UgT6NZAOXAkACE1qYLd5g7SCwcS9ZDQ2xtE02KComg==;5:ejjrsjaIy/8j6vWojaD8MkCmoUxTlQdpPTwvpZxGg9yk4zsB+kIEp91iVh04gKDTzj5crQYjXTHND4OuveQbyjU+qLc1UVSqruAwjkUB+zFgHma7kBQVaqONwmOUQCpi7iKi9umexFpQuSAnbVMzeiQtfIZqM/txAIWFvEVjA6c=;7:jCn0h7Vqc7EpqokwUhhLBANxgXwbYcQZUVwuRUHklRy5FuC9qBcq2doTIhypF0C7FrhCjC3zFcYhvgy2Y6WJcuOFSLDV/SBCDFmMiF5CfEbOPqEPnCdKdPT9GmX7zxtBylEF3wprj+GC0Po5Gk6ifwCCE7YaySDdvmi9e53VTOH4plM48o6NufxBt66Xk58vFn9pB6XMJkI0d/JqW1hZ3QzpFxqgQBwKL29a1ppqiq1mU8PnpMGUtv4Tj3Y4+u63
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8a877293-740f-4dd6-c2a3-08d629db4049
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
x-ms-traffictypediagnostic: VI1PR04MB4798:
x-microsoft-antispam-prvs: <VI1PR04MB4798FF6D5BCB2C1441F209F899EA0@VI1PR04MB4798.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(31051911155226)(9452136761055)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(13464003)(199004)(6246003)(15650500001)(476003)(11346002)(486006)(5250100002)(6916009)(86362001)(39060400002)(5660300001)(478600001)(53936002)(446003)(66066001)(256004)(14444005)(99286004)(25786009)(7696005)(229853002)(6436002)(55016002)(6506007)(9686003)(53546011)(76176011)(14454004)(8676002)(54906003)(26005)(2906002)(4326008)(3846002)(2900100001)(6116002)(186003)(33656002)(74316002)(71200400001)(71190400001)(68736007)(97736004)(81166006)(305945005)(7416002)(81156014)(102836004)(8936002)(7736002)(106356001)(105586002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SqD6rQ+z58Yinsvkzu8yhwMZ3B3HXywtda8EziS+kNHWK3YLIG/tqSSTlxFQdliqE+EaBVtiXOCSmQ4qLF6cWcQbXUmD/ijFMWDHOpTOKCJmdjfDdjFEpxJwKHMvF/lmZb2lFG73Q9x1ErUsC1w6do/55DtU8rjArbfx+9wPrW74vNzKjFZNOxKnlLoC47eSQf0pUTXRMCkckuUyG7Yo6J1Brvio5A1EqGXIY3ZLwXXwEQCo4qhJxTzMyy2If9gscs5rukJu1zvAVtJchT0GO74jfXQHuSEi2HbCOmf53CF+BwYki1VoLAqsgi+GO/w1IcP09ehFL/urOelPNMCvQhRvocZIET9SIiZPyOklRuE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a877293-740f-4dd6-c2a3-08d629db4049
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:24:57.1250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, October 4, 2018 2:48 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
>=20
> On Thu,  4 Oct 2018 14:18:40 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Flash mt35xu512aba connected to FlexSPI controller supports
> > 1-1-8 protocol.
> > Added flag spi-rx-bus-width and spi-tx-bus-width with values as
> > 8 and 1 respectively for both flashes connected at CS0 and CS1.
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > index 901ca346..817175a 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -42,6 +42,8 @@
> >  		m25p,fast-read;
> >  		spi-max-frequency =3D <20000000>;
> >  		reg =3D <0>;
> > +		spi-rx-bus-width =3D <8>;
> > +		spi-tx-bus-width =3D <1>;
>=20
> Why 1? The flash is already flagged with SPI_NOR_OCTAL_READ, which means
> only the read path will use 1-1-8 mode, so you can safely set spi-tx-bus-=
width
> here and let the framework choose the appropriate mode based on the flash
> capabilities.

Ok.

>=20
> >  	};
> >
> >  	mt35xu512aba1: flash@1 {
> > @@ -51,6 +53,8 @@
> >  		m25p,fast-read;
> >  		spi-max-frequency =3D <20000000>;
> >  		reg =3D <1>;
> > +		spi-rx-bus-width =3D <8>;
> > +		spi-tx-bus-width =3D <1>;
> >  	};
> >  };
> >

