Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934898AbeEIMLg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:11:36 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:16719 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751052AbeEIMLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:11:32 -0400
X-IronPort-AV: E=Sophos;i="5.49,381,1520866800";
   d="scan'208";a="280493952"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Topic: [PATCH v5] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Index: AQHT3XprffTv2V71Pkmyg2B+GHC2ZqQhAmOAgAZaEbA=
Date: Wed, 9 May 2018 12:11:27 +0000
Message-ID: <TY1PR01MB1769D461E888BA9F9537678EF5990@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1524759587-7007-1-git-send-email-phil.edworthy@renesas.com>
 <CAHp75Vc3qBOYjUAgxZCkpXAdg=ueM2KApPynPdpkEmOoMR7sQQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc3qBOYjUAgxZCkpXAdg=ueM2KApPynPdpkEmOoMR7sQQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1595;7:NcP0Wslgx4bMwZqlpoc0f2xx4MKjTjPIP24u/zxf4jMKOggZVHJ7lIaEm+IvRLQvpFXAL51uwxEYp4ui8VqLpxp6MAQA9QclLkfQ+ixwLxg4zyd9+PSbhJOxRRB9vI2od7Exvwi9DLN6j1ZYmrQplwksBqi3joCJZRXmfHn1TsI4yiin8WYbZUUdOvUh+/LgMI4OBfy+jL7BFRGWIFva+/hHA8SgTlOl7H7ocF2gcHyxcjyoPEpHbvnDYPwgEAUv;20:AuVj5Zxa201VzaK8WEKnYjuV+DOFkzGxxUsnrmyXt3zld3P0cvHMKyONNr1LZ+NoN6NkgImsPjURDXXZuUeGySEc2cya0GJwd3cxIQzRbJhySld3AvD3EipqVAK1Y/9V+VBduWIYy2VmL9E5Ls6OsybixcQSIH6EGjHinqkw8vY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1595;
x-ms-traffictypediagnostic: TY1PR01MB1595:
x-microsoft-antispam-prvs: <TY1PR01MB15950811FB75AE4F6BC4436BF5990@TY1PR01MB1595.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR01MB1595;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1595;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(376002)(346002)(189003)(199004)(33656002)(68736007)(5660300001)(66066001)(76176011)(478600001)(97736004)(53936002)(6246003)(7736002)(4326008)(7416002)(54906003)(316002)(99286004)(105586002)(86362001)(7696005)(8936002)(55016002)(39060400002)(14454004)(9686003)(106356001)(305945005)(561944003)(5250100002)(6916009)(2906002)(229853002)(3846002)(3660700001)(74316002)(44832011)(25786009)(476003)(6116002)(53546011)(3280700002)(102836004)(81156014)(186003)(81166006)(8676002)(59450400001)(11346002)(6436002)(6506007)(486006)(26005)(2900100001)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1595;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Vw5HVqB90+KI4LyIy8ywHTw3pg96ywaUCgYslPwnR7opFAO27hQDWVw4LMw3dQd87puUEizztLij5RuWP7VhA+PmMAYH84eOKiiAjPS/yDVnQJQw56w11Q1+LnU4E/LJYXTV0pgIWRe5qPgjEjE7M9UzF6n2sw7wtv4YKIHkOCSBsYcAnjlHAaP3Nil/jD0r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8f27fddc-bb37-4d31-dab7-08d5b5a5fe34
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f27fddc-bb37-4d31-dab7-08d5b5a5fe34
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 12:11:27.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1595
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49CBhE3004228

Hi Andy,

On 05 May 2018 11:49 Andy Shevchenko wrote:
> On Thu, Apr 26, 2018 at 7:19 PM, Phil Edworthy wrote:
> 
> Sotty fo a late response. Consider follow up fixes for below.
> 
> >         if (!pp->irq_shared) {
> > +               int i;
> > +
> > +               for (i = 0; i < pp->ngpio; i++) {
> > +                       if (pp->irq[i])
> > +                               irq_set_chained_handler_and_data(pp->irq[i],
> > +                                               dwapb_irq_handler, gpio);
> > +               }
> >         } else {
> >                 /*
> >                  * Request a shared IRQ since where MFD would have devices
> >                  * using the same irq pin
> >                  */
> > +               err = devm_request_irq(gpio->dev, pp->irq[0],
> >                                        dwapb_irq_handler_mfd,
> >                                        IRQF_SHARED, "gpio-dwapb-mfd",
> > gpio);
> 
> > +       if (pp->has_irq)
> >                 dwapb_configure_irqs(gpio, port, pp);
> 
> I would rather make irq array a type of signed int and move conditional into
> the function to test per IRQ based.
Ok, though since the driver can be used without interrupts, it has to check
if any are used before the driver does all the other interrupt related things.
 
> >         /* Add GPIO-signaled ACPI event support */
> > +       if (pp->has_irq)
> >                 acpi_gpiochip_request_interrupts(&port->gc);
> 
> Perhaps something similar.
> 
> >                 if (dev->of_node && pp->idx == 0 &&
> >                         fwnode_property_read_bool(fwnode,
> >
> > "interrupt-controller")) {
> 
> > +                       struct device_node *np = to_of_node(fwnode);
> > +                       unsigned int j;
> > +
> > +                       /*
> > +                        * The IP has configuration options to allow a single
> > +                        * combined interrupt or one per gpio. If one per gpio,
> > +                        * some might not be used.
> > +                        */
> > +                       for (j = 0; j < pp->ngpio; j++) {
> > +                               int irq = of_irq_get(np, j);
> > +                               if (irq < 0)
> > +                                       continue;
> > +
> > +                               pp->irq[j] = irq;
> > +                               pp->has_irq = true;
> > +                       }
> 
> for (...)
>  pp->irq = of_irq_get();
> 
> >                 }
> 
> > +               if (has_acpi_companion(dev) && pp->idx == 0) {
> > +                       unsigned int j;
> > +
> > +                       for (j = 0; j < pp->ngpio; j++) {
> > +                               pp->irq[j] = platform_get_irq(to_platform_device(dev), j);
> > +                               if (pp->irq[j])
> > +                                       pp->has_irq = true;
> > +                       }
> 
> Ditto.
> Moreover you have a bug here. See my proposal at the top of this message.
I guess you mean that it doesn’t check for errors returned?

> And now even better to ask, why platform_get_irq() wouldn't work for DT
> case?
The problem is that the interrupts are defined in the port sub-node in DT,
not in the gpio controller node, causing platform_get_irq() to fail. The
port sub-node doesn’t have an associated platform device. I don’t think
there is a way around this...

> > +
> > +                       if (!pp->has_irq)
> >                                 dev_warn(dev, "no irq for port%d\n",
> > pp->idx);
> 
> This could be issued in the actual function which will try to allocate IRQs
> (perhaps on debug level)
> 
> 
> P.S. Just think about it, perhaps you find even better solutions.
There's certainly some duplication between DT and ACPI that can be removed.

Thanks
Phil
