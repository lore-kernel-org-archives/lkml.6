Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeCMA0y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:26:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34460 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbeCMA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:26:52 -0400
Subject: Re: [PATCH v5 06/36] drm/rockchip: Only wait for panel ACK on PSR
 entry
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, a.hajda@samsung.com, ykk@rock-chips.com,
        kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        Sonny Rao <sonnyrao@chromium.org>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-7-enric.balletbo@collabora.com>
 <1909495.WV5cT3kS9W@diego>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <804ab508-40b8-71fa-c40b-b54f70fcc453@collabora.com>
Date: Tue, 13 Mar 2018 01:26:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1909495.WV5cT3kS9W@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/18 17:58, Heiko Stübner wrote:
> Hi,
> 
> the subject is misleading I think, as this is touching only the generic
> bridge code and not anything Rockchip-related, so should probably
> be "drm/bridge"?
> 

Right, I'll fix this when I need to send another version, I'll wait, for now, a
bit more for reviews on the other patches.

Thanks
  Enric

> Am Freitag, 9. März 2018, 23:22:57 CET schrieb Enric Balletbo i Serra:
>> From: zain wang <wzz@rock-chips.com>
>>
>> We currently wait for the panel to mirror our intended PSR state
>> before continuing on both PSR enter and PSR exit. This is really
>> only important to do when we're entering PSR, since we want to
>> be sure the last frame we pushed is being served from the panel's
>> internal fb before shutting down the soc blocks (vop/analogix).
>>
>> This patch changes the behavior such that we only wait for the
>> panel to complete the PSR transition when we're entering PSR, and
>> to skip verification when we're exiting.
>>
>> Cc: Stéphane Marchesin <marcheu@chromium.org>
>> Cc: Sonny Rao <sonnyrao@chromium.org>
>> Signed-off-by: zain wang <wzz@rock-chips.com>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> change itself looks good, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
