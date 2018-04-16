Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeDPNR0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:17:26 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36618 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbeDPNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:17:25 -0400
X-Google-Smtp-Source: AIpwx49MYGP2L2yKxveET5Vr0xXwHltrgmPvX4/RIVuSJPSBODoc0IH6FebC1kDkJAnjXdE/U8enSQ==
MIME-Version: 1.0
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095117epcas2p2093448b49aab2abd6684bf689f8888d5@epcas2p2.samsung.com>
 <20180405095000.9756-29-enric.balletbo@collabora.com> <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
In-Reply-To: <a9e436f8-34ec-123a-9c69-efabb4576bea@samsung.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 16 Apr 2018 13:12:07 +0000
X-Gmail-Original-Message-ID: <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
Message-ID: <CAAFQd5C_RhqSCfEXNPQ0zH-O1PGk6xGEdvzsSxnfz9kJ5G4Ceg@mail.gmail.com>
Subject: Re: [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier
To: a.hajda@samsung.com
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Yakir Yang <ykk@rock-chips.com>, kernel@collabora.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        jy0922.shim@samsung.com, rydberg@bitmath.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kgene@kernel.org, linux-input@vger.kernel.org,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Caesar Wang <wxt@rock-chips.com>, Jeffy <jeffy.chen@rock-chips.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Mark yao <mark.yao@rock-chips.com>,
        =?UTF-8?B?546L5b6B5aKe?= <wzz@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>, Jingoo Han <jingoohan1@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        kuankuan.y@gmail.com, Haixia Shi <hshi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Mon, Apr 16, 2018 at 6:57 PM Andrzej Hajda <a.hajda@samsung.com> wrote:

> On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> > From: Tomasz Figa <tfiga@chromium.org>
> >
> > It looks like the driver subsystem detaches devices from power domains
> > at shutdown without consent of the drivers.

> It looks bit strange. Could you elaborate more on it. Could you show the
> code performing the detach?

It not only looks strange, but it is strange. The code was present in 4.4:

https://elixir.bootlin.com/linux/v4.4.128/source/drivers/base/platform.c#L553

but was apparently removed in 4.5:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/base/platform.c?h=next-20180416&id=2d30bb0b3889adf09b342722b2ce596c0763bc93

So we might not need this patch anymore.

Best regards,
Tomasz
