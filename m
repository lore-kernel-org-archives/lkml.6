Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeBZXEa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:04:30 -0500
Received: from mail-eopbgr40138.outbound.protection.outlook.com ([40.107.4.138]:19536
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751608AbeBZXE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:04:28 -0500
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "digetx@gmail.com" <digetx@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "pgaikwad@nvidia.com" <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: tegra: fix pllu rate configuration
Thread-Topic: [PATCH] clk: tegra: fix pllu rate configuration
Thread-Index: AQHTrDGaop9X/jMI1EKf0deimIdiGKO2pjQAgACtrwA=
Date: Mon, 26 Feb 2018 23:04:24 +0000
Message-ID: <1519686262.6374.3.camel@toradex.com>
References: <20180222230451.15515-1-marcel@ziswiler.com>
         <31f039e8-9afc-22d1-d478-a7f41db0dace@gmail.com>
In-Reply-To: <31f039e8-9afc-22d1-d478-a7f41db0dace@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com;
x-originating-ip: [217.225.191.247]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR05MB340;7:KK2k4RjaswrgEv4HB5zJRUX8NEWXvih9utR/bkEjUFYLIS7QzSMZbnCXUKAqMbut9OylrF6I9uEl4R+48dZ+0FYbPmqkfUdefY78Mb3eU/3EQCbS/TlPb+BUXBvJrBqRp20vMnwUamj/A0/QsyM2aCCtlgMY17yOcRY5v8+HdwDmwGk+jvcptm5y82tQ6WSLUKLm0Lu/jJGyga3dl0G1mtJTgWgflS5Dqxoe/0zXbXwwGj/8ZNM/3k+P8yCSwOBT
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: ff1e0b6a-601b-45a5-b8a9-08d57d6d475f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR05MB340;
x-ms-traffictypediagnostic: AM3PR05MB340:
x-microsoft-antispam-prvs: <AM3PR05MB3400C6DAE042EFE3F533311FBC10@AM3PR05MB340.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR05MB340;BCL:0;PCL:0;RULEID:;SRVR:AM3PR05MB340;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39840400004)(346002)(396003)(366004)(376002)(377424004)(199004)(189003)(105586002)(36756003)(76176011)(97736004)(3280700002)(81156014)(2950100002)(86362001)(99286004)(8936002)(316002)(110136005)(54906003)(6116002)(7416002)(305945005)(3846002)(7736002)(2501003)(5250100002)(81166006)(8676002)(2900100001)(103116003)(25786009)(106356001)(2906002)(5660300001)(229853002)(102836004)(66066001)(6436002)(4326008)(53936002)(3660700001)(6486002)(6306002)(14454004)(53546011)(26005)(186003)(39060400002)(6512007)(6246003)(478600001)(68736007)(6506007)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR05MB340;H:AM3PR05MB1364.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: s2Lljl+QccjJox9EfGHP267snBkQSg1d+uvue+UkRDtW5HuEiA45NFVu6NPczrW9qBrFBo1ZHGwjP4i/n8gdT8UOI6Fm2SWG77rnhxXy1ZGICmqiy2941np09TiwCetm80SnxORSbnHkMVcSDX6MlaQJ736UtPArcfSCkQk6+q8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <56997F7CFF17FB46BF45C41DA7DCC7B6@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1e0b6a-601b-45a5-b8a9-08d57d6d475f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 23:04:24.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR05MB340
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QN4cNr007419

On Mon, 2018-02-26 at 15:42 +0300, Dmitry Osipenko wrote:
> On 23.02.2018 02:04, Marcel Ziswiler wrote:
> > Turns out latest upstream U-Boot does not configure/enable pllu
> > which
> > leaves it at some default rate of 500 kHz:
> > 
> > root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep
> > pll_u
> >        pll_u                  3        3        0      500000      
> >     0
> > 
> > Of course this won't quite work leading to the following messages:
> > 
> > [    6.559593] usb 2-1: new full-speed USB device number 2 using
> > tegra-
> > ehci
> > [   11.759173] usb 2-1: device descriptor read/64, error -110
> > [   27.119453] usb 2-1: device descriptor read/64, error -110
> > [   27.389217] usb 2-1: new full-speed USB device number 3 using
> > tegra-
> > ehci
> > [   32.559454] usb 2-1: device descriptor read/64, error -110
> > [   47.929777] usb 2-1: device descriptor read/64, error -110
> > [   48.049658] usb usb2-port1: attempt power cycle
> > [   48.759475] usb 2-1: new full-speed USB device number 4 using
> > tegra-
> > ehci
> > [   59.349457] usb 2-1: device not accepting address 4, error -110
> > [   59.509449] usb 2-1: new full-speed USB device number 5 using
> > tegra-
> > ehci
> > [   70.069457] usb 2-1: device not accepting address 5, error -110
> > [   70.079721] usb usb2-port1: unable to enumerate USB device
> > 
> > Fix this by actually allowing the rate also being set from within
> > the Linux kernel.
> > 
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > ---
> > 
> >  drivers/clk/tegra/clk-pll.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-
> > pll.c
> > index 7c369e21c91c..830d1c87fa7c 100644
> > --- a/drivers/clk/tegra/clk-pll.c
> > +++ b/drivers/clk/tegra/clk-pll.c
> > @@ -1151,6 +1151,8 @@ static const struct clk_ops
> > tegra_clk_pllu_ops = {
> >  	.enable = clk_pllu_enable,
> >  	.disable = clk_pll_disable,
> >  	.recalc_rate = clk_pll_recalc_rate,
> > +	.round_rate = clk_pll_round_rate,
> > +	.set_rate = clk_pll_set_rate,
> >  };
> >  
> >  static int _pll_fixed_mdiv(struct tegra_clk_pll_params
> > *pll_params,
> > 
> 
> Tegra's USB PHY driver only enables clock and clk driver doesn't
> specify the
> clock rate in the init table. Could you please clarify where in the
> kernels code
> PLL_U rate is getting set?

I guess that would be according to the following table isn't it:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
/drivers/clk/tegra/clk-tegra30.c?h=v4.16-rc3#n287
