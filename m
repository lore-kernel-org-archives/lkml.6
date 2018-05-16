Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeEPVky (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:40:54 -0400
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:43568
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750953AbeEPVku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:40:50 -0400
From: Hoan Tran <hoan.tran@amperecomputing.com>
To: Phil Edworthy <phil.edworthy@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        "Michel Pollet" <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hoan Tran <hoan.tran@amperecomputing.com>
Subject: Re: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Topic: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Index: AQHT6QKEeroxHiUlzUOz48IDYcRHwqQydbSA
Date: Wed, 16 May 2018 21:40:42 +0000
Message-ID: <F70CFA9C-2059-432E-BFD3-3FA6CB618795@amperecomputing.com>
References: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan.tran@amperecomputing.com;
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR0102MB3377;7:aIK9TOxyGiAX8OD2gyNJz1r/Rig5DqgnRb7Tryo0h2S+gI4l2QsmvHbAA4tFngySyYasaByyYbokDu23SMvhGYB/T3Wek4Ey3vB4CCWr2QcNomi4ghZJIOL/iW1sDsWG0i/Q4RQPfcK8t07YDBh0ThCV4jQhCP/WOrmd8mODIw4e4Jrt6Qa0Lv1TzaPNZKRUpo3cmvFUyGWapWNhKEBzuaNEnBWu0Ol1+KqVSpSzdAT61TSBvmgRL0uji0lC9syy
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39840400004)(396003)(346002)(376002)(366004)(39380400002)(199004)(189003)(8936002)(5250100002)(110136005)(7736002)(2906002)(3660700001)(83716003)(8676002)(81166006)(66066001)(44832011)(3280700002)(33656002)(53936002)(305945005)(54906003)(81156014)(3846002)(6436002)(316002)(6486002)(229853002)(6116002)(68736007)(86362001)(478600001)(446003)(36756003)(106356001)(14454004)(6512007)(5660300001)(2616005)(476003)(25786009)(59450400001)(7416002)(82746002)(102836004)(4326008)(97736004)(39060400002)(76176011)(105586002)(11346002)(2900100001)(186003)(6506007)(486006)(6246003)(26005)(99286004)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR0102MB3377;H:BL0PR0102MB3539.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR0102MB3377;
x-ms-traffictypediagnostic: BL0PR0102MB3377:
x-microsoft-antispam-prvs: <BL0PR0102MB337727A7AADC619ECED4C3CAE4920@BL0PR0102MB3377.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR0102MB3377;BCL:0;PCL:0;RULEID:;SRVR:BL0PR0102MB3377;
x-forefront-prvs: 0674DC6DD3
x-microsoft-antispam-message-info: njQACjvgk0B8Ih9dVjsh/vI31vVuqYCrwwo6yaYd3RM8Pvm7mmoFcJRj/9NXWJirmnlOzoVMsXCRpObyTo133ojosIuL5c58IQFhwHu5wRJU1NrKKNf7Dh25TdQGCPtpY75Usaty+wEcPsbcHjhaXbIsM/BgaDb1fcUza8a9hMvu31ztALWVnbvlJS/wnAY7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC9631F61DD19147B0D1A3F5AD4E1A36@prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aec884b6-30cc-4eab-249e-08d5bb75acdc
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec884b6-30cc-4eab-249e-08d5bb75acdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 21:40:42.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3377
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GLewCD005183

Hi Phil,

