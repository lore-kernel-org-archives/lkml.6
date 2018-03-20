Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeCTDV1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:21:27 -0400
Received: from mail-he1eur01on0089.outbound.protection.outlook.com ([104.47.0.89]:40989
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750991AbeCTDVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:21:22 -0400
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "aisheng.dong@codeaurora.org" <aisheng.dong@codeaurora.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>
Subject: RE: [RFC PATCH 1/2] clk: add new APIs to operate on all available
 clocks
Thread-Topic: [RFC PATCH 1/2] clk: add new APIs to operate on all available
 clocks
Thread-Index: AQHTlEjVfbmTWuCMEk2g+D43aXKTP6PYFFOAgACyqaA=
Date: Tue, 20 Mar 2018 03:21:17 +0000
Message-ID: <AM3PR04MB306226CE9E4AD6F1F2383F180AB0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1516711841-25234-1-git-send-email-aisheng.dong@nxp.com>
 <1516711841-25234-2-git-send-email-aisheng.dong@nxp.com>
 <152147653725.242365.16805388526685631797@swboyd.mtv.corp.google.com>
In-Reply-To: <152147653725.242365.16805388526685631797@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0725;6:YI+yccFmz5tzFuJSDZzgMFzOd6bdz8nFoNVg6dx0nbDqXr/YJrG1Vn58O7hBe4FbCIyDlUjSDe2fn5xAaZXrVdruy6eNw6G8mL3uE5btOowX66xNN0TFhoHnTeHsC4Jcnbk6XzxRBaZqLMDms3Nw53SFBlq8Mg0OpVEvZjLl8gRV8MlzvOI1ZGZFTxpk9dC+PEph7TQ/zQLUEWqm3pEtKFLK0bh+uOBuqDPpHZ+wWis9HGene6UL2UeB2F4ZKz9M2H32RnuK8NvF4AZXmcNNcw2pu9XGXcNXwkBAG9xN3H7BNSS9vf6Ibp51TkZGdUbPgsPJiGkZWLf18wq59ge/Josgrcdh7z2dGPcDox5xkabBF95a58+YQmYiGVMMvU6/;5:pAda7LMJqTv+eAvDacnJkvXWxH7rf39OWcmaNRV3oUzkjdQPf2Vz1UCh0AUO9mkRoyGElo02/FiqBRKgFAHmyrw8V/6v8LRG3hQCzsSkr8Ley41aSS3eDFcdx1xwQT0gZCMnDtOxet7wX4zFVfJMs55288pTNqhZl36eBclEw+k=;24:eKb8szG1LjzyDhhyINtsEFDz8Uhwoy6cZu82INIY//FQY6+1rENDPH6gNdpBv6bz9h5iV3KReJS2IPYAzt6Q3GWNAhNvh9zXgdxU/EmYTJk=;7:sjmcPEIiF62YMkDpZZd7RVmmSvSmC3SQit3G1PtaKvZqdiRpyZVVQxCsf7xJXeiRsBmt7ZgiMFKk3k16gDWKfSqCghl2TcOqN07ta7/HH0p1v4F4MRbXTtkSHWzIzygLvag0GXE1aE4Q6zrpe+JIkRzlwdG9scleb2/IamktwklVjmxuOv7mduP+8ITX5Ciu8SwgISQAs+ex1uwu6gt0pU/azOe4NjEZR2+gy7U2sprHSXmdbmmJ0Cad4hYU+IKI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92dd0952-22a9-4f6e-c257-08d58e11a524
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0725;
x-ms-traffictypediagnostic: AM3PR04MB0725:
x-microsoft-antispam-prvs: <AM3PR04MB07255FCE1FE6CDCDCF294F0180AB0@AM3PR04MB0725.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501306)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM3PR04MB0725;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0725;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(377424004)(199004)(189003)(13464003)(4326008)(3660700001)(966005)(3280700002)(5250100002)(7736002)(105586002)(305945005)(478600001)(53546011)(106356001)(6506007)(74316002)(102836004)(68736007)(66066001)(54906003)(2900100001)(110136005)(14454004)(6246003)(76176011)(55016002)(59450400001)(99286004)(2501003)(97736004)(229853002)(33656002)(53936002)(6436002)(2950100002)(9686003)(5660300001)(186003)(26005)(81166006)(8676002)(2906002)(86362001)(7416002)(81156014)(6306002)(45080400002)(316002)(7696005)(3846002)(6116002)(8936002)(25786009)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0725;H:AM3PR04MB306.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ooWOcQdRjmwNE4qlPE9i+88CXmTx6+y6mAAdvnoJFoMlpKhZGEfw1x9yOIn84WsmKtaCaa4DM0WLh4Kg+aQEOtE5lS4G2AimLMe7A7S0I2KvOz04FXwJE3m/Mkx+Us14LW2unVQkdorjAUnEg6ciNnWbLuBSzU2V4tgjyjV+4jiiet7k9cF21nlvehznBEBk+TL0lmDCTCQVX5b58gjjVoceTCDSsnyNmkKwl/w46cZout/9PliUwdZBVyaNvxo+vQfTIJAAKSrsjmovUb6PPbplp3+hLcc4ni0eHyuT4DLZZ7Yv9LgLCjNqFda5vW9mCLIfIuxX4j/0P06QlFqClw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dd0952-22a9-4f6e-c257-08d58e11a524
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 03:21:17.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0725
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2K3LV0Y029206

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Tuesday, March 20, 2018 12:22 AM
> To: A.s. Dong <aisheng.dong@nxp.com>; linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; dl-
> linux-imx <linux-imx@nxp.com>; aisheng.dong@codeaurora.org; linux-
> fbdev@vger.kernel.org; yamada.masahiro@socionext.com;
> sboyd@codeaurora.org; hdegoede@redhat.com;
> b.zolnierkie@samsung.com; A.s. Dong <aisheng.dong@nxp.com>
> Subject: Re: [RFC PATCH 1/2] clk: add new APIs to operate on all available
> clocks
> 
> Quoting Dong Aisheng (2018-01-23 04:50:40)
> > This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs to
> > users who just want to handle all available clocks from device tree
> > without need to know the detailed clock information likes clock
> > numbers and names. This is useful in writing some generic drivers to
> > handle clock part.
> >
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
> > ---
> > A few question may need discuss:
> > 1)  This patch is written based on of_clk_bulk_get.
> > [V4,1/1] clk: bulk: add of_clk_bulk_get()
> >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> >
> chwork.kernel.org%2Fpatch%2F9971527%2F&data=02%7C01%7Caisheng.don
> g%40n
> >
> xp.com%7C449209dd3e19491afb9908d58db5966d%7C686ea1d3bc2b4c6fa92c
> d99c5c
> >
> 301635%7C0%7C0%7C636570733411754127&sdata=4m5emXOR%2Bui3Mqw
> MbAJQDQxJcE
> > %2BxLcB51hEi2q3V2O8%3D&reserved=0 Stepen once said we may not
> need it,
> > but i guess as we already have clk_bulk_get, there may be guys who
> > want of_clk_bulk_get as well if they need specify the clock count
> > information, becaues of_clk_bulk_get_all will not check the count.
> > And of_clk_bulk_get is also helpful when implementing
> > of_clk_bulk_get_all.
> 
> Hmm ok. It's ok to implement it on top of of_clk_bulk_get I suppose, but
> maybe that API can be kept private until someone can prove they need it
> because they don't have a struct device pointer. Can you pick that patch from
> the list and resend in the series?
> 

