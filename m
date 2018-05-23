Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754553AbeEWJSW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:18:22 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:39272 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754395AbeEWJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:18:18 -0400
X-IronPort-AV: E=Sophos;i="5.49,432,1520866800";
   d="scan'208";a="280367652"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Rework support for 1 interrupt per port A
 GPIO
Thread-Topic: [PATCH] gpio: dwapb: Rework support for 1 interrupt per port A
 GPIO
Thread-Index: AQHT8nNx6PyEFcyp+E6A5mI/qUmV+aQ9B2cAgAAAYBA=
Date: Wed, 23 May 2018 09:18:11 +0000
Message-ID: <TY1PR01MB17699E71F8E1460867F1A6FAF56B0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1527065564-9127-1-git-send-email-phil.edworthy@renesas.com>
 <20180523091220.jfguqui75rup5qpl@verge.net.au>
In-Reply-To: <20180523091220.jfguqui75rup5qpl@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1818;7:AvT3+a+RR1NtNiZB+4MQjbZbpyFPnWoxAY6beVQxbZZ2jGIRxJyPDPr6eqeLweUs9fM5mq8uYK78/uTH3QVqHPP08scTkCBpyswYfDE8oqj5TDsPd7Uvd8NaXgFKcefjRQ/UvSG1MHW98nXo9F+kzBnIGQp1/z79ieUNUP1i12Gfo7uAVsGoR7mvpyi+5ebq8/3pRs21XCtv2M6E7ATvRLFI3Sls4B1M9SczjEZzkecgFQA0Z71ZnlPvSlZ9O7N5;20:OxmYHg44aOTse7wJxUTkSmHDe/DeTEWXLMT/ewbhTRBH5Pap7Rygcn6GY/FMs8AVknRJaPjE1WANi2/Il27a5NEJDTeJjX1Vle5XqbQhy5LDIdnap80U06I65+Dbk/Hp7+XPfMCiCxffugeGkPAa327bzWbvN7nY8QCnfYB3pgY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1818;
x-ms-traffictypediagnostic: TY1PR01MB1818:
x-microsoft-antispam-prvs: <TY1PR01MB181875B19342404AAB4605E0F56B0@TY1PR01MB1818.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1818;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1818;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(39380400002)(189003)(199004)(478600001)(25786009)(186003)(229853002)(26005)(53936002)(6506007)(8936002)(68736007)(102836004)(53546011)(3660700001)(8676002)(39060400002)(81156014)(2906002)(81166006)(6916009)(6246003)(7736002)(5660300001)(305945005)(3280700002)(2900100001)(86362001)(66066001)(74316002)(33656002)(97736004)(316002)(99286004)(5250100002)(55016002)(44832011)(486006)(7696005)(11346002)(446003)(6116002)(3846002)(6436002)(76176011)(14454004)(9686003)(106356001)(105586002)(476003)(4326008)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1818;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bP51CIA07X7sr1J3SkZ3mHFcs5xuODdPER4SSSpgC4fiZKX0K+IPxnjSVhY/fI/c/UXDHMr0BdHBqehtXXQYYCDqVZ2/T1WYDy8ZBnxr8NwqDxnPMgIK9HHBC/W7K93yx5WZjNEOULCs5UmHp42KbsgJbMFBpF/4V1Mh1U0x5OBjDRjKgpV7dDlGvm0Fc209
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3ae5d2b9-b788-4757-255c-08d5c08e1b2d
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae5d2b9-b788-4757-255c-08d5c08e1b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 09:18:11.4438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1818
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4N9IR3Y014694

Hi Simon,

On 23 May 2018 10:12 Simon Horman wrote:
> On Wed, May 23, 2018 at 09:52:44AM +0100, Phil Edworthy wrote:
> > Treat DT and ACPI the same as much as possible. Note that we can't use
> > platform_get_irq() to get the DT interrupts as they are in the port
> > sub-node and hence do not have an associated platform device.
> >
> > This also fixes a problem introduced with error checking when calling
> > platform_get_irq().
> 
> What is the problem? In general I think fixes should be in separate patches.
The ACPI code would ignore errors returned by platform_get_irq(), instead
treating the error as an interrupt number.