﻿On 5/11/18, 1:31 AM, "Phil Edworthy" <phil.edworthy@renesas.com> wrote:

    The DesignWare GPIO IP can be configured for either 1 interrupt or 1
    per GPIO in port A, but the driver currently only supports 1 interrupt.
    See the DesignWare DW_apb_gpio Databook description of the
    'GPIO_INTR_IO' parameter.
    
    This change allows the driver to work with up to 32 interrupts, it will
    get as many interrupts as specified in the DT 'interrupts' property.
    It doesn't do anything clever with the different interrupts, it just calls
    the same handler used for single interrupt hardware.
    
    Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Acked-by: Lee Jones <lee.jones@linaro.org>
    ---
    One point to mention is that I have made it possible for users to have
    unconnected interrupts by specifying holes in the list of interrupts. This is
    done by supporting the interrupts-extended DT prop.
    However, I have no use for this and had to hack some test case for this.
    Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
    
    v6:
     - Treat DT and ACPI the same as much as possible. Note that we can't use
       platform_get_irq() to get the DT interrupts as they are in the port
       sub-node and hence do not have an associated platform device.
    v5:
     - Rolled ACPI companion code provided by Hoan Tran into this patch.
    v4:
     - Use of_irq_get() instead of of_irq_parse_one()+irq_create_of_mapping()
    v3:
     - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid bisect problems
    v2:
     - Replaced interrupt-mask DT prop with support for the interrupts-extended
       prop. This means replacing the call to irq_of_parse_and_map() with calls
       to of_irq_parse_one() and irq_create_of_mapping().
    ---
     .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  9 +++-
     drivers/gpio/gpio-dwapb.c                          | 49 +++++++++++++++-------
     drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-
     include/linux/platform_data/gpio-dwapb.h           |  3 +-
     4 files changed, 45 insertions(+), 19 deletions(-)
    
    diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
    index 4a75da7..3c1118b 100644
    --- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
    +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
    @@ -26,8 +26,13 @@ controller.
       the second encodes the triger flags encoded as described in
       Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
     - interrupt-parent : The parent interrupt controller.
    -- interrupts : The interrupt to the parent controller raised when GPIOs
    -  generate the interrupts.
    +- interrupts : The interrupts to the parent controller raised when GPIOs
    +  generate the interrupts. If the controller provides one combined interrupt
    +  for all GPIOs, specify a single interrupt. If the controller provides one
    +  interrupt for each GPIO, provide a list of interrupts that correspond to each
    +  of the GPIO pins. When specifying multiple interrupts, if any are unconnected,
    +  use the interrupts-extended property to specify the interrupts and set the
    +  interrupt controller handle for unused interrupts to 0.
     - snps,nr-gpios : The number of pins in the port, a single cell.
     - resets : Reset line for the controller.
     
    diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
    index 226977f..15b4154 100644
    --- a/drivers/gpio/gpio-dwapb.c
    +++ b/drivers/gpio/gpio-dwapb.c
    @@ -441,14 +441,19 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
     	irq_gc->chip_types[1].handler = handle_edge_irq;
     
     	if (!pp->irq_shared) {
    -		irq_set_chained_handler_and_data(pp->irq, dwapb_irq_handler,
    -						 gpio);
    +		int i;
    +
    +		for (i = 0; i < pp->ngpio; i++) {
    +			if (pp->irq[i] >= 0)
    +				irq_set_chained_handler_and_data(pp->irq[i],
    +						dwapb_irq_handler, gpio);
    +		}
     	} else {
     		/*
     		 * Request a shared IRQ since where MFD would have devices
     		 * using the same irq pin
     		 */
    -		err = devm_request_irq(gpio->dev, pp->irq,
    +		err = devm_request_irq(gpio->dev, pp->irq[0],
     				       dwapb_irq_handler_mfd,
     				       IRQF_SHARED, "gpio-dwapb-mfd", gpio);
     		if (err) {
    @@ -524,7 +529,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
     	if (pp->idx == 0)
     		port->gc.set_config = dwapb_gpio_set_config;
     
    -	if (pp->irq)
    +	if (pp->has_irq)
     		dwapb_configure_irqs(gpio, port, pp);
     
     	err = gpiochip_add_data(&port->gc, port);
    @@ -535,7 +540,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
     		port->is_registered = true;
     
     	/* Add GPIO-signaled ACPI event support */
    -	if (pp->irq)
    +	if (pp->has_irq)
     		acpi_gpiochip_request_interrupts(&port->gc);
     
     	return err;
    @@ -557,7 +562,7 @@ dwapb_gpio_get_pdata(struct device *dev)
     	struct dwapb_platform_data *pdata;
     	struct dwapb_port_property *pp;
     	int nports;
    -	int i;
    +	int i, j;
     
     	nports = device_get_child_node_count(dev);
     	if (nports == 0)
    @@ -575,6 +580,8 @@ dwapb_gpio_get_pdata(struct device *dev)
     
     	i = 0;
     	device_for_each_child_node(dev, fwnode)  {
    +		struct device_node *np = NULL;
    +
     		pp = &pdata->properties[i++];
     		pp->fwnode = fwnode;
     
    @@ -594,23 +601,35 @@ dwapb_gpio_get_pdata(struct device *dev)
     			pp->ngpio = 32;
     		}
     
    +		pp->irq_shared	= false;
    +		pp->gpio_base	= -1;
    +
     		/*
     		 * Only port A can provide interrupts in all configurations of
     		 * the IP.
     		 */
    -		if (dev->of_node && pp->idx == 0 &&
    -			fwnode_property_read_bool(fwnode,
    +		if (pp->idx != 0)
    +			continue;
    +
    +		if (dev->of_node && fwnode_property_read_bool(fwnode,
     						  "interrupt-controller")) {
    -			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
    -			if (!pp->irq)
    -				dev_warn(dev, "no irq for port%d\n", pp->idx);
    +			np = to_of_node(fwnode);
     		}
     
    -		if (has_acpi_companion(dev) && pp->idx == 0)
    -			pp->irq = platform_get_irq(to_platform_device(dev), 0);
    +		for (j = 0; j < pp->ngpio; j++) {
    +			pp->irq[j] = -ENXIO;
     
    -		pp->irq_shared	= false;
    -		pp->gpio_base	= -1;
    +			if (np)
    +				pp->irq[j] = of_irq_get(np, j);
    +			else if (has_acpi_companion(dev))
    +				pp->irq[j] = platform_get_irq(to_platform_device(dev), j);
    +
    +			if (pp->irq[j] >= 0)
    +				pp->has_irq = true;
    +		}
    +
    +		if (!pp->has_irq)
    +			dev_warn(dev, "no irq for port%d\n", pp->idx);
     	}
     
     	return pdata;
    diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
    index 90e35de..5bddb84 100644
    --- a/drivers/mfd/intel_quark_i2c_gpio.c
    +++ b/drivers/mfd/intel_quark_i2c_gpio.c
    @@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
     	pdata->properties->idx		= 0;
     	pdata->properties->ngpio	= INTEL_QUARK_MFD_NGPIO;
     	pdata->properties->gpio_base	= INTEL_QUARK_MFD_GPIO_BASE;
    -	pdata->properties->irq		= pdev->irq;
    +	pdata->properties->irq[0]	= pdev->irq;
    +	pdata->properties->has_irq	= true;
     	pdata->properties->irq_shared	= true;
     
     	cell->platform_data = pdata;
    diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
    index 2dc7f4a..419cfac 100644
    --- a/include/linux/platform_data/gpio-dwapb.h
    +++ b/include/linux/platform_data/gpio-dwapb.h
    @@ -19,7 +19,8 @@ struct dwapb_port_property {
     	unsigned int	idx;
     	unsigned int	ngpio;
     	unsigned int	gpio_base;
    -	unsigned int	irq;
    +	int		irq[32];
    +	bool		has_irq;
     	bool		irq_shared;
     };

Acked-by: Hoan Tran <hoan.tran@amperecomputing.com>
     
    -- 
    2.7.4
    
    
