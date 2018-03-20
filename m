Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeCTGi7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:38:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41794 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751771AbeCTGi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:38:58 -0400
X-UUID: e246b5e27bf44fc39d0dfc9068289a14-20180320
Message-ID: <1521527932.21199.4.camel@mtkswgap22>
Subject: Re: [PATCH v4 3/6] clk: mediatek: add audsys support for MT2701
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>,
        "Garlic Tseng" <garlic.tseng@mediatek.com>
Date: Tue, 20 Mar 2018 14:38:52 +0800
In-Reply-To: <152149148431.242365.4625152577833480987@swboyd.mtv.corp.google.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
         <f1445b95864af04f1f90d3be96d0a485d1bb4560.1520327262.git.ryder.lee@mediatek.com>
         <152149148431.242365.4625152577833480987@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23730.005
X-TM-AS-Result: No-17.745800-8.000000-10
X-TMASE-MatchedRID: wQVy7q402w34OiVTWoD8RCa1MaKuob8PC/ExpXrHizxGqWrQwZFUCIe2
        B1kDoHWrwX0f1lPumDhPaUktJ/9D+psYdIGP6PlZXP5rFAucBUExXH/dlhvLv4KwF4K/wIz948f
        E6PIFskBl/p5QlddQ8R9l1zPMOb+6TX7PJ/OU3vKDGx/OQ1GV8t0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.745800-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23730.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 13:31 -0700, Stephen Boyd wrote:
> Quoting Ryder Lee (2018-03-06 01:09:28)
> > +
> > +static const struct of_device_id of_match_clk_mt2701_aud[] = {
> > +       { .compatible = "mediatek,mt2701-audsys", },
> > +       {}
> > +};
> > +
> > +static int clk_mt2701_aud_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +       int r;
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
> > +
> > +       mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> > +                              clk_data);
> > +
> > +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +       if (r) {
> > +               dev_err(&pdev->dev,
> > +                       "could not register clock provider: %s: %d\n",
> > +                       pdev->name, r);
> > +
> > +               return r;
> > +       }
> 
> This fails to remove the clk provider when devm_of_platform_populate()
> returns an error.
> 
> > +
> > +       return devm_of_platform_populate(&pdev->dev);
> > +}

I've sent a new one to fix it.

Thanks
