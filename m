Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeCTTaK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:30:10 -0400
Received: from mail-sn1nam02on0045.outbound.protection.outlook.com ([104.47.36.45]:51040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751320AbeCTTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:30:05 -0400
From: Jolly Shah <JOLLYS@xilinx.com>
To: Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>
CC: Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        "Shubhrajyoti Datta" <shubhraj@xilinx.com>
Subject: RE: [PATCH 1/3] drivers: clk: Add clk_get_children support
Thread-Topic: [PATCH 1/3] drivers: clk: Add clk_get_children support
Thread-Index: AQHTsONyVq38uAIpZESNAQVezIs9BKPX/IqAgAGlB4A=
Date: Tue, 20 Mar 2018 19:29:58 +0000
Message-ID: <DM2PR0201MB07679A2DF21F254ACD5E0417B8AB0@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-2-git-send-email-jollys@xilinx.com>
 <152148371542.242365.18433130635050412528@swboyd.mtv.corp.google.com>
In-Reply-To: <152148371542.242365.18433130635050412528@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0974;7:LGuQ/c+0bhCsXo1qFeKOVacpAVhI/AQmqio4mA4jMD1TavwrusMFXcmtFAnFkCOHooVyomkROvQAsoEAts8alsxvi+WfgRYWDoEGc9EHtbtROoAokzurA6Q/Lvtr3jhYwH+39cIxtaUl4VEuG/pwDgwwKbbiIuQn9BtZZt5iCVNgtfx72VDTIBRN7At53g/zNsREort3RTcKZWzXQJR0E6+lPmXoZcEzHIlb19WuqbIYdUZiCy8Ov6lzG/xVKc8B
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39380400002)(376002)(39860400002)(377424004)(189003)(199004)(13464003)(6506007)(25786009)(9686003)(55016002)(26005)(105586002)(53936002)(110136005)(316002)(54906003)(478600001)(3846002)(6246003)(2501003)(8936002)(6116002)(8676002)(76176011)(4326008)(53546011)(81166006)(81156014)(14454004)(7696005)(5250100002)(106356001)(99286004)(102836004)(186003)(2950100002)(33656002)(86362001)(7736002)(2906002)(107886003)(305945005)(229853002)(97736004)(68736007)(66066001)(72206003)(3280700002)(3660700001)(2201001)(6436002)(2900100001)(74316002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0974;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c0a5155-2916-4cf6-9cb9-08d58e98f7d1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0974;
x-ms-traffictypediagnostic: DM2PR0201MB0974:
x-microsoft-antispam-prvs: <DM2PR0201MB09741D98A260E381957F60FFB8AB0@DM2PR0201MB0974.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501314)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR0201MB0974;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0974;
x-forefront-prvs: 061725F016
x-microsoft-antispam-message-info: I90vbnyw8ybjhAJ5Smuy+l5vlUId8EajepaRRBOgZpsZkGgdVJWQjgu6fNwarpCOMY/3XubQYFlO/tlfllqO5249RAzMJLeourDF7WRKDUjV9a7lzMEvD/E40n8wkVMNdEn5PaxUkYkyJOm2juLOCLlQiMvmitlt03+Y3d+1vxAkGHYBbfUmdfjmRYspB8sFm0UOHIKCP2YVrs3EPUdqFC/sZB7l0/HMxHyOFGXz0T3SIKkAjFIJFn17zHkAtzxFzU9AFjkzH7oa+t/I1VbTFwhcQq8Z9VNIl17z/26GrIB65Tlh2yjRvW8+/72ianWuUdkO3xjzYwdm3OzqrCtkBA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0a5155-2916-4cf6-9cb9-08d58e98f7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 19:29:58.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0974
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KJUFw7025099

Hi Stephan,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Monday, March 19, 2018 11:22 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; linux-clk@vger.kernel.org;
> mark.rutland@arm.com; michal.simek@xilinx.com; mturquette@baylibre.com;
> robh+dt@kernel.org; sboyd@codeaurora.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Tejas Patel
> <TEJASP@xilinx.com>; Shubhrajyoti Datta <shubhraj@xilinx.com>
> Subject: Re: [PATCH 1/3] drivers: clk: Add clk_get_children support
> 
> Quoting Jolly Shah (2018-02-28 14:27:39)
> > From: Jolly Shah <jolly.shah@xilinx.com>
> >
> > This API helps to determine the users for any clock.
> 
> Ok, but why do you need it?

As you suggested in other patch, we will move children validation in FW.

> 
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Tejas Patel <tejasp@xilinx.com>
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  drivers/clk/clk.c            | 28 ++++++++++++++++++++++++++++
> >  include/linux/clk-provider.h |  1 +
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c index
> > 0f686a9..947a18b 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -274,6 +274,34 @@ struct clk_hw *clk_hw_get_parent(const struct
> > clk_hw *hw)  }  EXPORT_SYMBOL_GPL(clk_hw_get_parent);
> >
> > +static unsigned int sibling;
> 
> Looks very thread unsafe!
> 
> > +
> > +static void clk_show_subtree(struct clk_core *c,
> > +                            int level) {
> > +       struct clk_core *child;
> > +
> > +       if (!c)
> > +               return;
> > +
> > +       if (level == 1)
> > +               sibling++;
> > +
> > +       hlist_for_each_entry(child, &c->children, child_node)
> > +               clk_show_subtree(child, level + 1); }
> > +
> > +unsigned int clk_get_children(char *name) {
> > +       struct clk_core *core;
> > +       struct clk *pclk = __clk_lookup(name);
> > +
> > +       sibling = 0;
> > +       core = pclk->core;
> > +       clk_show_subtree(core, 0);
> > +       return sibling;
> > +}
> > +
> >  static struct clk_core *__clk_lookup_subtree(const char *name,
> >                                              struct clk_core *core)  {
> > diff --git a/include/linux/clk-provider.h
> > b/include/linux/clk-provider.h index f711be6..e94dfb2 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -745,6 +745,7 @@ unsigned int __clk_get_enable_count(struct clk
> > *clk);  unsigned long clk_hw_get_rate(const struct clk_hw *hw);
> > unsigned long __clk_get_flags(struct clk *clk);  unsigned long
> > clk_hw_get_flags(const struct clk_hw *hw);
> > +unsigned int clk_get_children(char *name);
> 
> And uses a string lookup instead of having the clk_hw pointer in hand.
> No thanks.