Of course. I will do that.

> >
> > 2) It only implements the DT type clk_get_all as i see Stephen said we
> > probably may not need to implement non-dt type as there're still no
> > users.
> 
> Good.
> 
> >
> > If we do want to implement non-dt type as well, we could revise the
> > patch to add it too.
> > ---
> >  drivers/clk/clk-bulk.c | 64
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h    | 61
> ++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 124 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c index
> > 1c1a79d..bac2aae 100644
> > --- a/drivers/clk/clk-bulk.c
> > +++ b/drivers/clk/clk-bulk.c
> > @@ -17,9 +17,11 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/of.h>
> > +#include <linux/slab.h>
> >
> >  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)  int
> > __must_check of_clk_bulk_get(struct device_node *np, int num_clks, @@
> > -50,6 +52,45 @@ int __must_check of_clk_bulk_get(struct device_node
> *np, int num_clks,
> >         return ret;
> >  }
> >  EXPORT_SYMBOL(of_clk_bulk_get);
> > +
> > +struct clk_bulk __must_check *of_clk_bulk_get_all(struct device_node
> > +*np) {
> > +       struct clk_bulk *clk_bulk;
> > +       int num_clks;
> > +       int ret;
> > +
> > +       num_clks = of_clk_get_parent_count(np);
> > +       if (!num_clks)
> > +               return NULL;
> > +
> > +       clk_bulk = kzalloc(sizeof(*clk_bulk) +
> > +                          num_clks * sizeof(struct clk_bulk_data),
> > +                          GFP_KERNEL);
> > +       if (!clk_bulk)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       clk_bulk->num_clks = num_clks;
> > +       ret = of_clk_bulk_get(np, clk_bulk->num_clks, clk_bulk->clks);
> > +       if (ret) {
> > +               kfree(clk_bulk);
> > +               return ERR_PTR(ret);
> > +       }
> 
> Has this been tested? clk_bulk->clks probably points to junk?
> 

You're right. Will fix in a formal patch.

> > +
> > +       return clk_bulk;
> > +}
> > +EXPORT_SYMBOL(of_clk_bulk_get_all);
> > +
> > +void of_clk_bulk_put_all(struct clk_bulk *clk_bulk) {
> > +       if (IS_ERR_OR_NULL(clk_bulk))
> > +               return;
> > +
> > +       clk_bulk_put(clk_bulk->num_clks, clk_bulk->clks);
> > +
> > +       kfree(clk_bulk->clks);
> > +       kfree(clk_bulk);
> > +}
> > +EXPORT_SYMBOL(of_clk_bulk_put_all);
> >  #endif
> 
> My goal was to make device drivers pass in their struct device to
> clk_bulk_get_all() and then have that call into a private DT helper function
> like of_clk_bulk_get_all(). With your patch 2 that could still be done so let's
> go that direction?
> 

Sounds good to me.

> >
> >  void clk_bulk_put(int num_clks, struct clk_bulk_data *clks) @@ -107,6
> > +148,12 @@ void clk_bulk_unprepare(int num_clks, const struct
> > clk_bulk_data *clks)  }  EXPORT_SYMBOL_GPL(clk_bulk_unprepare);
> >
> > +void inline clk_bulk_unprepare_all(const struct clk_bulk *clk_bulk) {
> > +       clk_bulk_unprepare(clk_bulk->num_clks, clk_bulk->clks); }
> > +EXPORT_SYMBOL_GPL(clk_bulk_unprepare_all);
> 
> Do we really need these _all APIs though?
> 
> > +
> >  /**
> >   * clk_bulk_prepare - prepare a set of clocks
> >   * @num_clks: the number of clk_bulk_data @@ -139,6 +186,11 @@ int
> > __must_check clk_bulk_prepare(int num_clks,  }
> > EXPORT_SYMBOL_GPL(clk_bulk_prepare);
> >
> > +int inline __must_check clk_bulk_prepare_all(const struct clk_bulk
> > +*clk_bulk)
> 
> inline won't help much here. Maybe these wrappers should go into the
> header file?
> 

Will try that.

> > +{
> > +       return clk_bulk_prepare(clk_bulk->num_clks, clk_bulk->clks); }
> > +
> >  #endif /* CONFIG_HAVE_CLK_PREPARE */
> >
> >  /**
> > @@ -158,6 +210,12 @@ void clk_bulk_disable(int num_clks, const struct
> > clk_bulk_data *clks)  }  EXPORT_SYMBOL_GPL(clk_bulk_disable);
> >
> > +void inline clk_bulk_disable_all(const struct clk_bulk *clk_bulk)
> 
> ditto
> 
> > +{
> > +       return clk_bulk_disable(clk_bulk->num_clks, clk_bulk->clks); }
> > +EXPORT_SYMBOL_GPL(clk_bulk_disable_all);
> > +
> >  /**
> >   * clk_bulk_enable - ungate a set of clocks
> >   * @num_clks: the number of clk_bulk_data @@ -188,3 +246,9 @@ int
> > __must_check clk_bulk_enable(int num_clks, const struct clk_bulk_data
> *clks)
> >         return  ret;
> >  }
> >  EXPORT_SYMBOL_GPL(clk_bulk_enable);
> > +
> > +int inline __must_check clk_bulk_enable_all(const struct clk_bulk
> > +*clk_bulk)
> 
> again
> 
> > +{
> > +       return clk_bulk_enable(clk_bulk->num_clks, clk_bulk->clks); }
> > +EXPORT_SYMBOL_GPL(clk_bulk_enable_all);
> > diff --git a/include/linux/clk.h b/include/linux/clk.h index
> > 09ae760..ccafda1 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > @@ -92,6 +92,21 @@ struct clk_bulk_data {
> >         struct clk              *clk;
> >  };
> >
> > +/**
> > + * struct clk_bulk - bulk clk structure
> > + *
> > + * @num_clks: the number of avaliable clocks in this bulk
> > + * @clks: struct clk_bulk_data * to store the associated clock
> > + *
> > + * The CLK APIs provide a series of clk_bulk_x_all() API calls as
> > + * a convenience to consumers which require multiple clks.  This
> > + * structure is used to manage data for these calls.
> > + */
> > +struct clk_bulk {
> > +       int num_clks;
> > +       struct clk_bulk_data *clks;
> > +};
> 
> This could go away, and we could return the number of clks from
> clk_bulk_get_all() as a positive number, 0 if there are none, and a negative
> number if something failed. Then we don't need the _all variants or a
> wrapper struct. It would be nice to avoid the extra variants just because we
> need to tell it the number of clks to handle.

This looks like a good idea.
I will try it.

Thanks for your good suggestions.

Regards
Dong Aisheng
