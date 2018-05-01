Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755237AbeEANyO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:54:14 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:60188 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753505AbeEANyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:54:12 -0400
X-IronPort-AV: E=Sophos;i="5.49,351,1520866800";
   d="scan'208";a="278341263"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>
Subject: RE: [PATCH] irqchip: Add support for Renesas RZ/N1 GPIO interrupt
 multiplexer
Thread-Topic: [PATCH] irqchip: Add support for Renesas RZ/N1 GPIO interrupt
 multiplexer
Thread-Index: AQHT2weh6W4b6F6C9ECWpTAVlJ2E0qQa6pcAgAAAeeA=
Date: Tue, 1 May 2018 13:54:02 +0000
Message-ID: <TY1PR01MB176998F43462BA754D67E635F5810@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1524490386-1544-1-git-send-email-phil.edworthy@renesas.com>
 <20180501132844.GA8298@rob-hp-laptop>
In-Reply-To: <20180501132844.GA8298@rob-hp-laptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0714;7:BZEcEuGXDQLr8daoozmIyWajJLuvAjZzvwUfO1P0PEck+2YGXVz8LPwJk0w2NKxR84zjRcHGAv1JobBKEji/vSE/PSjird1hLl+g49/Ntz8tlUcXwN+NYKGT9MoItnPDwiJSmtr2wz2hdrbRVYAS7FR8rHmMdfapwK5NnFmhVAqYSr4sQYsWkyD7lXv0zEd7DqZ1sQZVg6uIFEkuvDgkF3V+jQLb8O6408EpaAMtp7JZEBt5EmAb3gbLjorm4Vwl;20:asURqXQJTyhXIt5On1NZMoMMt5rhU57gcoHg35QBEyCer1ev8mDcUCI69NIyDNUiUoCdPt8jm/mE74/xyvQ8m7nhpxbm2wyfS5lVTOpZ6wu1TWHyO9H1y7CHuVbR8mCvovV6g1HsdHbPnYSFcFb093za0U3UQwuT3M1mtcT0LF4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0714;
x-ms-traffictypediagnostic: TY1PR01MB0714:
x-microsoft-antispam-prvs: <TY1PR01MB07146C4621FBDD1C540DE388F5810@TY1PR01MB0714.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR01MB0714;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0714;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(396003)(39380400002)(199004)(189003)(305945005)(26005)(59450400001)(3280700002)(2906002)(11346002)(3846002)(5250100002)(4326008)(7696005)(102836004)(6246003)(107886003)(53936002)(478600001)(9686003)(186003)(6116002)(53546011)(6506007)(3660700001)(76176011)(99286004)(68736007)(2900100001)(6436002)(81156014)(54906003)(5660300001)(25786009)(8676002)(229853002)(81166006)(575784001)(14454004)(86362001)(97736004)(486006)(33656002)(66066001)(44832011)(74316002)(7736002)(446003)(55016002)(6916009)(316002)(105586002)(476003)(8936002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0714;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: tu11VCU2RFU3E8MwNMTY4mjOc4/LGjnoDxL76fwqHLfoV86G5Iu1qohhtzdyBoaG7lPthVpkR6UsfwKUWQusiEdTCxBJC0FfM0bZYjbEnKV0JJpCIaPRtD5ctd/1c2GJqoY7MtMGpDVRq15804PcZsfMJIGtdIpg12BsXhG0/FZOakS08fL1+iFrrCx4A9g8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5d4533c2-c02a-4d69-e851-08d5af6aff21
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4533c2-c02a-4d69-e851-08d5af6aff21
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 13:54:02.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0714
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41DsK1W011673

Hi Rob,

On 01 May 2018 14:29 Rob Herring wrote:
> On Mon, Apr 23, 2018 at 02:33:06PM +0100, Phil Edworthy wrote:
> > On RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks each
> > configured to have 32 interrupt outputs, so we have a total of 96 GPIO
> > interrupts. All of these are passed to the GPIO IRQ Muxer, which
> > selects
> > 8 of the GPIO interrupts to pass onto the GIC. The interrupt signals
> > aren't latched, so there is nothing to do in this driver when an
> > interrupt is received, other than tell the corresponding GPIO block.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  .../interrupt-controller/renesas,rzn1-mux.txt      |  85 ++++++++++
> 
> Please split bindings to a separate patch.
Will do.

> >  drivers/irqchip/Kconfig                            |  10 ++
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-rzn1-irq-mux.c                 | 178
> +++++++++++++++++++++
> >  4 files changed, 274 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mu
> > x.txt  create mode 100644 drivers/irqchip/irq-rzn1-irq-mux.c
> >
> > diff --git
> > a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-
> > mux.txt
> > b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-
> > mux.txt
> > new file mode 100644
> > index 0000000..f28a365
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,r
> > +++ zn1-mux.txt
> > @@ -0,0 +1,85 @@
> > +* Renesas RZ/N1 GPIO Interrupt Multiplexer
> > +
> > +On Renesas RZ/N1 devices, there are 3 Synopsys DesignWare GPIO blocks
> > +each configured to have 32 interrupt outputs, so we have a total of
> > +96 GPIO interrupts. All of these are passed to the GPIO IRQ Muxer,
> > +which selects
> > +8 of the GPIO interrupts to pass onto the GIC.
> > +
> > +A single node in the device tree is used to describe the GPIO IRQ Muxer.
> > +
> > +Required properties:
> > +- compatible: the SoC specific name, i.e. "renesas,r9a06g032-gpioirq"
> > +   or "renesas,r9a06g033-gpioirq" followed by the SoC family name, i.e.
> > +   "renesas,rzn1-gpioirq".
> > +- interrupt-controller: Identifies the node as an interrupt controller.
> > +- #interrupt-cells: should be <1>. The meaning of the cells is the input
> > +   interrupt index, 0 to 95.
> > +- reg: Base address and size of GPIO IRQ Muxer registers.
> > +- interrupts: The list of interrupts generated by the muxer which are then
> > +   connected to a parent interrupt controller. The format of the interrupt
> > +   specifier depends in the interrupt parent controller.
> > +- gpioirq-#N: One property for each interrupt output from the GPIO IRQ
> Muxer
> > +   that specifies the input interrupt to use, #N is from 0 to 7.
> 
> Why do you need this in DT? Can't the driver handle this dynamically?
> When you request an interrupt on a GPIO line, then connect that GPIO line
> to a free IRQ line.
On the SoC that has this block, there is another CPU that runs firmware.
It's likely that the firmware will use some of these GPIO interrupts and
so we don't want them to move around. The firmware runs before Linux is
up, and luckily setting up the registers again won't affect the interrupts.

> If you really need this in DT, then interrupt-map can be used here.
Ok

> > +
> > +Optional properties:
> > +- interrupt-parent: pHandle of the parent interrupt controller, if not
> > +   inherited from the parent node.
> > +
> > +
> > +Example:
> > +
> > +	The following is an example for the RZ/N1D SoC.
> > +
> > +	gpioirq: gpioirq@51000480 {
> > +		compatible = "renesas,r9a06g032-gpioirq",
> > +				"renesas,rzn1-gpioirq";
> > +		reg = <0x51000480 0x20>;
> > +		interrupts =
> > +			<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > +			<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> > +		status = "disabled";
> 
> Don't show status in examples.
Ok

> > +	};
> > +
> > +	gpio0: gpio@5000b000 {
> > +		compatible = "snps,dw-apb-gpio";
> > +		reg = <0x5000b000 0x80>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		clock-names = "bus";
> > +		clocks = <&hclk_gpio0>;
> > +		status = "disabled";
> > +
> > +		gpio0a: gpio-controller@0 {
> > +			compatible = "snps,dw-apb-gpio-port";
> > +			bank-name = "gpio0a";
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			snps,nr-gpios = <32>;
> > +			reg = <0>;
> > +
> > +			interrupt-controller;
> > +			interrupt-parent = <&gpioirq>;
> > +			interrupts =   < 0  1  2  3  4  5  6  7
> > +					 8  9 10 11 12 13 14 15
> > +					16 17 18 19 20 21 22 23
> > +					24 25 26 27 28 29 30 31 >;
> > +			#interrupt-cells = <2>;
> > +		};
> > +	};
> > +
> > +
> > +	The following is an example for a board using this.
> 
> Don't show the soc/board split. This is convention, but not part of the
> binding.
Ok

> > +
> > +	&gpioirq {
> > +		status = "okay";
> > +		gpioirq-0 = <24>;	/* gpio0a 24 */
> > +		gpioirq-4 = <3>;	/* gpio0a 3 */
> > +	};

Thanks for your comments,
Phil
