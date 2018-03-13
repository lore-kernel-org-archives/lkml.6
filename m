Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933517AbeCMQmt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:42:49 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:63955 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752842AbeCMQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:41 -0400
X-IronPort-AV: E=Sophos;i="5.47,465,1515423600";
   d="scan'208";a="275056969"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] gpio: dwapb: Add support for a bus clock
Thread-Topic: [PATCH v2] gpio: dwapb: Add support for a bus clock
Thread-Index: AQHTujBNFru8uMrR90aBczGFMPozw6POXjsAgAAARiA=
Date: Tue, 13 Mar 2018 16:42:35 +0000
Message-ID: <HK2PR0601MB1393163460D31B07FF347D59F5D20@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1520879456-14777-1-git-send-email-phil.edworthy@renesas.com>
 <CAHp75Vfj-=fity+ibx8GDVf+vN7oPAUAzSGVBW=AVeSXhb3_Rw@mail.gmail.com>
In-Reply-To: <CAHp75Vfj-=fity+ibx8GDVf+vN7oPAUAzSGVBW=AVeSXhb3_Rw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR0601MB1329;7:ntCnYh9JEDu34TUUTPlsJcl5XpruriT9/XqvW2juhYS7180kzjRE1cFwb1oB73/37S/Vbq2RH+diizlSJE1/bc6EBI4kbvE/StdkcJ2A0FeLm4aFjZLamb++5yM5Emq3k+o9Lf9juugECbKNw2LknzF+UobTstrG1xaCI9ndjwH0unJxjXSI74BhWW4tThq51d6ALx9tkYUpcP81YBv3u0pVPxr4JvEdiYVUrOzJTffU0yYHcsoxF57CB8xAlhrc;20:9BhUue3gMhrTnpokLxMzSb+vxU3D9js0tH0SJckQn8sRZgiNftGkr8i1hU0jU65DojWy62/apS4cvGfs6eUMlynA8gqozOd82amM2/RoEfhYqGreMaPuCxx2qvNHfnYFpnSJJP9Cq7ZGfgcNgWi6AHFg0hkqoYaL4TO/g3AZI/o=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01cafcb8-6f24-4f84-fa78-08d589016d49
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR0601MB1329;
x-ms-traffictypediagnostic: HK2PR0601MB1329:
x-microsoft-antispam-prvs: <HK2PR0601MB13291AEC74F5709DBCFACDD1F5D20@HK2PR0601MB1329.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR0601MB1329;BCL:0;PCL:0;RULEID:;SRVR:HK2PR0601MB1329;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(189003)(199004)(54906003)(6506007)(9686003)(229853002)(7696005)(14454004)(2950100002)(6116002)(2900100001)(3846002)(186003)(55016002)(6916009)(68736007)(6436002)(478600001)(2906002)(97736004)(105586002)(106356001)(59450400001)(6246003)(316002)(76176011)(3280700002)(53936002)(5250100002)(53546011)(99286004)(102836004)(66066001)(39060400002)(8936002)(3660700001)(25786009)(305945005)(81166006)(74316002)(81156014)(7736002)(8676002)(26005)(4326008)(86362001)(33656002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR0601MB1329;H:HK2PR0601MB1393.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AQohO5f/q/zEcr4LcE5/HM4v8zOeJ/X/uIdCYjai/zmE623cYhdQw4QC1m5tOMrtBSlrk5XiXJoQEIRqD4ekwuLODJZk7t2HSUopauylCKIB2pEUaFhv1CJFqMd6WfKGLGGD7n5hPFsBElK9+R6gWwo7yXvB3MNHE/c4QrtC5isH1bIYrRSWumhR2vzLHI7PcV8EqLdPsevOivBv4W53kVmS3z+ca4HZPoAsMa9bFlncTFQ8Co06AgISuphmwN/VH1Xl5HOjWz9cgW6qpfQpXtmB2Niiajmbidoxrclmr9phDwNFSiPnIhXrv9NoPESshOLT5vGef7oUusqq2KPc6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cafcb8-6f24-4f84-fa78-08d589016d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 16:42:36.3339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1329
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DGj1AR024930

Hi Andy,

On 13 March 2018 16:36, Andy Shevchenko wrote:
> On Mon, Mar 12, 2018 at 8:30 PM, Phil Edworthy
> <phil.edworthy@renesas.com> wrote:
> > Enable an optional bus clock provided by DT.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!
 
> (Assuming it has been tested on clock-less cases)
I hacked together a test where the bus clock for the device I have
is always on, and the clock for this driver is not present in the DTB.
Whilst not ideal, it does test the clock-less case.

Thanks
Phil
 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v2:
> >  - Fix include order.
> >  - Use a clock name.
> >  - Check errors from clk_prepare_enable()
> >  - Add calls to enable/disable the clock in PM
> > ---
> >  drivers/gpio/gpio-dwapb.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> > index b0704a8..226977f 100644
> > --- a/drivers/gpio/gpio-dwapb.c
> > +++ b/drivers/gpio/gpio-dwapb.c
> > @@ -8,8 +8,9 @@
> >   * All enquiries to support@picochip.com
> >   */
> >  #include <linux/acpi.h>
> > -#include <linux/gpio/driver.h>
> > +#include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/gpio/driver.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > @@ -98,6 +99,7 @@ struct dwapb_gpio {
> >         struct irq_domain       *domain;
> >         unsigned int            flags;
> >         struct reset_control    *rst;
> > +       struct clk              *clk;
> >  };
> >
> >  static inline u32 gpio_reg_v2_convert(unsigned int offset) @@ -670,6
> > +672,16 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
> >         if (IS_ERR(gpio->regs))
> >                 return PTR_ERR(gpio->regs);
> >
> > +       /* Optional bus clock */
> > +       gpio->clk = devm_clk_get(&pdev->dev, "bus");
> > +       if (!IS_ERR(gpio->clk)) {
> > +               err = clk_prepare_enable(gpio->clk);
> > +               if (err) {
> > +                       dev_info(&pdev->dev, "Cannot enable clock\n");
> > +                       return err;
> > +               }
> > +       }
> > +
> >         gpio->flags = 0;
> >         if (dev->of_node) {
> >                 const struct of_device_id *of_devid; @@ -712,6 +724,7
> > @@ static int dwapb_gpio_remove(struct platform_device *pdev)
> >         dwapb_gpio_unregister(gpio);
> >         dwapb_irq_teardown(gpio);
> >         reset_control_assert(gpio->rst);
> > +       clk_disable_unprepare(gpio->clk);
> >
> >         return 0;
> >  }
> > @@ -757,6 +770,8 @@ static int dwapb_gpio_suspend(struct device *dev)
> >         }
> >         spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> >
> > +       clk_disable_unprepare(gpio->clk);
> > +
> >         return 0;
> >  }
> >
> > @@ -768,6 +783,9 @@ static int dwapb_gpio_resume(struct device *dev)
> >         unsigned long flags;
> >         int i;
> >
> > +       if (!IS_ERR(gpio->clk))
> > +               clk_prepare_enable(gpio->clk);
> > +
> >         spin_lock_irqsave(&gc->bgpio_lock, flags);
> >         for (i = 0; i < gpio->nr_ports; i++) {
> >                 unsigned int offset;
> > --
> > 2.7.4
> >
> 
> 
> 
> --
> With Best Regards,
> Andy Shevchenko