Andy Shevchenko provided some late feedback to the v5 patch, but v5 was 
already applied by Linus W. This patch just has the incremental changes that
were made in v6 of the patch.

BR
Phil

> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  drivers/gpio/gpio-dwapb.c | 53
> > ++++++++++++++++++++---------------------------
> >  1 file changed, 22 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> > index 7dcd06b..15b4154 100644
> > --- a/drivers/gpio/gpio-dwapb.c
> > +++ b/drivers/gpio/gpio-dwapb.c
> > @@ -444,7 +444,7 @@ static void dwapb_configure_irqs(struct
> dwapb_gpio *gpio,
> >  		int i;
> >
> >  		for (i = 0; i < pp->ngpio; i++) {
> > -			if (pp->irq[i])
> > +			if (pp->irq[i] >= 0)
> >  				irq_set_chained_handler_and_data(pp-
> >irq[i],
> >  						dwapb_irq_handler, gpio);
> >  		}
> > @@ -562,7 +562,7 @@ dwapb_gpio_get_pdata(struct device *dev)
> >  	struct dwapb_platform_data *pdata;
> >  	struct dwapb_port_property *pp;
> >  	int nports;
> > -	int i;
> > +	int i, j;
> >
> >  	nports = device_get_child_node_count(dev);
> >  	if (nports == 0)
> > @@ -580,6 +580,8 @@ dwapb_gpio_get_pdata(struct device *dev)
> >
> >  	i = 0;
> >  	device_for_each_child_node(dev, fwnode)  {
> > +		struct device_node *np = NULL;
> > +
> >  		pp = &pdata->properties[i++];
> >  		pp->fwnode = fwnode;
> >
> > @@ -599,46 +601,35 @@ dwapb_gpio_get_pdata(struct device *dev)
> >  			pp->ngpio = 32;
> >  		}
> >
> > +		pp->irq_shared	= false;
> > +		pp->gpio_base	= -1;
> > +
> >  		/*
> >  		 * Only port A can provide interrupts in all configurations of
> >  		 * the IP.
> >  		 */
> > -		if (dev->of_node && pp->idx == 0 &&
> > -			fwnode_property_read_bool(fwnode,
> > -						  "interrupt-controller")) {
> > -			struct device_node *np = to_of_node(fwnode);
> > -			unsigned int j;
> > -
> > -			/*
> > -			 * The IP has configuration options to allow a single
> > -			 * combined interrupt or one per gpio. If one per
> gpio,
> > -			 * some might not be used.
> > -			 */
> > -			for (j = 0; j < pp->ngpio; j++) {
> > -				int irq = of_irq_get(np, j);
> > -				if (irq < 0)
> > -					continue;
> > -
> > -				pp->irq[j] = irq;
> > -				pp->has_irq = true;
> > -			}
> > +		if (pp->idx != 0)
> > +			continue;
> >
> > -			if (!pp->has_irq)
> > -				dev_warn(dev, "no irq for port%d\n", pp-
> >idx);
> > +		if (dev->of_node && fwnode_property_read_bool(fwnode,
> > +						  "interrupt-controller")) {
> > +			np = to_of_node(fwnode);
> >  		}
> >
> > -		if (has_acpi_companion(dev) && pp->idx == 0) {
> > -			unsigned int j;
> > +		for (j = 0; j < pp->ngpio; j++) {
> > +			pp->irq[j] = -ENXIO;
> >
> > -			for (j = 0; j < pp->ngpio; j++) {
> > +			if (np)
> > +				pp->irq[j] = of_irq_get(np, j);
> > +			else if (has_acpi_companion(dev))
> >  				pp->irq[j] =
> platform_get_irq(to_platform_device(dev), j);
> > -				if (pp->irq[j])
> > -					pp->has_irq = true;
> > -			}
> > +
> > +			if (pp->irq[j] >= 0)
> > +				pp->has_irq = true;
> >  		}
> >
> > -		pp->irq_shared	= false;
> > -		pp->gpio_base	= -1;
> > +		if (!pp->has_irq)
> > +			dev_warn(dev, "no irq for port%d\n", pp->idx);
> >  	}
> >
> >  	return pdata;
> > --
> > 2.7.4
> >
