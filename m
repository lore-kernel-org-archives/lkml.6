Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeDSKDj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:03:39 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:51793 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751903AbeDSKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:03:36 -0400
X-IronPort-AV: E=Sophos;i="5.48,468,1517842800";
   d="scan'208";a="277261175"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Topic: [PATCH v3] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Index: AQHT0wSYdC3Wj2qtiEG+OZ/tkhpiS6P+5T2AgAAAjlCABzqbgIABw3IQ
Date: Thu, 19 Apr 2018 10:03:25 +0000
Message-ID: <TY1PR01MB17691AADC510B417E3F6E49DF5B50@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1523609472-4481-1-git-send-email-phil.edworthy@renesas.com>
 <CAFHUOYziPaZC-Zcb7rXqC9p24H+CU4wK4NQShQkYLgH7c5mVwA@mail.gmail.com>
 <TY1PR01MB1769DB39F986BEADEF61F8C9F5B30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAFHUOYzPO+99HMLV7i1=ZoQG3vKRp2v5GzJdpW9yoWovx8D91Q@mail.gmail.com>
In-Reply-To: <CAFHUOYzPO+99HMLV7i1=ZoQG3vKRp2v5GzJdpW9yoWovx8D91Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0778;7:naSbcHgX6vED4nxEMX3eX+TDqIwiShDz59aogAmIfLY83aY132K2HC4r2HsugeUnZx7DaAybRhrl1tejxJPisLotr+OTu9eAzeJjtpWdzScOW+8ybanihtxgG6q3j2VjULHR/8f/7bm9O5IFF8WmtE4j7LPW16ka+gNiYlyGVwWrnCP80S2atl5eKHGO2doISjo8J084vUh6FmOu+vPFO83JVq9HnggcojGYOYQU5rcggBl6u7i42lkxX5YPeg+1;20:v1hqHNspgXrP/U92FvWP4y3SLLLH29HEdU01cTDrZigolNpRJI0ecxRlC5pD1EBr3txZW9zFEJR+v8kjhP+64/p6K1/lmY4fhSEJe3bSIpMF8E0qzWgs+icSSdUYL1ZoKmw8NkfAXlwao2H3uZyAaBlVq3N3rY3ui2VkZlUolxQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0778;
x-ms-traffictypediagnostic: TY1PR01MB0778:
x-microsoft-antispam-prvs: <TY1PR01MB0778E034CA2093B68F4B7458F5B50@TY1PR01MB0778.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR01MB0778;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0778;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(376002)(39860400002)(366004)(6116002)(8676002)(25786009)(5660300001)(66066001)(81166006)(3846002)(229853002)(39060400002)(4326008)(7696005)(76176011)(9686003)(6506007)(86362001)(55016002)(102836004)(59450400001)(316002)(53936002)(54906003)(8936002)(99286004)(53546011)(44832011)(110136005)(93886005)(305945005)(5250100002)(6436002)(2906002)(476003)(74316002)(478600001)(7416002)(26005)(186003)(14454004)(6246003)(2900100001)(33656002)(3280700002)(3660700001)(7736002)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0778;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: wSnz5iZ5FvVVyNsfb2iR0RoxEC1aHf0Bnq/10f17TRMNM36fx8KZL8AkDVqFIhHIpcKaS3pLtHPKVgGTQNmUiWg/yYoLQ8itoZFIe4R7qbKb7LLZk+yZd65PXXkhpk0MXywT8Ir0ravxV4BnSAyZBMqr1ivBDKAT2toUO/Ux3jcQqWiXZwGban2iN9oDe3mP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 288d1606-cfc0-4ed0-2a6a-08d5a5dccaf1
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d1606-cfc0-4ed0-2a6a-08d5a5dccaf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 10:03:25.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3JA3heg020892

Hi Hoan

