Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeENA5O (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:57:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39919 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbeENA5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:57:12 -0400
X-Google-Smtp-Source: AB8JxZpCuSNUfJPyGswqF5ZazLAVqpXaPnsqqd5gvVejKSfQyW3u4zDBozuY9yJ4qL4Yw2Ubqaq8CQ==
Date: Mon, 14 May 2018 08:56:32 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh@kernel.org>
Subject: Re: linux-next: build warning after merge of the imx-mxs tree
Message-ID: <20180514005629.GA11867@dragon>
References: <20180514092158.297b4fe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514092158.297b4fe4@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, May 14, 2018 at 09:21:58AM +1000, Stephen Rothwell wrote:
> Hi Shawn,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (reg_format): /soc/ipu@2400000/port@2/endpoint@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (avoid_default_addr_size): /soc/ipu@2400000/port@2/endpoint@0: Relying on default #address-cells value
> 
> and about 7000 more lines across several files ...
> 
> It is hard tell what introduced these warnings ...

Commit e6bb17850d1e ("ARM: dts: imx: fix IPU OF graph endpoint node
names") introduced the warnings.  I will submit a patch to fix them.
Sorry for this.

Shawn
