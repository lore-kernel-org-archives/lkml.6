Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43101C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99472133D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="y3gs1nIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99472133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeKIW72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:59:28 -0500
Received: from mail-eopbgr710061.outbound.protection.outlook.com ([40.107.71.61]:20893
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeKIW72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1nc1et1gT5y6onR9LGYT6NnjfwRqucKFu2obPq07Js=;
 b=y3gs1nITzD6Qeq26ryXRpGa/cSUc2GEtXcxjbvqXpxf3TO/SPXsk+IH3/faoikbG4yPBiMkEIjszNokFJYmeJ16p2OzZitXKOLArZCtIq1KOp326ZoSPzfC5Ik9r/16INi0NWeEQZyjvC3q5FapS2aO1avbtFw7nHcAjyGX8Q4k=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2784.namprd02.prod.outlook.com (10.175.49.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 13:18:43 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c%6]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 13:18:42 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VHFraAgABM8YA=
Date:   Fri, 9 Nov 2018 13:18:42 +0000
Message-ID: <MWHPR02MB262374134ED95C0DF68BA8F9AFC60@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20181109090733.41ef6edf@bbrezillon>
In-Reply-To: <20181109090733.41ef6edf@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2784;6:KSTPzu36cj4a2j2i//IZD1+o98acc7buuckjax8dOhdspTd0kCB1xL3D6T3C4LwCyk0EMaj6k6Ny5sqIKkIBqZARNjJi9J2Hgy/fh2/frPJqdNyDpOkT3vwk2Jvw1j9xHQQLe0LdEshnvg0Zc5/7bN02rbyRqLJ2eaAzwQFqsdU2n5qWa3WVIZONk7r9uNFrjdwO2W+g+bgKFyTmekncVycY4A+UXHKcuv+/Ab3jq4PnBQJWKlZw2fiBWtJUKDPN0KN+5IIx43D+vINzxWoAK+FQOnjnuphG3WSBRtrywENXTzz4CyHK4o9sYQ35tVou8oiZ9LIIjN0LeGwAttoSiAq3+A8z1HemGy9agkOrZva/Um+AHNw68ireg9L3KyrmS76iPHGi6bm91mJ1Xog+VWREv5U2QYnVnBGiXvMEo4L7m5KI/Y9szZbcs/TLT0Y35ezwSYChZO8bsyPeVZ75kQ==;5:t11Vx42qKcTjCJOUNkLnWLlcwyBh1qJsmHDd7p2gW7MQtJjTdYAqyfuoSZ0bHO0F4dNcX3YNE7X7SUqYMV9+adzIs0ZvuITz8vTz6uJc0z+/4iPEuUhBv8V8ph2RvTGj/qc4aMlduuawuTxVHKl+CLhhFLxnmgPbsSI+77CcFK4=;7:TsUoTjXa5yVjiCDi6cQiOgi2T/Y5AZTWty81lwD2G1esu38Y/vpaB/k4GAC/zHCeanUWxMtI5MOvcvkhWzWof7Loo/6/w5hel+GEZ6xLJd9UEh7bVlY9A5QYVjh58GGRqD+qhrosg53GK+2+ElxoUA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(13464003)(102836004)(6436002)(6246003)(81166006)(74316002)(76176011)(7696005)(305945005)(6506007)(53546011)(5660300001)(7736002)(2906002)(2900100001)(229853002)(71200400001)(8676002)(81156014)(99286004)(71190400001)(3846002)(8936002)(97736004)(6116002)(33656002)(106356001)(14454004)(6916009)(9686003)(4326008)(105586002)(68736007)(66066001)(26005)(39060400002)(256004)(186003)(478600001)(54906003)(86362001)(53936002)(25786009)(55016002)(14444005)(5024004)(217873002)(11346002)(486006)(476003)(316002)(446003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2784;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5e886223-c6e7-4c6b-1769-08d64645df23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2784;
x-ms-traffictypediagnostic: MWHPR02MB2784:
x-microsoft-antispam-prvs: <MWHPR02MB2784F1D07C574E9E1D5FF1A8AFC60@MWHPR02MB2784.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2784;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2784;
x-forefront-prvs: 08512C5403
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e7LcZwMZteYkKu4X/R5o2crA3bIVVFeUQ3NVlktia4BfVhg1OsqWz7kZRrci49HJkrL5jhLXxmeJImWYnuPL7vf0tXcxeI5hy865Fs9NjqWgKPaPhBhQrjGRxm3pU/TAnY2LTrQfesefDJ+xOX7X0gvp/pdKGSzou3mOsVFBnbGfpsFFi+SglaoYJOzygkrANzpP2Yz4Miz87lXb3C+gY8SekHBVZK3qpIWuldQ13PotXqDHVlQgw2iS6yzIU4CHExyTDymeTfOF4cV4K/SNCfnwl/aonrEv7Z2BXyf6MwSn6yhUjgg+LG2r87TjNelnaKCTXYd8X3A7CtyYA4SAJYZ0++rjL0QE8WKazPHCQqU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e886223-c6e7-4c6b-1769-08d64645df23
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 13:18:42.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Friday, November 9, 2018 1:38 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; Michal Simek
> <michals@xilinx.com>; linux-mtd@lists.infradead.org; linux-kernel@vger.ke=
rnel.org;
> nagasuresh12@gmail.com; robh@kernel.org
> Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for =
Arasan NAND
> Flash Controller
>=20
> Hi Naga,
>=20
> Just a preliminary review. I still think we have problems with how you ex=
ecute NAND
> operations. You seem to assume that read/write operation are always page =
write/read operation
> with a size aligned on a page size. This is wrong, either the controller =
is able to execute the
> exact operation that has been requested or it returns -ENOTSUPP.
Are you pointing the anfc_read_param_get_feature_sp_read_type_exec()?
Where I am reading a length of page size even for get_features op.
Is that you are pointing?

>=20
> On Fri, 9 Nov 2018 10:30:41 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > +
> > +/**
> > + * struct anfc_nand_chip - Defines the nand chip related information
> > + * @node:		Used to store NAND chips into a list.
> > + * @chip:		NAND chip information structure.
> > + * @strength:		Bch or Hamming mode enable/disable.
>=20
> The name is still confusing. BTW, can't you deduce Hamming vs BCH from th=
e strength?
> Hamming strength is 1, while BCH strengths seem to start at 4.
Yes we can deduce. I will try that.
.
>=20
> > + * @ecc_strength:	Ecc strength 4.8/12/16.
>=20
> 				      ^/
>=20
> > + * @eccval:		Ecc config value.
> > + * @spare_caddr_cycles:	Column address cycle information for spare are=
a.
> > + * @pktsize:		Packet size for read / write operation.
> > + * @csnum:		chipselect number to be used.
> > + * @spktsize:		Packet size in ddr mode for status operation.
> > + * @inftimeval:		Data interface and timing mode information
> > + */
> > +struct anfc_nand_chip {
> > +	struct list_head node;
> > +	struct nand_chip chip;
> > +	bool strength;
> > +	u32 ecc_strength;
> > +	u32 eccval;
> > +	u16 spare_caddr_cycles;
> > +	u32 pktsize;
> > +	int csnum;
> > +	u32 spktsize;
> > +	u32 inftimeval;
> > +};
> > +
> > +/**
> > + * struct anfc_nand_controller - Defines the Arasan NAND flash control=
ler
> > + *				 driver instance
> > + * @controller:		base controller structure.
> > + * @chips:		list of all nand chips attached to the ctrler.
> > + * @dev:		Pointer to the device structure.
> > + * @base:		Virtual address of the NAND flash device.
> > + * @clk_sys:		Pointer to the system clock.
> > + * @clk_flash:		Pointer to the flash clock.
> > + * @dma:		Dma enable/disable.
> > + * @buf:		Buffer used for read/write byte operations.
> > + * @irq:		irq number
>=20
> You should need this field. Just get the irq num in you probe path an reg=
ister an irq handler
> with devm_request_irq().
You mean to say, instead of putting irq in anfc_nand_controller structure, =
update the code like below snippet, right?

irq =3D platform_get_irq(pdev, 0);
if (irq < 0) {
            dev_err(dev, "failed to retrieve irq\n");
            return irq;
}
devm_request_irq(&pdev->dev, irq, anfc_irq_handler, 0, "arasannfc", nfc);

>=20
> > + * @bufshift:		Variable used for indexing buffer operation
> > + * @csnum:		Chip select number currently inuse.
>=20
> 						     ^ in use
>=20
> > + * @event:		Completion event for nand status events.
> > + * @status:		Status of the flash device.
> > + * @prog:		Used to initiate controller operations.
> > + */
> > +struct anfc_nand_controller {
> > +	struct nand_controller controller;
> > +	struct list_head chips;
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct clk *clk_sys;
> > +	struct clk *clk_flash;
> > +	int irq;
> > +	int csnum;
> > +	struct completion event;
> > +	int status;
> > +	u8 buf[TEMP_BUF_SIZE];
>=20
> Allocate this buf dynamically.
Ok
>=20
> > +	u32 eccval;
> > +};
>=20
> > +static int anfc_page_write_type_exec(struct nand_chip *chip,
> > +				     const struct nand_subop *subop) {
> > +	const struct nand_op_instr *instr;
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	unsigned int op_id, len;
> > +	struct anfc_op nfc_op =3D {};
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +
> > +	anfc_parse_instructions(chip, subop, &nfc_op);
> > +	instr =3D nfc_op.data_instr;
> > +	op_id =3D nfc_op.data_instr_idx;
> > +	anfc_prepare_cmd(chip, nfc_op.cmds[0], nfc_op.cmds[1], 1,
> > +			 mtd->writesize, nfc_op.naddrcycles);
> > +	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +	if (!nfc_op.data_instr)
> > +		return 0;
> > +
> > +	len =3D nand_subop_get_data_len(subop, op_id);
> > +	anfc_write_data_op(chip,  (char *)instr->ctx.data.buf.out,
>=20
> 				^ extra white space here
> and please drop the cast.
Ok
>=20
> Can you please run checkpatch --strict prior to submitting patches?
I ran it with --strict while submitting the patch, but I didn't find any wa=
rning.
Anyway I will correct it.
>=20
> > +			   mtd->writesize,
> > +			   DIV_ROUND_UP(mtd->writesize, achip->pktsize),
>=20
> No, that's wrong. You should use instr->ctx.data.len here, and the
> DIV_ROUND_UP() thing is a bit scary. That means you might be writing more=
 data than
> requested.
Ok. Got it.
>=20
> > +			   achip->pktsize);
> > +
> > +	return 0;
> > +}
> > +
>=20
> > +
> > +static int anfc_probe(struct platform_device *pdev) {
> > +	struct anfc_nand_controller *nfc;
> > +	struct anfc_nand_chip *anand_chip;
> > +	struct device_node *np =3D pdev->dev.of_node, *child;
> > +	struct resource *res;
> > +	int err;
> > +
> > +	nfc =3D devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
> > +	if (!nfc)
> > +		return -ENOMEM;
> > +
> > +	nand_controller_init(&nfc->controller);
> > +	INIT_LIST_HEAD(&nfc->chips);
> > +	init_completion(&nfc->event);
> > +	nfc->dev =3D &pdev->dev;
> > +	platform_set_drvdata(pdev, nfc);
> > +	nfc->csnum =3D -1;
> > +	nfc->controller.ops =3D &anfc_nand_controller_ops;
>=20
> Add a blank line here please
Ok, I will update
>=20
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	nfc->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(nfc->base))
> > +		return PTR_ERR(nfc->base);
>=20
> and here
Ok, I will update
>=20
> > +	nfc->irq =3D platform_get_irq(pdev, 0);
> > +	if (nfc->irq < 0) {
> > +		dev_err(&pdev->dev, "platform_get_irq failed\n");
> > +		return -ENXIO;
> > +	}
>=20
> and here
Ok, I will update
>=20
> > +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>=20
> Is this really needed?
Yes, As our DMA supports 64bit addressing. It is needed
>=20
> > +	err =3D devm_request_irq(&pdev->dev, nfc->irq, anfc_irq_handler,
> > +			       0, "arasannfc", nfc);
> > +	if (err)
> > +		return err;
>=20
> Add a blank line here too.
Ok, I will update
>=20
> > +	nfc->clk_sys =3D devm_clk_get(&pdev->dev, "clk_sys");
> > +	if (IS_ERR(nfc->clk_sys)) {
> > +		dev_err(&pdev->dev, "sys clock not found.\n");
> > +		return PTR_ERR(nfc->clk_sys);
> > +	}
> > +
> > +	nfc->clk_flash =3D devm_clk_get(&pdev->dev, "clk_flash");
> > +	if (IS_ERR(nfc->clk_flash)) {
> > +		dev_err(&pdev->dev, "flash clock not found.\n");
> > +		return PTR_ERR(nfc->clk_flash);
> > +	}
> > +
> > +	err =3D clk_prepare_enable(nfc->clk_sys);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Unable to enable sys clock.\n");
> > +		return err;
> > +	}
> > +
> > +	err =3D clk_prepare_enable(nfc->clk_flash);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Unable to enable flash clock.\n");
> > +		goto clk_dis_sys;
> > +	}
> > +
> > +	for_each_available_child_of_node(np, child) {
> > +		anand_chip =3D devm_kzalloc(&pdev->dev, sizeof(*anand_chip),
> > +					  GFP_KERNEL);
> > +		if (!anand_chip) {
> > +			of_node_put(child);
> > +			err =3D -ENOMEM;
> > +			goto nandchip_clean_up;
> > +		}
>=20
> and here.
Ok, I will update
>=20
> > +		err =3D anfc_nand_chip_init(nfc, anand_chip, child);
> > +		if (err) {
> > +			devm_kfree(&pdev->dev, anand_chip);
>=20
> We usually try to avoid calling devm_kfree(). I guess you do it to avoid =
keeping the chip obj
> around when init failed, but this should be rare enough so we can actuall=
y ignore it and let the
> mem allocated for the NFC lifetime.
Ok. I understood.
>=20
> > +			continue;
> > +		}
> > +
> > +		list_add_tail(&anand_chip->node, &nfc->chips);
> > +	}
> > +	return 0;
> > +
> > +nandchip_clean_up:
> > +	list_for_each_entry(anand_chip, &nfc->chips, node)
> > +		nand_release(&anand_chip->chip);
>=20
> Blank line here.
Ok, I will update
>=20
> > +	clk_disable_unprepare(nfc->clk_flash);
>=20
> Blank line here.
Ok, I will update
>=20
> > +clk_dis_sys:
> > +	clk_disable_unprepare(nfc->clk_sys);
> > +
> > +	return err;
> > +}
>=20
> Regards,
>=20
> Boris

Boris/Miquel, could you please review the remaining code as well, if you fe=
el
There is still something to improve.
One concern I have is especially anfc_read_page_hwecc(), there I am checkin=
g erased pages bit flips.
Since Arasan NAND controller doesn't have multibit error detection beyond 2=
4-bit( it can correct upto 24 bit errors),=20
I took some error count as default value(16, I put this based on the error =
count that I got while reading erased page on Micron device).
I will just read the error count register and compare this value with the d=
efault error count(16) and if it is more
Than default then I am checking for erased page bit flips.
I am doubting that this will not work in all cases.
In my case it is just working because the error count that it got on an era=
sed page is 16.
Could you please suggest a way to do detect erased_page bit flips.

Thanks,
Naga Sureshkumar Relli
