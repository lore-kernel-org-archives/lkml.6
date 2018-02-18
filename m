Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeBRKyF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 05:54:05 -0500
Received: from gloria.sntech.de ([95.129.55.99]:37366 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeBRKyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 05:54:04 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yakir Yang <ykk@rock-chips.com>,
        =?ISO-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
Subject: Re: [PATCH v3 03/43] drm/rockchip: Respect page offset for PRIME mmap calls
Date: Sun, 18 Feb 2018 11:53:49 +0100
Message-ID: <3167776.tAZEmiy1TT@phil>
In-Reply-To: <20180130202913.28724-4-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com> <20180130202913.28724-4-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Januar 2018, 21:28:33 CET schrieb Thierry Escande:
> From: Ørjan Eide <orjan.eide@arm.com>
> 
> When mapping external DMA-bufs through the PRIME mmap call, we might be
> given an offset which has to be respected. However for the internal DRM
> GEM mmap path, we have to ignore the fake mmap offset used to identify
> the buffer only. Currently the code always zeroes out vma->vm_pgoff,
> which breaks the former.
> 
> This patch fixes the problem by moving the vm_pgoff assignment to a
> function that is used only for GEM mmap path, so that the PRIME path
> retains the original offset.
> 
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Ørjan Eide <orjan.eide@arm.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

applied to drm-misc.

So I've picked up the "easy" patches that I have read somewhat often
and also tested myself using the lima driver on some Rockchip socs
(rk3036 + mali400 and rk3328 + mali450).

I'll try to also look at the rest but no guarantees on timing as they
look a lot more involved in real graphics-related stuff :-)


Thanks
Heiko
