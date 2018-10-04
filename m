Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9660C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4892D21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rHCBNuwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4892D21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeJDQHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:07:01 -0400
Received: from mail-ve1eur01on0060.outbound.protection.outlook.com ([104.47.1.60]:11200
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeJDQHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aH+pmEA9IAxsHj8F/BXbudeQyl66JxJXD1cY/FEB/U=;
 b=rHCBNuwBb2cvL2JuYx7cWHyGvX0rqMKCKjuFVrXC/ybDAHZ63RS8TkNfSOv6C+boDhm5J30TnZVKDU+8DHj1H0eRo2OrQq8/T/L7Lkv0DOXCRHBXU9scQfX1xoYIzliNOCdAxA6nk8XBt45ycHTjiGjTnCv9TB+My3r8erpEvs4=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB2125.eurprd04.prod.outlook.com (10.166.43.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 09:14:36 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 09:14:36 +0000
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
Thread-Index: AQHUW79Pt2f0aPifqU6iS7lMxP3ev6UOyxkAgAAA6rA=
Date:   Thu, 4 Oct 2018 09:14:36 +0000
Message-ID: <VI1PR04MB10380FD9CE99E34BA27E55B699EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181004110446.5e1bb255@bbrezillon>
In-Reply-To: <20181004110446.5e1bb255@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB2125;6:tlvUruqV6GqrX+yjHI2Kv7i4rM+T2aTCTQiBNTtMdyKFCVi0z8N3FOMfRHQiXqPGuRPIk+sJJU7fnDXlsj2erODIIrkWOF8OgpjOkAlVtZu5aQoyaJ+pxD08hDJQLKBzaxODgZLzVl68USmPkg33mesrv8y0VVLUg6h0H6FHPy7vk0tcum920yVxE0qsf9XNX37l7JKQBV8aQuHpFU9SBkMEFW1boH7C5SdNFDBS0ZF9if5a8k4svnT3MMW02SfMdC6zqBW2IiE6EQa0iRDv80kye0KqHd0ceaaBGfreTjTf477+pFsfN56yF3toAQ9rySKktU+Q96E9S15dfGiQ6oNpDEdl2JByKVqWyI0DoEi8+Xm+rz+XGOENScSuDQGyGkGc64zbISiehQjXKgNWLXkU4xxiZhl6uMpCJsjFGctc6v6A1MxgYcdaKdIiwH3KgcR5cKFLzh00uvQn+Syd9w==;5:V+AIyS+GrpHXsfj2ENzjiLe12UNsz9BseocipbLC7oeIkHjIk3ykfzrN/Wt0jO9/ExL6w/AoyTxptzCFGXV9dHpdpsGo4V1twKnJHKJpSOIpbcapQdjXEbcnIZv72g5IBLHA1Wwd/s2V3YkpjuvR41rUsAfbl2GykO6/8pbAa7c=;7:K6tzHJGxk1TY/laTuyT56aZLIHwVjOzguqIFjs7WonJ2pI4IAFABDTi92GXVHPz43Ew7V3ot4fxEwaw1YO/TRazlD6L9vw+ueYA9tCdcyCYBQyhv/A6LSar0khcLTEUtiLFxyxAzwht0OSe28mGZKqpIFWQeeQrzYJcHom55ArC49MN0FOF7iviODd+rXYwrJQTh7J9T7LTSSEB4IFqsnmpjeGIduhhOBRaBsjySd+Ss6QFNtx53fH0EOTOdBAn1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fc0bcfa4-1f43-40df-8e15-08d629d9ce50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2125;
x-ms-traffictypediagnostic: VI1PR04MB2125:
x-microsoft-antispam-prvs: <VI1PR04MB21259E7D3EB555CBBCE1C70A99EA0@VI1PR04MB2125.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(31051911155226)(9452136761055)(180628864354917)(20558992708506)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB2125;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB2125;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(13464003)(189003)(199004)(5660300001)(2906002)(53936002)(229853002)(6116002)(3846002)(6436002)(186003)(33656002)(4326008)(39060400002)(25786009)(55236004)(102836004)(6246003)(26005)(6506007)(53546011)(7696005)(76176011)(71190400001)(71200400001)(6916009)(316002)(7416002)(2900100001)(54906003)(5250100002)(81166006)(8676002)(81156014)(97736004)(446003)(68736007)(8936002)(106356001)(14454004)(105586002)(9686003)(476003)(86362001)(486006)(11346002)(74316002)(305945005)(575784001)(7736002)(256004)(66066001)(14444005)(55016002)(478600001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2125;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ViUZJAurMGMv8mte/zRanAIKF9C+InvLY0xRtgCadVSeDmnQ7v4TPnKdKMgtqeXyQrSaapMkyfpF8bw8Pxhrd/LfDR0JDFIaKj1JsNCzHxmWqSeBs82I7WnAmGo+ad2dO+I6VZ8qOr4dS5T3sTBCRTlQxt2IW6PQ19DCfAzD6Zw0PIQzrXU7PTF2DypPDtZ9utvU+1H41T19478f71f/LmCyoUG16Lt+rQ3JL5d1/i7EfvTVy9OXdiyb6iLjipw2zVLZd3/ja932UGpXNqMSKg8MMnLKswq2427UBLCMqSrr7+xX/+A4FBHNzlLXWJl62L6pspB0AZq+yyw1kWP2sWjnz4Xenq3VKB7kF9I48Ts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0bcfa4-1f43-40df-8e15-08d629d9ce50
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:14:36.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, October 4, 2018 2:35 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
>=20
> Hi Yogesh,
>=20
> On Thu,  4 Oct 2018 14:18:37 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Add flags for Octal I/O data transfer
> > Required for the SPI controller which can do the data transfer (TX/RX)
> > on 8 data lines e.g. NXP FlexSPI controller.
> >  SPI_TX_OCTAL: transmit with 8 wires
> >  SPI_RX_OCTAL: receive with 8 wires
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> >  drivers/spi/spi.c       | 6 ++++++
> >  include/linux/spi/spi.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > ec395a6..80f672f 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1573,6 +1573,9 @@ static int of_spi_parse_dt(struct spi_controller =
*ctlr,
> struct spi_device *spi,
> >  		case 4:
> >  			spi->mode |=3D SPI_TX_QUAD;
> >  			break;
> > +		case 8:
> > +			spi->mode |=3D SPI_TX_OCTAL;
> > +			break;
> >  		default:
> >  			dev_warn(&ctlr->dev,
> >  				"spi-tx-bus-width %d not supported\n", @@ -
> 1591,6 +1594,9 @@
> > static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_devi=
ce *spi,
> >  		case 4:
> >  			spi->mode |=3D SPI_RX_QUAD;
> >  			break;
> > +		case 8:
> > +			spi->mode |=3D SPI_RX_OCTAL;
> > +			break;
> >  		default:
> >  			dev_warn(&ctlr->dev,
> >  				"spi-rx-bus-width %d not supported\n", diff --
> git
> > a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
> > a64235e..2d21307 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -163,6 +163,8 @@ struct spi_device {
> >  #define	SPI_TX_QUAD	0x200			/* transmit with 4
> wires */
> >  #define	SPI_RX_DUAL	0x400			/* receive with 2 wires
> */
> >  #define	SPI_RX_QUAD	0x800			/* receive with 4 wires
> */
> > +#define	SPI_TX_OCTAL	0x1000			/* transmit with 8
> wires */
> > +#define	SPI_RX_OCTAL	0x2000			/* receive with 8 wires
> */
> >  	int			irq;
> >  	void			*controller_state;
> >  	void			*controller_data;
>=20
> You're still not updating spi-mem.c to check those flags and
> SPI_MEM_MAX_BUSWIDTH is not updated to match the new limit (8 instead of
> 4).
>=20
Yes and its strange that my octal mode communication is working fine withou=
t adding support in spi-mem.c and that's why this has been missed from me.
For this patch series, have done data read/write verification using MTD_DEB=
UG and JFFS2 mount utility and none of them reports data read error.
Would add octal mode related changes in this file too.

--
Regards
Yogesh Gaur.

> Regards,
>=20
> Boris
