Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeE2Lsd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:48:33 -0400
Received: from 8bytes.org ([81.169.241.247]:46852 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933288AbeE2Lsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:48:30 -0400
Date: Tue, 29 May 2018 13:48:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/8] Make deferring probe forever optional
Message-ID: <20180529114825.GH18595@8bytes.org>
References: <20180524175024.19874-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 12:50:16PM -0500, Rob Herring wrote:
> Rob Herring (8):
>   driver core: make deferring probe after init optional
>   driver core: add a deferred probe timeout
>   dt-bindings: pinctrl: add a 'pinctrl-use-default' property
>   arm: dts: bcm283x: mark the UART pin muxing nodes with
>     pinctrl-use-default
>   pinctrl: optionally stop deferring probe at end of initcalls
>   iommu: Stop deferring probe at end of initcalls
>   iommu: Remove IOMMU_OF_DECLARE
>   PM / Domains: Stop deferring probe at the end of initcall
> 
>  .../admin-guide/kernel-parameters.txt         |  7 +++
>  .../bindings/pinctrl/pinctrl-bindings.txt     |  6 +++
>  arch/arm/boot/dts/bcm283x.dtsi                |  2 +
>  drivers/base/dd.c                             | 43 +++++++++++++++++++
>  drivers/base/power/domain.c                   |  2 +-
>  drivers/iommu/arm-smmu-v3.c                   |  2 -
>  drivers/iommu/arm-smmu.c                      |  7 ---
>  drivers/iommu/exynos-iommu.c                  |  2 -
>  drivers/iommu/ipmmu-vmsa.c                    |  3 --
>  drivers/iommu/msm_iommu.c                     |  2 -
>  drivers/iommu/of_iommu.c                      | 21 +--------
>  drivers/iommu/qcom_iommu.c                    |  2 -
>  drivers/iommu/rockchip-iommu.c                |  2 -
>  drivers/pinctrl/devicetree.c                  | 14 ++++--
>  include/linux/device.h                        |  2 +
>  include/linux/of_iommu.h                      |  4 --
>  16 files changed, 73 insertions(+), 48 deletions(-)

For the IOMMU bits:

Acked-by: Joerg Roedel <jroedel@suse.de>
