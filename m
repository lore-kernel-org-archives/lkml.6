Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeEGKMf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:12:35 -0400
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:63917
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbeEGKMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:12:33 -0400
From: Naga Sureshkumar Relli <nagasure@xilinx.com>
To: Julia Cartwright <julia@ni.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
CC: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Topic: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Index: AQHTu4GvmXFu5KnCoUisvmGJ5xXly6PvYMoAgDT38PA=
Date: Mon, 7 May 2018 10:12:28 +0000
Message-ID: <BY2PR02MB1411FA717E8DFB244F9B7976AF9B0@BY2PR02MB1411.namprd02.prod.outlook.com>
References: <1521024235-30374-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <1521024274-30467-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <20180403165042.GE7654@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20180403165042.GE7654@jcartwri.amer.corp.natinst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR02MB2133;7:Dhg5dS//MUi2tqPNfKT+jxxtEuxgUeFSdyFjkVAU7znYA0KixvbHmQKjMvc3aM4CM049S9sTE56u4S4EqWJ8FcqXrvFaLbQnRBj3AVzFerVJIVBJYzGW9PS6v9YSneYhinVmewqNootDN9ThHJ270Lv1AVcJ75PmCpCP1/6/nKwaLg0rbcjy3RQT/tUPbFKWypNP87rQiLm2FvzyzrFmrYhdH2Ajd3dH342l4R/O9Kv6GGLX+rIqaVrZSZ9avbQX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BY2PR02MB2133;
x-ms-traffictypediagnostic: BY2PR02MB2133:
x-microsoft-antispam-prvs: <BY2PR02MB21333AD32D6DA65B290B3381AF9B0@BY2PR02MB2133.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(192813158149592)(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR02MB2133;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2133;
x-forefront-prvs: 066517B35B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(39380400002)(346002)(189003)(199004)(13464003)(7696005)(3846002)(6116002)(33656002)(110136005)(106356001)(105586002)(486006)(2900100001)(54906003)(316002)(97736004)(68736007)(53936002)(14454004)(55016002)(25786009)(9686003)(39060400002)(4326008)(6246003)(8676002)(102836004)(55236004)(6506007)(66066001)(53546011)(26005)(186003)(81166006)(81156014)(8936002)(7736002)(6436002)(59450400001)(76176011)(3660700001)(476003)(3280700002)(446003)(11346002)(2906002)(305945005)(575784001)(86362001)(5660300001)(7416002)(5250100002)(478600001)(229853002)(99286004)(74316002)(2501003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2133;H:BY2PR02MB1411.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YIjORPQqWGv8OpNW0IQqUtywqx/zjZWUtlqwFeIP42GmzR7SMm/N+iNgEdJORqUNWhCfoS7//vBBT5VgdCZS8yyRB9fVYx1GTkScnP8tWywSF+YalGivJzN/jOttfXBLhGShae2yzcvqL5RgUrdVTEpLglExtGdmhzcWr+p84VCJ5DcRProXs5RZBzq7E1nz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 30a21aae-f04d-4609-b00f-08d5b40309c4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a21aae-f04d-4609-b00f-08d5b40309c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2018 10:12:28.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2133
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47ACgOE012633

Hi Julia,

Thanks for reviewing the patch and 
Sorry for my late reply. This patch went to junk folder, hence I didn't catch this patch.

> -----Original Message-----
> From: Julia Cartwright [mailto:julia@ni.com]
> Sent: Tuesday, April 3, 2018 10:21 PM
> To: nagasureshkumarrelli@gmail.com
> Cc: boris.brezillon@bootlin.com; rogerq@ti.com; lee.jones@linaro.org; alexandre.belloni@free-
> electrons.com; nicolas.ferre@microchip.com; ladis@linux-mips.org; ada@thorsis.com; linux-
> kernel@vger.kernel.org; Naga Sureshkumar Relli <nagasure@xilinx.com>
> Subject: Re: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353 static
> memory controller
> 
> Hello-
> 
> On Wed, Mar 14, 2018 at 04:14:34PM +0530, nagasureshkumarrelli@gmail.com wrote:
> > From: Naga Sureshkumar Relli <nagasure@xilinx.com>
> 
> I'm pleased to see this patchset revived and resubmitted!
Thanks.
> 
> It would be easier to follow if you constructed your two patchsets with git format-patch --
> thread.
> 
I am using the same but with out --thread.
> Or, merge them into a single patchset, especially considering the dependency between patches.
But both are different patches, one for Device tree documentation and other for driver update.

> 
> Some code review comments below:
> 
> > Add driver for arm pl353 static memory controller. This controller is
> > used in xilinx zynq soc for interfacing the nand and nor/sram memory
> > devices.
> >
> > Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > ---
> > Changes in v8:
> > - None
> > Changes in v7:
> > - Corrected the kconfig to use tristate selection
> > - Corrected the GPL licence ident
> > - Added boundary checks for nand timing parameters Changes in v6:
> > - Fixed checkpatch.pl reported warnings Changes in v5:
> > - Added pl353_smc_get_clkrate function, made pl353_smc_set_cycles as public
> >   API
> > - Removed nand timing parameter initialization and moved it to nand
> > driver Changes in v4:
> > - Modified driver to support multiple instances
> > - Used sleep instaed of busywait for delay Changes in v3:
> > - None
> > Changes in v2:
> > - Since now the timing parameters are in nano seconds, added logic to convert
> >   them to the cycles
> > ---
> >  drivers/memory/Kconfig                  |   7 +
> >  drivers/memory/Makefile                 |   1 +
> >  drivers/memory/pl353-smc.c              | 548
> ++++++++++++++++++++++++++++++++
> >  include/linux/platform_data/pl353-smc.h |  34 ++
> >  4 files changed, 590 insertions(+)
> >  create mode 100644 drivers/memory/pl353-smc.c  create mode 100644
> > include/linux/platform_data/pl353-smc.h
> >
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig index
> > 19a0e83..d70d6db 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -152,6 +152,13 @@ config DA8XX_DDRCTL
> >  	  This driver is for the DDR2/mDDR Memory Controller present on
> >  	  Texas Instruments da8xx SoCs. It's used to tweak various memory
> >  	  controller configuration options.
> > +config PL35X_SMC
> > +	bool "ARM PL35X Static Memory Controller(SMC) driver"
> 
> Is there any reason why this can't be tristate?
There is a Nand driver which uses this driver. i.e The NAND driver
Depends on this driver.
> 
> [..]
> > +++ b/drivers/memory/pl353-smc.c
> [..]
> > +/**
> > + * struct pl353_smc_data - Private smc driver structure
> > + * @devclk:		Pointer to the peripheral clock
> > + * @aperclk:		Pointer to the APER clock
> > + */
> > +struct pl353_smc_data {
> > +	struct clk		*memclk;
> > +	struct clk		*aclk;
> > +};
> > +
> > +/* SMC virtual register base */
> > +static void __iomem *pl353_smc_base;
> 
> While it's true that the Zynq chips only have a single instance of this IP, there is no real
> reason why an SoC can't instantiate more than one.
> I'm a bit uncomfortable with the fact that this has been designed out.
It might be a design level answer.
> 
> > +
> > +/**
> > + * pl353_smc_set_buswidth - Set memory buswidth
> > + * @bw:	Memory buswidth (8 | 16)
> > + * Return: 0 on success or negative errno.
> > + */
> > +int pl353_smc_set_buswidth(unsigned int bw) {
> > +
> > +	if (bw != PL353_SMC_MEM_WIDTH_8  && bw !=
> PL353_SMC_MEM_WIDTH_16)
> > +		return -EINVAL;
> > +
> > +	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);
> 
> There should be no reason not to use the _relaxed() accessor variants.
Ok, I will update.
> 
> > +	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
> > +	       PL353_SMC_DIRECT_CMD_OFFS);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pl353_smc_set_buswidth);
> > +
> > +/**
> > + * pl353_smc_set_cycles - Set memory timing parameters
> > + * @t0:	t_rc		read cycle time
> > + * @t1:	t_wc		write cycle time
> > + * @t2:	t_rea/t_ceoe	output enable assertion delay
> > + * @t3:	t_wp		write enable deassertion delay
> > + * @t4:	t_clr/t_pc	page cycle time
> > + * @t5:	t_ar/t_ta	ID read time/turnaround time
> > + * @t6:	t_rr		busy to RE timing
> > + *
> > + * Sets NAND chip specific timing parameters.
> > + */
> > +static void pl353_smc_set_cycles(u32 t0, u32 t1, u32 t2, u32 t3, u32
> > +			      t4, u32 t5, u32 t6)
> > +{
> > +	t0 &= PL353_SMC_SET_CYCLES_T0_MASK;
> > +	t1 = (t1 & PL353_SMC_SET_CYCLES_T1_MASK) <<
> > +			PL353_SMC_SET_CYCLES_T1_SHIFT;
> > +	t2 = (t2 & PL353_SMC_SET_CYCLES_T2_MASK) <<
> > +			PL353_SMC_SET_CYCLES_T2_SHIFT;
> > +	t3 = (t3 & PL353_SMC_SET_CYCLES_T3_MASK) <<
> > +			PL353_SMC_SET_CYCLES_T3_SHIFT;
> > +	t4 = (t4 & PL353_SMC_SET_CYCLES_T4_MASK) <<
> > +			PL353_SMC_SET_CYCLES_T4_SHIFT;
> > +	t5 = (t5 & PL353_SMC_SET_CYCLES_T5_MASK) <<
> > +			PL353_SMC_SET_CYCLES_T5_SHIFT;
> > +	t6 = (t6 & PL353_SMC_SET_CYCLES_T6_MASK) <<
> > +			PL353_SMC_SET_CYCLES_T6_SHIFT;
> > +
> > +	t0 |= t1 | t2 | t3 | t4 | t5 | t6;
> > +
> > +	writel(t0, pl353_smc_base + PL353_SMC_SET_CYCLES_OFFS);
> > +	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
> > +	       PL353_SMC_DIRECT_CMD_OFFS);
> > +}
> > +
> > +/**
> > + * pl353_smc_ecc_is_busy_noirq - Read ecc busy flag
> > + * Return: the ecc_status bit from the ecc_status register. 1 = busy,
> > +0 = idle  */ static int pl353_smc_ecc_is_busy_noirq(void)
> 
> _noirq() is intended to convey some warning to a user of a function about this functions
> behavior w.r.t. interrupts, but this function doesn't do anything with interrupts ...
You mean to say, naming convention?
> 
> > +{
> > +	return !!(readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
> > +		  PL353_SMC_ECC_STATUS_BUSY);
> > +}
> > +
> > +/**
> > + * pl353_smc_ecc_is_busy - Read ecc busy flag
> > + * Return: the ecc_status bit from the ecc_status register. 1 = busy,
> > +0 = idle  */ int pl353_smc_ecc_is_busy(void) {
> > +	int ret;
> > +
> > +	ret = pl353_smc_ecc_is_busy_noirq();
> 
> In fact, why even have pl353_smc_ecc_is_busy_noirq and pl353_smc_ecc_is_busy as separate
> functions?
I agree, I will update this.
> 
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
> > +
> [..]
> > +/**
> > + * pl353_smc_init_nand_interface - Initialize the NAND interface
> > + * @pdev:	Pointer to the platform_device struct
> > + * @nand_node:	Pointer to the pl353_nand device_node struct
> > + */
> > +static void pl353_smc_init_nand_interface(struct platform_device *pdev,
> > +				       struct device_node *nand_node) {
> > +	u32 t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr;
> > +	int err;
> > +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> > +
> > +	/* nand-cycle-<X> property is refer to the NAND flash timing
> > +	 * mapping between dts and the NAND flash AC timing
> > +	 *  X  : AC timing name
> > +	 *  t0 : t_rc
> > +	 *  t1 : t_wc
> > +	 *  t2 : t_rea
> > +	 *  t3 : t_wp
> > +	 *  t4 : t_clr
> > +	 *  t5 : t_ar
> > +	 *  t6 : t_rr
> > +	 */
> > +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t0", &t_rc);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "arm,nand-cycle-t0 not in device tree");
> > +		goto default_nand_timing;
> > +	}
> > +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t1", &t_wc);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "arm,nand-cycle-t1 not in device tree");
> > +		goto default_nand_timing;
> > +	}
> > +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t2", &t_rea);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "arm,nand-cycle-t2 not in device tree");
> > +		goto default_nand_timing;
> > +	}
> > +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t3", &t_wp);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "arm,nand-cycle-t3 not in device tree");
> > +		goto default_nand_timing;
> > +	}
> > +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t4", &t_clr);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "arm,nand-cycle-t4 not in device tree");
> > +		goto default_nand_timing;
> > +	}
> > +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t5", &t_ar);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "arm,nand-cycle-t5 not in device tree");
> > +		goto default_nand_timing;
> > +	}
> > +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t6", &t_rr);
> > +	if (err) {
> > +		dev_warn(&pdev->dev, "arm,nand-cycle-t6 not in device tree");
> > +		goto default_nand_timing;
> > +	}
> > +
> > +default_nand_timing:
> > +	if (err) {
> > +		/* set default NAND flash timing property */
> > +		dev_warn(&pdev->dev, "Using default timing for");
> > +		dev_warn(&pdev->dev, "2Gb Numonyx MT29F2G08ABAEAWP NAND
> flash");
> > +		dev_warn(&pdev->dev, "t_wp, t_clr, t_ar are set to 2");
> > +		dev_warn(&pdev->dev, "t_rc, t_wc, t_rr are set to 4");
> > +		dev_warn(&pdev->dev, "t_rea is set to 1");
> > +		t_rc = t_wc = t_rr = 4;
> > +		t_rea = 1;
> > +		t_wp = t_clr = t_ar = 2;
> > +	}
> > +
> > +	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
> > +
> > +	/*
> > +	 * Default assume 50MHz clock (20ns cycle time) and 3V operation
> > +	 * The SET_CYCLES_REG register value depends on the flash device.
> > +	 * Look in to the device datasheet and change its value, This value
> > +	 * is for 2Gb Numonyx flash.
> > +	 */
> 
> This comment should go above, with the default assignments.
Ok, I will update in next version.
> 
> > +	pl353_smc_set_cycles(t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr);
> > +	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
> > +		pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
> > +	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
> > +	       PL353_SMC_DIRECT_CMD_OFFS);
> > +	/* Wait till the ECC operation is complete */
> > +	do {
> > +		if (pl353_smc_ecc_is_busy_noirq())
> > +			cpu_relax();
> > +		else
> > +			break;
> > +	} while (!time_after_eq(jiffies, timeout));
> > +
> > +	if (time_after_eq(jiffies, timeout))
> > +		dev_err(&pdev->dev, "nand ecc busy status timed out");
> > +	/* Set the command1 and command2 register */
> 
> This comment is useless.
Ok, I will remove.
> 
> > +	writel(PL353_NAND_ECC_CMD1,
> > +			pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
> > +	writel(PL353_NAND_ECC_CMD2,
> > +			pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS); }
> > +
> > +static const struct of_device_id matches_nor[] = {
> > +	{ .compatible = "cfi-flash" },
> > +	{}
> > +};
> > +
> > +static const struct of_device_id matches_nand[] = {
> > +	{ .compatible = "arm,pl353-nand-r2p1" },
> > +	{}
> > +};
> > +
> > +static int pl353_smc_probe(struct platform_device *pdev) {
> > +	struct pl353_smc_data *pl353_smc;
> > +	struct device_node *child;
> > +	struct resource *res;
> > +	int err;
> > +	struct device_node *of_node = pdev->dev.of_node;
> > +	const struct of_device_id *matches = NULL;
> > +
> > +	pl353_smc = devm_kzalloc(&pdev->dev, sizeof(*pl353_smc), GFP_KERNEL);
> > +	if (!pl353_smc)
> > +		return -ENOMEM;
> > +
> > +	/* Get the NAND controller virtual address */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	pl353_smc_base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(pl353_smc_base))
> > +		return PTR_ERR(pl353_smc_base);
> > +
> > +	pl353_smc->aclk = devm_clk_get(&pdev->dev, "aclk");
> > +	if (IS_ERR(pl353_smc->aclk)) {
> > +		dev_err(&pdev->dev, "aclk clock not found.\n");
> > +		return PTR_ERR(pl353_smc->aclk);
> > +	}
> > +
> > +	pl353_smc->memclk = devm_clk_get(&pdev->dev, "memclk");
> > +	if (IS_ERR(pl353_smc->memclk)) {
> > +		dev_err(&pdev->dev, "memclk clock not found.\n");
> > +		return PTR_ERR(pl353_smc->memclk);
> > +	}
> > +
> > +	err = clk_prepare_enable(pl353_smc->aclk);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Unable to enable AXI clock.\n");
> > +		return err;
> > +	}
> > +
> > +	err = clk_prepare_enable(pl353_smc->memclk);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Unable to enable memory clock.\n");
> > +		goto out_clk_dis_aper;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, pl353_smc);
> > +
> > +	/* clear interrupts */
> > +	writel(PL353_SMC_CFG_CLR_DEFAULT_MASK,
> > +		pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
> > +
> > +	/* Find compatible children. Only a single child is supported */
> > +	for_each_available_child_of_node(of_node, child) {
> > +		if (of_match_node(matches_nand, child)) {
> > +			pl353_smc_init_nand_interface(pdev, child);
> > +			if (!matches) {
> > +				matches = matches_nand;
> > +			} else {
> > +				dev_err(&pdev->dev,
> > +					"incompatible configuration\n");
> > +				goto out_clk_disable;
> > +			}
> 
> If the comment stating that only a single available child is supported is true, then these checks
> are insufficient to guarantee that.  It's only counting nor devices; multiple NAND devices
> would be probed.
> 
> I would suggest cleaning this all up with something like:
> 
> 	static const struct of_device_id pl353_supported_children[] = {
> 		{ .compatible = "cfi-flash" },
> 		{ .compatible = "arm,pl353-nand-r2p1",
> 		  .data = pl353_smc_init_nand_interface },
> 		{},
> 	};
> 
> 	void (*init)(struct platform_device *pdev,
> 		     struct device_node *nand_node);
> 	const struct of_device_id *match = NULL;
> 
> 	for_each_available_child_of_node(of_node, child) {
> 		match = of_match_node(pl353_supported_children, child);
> 		if (!match) {
> 			dev_warn(&pdev->err, "unsupported child node\n");
> 			continue;
> 		}
> 
> 		break;
> 	}
> 
> 	if (!match) {
> 		dev_err(&pdev->dev, "no matching children\n");
> 		goto err_clk_disable;
> 	}
> 
> 	init = match->data;
> 	if (init)
> 		init();
> 
> 	return of_platform_device_create(child, NULL, &pdev->dev);
> 
Yes, the above logic looks good, I will update like that and send next series.

Thanks,
Naga Sureshkumar Relli
>    Julia
