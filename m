Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF0DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1757020841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E8Z5UttA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1757020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJHSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:33:03 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:12690
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbeJHSdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7JNq6t4jYvSHTxpWsAGlAc1jjeVkPei0EI7mpTo+W8=;
 b=E8Z5UttAsma6/kJRvi3LUeBtlQppDCqs0R31PdTZ9CtBmhD2d1cNyXFW9EekDDlkqViLdhtkq8aWEBFG7GW9Om0D9NhQItRX7nFMkaxPVA6HS+GeYKI7OjSRp0LVg9jEjwyatvLdupM7bEMdevz9ejEV3iq7RkQkx0fJa9RfJU0=
Received: from AM2PR04MB1027.eurprd04.prod.outlook.com (10.162.36.13) by
 AM2PR04MB1058.eurprd04.prod.outlook.com (10.162.36.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 11:21:24 +0000
Received: from AM2PR04MB1027.eurprd04.prod.outlook.com
 ([fe80::8c6d:eff3:8a7f:c75e]) by AM2PR04MB1027.eurprd04.prod.outlook.com
 ([fe80::8c6d:eff3:8a7f:c75e%7]) with mapi id 15.20.1207.021; Mon, 8 Oct 2018
 11:21:14 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
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
Subject: RE: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUUZU0BGO6lojD7UazPwC06l6oF6UHck2AgA3EK7A=
Date:   Mon, 8 Oct 2018 11:21:13 +0000
Message-ID: <AM2PR04MB1027555CED1534472C6B8A3C99E60@AM2PR04MB1027.eurprd04.prod.outlook.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180929174023.51b1e284@bbrezillon>
In-Reply-To: <20180929174023.51b1e284@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM2PR04MB1058;6:/tV5ltDcIkdCznM2V16tpGSSRf9lV1FPPJ7kOv/IqGYNdxV1vV+04RaB7GQvNcPDWwnsA02Lqilo9A9LQztjTawmNRWPlrlF7VUy/CWRwrH6I2+dxVRk00E00TdFr5y/CCMPDfUJD98wdny3BjNEa4etun6nFiw/xSzljnziJuX4LdM3ltVRxoxjb0xRTOLaAIV2Wn5V3E0fsIqYmJlIXD+IUuii3ToIj06wTDf2ZtoNGCkslIb0O+DqdJgeNVHm+8F/xsUVUBroSodydJybeEV8DgF37//hTZU9abcZnvr9X7G4HufYZ/ydVlKD1ms2YvBsnQ7+9/g/zO5BYuxo1LQ7Viaf3BNGnGHI+1Ysr5T+H+p0d4ceHMQTBY9qDx4sFcskkUD3AS4B7zdtDZmn7rkfnc1Qz79mgQURl8CK7AxD9Jzc6CUWQShYS2nUlfMrtPFvN0c1mCChFKE9+ZHBDg==;5:wVg/DScnD4wA4qHiRUJV/j+2RdbNu3e9pUm862VwaXF+lJ+7c59opaTe/Y4O0XU7WLVrKNnzG9lWr8aksZaVZKqAB5ut89N2iTUU5NJjlNkPu1evMwkpa0Slxg+9vB6fc1NQP901f1ospVABX8agMQq6T9eHJ2xdfMzoU0QTmFM=;7:JqF/7D+cBKg2IFs6L51KfVKngGkl0ZYqLhI01YoYuSTzK5ys7Rhr0FQcava8pHOPG4vt+kG9kNT6IyKZhmny4AGO55bQ656TchmfGtL/El2F0JBjHVz+327WeFpuz7PEnFu7LkNjPsGf5z74qXdslfIW91a+TTpreX1eIEpZT7z00vpHhwHkinPEWo3+dMVva68YUxL48Y6KXP505tdN5ZzU42FcmegUQjUHJfwaHgxh1930upZMq6QE3bPkS1fg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5d824053-4771-4176-eb8e-08d62d10289c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1058;
x-ms-traffictypediagnostic: AM2PR04MB1058:
x-microsoft-antispam-prvs: <AM2PR04MB1058EC2BAD300B6E167FD1D599E60@AM2PR04MB1058.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(9452136761055)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:AM2PR04MB1058;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1058;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(13464003)(476003)(7736002)(3846002)(71190400001)(71200400001)(6116002)(68736007)(316002)(6506007)(6436002)(53546011)(6246003)(76176011)(478600001)(39060400002)(5660300001)(7696005)(446003)(53936002)(5250100002)(11346002)(305945005)(486006)(2906002)(54906003)(74316002)(55236004)(186003)(14444005)(66066001)(81166006)(7416002)(81156014)(105586002)(8676002)(102836004)(229853002)(25786009)(106356001)(6306002)(6916009)(4326008)(256004)(55016002)(9686003)(8936002)(99286004)(26005)(966005)(33656002)(2900100001)(14454004)(97736004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1058;H:AM2PR04MB1027.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l9iUA5XiVyJ9lLe2dvHKfhaspRG74H3HE67k/UxfVJqJARm7opI8t22ncp0biq4xKWVTDahgVpQu8barYg7ic6kkmnyyh5OUct68PKo33mVkv9pbD4eQxfK0AOIsEIbuwIIZj9l3VJ4wRwsIpUPYqPlUd7374G2Z01PLKDqsnYBWBYxeVi7O1wVz/X4yEyz2Cl//gshcKSpMN+xpMM6oSzWx7kCmYJMNlAmCIHaz4Q4Lby2r3ny7+SAWtjmg+b9dhGneo++6ytVxqGDKDJDmeG/v3x4xAw1e+pSXKV1uCGKVtgW8zERIwKAtJaxqHzeCVcjC8PpkJ6BoElDd2QE8Q0mPJlpUuwv3VEZ+s00jKVM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d824053-4771-4176-eb8e-08d62d10289c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 11:21:13.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Saturday, September 29, 2018 9:10 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI cont=
roller
>=20
> Hi Yogesh,
>=20
> On Fri, 21 Sep 2018 15:51:59 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > +/* Registers used by the driver */
> > +#define FSPI_MCR0			0x00
> > +#define FSPI_MCR0_AHB_TIMEOUT_SHIFT	24
> > +#define FSPI_MCR0_AHB_TIMEOUT_MASK	(0xFF <<
> FSPI_MCR0_AHB_TIMEOUT_SHIFT)
> > +#define FSPI_MCR0_IP_TIMEOUT_SHIFT	16
> > +#define FSPI_MCR0_IP_TIMEOUT_MASK	(0xFF <<
> FSPI_MCR0_IP_TIMEOUT_SHIFT)
> > +#define FSPI_MCR0_LEARN_EN_SHIFT	15
> > +#define FSPI_MCR0_LEARN_EN_MASK		(1 <<
> FSPI_MCR0_LEARN_EN_SHIFT)
> > +#define FSPI_MCR0_SCRFRUN_EN_SHIFT	14
> > +#define FSPI_MCR0_SCRFRUN_EN_MASK	(1 <<
> FSPI_MCR0_SCRFRUN_EN_SHIFT)
> > +#define FSPI_MCR0_OCTCOMB_EN_SHIFT	13
> > +#define FSPI_MCR0_OCTCOMB_EN_MASK	(1 <<
> FSPI_MCR0_OCTCOMB_EN_SHIFT)
> > +#define FSPI_MCR0_DOZE_EN_SHIFT		12
> > +#define FSPI_MCR0_DOZE_EN_MASK		(1 <<
> FSPI_MCR0_DOZE_EN_SHIFT)
> > +#define FSPI_MCR0_HSEN_SHIFT		11
> > +#define FSPI_MCR0_HSEN_MASK		(1 << FSPI_MCR0_HSEN_SHIFT)
> > +#define FSPI_MCR0_SERCLKDIV_SHIFT	8
> > +#define FSPI_MCR0_SERCLKDIV_MASK	(7 <<
> FSPI_MCR0_SERCLKDIV_SHIFT)
> > +#define FSPI_MCR0_ATDF_EN_SHIFT		7
> > +#define FSPI_MCR0_ATDF_EN_MASK		(1 <<
> FSPI_MCR0_ATDF_EN_SHIFT)
> > +#define FSPI_MCR0_ARDF_EN_SHIFT		6
> > +#define FSPI_MCR0_ARDF_EN_MASK		(1 <<
> FSPI_MCR0_ARDF_EN_SHIFT)
> > +#define FSPI_MCR0_RXCLKSRC_SHIFT	4
> > +#define FSPI_MCR0_RXCLKSRC_MASK		(3 <<
> FSPI_MCR0_RXCLKSRC_SHIFT)
> > +#define FSPI_MCR0_END_CFG_SHIFT		2
> > +#define FSPI_MCR0_END_CFG_MASK		(3 <<
> FSPI_MCR0_END_CFG_SHIFT)
> > +#define FSPI_MCR0_MDIS_SHIFT		1
> > +#define FSPI_MCR0_MDIS_MASK		(1 << FSPI_MCR0_MDIS_SHIFT)
> > +#define FSPI_MCR0_SWRST_SHIFT		0
> > +#define FSPI_MCR0_SWRST_MASK		(1 <<
> FSPI_MCR0_SWRST_SHIFT)
>=20
> Do we really need all those _SHIFT/_MASK defs? I mean
>=20

