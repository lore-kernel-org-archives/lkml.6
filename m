Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964869AbeEJNdx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934693AbeEJNdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:33:51 -0400
Date: Thu, 10 May 2018 08:33:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Yao Chen <chenyao11@huawei.com>, songxiaowei@hisilicon.com,
        wangbinghui@hisilicon.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, xuwei5@hisilicon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        dimitrysh@google.com, guodong.xu@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jianguo Sun <sunjianguo1@huawei.com>
Subject: Re: [PATCH] Kirin-PCIe: Add kirin pcie msi feature.
Message-ID: <20180510133350.GH173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525763028-107417-1-git-send-email-chenyao11@huawei.com>
 <20180508125658.GK161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509045151.GA24899@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509045151.GA24899@dragon>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:51:53PM +0800, Shawn Guo wrote:
> Hi Bjorn,
> 
> On Tue, May 08, 2018 at 07:56:58AM -0500, Bjorn Helgaas wrote:
> ...
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	pci->pp.root_bus_nr = -1;
> > 
> > Setting root_bus_nr looks like an unrelated change that should be in a
> > separate patch.
> > 
> > But I'm not sure why you need to set root_bus_nr at all, since
> > dw_pcie_host_init() always sets it.
> > 
> > Some other callers of dw_pcie_host_init() do set it:
> > 
> >   exynos_add_pcie_port()
> >   imx6_add_pcie_port()
> >   armada8k_add_pcie_port()
> >   artpec6_add_pcie_port()
> >   dw_plat_add_pcie_port()
> >   histb_pcie_probe()
> >   qcom_pcie_probe()
> >   spear13xx_add_pcie_port()
> > 
> > But I don't see *why* any of these need to set it.  If they don't need to
> > set it, they shouldn't.
> 
> Mostly it's a blind copy of unnecessary code.  I tested histb driver
> by dropping the line, and did not see anything broken.  I will cook up
> a series to remove the code from all above drivers, and copy
> corresponding driver owner to comment.

Thanks, Shawn, I really appreciate that!

> > And it would be nice if histb and qcom followed the structure and naming
> > conventions of the other drivers, i.e., they should have
> > histb_add_pcie_port() and qcom_add_pcie_port().
> 
> I can create a patch for histb driver, but will leave qcom one to
> Stanimir to decide.

Sounds good, thanks again!
