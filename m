Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030419AbeE3IUM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:20:12 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:7606 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935879AbeE3IUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:20:01 -0400
X-IronPort-AV: E=Sophos;i="5.49,459,1520866800";
   d="scan'208";a="282505582"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Juri Lelli <juri.lelli@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@endlessm.com>, Kevin Hilman <khilman@baylibre.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Topic: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Index: AQHT80rtXOJcR0J+202tfDBsf6Vuk6RANLCAgAe9YLA=
Date: Wed, 30 May 2018 08:19:54 +0000
Message-ID: <OSBPR01MB20546AE06422C9AD896F8F60D26C0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1527157834-7747-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527157834-7747-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWv2ZRbX=k5+H_WfAeoQ4QsyQLU9iQ9TJ9OQ0fmwg0GOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWv2ZRbX=k5+H_WfAeoQ4QsyQLU9iQ9TJ9OQ0fmwg0GOQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1608;7:DYTCNDZuEsgA9NDE+/XODnZsI2A7Ak1H5uzneYy5oxkw5Cstcej8GW2SS/lLcRKg+P9Wa6UnbQPaE580yTbQNyPSWL21L0ohpuhEjn90YykYDMHlzZYuIkLqP1yGpFq/wjjXuaOWJN7iB/kcvv8+Rbk/a2s5rKbqObAj73TPigOVI6F029SIumDogheRFfYEgtqR96bWSFhCYz0hcM/vfujK8NhCgAufDIHPmWdTqEeqTT3SavNyqUvuG3VYUKFH;20:a/w9lbKsHWvqLd8AEZ/LWdMAyoVQ4Qf9rPTHTSEG5Te6u8KobUZEpbNEBt0oOqXS1xqOlgjlntLWes2QzKzCEV4W136xD8OgBQmBDULpLIbHs0X/IiSAy4IwxXk4+wbBvaS/K3X2rQQmHUyfx0bFYiseCrZnVbUCeAAj/k4HBMo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1608;
x-ms-traffictypediagnostic: OSBPR01MB1608:
x-microsoft-antispam-prvs: <OSBPR01MB1608F583971AD20317576209D26C0@OSBPR01MB1608.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB1608;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1608;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(305945005)(476003)(186003)(74316002)(81166006)(44832011)(53936002)(478600001)(3660700001)(66066001)(486006)(81156014)(33656002)(99286004)(3280700002)(229853002)(8936002)(9686003)(6116002)(3846002)(2906002)(54906003)(25786009)(39060400002)(53546011)(26005)(8676002)(7416002)(14454004)(6506007)(5250100002)(6916009)(4326008)(102836004)(8656006)(6246003)(6436002)(446003)(76176011)(7696005)(68736007)(97736004)(86362001)(55016002)(106356001)(105586002)(5660300001)(2900100001)(316002)(7736002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1608;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: 3YG5tpqPAT2dVChwyPtADT9SMQuWUrGie9QET+bPcPrYH8y015LGMXskjoOH5cFW2Z3G9EBafrlvNg7mb7a18nz6bPzvjERcRsdN3UcaYFN+Zv+zGyPuaA89clV5fxTrDwGrKIvoPiwZRhcRYvOnj2SBlO30cdIDE/4COTApLDH63dD5K/LtHFVyzh2jdfKr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f67502e1-6589-4cbe-a5c0-08d5c6062009
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67502e1-6589-4cbe-a5c0-08d5c6062009
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 08:19:54.9274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1608
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4U8L1xl031989


On 25 May 2018 10:49, Geert wrote:
> Subject: Re: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
> driver
>
> Hi Michel,

Hi Geert,

>
> On Thu, May 24, 2018 at 12:30 PM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
> > it requires a special enable method to get it started.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>
> Thanks for your patch!
>
> >  arch/arm/mach-shmobile/smp-r9a06g032.c | 85
> > ++++++++++++++++++++++++++++++++++
>
> I think you can safely call this driver smp-rzn1d.c, or smp-rzn1.c.
> Source files are not covered by the stable DT ABI, and can be reordered later
> at will.
>
> I expect you will just add more CPU_METHOD_OF_DECLARE() lines later
> (perhaps with a little bit of extra code to handle deviations).

Now I am completely confused -- you had me remove the mention of rzn1
from everywhere it mattered to handle 'family' cases, and now you are
telling me that in *this* case where there is not a single chance of that file
covering another part and there's a clear cut case for it to be part specific
.... I should call it rzn1?!?

I even already renamed the symbols on my tree to match the
rest for v4...

I'd like consistency -- I *thought* I had a consistent naming scheme before,
now I've moved to your part specific one (under duress), I'd rather stick to
something that is consistent and keep everything as r9a06g032 now.

>
> > --- /dev/null
> > +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
> > @@ -0,0 +1,85 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RZ/N1D Second CA7 enabler.
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * Michel Pollet <michel.pollet@bp.renesas.com>,
> <buserror@gmail.com>
> > + * Derived from action,s500-smp
> > + */
> > +
> > +#include <linux/delay.h>
>
> Do you need this?

Fixed all the other remarks, thanks for that!

Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
