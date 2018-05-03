Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeECMq1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:46:27 -0400
Received: from 8bytes.org ([81.169.241.247]:54180 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeECMq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:46:26 -0400
Date: Thu, 3 May 2018 14:46:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@chromium.org>,
        Simon Xue <xxm@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: rockchip: fix building without CONFIG_OF
Message-ID: <20180503124623.wjnv6smvhpblpr76@8bytes.org>
References: <20180404102401.3634085-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404102401.3634085-1-arnd@arndb.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:23:53PM +0200, Arnd Bergmann wrote:
> We get a build error when compiling the iommu driver without CONFIG_OF:
> 
> drivers/iommu/rockchip-iommu.c: In function 'rk_iommu_of_xlate':
> drivers/iommu/rockchip-iommu.c:1101:2: error: implicit declaration of function 'of_dev_put'; did you mean 'of_node_put'? [-Werror=implicit-function-declaration]
> 
> This replaces the of_dev_put() with the equivalent platform_device_put(),
> and adds an error check for of_find_device_by_node() returning NULL,
> which seems to be appropriate here given that we pass the device into
> platform_get_drvdata() next, and that of_find_device_by_node() might
> theoretically return a NULL pointer.
> 
> Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This warning appears to only have been introduced in linux-next after
> the merge window opened.
> ---
>  drivers/iommu/rockchip-iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Changed patch according to Robins comments and applied it, thanks.
