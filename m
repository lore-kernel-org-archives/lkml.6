Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbeENNm7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:42:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37181 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932269AbeENNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:42:47 -0400
X-Google-Smtp-Source: AB8JxZphKYT1nLY5DLaVHF5ZQb0MXjE8VMLLB4dhxyqjZBUUuKuhTWxiYqT53se2ExALKos3lCQc2w==
Date: Mon, 14 May 2018 21:42:02 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: linux-next: build warning after merge of the imx-mxs tree
Message-ID: <20180514134200.GB11867@dragon>
References: <20180514092158.297b4fe4@canb.auug.org.au>
 <20180514005629.GA11867@dragon>
 <CAL_JsqJDj3Gx__L7Dc2WSEQ+MnJp-e2aO4K498qq5odkco-dCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJDj3Gx__L7Dc2WSEQ+MnJp-e2aO4K498qq5odkco-dCQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 08:05:29AM -0500, Rob Herring wrote:
> On Sun, May 13, 2018 at 7:56 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Hi Stephen,
> >
> > On Mon, May 14, 2018 at 09:21:58AM +1000, Stephen Rothwell wrote:
> >> Hi Shawn,
> >>
> >> After merging the imx-mxs tree, today's linux-next build (arm
> >> multi_v7_defconfig) produced this warning:
> >>
> >> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (reg_format): /soc/ipu@2400000/port@2/endpoint@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> >> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> >> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> >> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (avoid_default_addr_size): /soc/ipu@2400000/port@2/endpoint@0: Relying on default #address-cells value
> >>
> >> and about 7000 more lines across several files ...
> >>
> >> It is hard tell what introduced these warnings ...
> >
> > Commit e6bb17850d1e ("ARM: dts: imx: fix IPU OF graph endpoint node
> > names") introduced the warnings.  I will submit a patch to fix them.
> > Sorry for this.
> 
> Well, it was the combination of that and commit ed94e3c3ceb4 ("ARM:
> dts: imx6: Remove #address/#size-cells from ipu nodes"). Commit
> ed94e3c3ceb4q should be reverted.

Ah, okay.  I will just drop that commit then.

Shawn