Changes done in next version of the patch series, v4 [1].

> #define FSPI_MCR0_SWRST		BIT(0)
>=20
> or
>=20
> #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
> #define FSPI_MCR0_AHB_TIMEOUT_MASK	GENMASK(31, 24)
>=20
> are just fine.
>=20
> > +
> > +enum nxp_fspi_devtype {
> > +	NXP_FSPI_LX2160A,
> > +};
>=20
> I'm pretty sure you don't need this enum if you describe all dev caps in =
the
> nxp_fspi_devtype_data struct.

Done, in v4.

>=20
> > +
> > +struct nxp_fspi_devtype_data {
> > +	enum nxp_fspi_devtype devtype;
> > +	unsigned int rxfifo;
> > +	unsigned int txfifo;
> > +	unsigned int ahb_buf_size;
> > +	unsigned int quirks;
> > +	bool endianness;
>=20
> How about renaming this variable big_endian and dropping the {L,B}_ENDIAN
> macros?
>=20
Done in v4, default make as little_endian to reduce indirect branch checkin=
g.

> > +};
>=20
> [...]
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
> > +};
> > +
> > +static void fspi_writel_be(u32 val, void __iomem *addr) {
> > +	iowrite32be(val, addr);
> > +}
> > +
> > +static void fspi_writel(u32 val, void __iomem *addr) {
> > +	iowrite32(val, addr);
> > +}
> > +
> > +static u32 fspi_readl_be(void __iomem *addr) {
> > +	return ioread32be(addr);
> > +}
> > +
> > +static u32 fspi_readl(void __iomem *addr) {
> > +	return ioread32(addr);
> > +}
>=20
> Hm, I'd recommend dropping the ->read/write() hooks and providing the
> following functions:
>=20
> static void fspi_writel(struct nxp_fspi *f, u32 val, void __iomem *addr) =
{
> 	if (f->big_endian)
> 		iowrite32be(val, addr);
> 	else
> 		iowrite32(val, addr);
> }
>=20
>=20
> static u32 fspi_readl(struct nxp_fspi *f, void __iomem *addr) {
> 	if (f->big_endian)
> 		return ioread32be(addr);
> 	else
> 		return ioread32(addr);
> }
>=20
> > +
> > +static irqreturn_t nxp_fspi_irq_handler(int irq, void *dev_id) {
> > +	struct nxp_fspi *f =3D dev_id;
> > +	u32 reg;
> > +
> > +	/* clear interrupt */
> > +	reg =3D f->read(f->iobase + FSPI_INTR);
> > +	f->write(FSPI_INTR_IPCMDDONE_MASK, f->iobase + FSPI_INTR);
> > +
> > +	if (reg & FSPI_INTR_IPCMDDONE_MASK)
> > +		complete(&f->c);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> [...]
>=20
> > +/*
> > + * If the slave device content being changed by Write/Erase, need to
> > + * invalidate the AHB buffer. This can be achieved by doing the reset
> > + * of controller after setting MCR0[SWRESET] bit.
> > + */
> > +static inline void nxp_fspi_invalid(struct nxp_fspi *f) {
> > +	u32 reg;
> > +
> > +	reg =3D f->read(f->iobase + FSPI_MCR0);
> > +	f->write(reg | FSPI_MCR0_SWRST_MASK, f->iobase + FSPI_MCR0);
> > +
> > +	while (f->read(f->iobase + FSPI_MCR0) & FSPI_MCR0_SWRST_MASK)
> > +		;
>=20
> Did you consider using readl_poll_timeout[_atomic]()?
>=20
> 	if (f->big_endian)
> 		mask =3D (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
> 	else
> 		mask =3D (u32)cpu_to_be32(FSPI_MCR0_SWRST_MASK);
>=20
> 	ret =3D readl_poll_timeout(f->iobase + FSPI_MCR0, reg,
> 				 reg & mask, 0, FSPI_SWRST_TIMEOUT);
> 	WARN_ON(ret);
>=20
> > +}
>=20
Thanks, added readl_poll_timeout() functionality instead of busy looping.

> [...]
>=20
> > +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct
> > +spi_mem_op *op) {
> > +	u32 len =3D op->data.nbytes;
> > +
> > +	/* Read out the data directly from the AHB buffer. */
> > +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);
>=20
> Don't know if it's supported, but if it is, I recommend using DMA to do t=
his copy,
> because otherwise you might stall the CPU for quite a long time if the fl=
ash is
> operating in a low-speed mode, and RT maintainers will complain about tha=
t at
> some point ;-).
>=20
Read using DMA is not supported by the controller in AHB mode, only support=
ed in IP mode.
Have to use memcpy_fromio() calls. Maximum data size can be read in single =
call is 0x800 using AHB read.

