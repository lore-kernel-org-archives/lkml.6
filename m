Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeDQLoJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:44:09 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:24723 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752686AbeDQLoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:44:04 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="278458298"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Topic: [PATCH v3] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Index: AQHT0wSYdC3Wj2qtiEG+OZ/tkhpiS6QD1fCAgAEGFIA=
Date: Tue, 17 Apr 2018 11:43:58 +0000
Message-ID: <TY1PR01MB1769AE3A4B1E5EA521DDC867F5B70@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1523609472-4481-1-git-send-email-phil.edworthy@renesas.com>
 <20180416200329.notqjtdztzjrnim7@rob-hp-laptop>
In-Reply-To: <20180416200329.notqjtdztzjrnim7@rob-hp-laptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0411;7:uIml7SAdLCe9BygeH7eOgTVOJfP4N4kD8PwsxLKHbBkFTnTR+SFRQBmSAADnkGFZPKtoPzhqEl+siMiEINFdSJDzoI7TX8fwtc7o39y0Os8PhsRKWSE5yn/6GrbQjUVwWDqVewAyKP/sq1mfdhYsKH1vyYglcXobLcKC+ZrtW+L/7gVBbRdya5PdHRArrVI5i2Coxa7/MkTttbCAutvwCZmg+8bLqJYzWLjxR1aM3b7CfqE0u1BCP4kuxO5NIvd8;20:8KefUvqvnfIYnS6cAV4iNxwP0qmNW7GO4diTU8n29Pcie0+p0WIYECeM2SX11ahFvX1AXLk5kC5fm5+bnFGkfVpfX1QVgpVOIPOdy8CByU6U16CoaYCNH+86EznwahP6MozyMMrglFbwtnFrHVuqbhFZ6VGnDGRrAe9CbQksJCs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0411;
x-ms-traffictypediagnostic: TY1PR01MB0411:
x-microsoft-antispam-prvs: <TY1PR01MB04114C68A867C5CCBD5F34BDF5B70@TY1PR01MB0411.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:TY1PR01MB0411;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0411;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(199004)(189003)(186003)(229853002)(53936002)(486006)(305945005)(76176011)(54906003)(99286004)(316002)(446003)(7736002)(26005)(6506007)(102836004)(53546011)(7696005)(106356001)(14454004)(44832011)(6916009)(86362001)(11346002)(2900100001)(81156014)(81166006)(8676002)(74316002)(3280700002)(7416002)(66066001)(8936002)(2906002)(68736007)(97736004)(5250100002)(5660300001)(3660700001)(476003)(33656002)(105586002)(3846002)(39060400002)(6246003)(25786009)(4326008)(478600001)(6436002)(6116002)(9686003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0411;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rK7DyjPHR+STvXHL8GpuQqOMEJMNNoAMimMWnAQlY3elHqVVVLRnl+n6KS9fPGCapCXnG6/06WaChFbD2VSXQKHOFNOWmwGa/zD764V6ZJREomUFx7O9hOzAvg51e6IuTEqINOGAfWyvGXtL4uxsW/oyO5TqQohVgIfLR55zh6YHRIdLWjeiYjeV9PqXPSoH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ba61611a-43c7-4ee0-8be8-08d5a45881e8
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba61611a-43c7-4ee0-8be8-08d5a45881e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 11:43:58.4652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0411
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HBiEPK008270

Hi Rob,

On 16 April 2018 21:03 Rob Herring wrote:
> On Fri, Apr 13, 2018 at 09:51:12AM +0100, Phil Edworthy wrote:
> > The DesignWare GPIO IP can be configured for either 1 interrupt or 1
> > per GPIO in port A, but the driver currently only supports 1 interrupt.
> > See the DesignWare DW_apb_gpio Databook description of the
> > 'GPIO_INTR_IO' parameter.
> >
> > This change allows the driver to work with up to 32 interrupts, it
> > will get as many interrupts as specified in the DT 'interrupts' property.
> > It doesn't do anything clever with the different interrupts, it just
> > calls the same handler used for single interrupt hardware.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > One point to mention is that I have made it possible for users to have
> > unconncted interrupts by specifying holes in the list of interrupts.
> > This is done by supporting the interrupts-extended DT prop.
> > However, I have no use for this and had to hack some test case for this.
> > Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
> >
> > v3:
> >  - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid
> > bisect problems
> > v2:
> >  - Replaced interrupt-mask DT prop with support for the interrupts-
> extended
> >    prop. This means replacing the call to irq_of_parse_and_map() with calls
> >    to of_irq_parse_one() and irq_create_of_mapping().
> >
> > Note: There are a few *code* lines over 80 chars, but this is just guidance,
> >    right? Especially as there are already some lines over 80 chars.
> > ---
[snip]

> > +			for (j = 0; j < pp->ngpio; j++) {
> > +				if (of_irq_parse_one(np, j, &oirq))
> > +					continue;
> > +
> > +				pp->irq[j] = irq_create_of_mapping(&oirq);
> 
> I'm hoping to not have new users of of_irq_parse_one and
> irq_create_of_mapping. Can you use of_irq_get instead? It will base back
> error codes so you can distinguish different conditions.
Sure, I hadn't noticed that particular variant!

Thanks
Phil

> > +				if (pp->irq[j])
> > +					pp->has_irq = true;
> > +			}
> > +
> > +			if (!pp->has_irq)
> >  				dev_warn(dev, "no irq for port%d\n", pp-
> >idx);
> >  		}
> >
> > -		if (has_acpi_companion(dev) && pp->idx == 0)
> > -			pp->irq =
> platform_get_irq(to_platform_device(dev), 0);
> > +		if (has_acpi_companion(dev) && pp->idx == 0) {
> > +			pp->irq[0] =
> platform_get_irq(to_platform_device(dev), 0);
> > +			if (pp->irq[0])
> > +				pp->has_irq = true;
> > +		}
> >
> >  		pp->irq_shared	= false;
> >  		pp->gpio_base	= -1;