On 18 April 2018 08:03 Hoan Tran wrote:
> On Fri, Apr 13, 2018 at 9:47 AM, Phil Edworthy wrote:
> > On 13 April 2018 17:37 Hoan Tran wrote:
> >> On Fri, Apr 13, 2018 at 1:51 AM, Phil Edworthy wrote:
> >> > The DesignWare GPIO IP can be configured for either 1 interrupt or
> >> > 1 per GPIO in port A, but the driver currently only supports 1 interrupt.
> >> > See the DesignWare DW_apb_gpio Databook description of the
> >> > 'GPIO_INTR_IO' parameter.
> >> >
> >> > This change allows the driver to work with up to 32 interrupts, it
> >> > will get as many interrupts as specified in the DT 'interrupts' property.
> >> > It doesn't do anything clever with the different interrupts, it
> >> > just calls the same handler used for single interrupt hardware.
> >> >
> >> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >> > ---
> >> > One point to mention is that I have made it possible for users to
> >> > have unconncted interrupts by specifying holes in the list of interrupts.
> >> > This is done by supporting the interrupts-extended DT prop.
> >> > However, I have no use for this and had to hack some test case for this.
> >> > Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
> >> >
> >> > v3:
> >> >  - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid
> >> > bisect problems
> >> > v2:
> >> >  - Replaced interrupt-mask DT prop with support for the interrupts-
> >> extended
> >> >    prop. This means replacing the call to irq_of_parse_and_map() with
> calls
> >> >    to of_irq_parse_one() and irq_create_of_mapping().
> >> >
> >> > Note: There are a few *code* lines over 80 chars, but this is just
> guidance,
> >> >    right? Especially as there are already some lines over 80 chars.
> >> > ---
> > [snip]
> >
> >> > -               if (has_acpi_companion(dev) && pp->idx == 0)
> >> > -                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
> >> > +               if (has_acpi_companion(dev) && pp->idx == 0) {
> >> > +                       pp->irq[0] = platform_get_irq(to_platform_device(dev),
> 0);
> >> > +                       if (pp->irq[0])
> >> > +                               pp->has_irq = true;
> >> > +               }
> >>
> >> It doesn't work for ACPI. Could you do the same logic for ACPI?
> > I don’t have access to any device that was baked (i.e. fabbed) with
> > multiple output interrupts from the Synopsys GPIO blocks and use ACPI.
> > I don't know if any such device exists.
> 
> Below code is tested on X-Gene system which supports 1 interrupt per GPIO
> on Port A. You can update it into your patch.
> 
> -               if (has_acpi_companion(dev) && pp->idx == 0)
> -                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
> +               if (has_acpi_companion(dev) && pp->idx == 0) {
> +                       unsigned int j;
> +                       for (j = 0; j < pp->ngpio; j++) {
> +                               pp->irq[j] =
> platform_get_irq(to_platform_device(dev), j);
> +                               if (pp->irq[j])
> +                                       pp->has_irq = true;
> +                       }
> +               }
Since I've already got some reviewed-by and acks for v4, I'll leave it to Linus
to decide if he wants me to roll your changes into this patch or for you to
submit a separate patch.

Thanks
Phil


> >> >                 pp->irq_shared  = false;
> >> >                 pp->gpio_base   = -1;
> >> > diff --git a/drivers/mfd/intel_quark_i2c_gpio.c
> >> > b/drivers/mfd/intel_quark_i2c_gpio.c
> >> > index 90e35de..5bddb84 100644
> >> > --- a/drivers/mfd/intel_quark_i2c_gpio.c
> >> > +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> >> > @@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct
> >> > pci_dev
> >> *pdev, struct mfd_cell *cell)
> >> >         pdata->properties->idx          = 0;
> >> >         pdata->properties->ngpio        = INTEL_QUARK_MFD_NGPIO;
> >> >         pdata->properties->gpio_base    =
> INTEL_QUARK_MFD_GPIO_BASE;
> >> > -       pdata->properties->irq          = pdev->irq;
> >> > +       pdata->properties->irq[0]       = pdev->irq;
> >> > +       pdata->properties->has_irq      = true;
> >> >         pdata->properties->irq_shared   = true;
> >> >
> >> >         cell->platform_data = pdata; diff --git
> >> > a/include/linux/platform_data/gpio-dwapb.h
> >> > b/include/linux/platform_data/gpio-dwapb.h
> >> > index 2dc7f4a..5a52d69 100644
> >> > --- a/include/linux/platform_data/gpio-dwapb.h
> >> > +++ b/include/linux/platform_data/gpio-dwapb.h
> >> > @@ -19,7 +19,8 @@ struct dwapb_port_property {
> >> >         unsigned int    idx;
> >> >         unsigned int    ngpio;
> >> >         unsigned int    gpio_base;
> >> > -       unsigned int    irq;
> >> > +       unsigned int    irq[32];
> >> > +       bool            has_irq;
> >> >         bool            irq_shared;
> >> >  };
> >> >
> >> > --
> >> > 2.7.4
> >> >
