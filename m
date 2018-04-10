Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeDJGYc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:24:32 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:44004 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751812AbeDJGY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:24:29 -0400
X-IronPort-AV: E=Sophos;i="5.48,430,1517842800";
   d="scan'208";a="276333432"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Topic: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Index: AQHTxqA8Q/Tp1OQLo0C0CX9dPZ3BD6P44lCAgAC3EuA=
Date: Tue, 10 Apr 2018 06:24:24 +0000
Message-ID: <TY1PR01MB1769EC6963CFB3D720D1B9EEF5BE0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
 <20180409192013.5rytwgoixtyraow3@rob-hp-laptop>
In-Reply-To: <20180409192013.5rytwgoixtyraow3@rob-hp-laptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1SPR01MB1;7:yHZJnwZKZU0ilL6ldMzC2zAG2NAs5SogYzI9Cy3xKgIM+8G7zRzQrS+RCpDuJ+6Ovae6jR72BfbSHad/CBCRZvS2G3PHcAEd1V5hL9ZumzoLb/E3vZrMfKg1jEKuh0dodcv199man0W9YQQXNaIbE9ZB9SXEPFuXB8cUHc6S8OLkXi4bp5nyQVrOhFpEZymFHKmfjDCHjfLXpzuwGaZ5MUZH58SJXpmXQTt8jLybqMNc9apH6jQmR7x8sgBB+JK+;20:MQof+SCeKM+BGyAJn/Mcb6XlsxdJssoDVsbFNU5ZrA8uIDZElGG00JrkwkHSevCLwQXHdIrplHns9KqQquT6Mxj7zIrXtRyAlBtB+wUq1+bPuwZndarH8sczfdUGon38W1MBYoFXoY2QP+II6LEGOxdJepICcyZqfLps5kOq1SE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
X-MS-Office365-Filtering-Correlation-Id: 38360f43-dc26-4083-59be-08d59eabb4a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1SPR01MB1;
x-ms-traffictypediagnostic: TY1SPR01MB1:
x-microsoft-antispam-prvs: <TY1SPR01MB177C3D6526D77D6D77BBDF5BE0@TY1SPR01MB1.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:TY1SPR01MB1;BCL:0;PCL:0;RULEID:;SRVR:TY1SPR01MB1;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(376002)(396003)(39380400002)(199004)(189003)(229853002)(74316002)(7736002)(186003)(6916009)(305945005)(2900100001)(478600001)(33656002)(7696005)(2906002)(14454004)(26005)(102836004)(39060400002)(54906003)(106356001)(3280700002)(3660700001)(68736007)(53936002)(9686003)(6246003)(99286004)(55016002)(53546011)(6506007)(6436002)(476003)(25786009)(446003)(11346002)(486006)(97736004)(5250100002)(8936002)(8676002)(81156014)(81166006)(4326008)(76176011)(316002)(86362001)(105586002)(3846002)(66066001)(5660300001)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1SPR01MB1;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5TDq19kIdxq1A7WVlBLYuSlXc9Mo+HRBw63BZtF4GXdjR7QwEnM1JxwVGVNL504fEaPGxe1EHlSXQK00n4x/n6sTJ/kAZffk9lnmNMasy5qADATIdqxFXF23qc/iP2/YXMqCBXz5SBKNWS3O6V6JZw+fTXv5BI6JpGHzRwP+bO2Gfo8AGiSAoJK0GvcEMjQ6hb8rNBf4ZQ9cZca0GeiIfaiUjcB5r6dmuk+Pge11m/UetdRZAkYiZMmyFKAAw509lNyttTNA0EriAQWdoJdqUg++6SFpJfqcXZF06FSRqIMNRriX+9pejZAI532nJYSE8e0QaAp2LbhC4440VWzx1GwWvH3iqkxlPhxzeWneSLlc4/dVsSGvd74yx7WgePPE68p25s4zQH7Sptc8pFP09csPqf8oweGYd7QJolgZuAE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38360f43-dc26-4083-59be-08d59eabb4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 06:24:24.8133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1SPR01MB1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3A6ObK2028978

Hi Rob,

On 09 April 2018 20:20 Rob Herring wrote:
> On Wed, Mar 28, 2018 at 03:22:30PM +0100, Phil Edworthy wrote:
> > The DesignWare GPIO IP can be configured for either 1 or 32
> > interrupts, but the driver currently only supports 1 interrupt. See
> > the DesignWare DW_apb_gpio Databook description of the
> 'GPIO_INTR_IO' parameter.
> 
> Someday h/w designers will realize this does nothing to optimize interrupt
> handling...
I can imagine some software where the isr is written to handle a specific GPIO
interrupt _could_ be faster, though no sane software would be designed like
that.

> > This change allows the driver to work with up to 32 interrupts, it
> > will get as many interrupts as specified in the DT 'interrupts' property.
> > It doesn't do anything clever with the different interrupts, it just
> > calls the same handler used for single interrupt hardware.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > Note: There are a few lines over 80 chars, but this is just guidance, right?
> >       Especially as there are already some lines over 80 chars.
> 
> Code, yes, but not for paragraphs of text in DT bindings.
Good, that's what I did.

> > ---
> >  .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   | 10 ++++-
> >  drivers/gpio/gpio-dwapb.c                          | 44 +++++++++++++++++-----
> >  include/linux/platform_data/gpio-dwapb.h           |  3 +-
> >  3 files changed, 45 insertions(+), 12 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> > b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> > index 4a75da7..e343581 100644
> > --- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> > +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> > @@ -26,8 +26,14 @@ controller.
> >    the second encodes the triger flags encoded as described in
> >
> > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> >  - interrupt-parent : The parent interrupt controller.
> > -- interrupts : The interrupt to the parent controller raised when
> > GPIOs
> > -  generate the interrupts.
> > +- interrupts : The interrupts to the parent controller raised when
> > +GPIOs
> > +  generate the interrupts. If the controller provides one combined
> > +interrupt
> > +  for all GPIOs, specify a single interrupt. If the controller
> > +provides one
> > +  interrupt for each GPIO, provide a list of interrupts that
> > +correspond to each
> > +  of the GPIO pins. When specifying multiple interrupts, if any of
> > +the GPIOs are
> > +  not connected to an interrupt, use the interrupt-mask property.
> > +- interrupt-mask : a 32-bit bit mask that specifies which interrupts
> > +in the list
> > +  of interrupts is valid, bit is 1 for a valid irq.
> 
> This is not a standard property and would need a vendor prefix. However, I'd
> prefer you just skip any not connected interrupts with an invalid interrupt
> number. Then the GPIO number is the index into "interrupts".
Makes sense, I'll rework it to do this.

> >  - snps,nr-gpios : The number of pins in the port, a single cell.
> 
> This BTW should be deprecated to use "nr-gpios" instead, but that's another
> patch.

Thanks for your comments,
Phil
