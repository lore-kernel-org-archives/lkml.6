Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeDPTns (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:43:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44442 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeDPTnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:43:46 -0400
Message-ID: <aec7e2d36b4599f77bc419b8fe7c415815529c2f.camel@collabora.com>
Subject: Re: [PATCH v6 24/30] drm/rockchip: Disable PSR on input events
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, ykk@rock-chips.com, kernel@collabora.com,
        m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org,
        jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org, "Kristian H. Kristensen" <hoegsberg@google.com>
Date: Mon, 16 Apr 2018 16:42:29 -0300
In-Reply-To: <20180405095000.9756-25-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
         <20180405095000.9756-25-enric.balletbo@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-05 at 11:49 +0200, Enric Balletbo i Serra wrote:
> From: "Kristian H. Kristensen" <hoegsberg@google.com>
> 
> To improve PSR exit latency, we speculatively start exiting when we
> receive input events. Occasionally, this may lead to false positives,
> but most of the time we get a head start on coming out of PSR.
> Depending
> on how userspace takes to produce a new frame in response to the
> event,
> this can completely hide the exit latency. In case of Chrome OS, we
> typically get the input notifier 50ms or more before the dirty_fb
> triggered exit.
> 

Why is this rockchip-specific? It sounds more like something
we'd want to integrate generically for drivers to leverage.

Regards,
Eze
