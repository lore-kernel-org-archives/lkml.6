Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCNNZt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:25:49 -0400
Received: from gloria.sntech.de ([95.129.55.99]:47314 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751353AbeCNNZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:25:48 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/rockchip: VOP interrupt fixes
Date: Wed, 14 Mar 2018 14:25:39 +0100
Message-ID: <9337520.8DqYEZO4hX@diego>
In-Reply-To: <20180220130120.5254-1-marc.zyngier@arm.com>
References: <20180220130120.5254-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 20. Februar 2018, 14:01:17 CET schrieb Marc Zyngier:
> This small series fixes a number of issues that I found while trying
> to get kexec working on the Chromebook Plus (aka rk3399-gru-kevin) in
> order to use it as some sort of interactive bootloader.
> 
> The main issue is that the vop driver expects the interrupts to be
> cleared and disabled when booting. Nothing could be more wrong. The
> device should be expected to be alive and screaming, and it is the
> driver's job to put it back into a sane state.
> 
> This is what the first patch does, making sure the interrupt is
> requested only when the device has been put back into a known
> state. Given that this is an observable bug that has been around for a
> while, I've tagged it with a Cc: stable.
> 
> The two following patches are less important: Using memcpy on MMIO
> ranges is plain wrong, and using spin_lock_irqsave in irq context is
> slightly pointless.
> 
> With these patches in, I'm able to get kexec to work. There is still
> some funny issues at the iommu level, but that's for another day.
> 
> Patches on top of 4.16-rc2.
> 
> Marc Zyngier (3):
>   drm/rockchip: Clear all interrupts before requesting the IRQ
>   drm/rockchip: Do not use memcpy for MMIO addresses
>   drm/rockchip: Don't use spin_lock_irqsave in interrupt context

Tested on rk3036 (hdmi), rk3288 (hdmi+edp) and rk3399 (edp) and
applied to drm-misc-next after slightly fixing patch1 for a recent change
to the code around the old request_irq position, so it applies.


Thanks
Heiko
