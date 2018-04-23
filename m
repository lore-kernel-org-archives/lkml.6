Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeDWWFz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:05:55 -0400
Received: from mail-eopbgr00108.outbound.protection.outlook.com ([40.107.0.108]:1990
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932416AbeDWWFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:05:51 -0400
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "marvin24@gmx.de" <marvin24@gmx.de>,
        "digetx@gmail.com" <digetx@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Thread-Topic: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Thread-Index: AQHTqZQpuMUJhpgZG02Zgpan0LEyW6QJtogAgAAhBACABXO1AA==
Date: Mon, 23 Apr 2018 22:05:44 +0000
Message-ID: <1524521136.4493.70.camel@toradex.com>
References: <20180219151252.29289-1-marcel@ziswiler.com>
         <6600596.BijQW1iq1K@ax5200p>
         <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
In-Reply-To: <4f2ac009-8618-4b4d-e137-a5fd4907a56f@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com;
x-originating-ip: [84.227.20.26]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0501MB2108;7:GmMhs9sf6d4HZm4mHoAqlPFTO3apR4N2Z0MvBmRrrS1SGJJnPbHi+jXyFZZnlpCgB0o3k/aGrPdesAnDkJcbdBV5nZRJHp+WxumCfsSkMEZt2BEUqIIRoWrtihpcEzm0MDZ2lZJnckpCBFWR5NG/q2ixoybXUjK5Ykfo9Nr29l3fVJn93PHTzCyJUOc/TAw+Kcv/Bktb9EGYH7jYEp/kDxngnQEjbUqq4g5tuQ+ajeloBh1MbYraD1/WUqxfNhEQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2108;
x-ms-traffictypediagnostic: HE1PR0501MB2108:
x-microsoft-antispam-prvs: <HE1PR0501MB2108B1A6F2A263B5D044F5F8FB890@HE1PR0501MB2108.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0501MB2108;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2108;
x-forefront-prvs: 06515DA04B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39840400004)(346002)(376002)(377424004)(86362001)(575784001)(3846002)(6116002)(66066001)(5250100002)(6436002)(99286004)(7416002)(8666007)(5660300001)(103116003)(8676002)(39060400002)(81166006)(8936002)(6486002)(4326008)(6512007)(478600001)(2616005)(44832011)(446003)(11346002)(229853002)(2900100001)(476003)(7736002)(110136005)(305945005)(25786009)(6506007)(26005)(102836004)(3660700001)(59450400001)(186003)(316002)(36756003)(54906003)(14454004)(53936002)(6246003)(3280700002)(2501003)(2906002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0501MB2108;H:HE1PR0501MB2330.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: fCbj6/1AY5kR88+YqmvYr+WfTIIQ+hLIhsY48/dlZlcjFYfiq2Y5I4mxWHLzQkUxTB6JefUDkXqkKJyv09FSmYpgKT3jlNODGQKfFVN+NkQ+zlGqxiL3vMnZNPGuFjSRPlJzQEWPdHRq7kUhyQZ233QbxEJKlABE8kc6J+OjpNfnSTlrhpnuidwdHUnWp4ba
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F44244DA3365E842AB0BCD2F93B6A28F@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c8f38fcc-b527-4922-3a2e-08d5a9665ccc
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f38fcc-b527-4922-3a2e-08d5a9665ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2018 22:05:44.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3NM626W012563

Hi Dmitry

On Fri, 2018-04-20 at 13:50 +0300, Dmitry Osipenko wrote:
> ...
> I managed to find CDEV clocks in TRM this time.

And where exactly in which TRM? In all my attempts at finding anything
CDEV2 is just a pad group which includes the DAP_MCLK2 pad in question.

> Seems assigning CDEV2 clock to
> "ulpi-link" was correct

Sorry, but I do really not see how you can get to any such conclusion.

Whatever that CDEV2 clock exactly is. Its offset 93 points towards the
CLK_RST_CONTROLLER_CLK_OUT_ENB_U_0 register which has CLK_ENB_DEV2_OUT
at bit position 29 reading "Enable clock to DEV2 pad". While the TRM
misses further documenting what exactly that DEV2 pad should be I guess
it may point towards our suspected DAP_MCLK2. So for some reason
besides PLL_P_OUT4 which is what that pad is actually muxed to also
some additional DEV2 pad clock needs enabling. In addition there would
be a CLK_RST_CONTROLLER_MISC_CLK_ENB_0 register where one could also
specify a DEV2_OSC_DIV_SEL but I would assume that one only applies if
the pad in question being muxed to OSC which is not the case at least
in all device trees I have looked at.

> and both CDEV2 and PLL_P_OUT4 should be enabled,

Agreed, basically the DAP_MCLK2 pad seems gated by an additional enable
called CLK_ENB_DEV2_OUT.

> CDEV2
> should gate the PLL_P_OUT4 that feeds USB HW and PLL_P_OUT4 should be
> always-enabled because it is enabled by init_table, but apparently it
> is getting
> disabled erroneously.

At least that was the case back when I had trouble getting ULPI to work
on T20. Strangely latest -next right now does no longer seem to suffer
from that same issue even if my patch is reverted but as mentioned
before nobody stops the required PLL_P_OUT4 which is what is actually
driving DAP_MCLK2 to not be changed behind the scenes breaking the
whole thing again.

> Marcel, could you please revert your patch, add
> "trace_event=clk_enable,clk_disable,clk_set_parent tp_printk" to
> kernels cmdline
> and post the log?

Yes, the only difference in those traces is whether or not that non-
existent CDEV2 clock is enabled or not:

[    1.897521] clk_enable: cdev2_fixed
[    1.901008] clk_enable: cdev2

I also do have an explanation why it kept working in my case. Probably
the boot ROM or U-Boot is already setting that bit.

> It looks like there is some clk framework bug,

My conclusion is that there should be a DAP_MCLK2 clock which is gated
by that CLK_ENB_DEV2_OUT but really outputs a T20 internal clock
according to its pin muxing which if set to OSC may be further divided
down by DEV2_OSC_DIV_SEL.

> but just in case please also try
> to apply this patch:
> 
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c
> b/drivers/clk/tegra/clk-tegra-periph.c
> index 2acba2986bc6..407bd0c0ac2f 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -1024,7 +1024,7 @@ static void __init init_pllp(void __iomem
> *clk_base, void
> __iomem *pmc_base,
>                 if (dt_clk) {
>                         clk =
> tegra_clk_register_pll_out("pll_p_out4",
>                                         "pll_p_out4_div", clk_base +
> PLLP_OUTB,
> -                                       17, 16, CLK_IGNORE_UNUSED |
> +                                       17, 16, CLK_IS_CRITICAL |
>                                         CLK_SET_RATE_PARENT, 0,
>                                         &PLLP_OUTB_lock);
>                         *dt_clk = clk;

I did not have to do any such but maybe that would at least prevent any
further issues on PLL_P_OUT4. However I still believe this is kind of
wrong as PLL_P_OUT4 is what drives DAP_MCLK2 in its current muxing
which is connected to the ULPI transceivers REFCLK pin.

BTW: That pin is usually to be driven at 24 MHz and not 26 MHz which
CDEV2 claims to be at.

What do you think?

Cheers

Marcel
