Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8703C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BBF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uAcM3t2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfAOJyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:54:33 -0500
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:31392
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfAOJyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP+KXB8zFOK4sZCBhjaGxvjFEMvzCWPT2GLhGFe3WIw=;
 b=uAcM3t2tkIOcaA3XPtykt1hfhHQSO8a40VhfP4tmEnLrbP/6heZzUMnCFy930MHQbXpJxViTywmi1F+yvs+ebYOrQ1gEV3DmxSxGEZmnaixDNQBj6Ho0SBT9h/+OIsBZDoEpaNQ15slbDk1aQrEKlWSJc1ltYCE9ixyFcv1q80E=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5056.eurprd04.prod.outlook.com (20.177.50.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 09:54:27 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:54:27 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP8UrlUpBv3BkeiEjKwk1C7CKWotMOAgAXFxoCAAabw8A==
Date:   Tue, 15 Jan 2019 09:54:27 +0000
Message-ID: <VI1PR04MB572615130C849F1B8A807F9A99810@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1546939346-20181-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <dbb6ddc8-5939-3d4b-7031-931afa79fccb@kontron.de>
 <20190114093759.2ce51b55@bbrezillon>
In-Reply-To: <20190114093759.2ce51b55@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5056;6:Vq0W4xaAIk5RE30Huoeg/bLOGZSsoRig0hmvPL3N+Q0NsfDxnISDCzvcvmz1xjvx9PSu7vLojweprYnGzl9lj+X1NKA+dgo4nUyMPTbFxYU7FIf4WSGDL3R8TGfDKzbCwWQbKa6jvWY9HV4xNGNyjTzFR8lNoThvP6HsU+mfLxsd3KMs3Yu7l6Ej1MwOfIgBVGBPoRsAyM77othdduZYqA+lJktDepQgjok710DZPSVAbeu8KydJWpz6vKOXYupAkjuYQIAk9BHZoc/rKIkDjM19lrwv/TvM+C1B0pk6E7NCXG2Qr1oGWW3UfnaQ/VLobkL3GMIleDF8fUgamcO81MwDQCz+YqzgTy6U3IkDxWFkULnM8XZEwQd/CnG0C5kXBSmUKkgg15QYcnqE6PoneaE/ATxW/qXsiaFqMrlHQQBI/UPchUqi7OpKZoYNtHFrFD40Z525TyOvUmMMc/wY/Q==;5:4giVufR2niPvpzS2DeOKBm5qx/cxiPc3o9Tc/1VN4om9ZFYpOjBc5n+PpUmE1xwHqZs+LVsYbewsgK+1iNKjOPTCeypmmnMv1Dj2GRlt/O1DfK7xoydqKwsuNJQBcKLozO/D6xYO1jh5w5Pph+S2XdfJ3KYjjXWPf02k6Dm/44PaGs4ZfDwOPDuuT5Pjrk16qperLG9CqZdEXfWW+l9erg==;7:brrLqcTEvdrZJUBNqg915CzWFLn8ty8noezqtDZ6SpE7cbtFxBtjsDE9+Y8EFzd4pWM6rmty9OUBseDakao+4tjSblShsqMUsQEtGEzeJQdKVYSl7HcGet5h1HjR2cnvDjNZZe3tXzHX1gsa27It9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7b79fdd6-bf0d-42b1-ea78-08d67acf6fed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5056;
x-ms-traffictypediagnostic: VI1PR04MB5056:
x-microsoft-antispam-prvs: <VI1PR04MB5056CFDEC63E0F24FF24110599810@VI1PR04MB5056.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(13464003)(199004)(189003)(97736004)(966005)(25786009)(9686003)(4326008)(68736007)(6436002)(14454004)(478600001)(71190400001)(71200400001)(74316002)(93886005)(7416002)(86362001)(6246003)(53936002)(39060400002)(66066001)(81166006)(81156014)(8936002)(5660300001)(8676002)(6306002)(316002)(110136005)(105586002)(106356001)(33656002)(11346002)(446003)(6116002)(3846002)(55016002)(2906002)(53546011)(54906003)(256004)(229853002)(102836004)(6506007)(76176011)(486006)(476003)(99286004)(186003)(26005)(305945005)(7696005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5056;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +uvs3k99yw5+733l5Qb3kbgnZ4EWkY7mHbrBuA8zCyzUidmThqhA/zwH9vCjhBjRMCoxjxKRsirRGhxEzP4Upti5A0k/vjxEj0cxitaMAC5yf0gVaR0pQI13X1wDkZ8kMzNNj4/phkUEVkd/f4JAmlglWpJ0C8Dd7KLQLJBa9plWNBCjWzfd42bbc4NJMF0FvWI/f8yb2DZZ5SwV9RCBgjFPB+fjXrhJZH/b8BCV0XIgVPJWbBHBUaREJD3oIcosO6/rDB+D2Al6/kUtu77APalpRds0uG1oB9CNDGmFLJHm2YLXPSwW5ycbLc6iA0lOoE46RFgHEtvFwNqGmBKco3J2ehNLXn3uq9o0F09ysnH0u7Yy+0N3hYhyy+9a5/ZPv3rc1qOXFOGiiO2mfF+h2uSYcvdK3SAYsqMmjhSbX1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b79fdd6-bf0d-42b1-ea78-08d67acf6fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:54:27.2779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:bbrezillon@kernel.org]
> Sent: Monday, January 14, 2019 2:08 PM
> To: Schrempf Frieder <frieder.schrempf@kontron.de>
> Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; marek.vasut@gmail.c=
om;
> broonie@kernel.org; linux-spi@vger.kernel.org; devicetree@vger.kernel.org=
;
> mark.rutland@arm.com; robh@kernel.org; linux-kernel@vger.kernel.org;
> computersforpeace@gmail.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI cont=
roller
>=20
> On Thu, 10 Jan 2019 17:28:57 +0000
> Schrempf Frieder <frieder.schrempf@kontron.de> wrote:
>=20
> > Hi Yogesh,
> >
> > my comments below are mainly about things I already mentioned in my
> > review for v5 and about removing or simplifying some unnecessary or
> > complex code.
> >
[...]
> >
>=20
> Once you've addressed all of Frieder's comments you can add
>=20
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
>=20
Thanks.
I have send next version, v7, of the patch series having added code changes=
 as per Frieder's comments. [1]
Based on the feedback from Frieder, would add yours r-o-b tag.

--
Regards
Yogesh Gaur
[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D86130

> Regards,
>=20
> Boris
