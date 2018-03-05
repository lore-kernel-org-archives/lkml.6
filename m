Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeCEP4x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:56:53 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:32887 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeCEP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:56:49 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "vinod.koul@intel.com" <vinod.koul@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "wan.ahmad.zainie.wan.mohamad@intel.com"
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH v2 1/2] dmaengine: Introduce DW AXI DMAC driver
Thread-Topic: [PATCH v2 1/2] dmaengine: Introduce DW AXI DMAC driver
Thread-Index: AQHTrxIKKwJ+pE4H3kOhh2UUT+cHx6O20tCAgArzXAA=
Date: Mon, 5 Mar 2018 15:56:37 +0000
Message-ID: <1520265396.3152.27.camel@synopsys.com>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com>
         <20180226145628.11892-2-Eugeniy.Paltsev@synopsys.com>
         <CAHp75Vc6KtppecYJBtuXTGCzXySOUZiYqxBfb6w69f1j3J0jDQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc6KtppecYJBtuXTGCzXySOUZiYqxBfb6w69f1j3J0jDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDE8ACC55BBB764A9982F947CC578253@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25FuupM031263

On Mon, 2018-02-26 at 18:42 +0200, Andy Shevchenko wrote:
> On Mon, Feb 26, 2018 at 4:56 PM, Eugeniy Paltsev
> <Eugeniy.Paltsev@synopsys.com> wrote:
> 
> > +       chip->core_clk = devm_clk_get(chip->dev, "core-clk");
> 
> Does the name come from datasheet?
> 
> > +       chip->cfgr_clk = devm_clk_get(chip->dev, "cfgr-clk");
> 
> Ditto?

Yes, these names came from datasheet.

> > +       }
> > +       /* Enable clk before accessing to registers */
> > +       clk_prepare_enable(chip->cfgr_clk);
> > +       clk_prepare_enable(chip->core_clk);
> 
> Each of them may fail. Is it okay?

As it is driver remove callback I guess it is okay.

> > +static const struct dev_pm_ops dw_axi_dma_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
> > +};
> 
> No system suspend?

Are you talking about SET_SYSTEM_SLEEP_PM_OPS?
I don't implement these OPS as we don't have any platform which has DW AXI DMAC
and supports sleeping - so I can't test them.

-- 
 Eugeniy Paltsev