--
Regards
Yogesh Gaur.

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D69535

> > +}
> > +
> > +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> > +				 const struct spi_mem_op *op)
> > +{
> > +	void __iomem *base =3D f->iobase;
> > +	int i, j;
> > +	int size, tmp_size, wm_size;
> > +	u32 data =3D 0;
> > +	u32 *txbuf =3D (u32 *) op->data.buf.out;
> > +
> > +	/* clear the TX FIFO. */
> > +	f->write(FSPI_IPTXFCR_CLR_MASK, base + FSPI_IPTXFCR);
> > +
> > +	/* Default value of water mark level is 8 bytes. */
> > +	wm_size =3D 8;
> > +	size =3D op->data.nbytes / wm_size;
> > +	for (i =3D 0; i < size; i++) {
> > +		/* Wait for TXFIFO empty */
> > +		while (!(f->read(base + FSPI_INTR) & FSPI_INTR_IPTXWE_MASK))
> > +			;
>=20
> Use readl_poll_timeout(), or even better, provide an helper
> (fspi_readl_poll_timeout()?) that hides the BE/LE stuff, so that you can =
reuse it
> when this pattern occurs.
>=20
> [...]
>=20
> > +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct
> > +spi_mem_op *op) {
> > +	struct nxp_fspi *f =3D spi_controller_get_devdata(mem->spi->master);
> > +	void __iomem *base =3D f->iobase;
> > +	int err =3D 0;
> > +	unsigned int timeout =3D 1000;
> > +
> > +	mutex_lock(&f->lock);
> > +
> > +	/* wait for the controller being ready */
> > +	do {
> > +		u32 status;
> > +
> > +		status =3D f->read(base + FSPI_STS0);
> > +		if ((status & FSPI_STS0_ARB_IDLE_MASK) &&
> > +		    (status & FSPI_STS0_SEQ_IDLE_MASK))
> > +			break;
> > +		udelay(1);
> > +		dev_dbg(f->dev, "The controller is busy, 0x%x\n", status);
>=20
> Same here.
>=20
> Note that I didn't spend time looking at how the IP works, which explains=
 why I
> focus on tiny details here. Unfortunately, I won't have time to review th=
e driver
> in more details, so I'll leave that to someone else, or let Mark decides =
if he's
> happy enough with the current version.
>=20
> Regards,
>=20
> Boris
