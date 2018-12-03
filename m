Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775E220851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i5z9VoEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775E220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeLCIr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:47:57 -0500
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:62197
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeLCIr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef+obMHy8lfjIairvvkzFPraABOKiDLuFibnxEmgQMY=;
 b=i5z9VoEmvoxrqzOVAtLGHijIQqxo+WsLYywSpB1y2unMfmFpW7Eos+15Khuv/oB8WGj5Y5qhNstwCnDQ7DMiK53h1aHo9gizKITgsZPOLrUJkfYtAJ7iJyDMWNugAUiSbmoZkg/ndrqxjlp50f8VEkFHUtyW2ogiuVGAI87bqa4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5536.eurprd04.prod.outlook.com (20.178.122.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 08:47:48 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:47:48 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>
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
Subject: RE: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Thread-Topic: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Thread-Index: AQHUgiJAcEpOMRHFo0C5hsFrjEN72KVsuW4AgAALwwA=
Date:   Mon, 3 Dec 2018 08:47:48 +0000
Message-ID: <VI1PR04MB5726A8B992BF7DE2A646D20C99AE0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1542863544-21257-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203090444.0c37efa7@bbrezillon>
In-Reply-To: <20181203090444.0c37efa7@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5536;6:1HZvw3gFltk3ksX4//qJ+msXsTq+2xcrCOW1vrKpxBmQp+XRCxQ3TO+7uoRiXzbfFMqMNC3IESfWPsBV8NOo58op92VQcHenLL+DEXfIufqo/vZQhADBolsAPh7AoH+mSVun6GfECf0D6JO8scrUyxw0eB5G9y71HVxNoK2wInNYSwivdeoicDsg9maJp7b7FvsHkzq5FUqu3cWtiVRvVveJkNekoMSalzyPKi0EpfOFdBIl/Uq2gerDxDMgjSlpZo7fXgZkjWbuUYRM+UfARrvH7k3cWYJAO9K+RCSjbditrctQTh7bNPc6civxSYnJGIM7JA1vj18Q1rD4Fi+ZPZL5kFGKVW/0nTaRRK+Ef9/FLS0e9rVJy4UGOVsxRAvrFWmLrHSnsXEAtbm2kkME0Yfyf4XdlGu5NBzTa1/FVHNelOArKjwD0XrdlGtkK0g4hY5F0dDT/aJXmjisHUj9Yg==;5:sU0OXZeUwj7Ghp/tAxWkkshp+esq8ZJn6+JOjCvgzPkdNUpYuotd0twAi3jpmab5BVY/5GhSLkmxeGNBJOrTzckcntz+plx0pVXx7f9FnbvYVAspX+/ctb45miNTPH6EZs5veEGMJQKOAz5GQb37txXkeoeCbW+KwXl7Gfs0lN8=;7:L4L8DMf12Q1/Z6QHPlYHo01+/eZNwhlWpCV3Ujkvt4Ov8dxHwaYGBcJ5xQ4DxGs88ro0QHnqTfMHUfa9ZFe3j6FcGmPff27J4hclI64RlcdOn5djC0Q6eiG00FTNxSaJiZjegthKJFuV9YdvCqc2KQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 38527abc-ebf8-44e1-5723-08d658fc00b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5536;
x-ms-traffictypediagnostic: VI1PR04MB5536:
x-microsoft-antispam-prvs: <VI1PR04MB5536CE0D4C1660FD15E42F2299AE0@VI1PR04MB5536.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5536;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5536;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(13464003)(74316002)(6306002)(110136005)(186003)(5660300001)(54906003)(7736002)(66066001)(305945005)(105586002)(86362001)(55016002)(106356001)(2501003)(26005)(316002)(53936002)(8676002)(68736007)(99286004)(71200400001)(71190400001)(966005)(2906002)(39060400002)(478600001)(33656002)(97736004)(78486014)(7696005)(6436002)(8936002)(7416002)(81166006)(6116002)(3846002)(476003)(6506007)(14454004)(53546011)(256004)(446003)(11346002)(55236004)(486006)(4326008)(6246003)(25786009)(102836004)(76176011)(9686003)(229853002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5536;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QSklY+OSeAbfa8Z/xTKwJC4JvFhrz9vN2W0ABMJrkCLsErc0/8pdGvA4A5NisdX69NFdL+TOaN3YB54zvJcGtFclsaypVlcRZGh7fS3VU6hjIQqguU5QHjDWZ1SC5mi2rwqOvxhynQtBUJVqJwInSm/qs1x7Oam80tOuOoMO5q7mWTHviGN2wm5m8PTCrzaI6TDGNvRhqsxmSjq4+nAc3J6q0SfKcgykCYTx1+3y+WSKyFmcqMk11zlCks0zAKBVKhrAY9tb/TmEl45Y+B00WvZpawn0tZt+JYe9JMvr8njSS5sLb+AXRIiktQ8Vw/f893D3Rmc6DPPPYBlOznrzn94FJsbEr0s43J65vjjX08s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38527abc-ebf8-44e1-5723-08d658fc00b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:47:48.5697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 3, 2018 1:35 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> broonie@kernel.org
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 1/7] spi: add support for octo mode I/O data trans=
fer
>=20
> Hi Yogesh,
>=20
> On Thu, 22 Nov 2018 05:14:31 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Add flags for Octo mode I/O data transfer Required for the SPI
> > controller which can do the data transfer (TX/RX) on 8 data lines e.g.
> > NXP FlexSPI controller.
> >  SPI_TX_OCTO: transmit with 8 wires
> >  SPI_RX_OCTO: receive with 8 wires
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> > Changes for v4:
> > - Rebase on top of v4.20-rc2
> > Changes for v3:
> > - Modified string 'octal' with 'octo'.
>=20
> When I listed the differences between your version and mine, I mentioned =
the
> OCTO vs OCTAL name, but I didn't say my decision was the correct one :-).=
 Looks
> like OCTAL is the term employed almost everywhere, and it's also consiste=
nt
> with DUAL. Would you mind sending a new version reverting the name to OCT=
AL.
>=20
Next version of patch series send [1]

--
Regards,
Yogesh Gaur
[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D79338

[...]
