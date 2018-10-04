Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D6DC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2780D20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IvFk34hE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2780D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJDQSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:18:25 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:27088
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbeJDQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQRJQ9FMDY5c5lP+FxLo2oTUHie6Wv3iWUK7NGN7nOw=;
 b=IvFk34hEjv7TP0TwwBuGcPQYUR1vcPjWA/8koxym5pV24a19tkJwMgQg6m/S2Kty76uCEixD6QQDI244woNMw7OMnJRPW3Z9HCkRVec0l0GvZwzWkzXzc9B4AOkk/JgwdW5gJJQZv3Hnv2WFNIhlbOpKggWBmJKog+VxjT4zN/Q=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (20.177.48.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Thu, 4 Oct 2018 09:25:57 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 09:25:56 +0000
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
Subject: RE: [PATCH 1/4] spi: add support for octal I/O data transfer
Thread-Topic: [PATCH 1/4] spi: add support for octal I/O data transfer
Thread-Index: AQHUW79Pt2f0aPifqU6iS7lMxP3ev6UOyxkAgAAA6rCAAANBgIAAAEdg
Date:   Thu, 4 Oct 2018 09:25:56 +0000
Message-ID: <VI1PR04MB1038E23CBFE9CFD5C2ECCD3299EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181004110446.5e1bb255@bbrezillon>
        <VI1PR04MB10380FD9CE99E34BA27E55B699EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181004111941.0da33ec0@bbrezillon>
In-Reply-To: <20181004111941.0da33ec0@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4798;6:BrP050eDgHoUbCqDu0xZ3Nby0CNuLXTVt2A+iLuqylSd8LiarzJVwXi9dQUz30qXeHJNHIYul375BFWJGW8OVHKnGysHpWJQ2EghTXDrT96YCLpA7F7N23GcCkvRJ+ViHxuffOsYOHsre/fXvv/rdqv1vqR/qEO/5mk/RI9sAAJEnFHdErA58B9YRRI8dJ9poAeFakUrZ/A+omZa2UDFufFhQ62ahUlIKe2AryU+/aaqmMoiNdc5vRLk7aU2JnNuTCV2Ang5J/Pa8aI1xLsWGoJdMdSedT2YhiCgimoKhkdWaYW6adJNCBok/A3llWM/GYSJd3Oq6v/rvPeNF2G/rAgLlFHNpd1p0tpe/sS/SfsJjDSkrZ+spzMO3t/gNnFxtxurWwYWViX2nI6SDqoxSFcT8214Km+T4elON2N8q0+dwzu1k4shdBocwZaD3xloccqACL1YWEJR/mgBds146w==;5:8a5Ng/HM0KC8jVpaNuvW0W7odxOTBUFiyR7y8WJm7qBc4RRilGLAUmNcPgH/D0JZiA2UrAKF1soeMFJWCXGzRNbTF0o9Jd6ZsM+39I78DDlvpIJd7DITXWZydHv1MM09z8S0mcUxgvKcyWhicIzasMpYKipCEHxlflrCH3FV3J8=;7:pD2YiLc/JPLXexLvPsYbYwxGPhAFv4B5qHIc25kLGsqDHYt2t0kl8/2LHQyfqtWUPOsQciMg4KGr48NhMr7SITj4LWZ35oeefEzKwyPXgrJAied0ZEjXSS7r/65pawK8znhORHs0QzcZpK1Bssynm/BCPJGVHgisgyrB++WaK0a7qNV3NUEzgFjM/r0fSbbuvpLRRHlGpLieGfpn4cqyjtguiQ92fjahzwJ6TqbiRXWDX0FEDvQiUjV38vQ9uSyu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 05b3a09d-1c84-4e92-bf72-08d629db63d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
x-ms-traffictypediagnostic: VI1PR04MB4798:
x-microsoft-antispam-prvs: <VI1PR04MB479821ED3F3A4237080BB2D999EA0@VI1PR04MB4798.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(31051911155226)(9452136761055)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(13464003)(199004)(6246003)(476003)(11346002)(486006)(5250100002)(6916009)(86362001)(39060400002)(5660300001)(93886005)(478600001)(53936002)(446003)(66066001)(256004)(14444005)(99286004)(25786009)(7696005)(229853002)(6436002)(55016002)(6506007)(9686003)(53546011)(76176011)(14454004)(8676002)(54906003)(26005)(2906002)(4326008)(3846002)(2900100001)(6116002)(186003)(33656002)(74316002)(71200400001)(71190400001)(68736007)(97736004)(81166006)(305945005)(7416002)(81156014)(102836004)(8936002)(7736002)(106356001)(105586002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eXiel9RQt8D0oIZjuCgORYQ9eWOVt2ycyDFkU7OJsZj3lTKn0emytXWM4CEyCLvi9hhcRgyadAuRpUd7hPpELfkmg1Lea5juDf5z8CdLnQQgwem7ruiIf+6NCMdOG9y2IXP+mL2zqyvR1nf40m6sERLynYp6GhHZUOisvU0fn91BwTQ41PSaxtyMr2+W8ywBm+C10Nsq+f7O5JAflJxrHBWoRNIkEsh7ARmkH3xDCydd9zUkWmOyMAMZpBVvfdXH21WV4oM2hG/rTyWLW5RIZgFKQCWBC2kTRqSbqohUtd+bOh6uG8Gge/Jym4AXKIHLXUnQfnAiFN5nbBpYyeFzKhYftf+oAGEtLmrus9aNzqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b3a09d-1c84-4e92-bf72-08d629db63d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:25:56.7823
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
> Sent: Thursday, October 4, 2018 2:50 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
>=20
> On Thu, 4 Oct 2018 09:14:36 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Thursday, October 4, 2018 2:35 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > > linux-kernel@vger.kernel.org Subject: Re: [PATCH 1/4] spi: add
> > > support for octal I/O data transfer
> > >
> > > Hi Yogesh,
> > >
> > > On Thu,  4 Oct 2018 14:18:37 +0530
> > > Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >
> > > > Add flags for Octal I/O data transfer Required for the SPI
> > > > controller which can do the data transfer
> > > > (TX/RX) on 8 data lines e.g. NXP FlexSPI controller.
> > > >  SPI_TX_OCTAL: transmit with 8 wires
> > > >  SPI_RX_OCTAL: receive with 8 wires
> > > >
> > > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > > ---
> > > >  drivers/spi/spi.c       | 6 ++++++
> > > >  include/linux/spi/spi.h | 2 ++
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > > > ec395a6..80f672f 100644
> > > > --- a/drivers/spi/spi.c
> > > > +++ b/drivers/spi/spi.c
> > > > @@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct
> > > > spi_controller *ctlr,
> > > struct spi_device *spi,
> > > >  		case 4:
> > > >  			spi->mode |=3D SPI_TX_QUAD;
> > > >  			break;
> > > > +		case 8:
> > > > +			spi->mode |=3D SPI_TX_OCTAL;
> > > > +			break;
> > > >  		default:
> > > >  			dev_warn(&ctlr->dev,
> > > >  				"spi-tx-bus-width %d not
> > > > supported\n", @@ -
> > > 1591,6 +1594,9 @@
> > > > static int of_spi_parse_dt(struct spi_controller *ctlr, struct
> > > > spi_device *spi, case 4:
> > > >  			spi->mode |=3D SPI_RX_QUAD;
> > > >  			break;
> > > > +		case 8:
> > > > +			spi->mode |=3D SPI_RX_OCTAL;
> > > > +			break;
> > > >  		default:
> > > >  			dev_warn(&ctlr->dev,
> > > >  				"spi-rx-bus-width %d not
> > > > supported\n", diff --
> > > git
> > > > a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
> > > > a64235e..2d21307 100644
> > > > --- a/include/linux/spi/spi.h
> > > > +++ b/include/linux/spi/spi.h
> > > > @@ -163,6 +163,8 @@ struct spi_device {
> > > >  #define	SPI_TX_QUAD
> > > > 0x200			/* transmit with 4
> > > wires */
> > > >  #define	SPI_RX_DUAL
> > > > 0x400			/* receive with 2 wires
> > > */
> > > >  #define	SPI_RX_QUAD
> > > > 0x800			/* receive with 4 wires
> > > */
> > > > +#define	SPI_TX_OCTAL
> > > > 0x1000			/* transmit with 8
> > > wires */
> > > > +#define	SPI_RX_OCTAL
> > > > 0x2000			/* receive with 8 wires
> > > */
> > > >  	int			irq;
> > > >  	void			*controller_state;
> > > >  	void			*controller_data;
> > >
> > > You're still not updating spi-mem.c to check those flags and
> > > SPI_MEM_MAX_BUSWIDTH is not updated to match the new limit (8
> > > instead of 4).
> > >
> > Yes and its strange that my octal mode communication is working fine
> > without adding support in spi-mem.c and that's why this has been
> > missed from me.
>=20
> Are you based on top of spi-next?

Ok, that might be the reason. I have rebased few days back.
Would rebase with current tip and add support in spi-mem interface too.
