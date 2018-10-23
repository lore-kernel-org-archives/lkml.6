Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C1C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4FD20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F6scvhcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4FD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeJWRf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:35:28 -0400
Received: from mail-db5eur01on0080.outbound.protection.outlook.com ([104.47.2.80]:5356
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727602AbeJWRf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9Lt/kO2Lfx86CCoI8sfQBVP1JrKizOFTKeka/1Jygk=;
 b=F6scvhcSAYp7Hnzvzq07TK0nK+QD4fpeYapLGY/MafOB1yFzKhT+zDMVJ23qUomfg1Wz22v7o8bl4J9TJ/7qYyIdfiJ55u6M+yJb8hWFR4cvGrYc1HceSadu/FWm8W6IYG/6onXGTv6MHE+qxZGHdYHcpSF56NB5AFaAiY4u16s=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5342.eurprd04.prod.outlook.com (52.134.123.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:12:53 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:12:52 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Subject: RE: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUaq5Tg/rVBdn7h0WIWDOJEqFt/qUsigcAgAABAhA=
Date:   Tue, 23 Oct 2018 09:12:52 +0000
Message-ID: <VI1PR04MB1038247D1A2B65268F76F8F099F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1540284888-32307-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181023110634.26ff2629@bbrezillon>
In-Reply-To: <20181023110634.26ff2629@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5342;6:MuBOm74ZK2DROBZCG0iIb0YTK+oqdmyWv3UMShV1cy5J+QKsGRot6/OCl46xyIp4wrGQBMZhMReEtJ1vq8kTrwRV6l/YQJvB0LRN5zsBV95NrwX2a05HbHrtZt8lqxvaIDIIkRAdmgUPN8Z6DpqKIZoqg/Ia0xAhPQu4gYKTEdAfqLWU58YpoMt083Bg1cr5bCj58FGK97xRwx5/wg5nYgx8lnyqrIUqg5H7IMkl5x9fqaEUm4KZ0pHnXXA7aiPDZYIU2oERmeJlnGQ11HTgQZ7tuWutEpFmZLDCfJPFErtsl7gqtMSM65pKcrpN1zb0HGXgr1TzqybldstgNgqM0DixT8YCwUk2M/aPU4dqwYd2Cq+y3xhKOC10+31U/pRCCXHKF8AmAe1Q0FJrRPjxefF5IOjYsY8tZ2TS6r6PwObOOTeoetjh2cF2OP0kHs+ymTZkItok2ea+eUlt3dxV3A==;5:ltP2iGtEnAbzMR5If0vk+NHiF2GlPNmMaJmtxW+g+AP1ofceCY9Tvxozx8RcxckjMEzaHc0XPydTK1kBxr7/9oeiXnO51jxjeou0M4I4FK26v9YS4GnjOlvt7b0NJis0oJowf4GAJ22NrS73a6wz1q/tAAt9ybFcoqAOyosu7H0=;7:B/10VpwYGCFmkXcAwBGa6hPu1Q+QPEgeVaHDzmECNyQQwAgjRs5LU1tjRJunn2K3zuJFS61VcFhtQgFB9By0fHlYZwqQgWmIKdYcR6YL/zzCr0Wtx0+Mgh94zZzjS/2vqv9tyveq9dS+CeKZ5AYADRUgPjfzQH+lbmReFGiVALNISomYEWBcfCtszo0MfxF8oqi0KyfyEl9hSyh2fIds1usrzCRjq4+RIDC6QJMWjq8KhlRsZIca7I4BLoy8DjdG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 10da913b-4fcb-4a47-28b9-08d638c7b666
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5342;
x-ms-traffictypediagnostic: VI1PR04MB5342:
x-microsoft-antispam-prvs: <VI1PR04MB5342E031BD241312DF68F47499F50@VI1PR04MB5342.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(9452136761055)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5342;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(13464003)(55236004)(5660300001)(6506007)(76176011)(102836004)(74316002)(53546011)(476003)(478600001)(4326008)(5250100002)(7696005)(6916009)(217873002)(316002)(97736004)(186003)(2900100001)(305945005)(54906003)(26005)(14444005)(256004)(446003)(11346002)(14454004)(99286004)(486006)(55016002)(33656002)(9686003)(2906002)(39060400002)(86362001)(78486010)(229853002)(53936002)(6436002)(71190400001)(105586002)(81166006)(7736002)(68736007)(25786009)(106356001)(6246003)(8936002)(81156014)(8676002)(3846002)(71200400001)(7416002)(6116002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5342;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J4xUUTUYJBdhcJ8mKugj0U+9mCeOlJR6sZixLCGs+B/he4iNWe7KSuXyasoAwP/URIo8ts2hKc8ocYtni8uQjXprihfXlUCpxDQ+f7JMuD1lTR6pzydIfRM0b/vRT128VuE5/AeUAdZCj0NkNEZ9du8GeFCNoSBfrZMXzFJtWhgfkOTVqdeQ/gjlz9GTCSbTSYPQmQj5fUGWclVg/iayhEsXGIDi0mxTMqQ3b8DKFxURkXS1YwAzl72JlIq8d881ISFeEXBmJPz8KK9LJM/XqjcSS3gQ3J4MHvVLsH/KrZEunb5JeA3QS5n40kDeSQtaktawgNJS2E8GFeF5O8peDFLh9qtxNGAAKmWOPOWFPkM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10da913b-4fcb-4a47-28b9-08d638c7b666
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:12:52.8208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 23, 2018 2:37 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> broonie@kernel.org; linux-spi@vger.kernel.org; devicetree@vger.kernel.org=
;
> robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH RESEND v4 1/5] spi: spi-mem: Add driver for NXP FlexS=
PI
> controller
>=20
> On Tue, 23 Oct 2018 08:56:46 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > +struct nxp_fspi {
> > +	void __iomem *iobase;
> > +	void __iomem *ahb_addr;
> > +	u32 memmap_phy;
> > +	u32 memmap_phy_size;
> > +	struct clk *clk, *clk_en;
> > +	struct device *dev;
> > +	struct completion c;
> > +	const struct nxp_fspi_devtype_data *devtype_data;
> > +	struct mutex lock;
> > +	struct pm_qos_request pm_qos_req;
> > +	int selected;
> > +	void (*write)(u32 val, void __iomem *addr);
> > +	u32 (*read)(void __iomem *addr);
>=20
> I think I already commented on this aspect, and I keep thinking having a =
function
> pointer is overkill here.
> Just declare 2 functions and do the f->devtype_data->little_endian check =
in
> there:
>=20
> static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr) {
> 	if (f->devtype_data->little_endian)
> 		return ioread32(addr);
>=20
> 	return ioread32be(addr);
> }
>=20
> static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem *addr) =
{
> 	if (f->devtype_data->little_endian)
> 		iowrite32(val, addr);
>=20
> 	iowrite32be(val, addr);
> }

This, I have kept same as being done in spi-fsl-qspi.c driver file as Fried=
er have got the comment to remove the condition in read/write path and he h=
as introduced these hooks there.

Would remove in next version. Please review other changes and complete driv=
er file.

--
Regards
Yogesh Gaur
