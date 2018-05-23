Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754496AbeEWIqL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:46:11 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:52274 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754323AbeEWIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:46:03 -0400
X-IronPort-AV: E=Sophos;i="5.49,432,1520866800";
   d="scan'208";a="281819870"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, "Lee Jones" <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Topic: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Thread-Index: AQHT6QKCgVHb0wgsvk2c+rOrISBqoqQ9DkUAgAAENUA=
Date: Wed, 23 May 2018 08:45:57 +0000
Message-ID: <TY1PR01MB17696814810E9F9DA4C79989F56B0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
 <CACRpkdZAdhAn97iWPsym_K+A8iVwa3tRacpeEu=J6C=b+xAO6g@mail.gmail.com>
In-Reply-To: <CACRpkdZAdhAn97iWPsym_K+A8iVwa3tRacpeEu=J6C=b+xAO6g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0649;7:Fe2AVHwYHw62mm4U9JSwRHFLLzctdHT2AC/OKjqdy2GiNghBDiXebBwau14QBdOhReqPq/kiA2wyTbq8Lu8YRihIDufsv66aivb7TDIIEu7dFxDMAe//qRXrjbeQOfaXi3bz/eXbrK1r5tBu0XleKGCbAAjIKDILhCxq7iKFOjVbpnQgiqDvn3du3Yy0I27lum4eFWPl67jAj/VvbUizrsoeP6+Y/YzN/PBKiXx8LV+QnJfsIqlPeToV/jQjcmbi;20:0yV5rETfhNz0ZJeEFwAIcKe0ofui8OjMoXPtJ74sVKOqqCYDjCVMZIr06p+HLuHevGx0IkgRCTY/8Oie7VPvww+1Fhf7adaQOuAWDKQXoKd5v9DzHX96WwH+78OR6qIB0Q2WCdlCGr5+xruMyQu7OFtR4v802D0zSoZ065oUtKg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0649;
x-ms-traffictypediagnostic: TY1PR01MB0649:
x-microsoft-antispam-prvs: <TY1PR01MB0649C9B33592365D2EC76DB9F56B0@TY1PR01MB0649.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0649;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0649;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(39380400002)(189003)(199004)(446003)(25786009)(4326008)(476003)(3660700001)(54906003)(6246003)(11346002)(3280700002)(7736002)(229853002)(53936002)(14454004)(7416002)(6436002)(68736007)(44832011)(66066001)(86362001)(9686003)(478600001)(966005)(106356001)(105586002)(76176011)(99286004)(8676002)(97736004)(53546011)(2906002)(33656002)(6306002)(2900100001)(5250100002)(55016002)(5660300001)(39060400002)(7696005)(6506007)(486006)(8936002)(6916009)(305945005)(81156014)(74316002)(186003)(102836004)(26005)(316002)(81166006)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0649;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: V0YdiRkEMtenVZaLQgT7dKAtq63hvYzxrWFdfj9TIYFLNyZUrNPxHzJksrvzgCpGoZ+EuC/WlRF6RlduxXhqpmD0phYOasG8XF0b1WEAIrZA91Z5ITXrZOZWZLfnmwhUy8mxTpK0WjKC1YOcXjPQYxXSoVclP6Ray2OogQETODyp4zcYsxFznVCWa3yqMswo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6f3f117f-cda1-4a7c-aefd-08d5c0899a7b
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3f117f-cda1-4a7c-aefd-08d5c0899a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 08:45:57.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0649
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4N8kGw4011029

Hi Linus,

On 23 May 2018 09:29, Linus Walleij wrote:
> On Fri, May 11, 2018 at 10:31 AM, Phil Edworthy wrote:
> 
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
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > One point to mention is that I have made it possible for users to have
> > unconnected interrupts by specifying holes in the list of interrupts.
> > This is done by supporting the interrupts-extended DT prop.
> > However, I have no use for this and had to hack some test case for this.
> > Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
> >
> > v6:
> >  - Treat DT and ACPI the same as much as possible. Note that we can't use
> >    platform_get_irq() to get the DT interrupts as they are in the port
> >    sub-node and hence do not have an associated platform device.
> 
> I already applied this patch in some version, can you check what is in my
> devel branch and send incremental patches on top if something needs
> changing?
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-
> gpio.git/commit/?h=devel&id=e6ca26abd37606ba4864f20c85d3fe4a2173b93f
> 
> Sorry for not knowing by heart what was applied or when, it's just too much
> for me sometimes.
No problem, I'll send a patch with the incremental changes.

Thanks
Phil
