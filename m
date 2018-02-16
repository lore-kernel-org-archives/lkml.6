Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033229AbeBPOAC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:00:02 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:37186 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032862AbeBPN74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:59:56 -0500
Subject: Re: [PATCH 0/4] Move DP phy switch to PHY driver
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
 <a9eac594-33d5-6171-51ca-66204008fc1f@ti.com> <1752563.I66u68YxnT@diego>
CC: Chris Zhong <zyw@rock-chips.com>, <dri-devel@lists.freedesktop.org>,
        <robh@kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.yao@rock-chips.com>,
        <groeck@chromium.org>, <seanpaul@chromium.org>,
        William wu <wulf@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>, Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will.deacon@arm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianqun Xu <jay.xu@rock-chips.com>, Caesar Wang <wxt@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5d20a7bf-f96a-f030-1350-aea2c5cd8153@ti.com>
Date: Fri, 16 Feb 2018 19:29:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1752563.I66u68YxnT@diego>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 16 February 2018 06:35 PM, Heiko Stübner wrote:
> Hi Kishon,
> 
> Am Freitag, 16. Februar 2018, 12:04:42 CET schrieb Kishon Vijay Abraham I:
>> On Friday 10 February 2017 01:14 PM, Chris Zhong wrote:
>>> There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
>>> only one PHY can connect to DP controller at one time, the other should
>>> be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
>>> set this bit means enable PHY 1, clear this bit means enable PHY 0.
>>>
>>> If the board has 2 Type-C ports, the DP driver get the phy id from
>>> devm_of_phy_get_by_index, and then control this switch according to
>>> this id. But some others board only has one Type-C port, it may be PHY 0
>>> or PHY 1. The dts node id can not tell us the correct PHY id. Hence move
>>> this switch to PHY driver, the PHY driver can distinguish between PHY 0
>>> and PHY 1, and then write the correct register bit.
>>
>> Changed subject of "Documentation: bindings: add uphy-dp-sel for Rockchip
>> USB Type-C PHY" as suggested by Rob, rebased "phy: rockchip-typec: support
>> DP phy switch" to the latest kernel and merged.
> 
> I'm not sure how far along you are with your merging, but you might want to 
> revert this one.
> 
> In your inbox you should find more recent threads about the type-c phy
> where Rob strongly suggested moving the whole grf registers out of the
> dt and into the driver.
> 
> Enric Balletbo did just that and posted a series (including the dp-move)
> yesterday (refined in a v2 from today).
> 
> Alternatively Enric could rebase his series on top of that recent change.

I can drop this series and take Enric's series. All of them are still in my
local system.

Thanks
Kishon
