Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeBGBRy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:17:54 -0500
Received: from regular1.263xmail.com ([211.150.99.134]:49508 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754271AbeBGBRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:17:53 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: wxt@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: wxt@rock-chips.com
X-UNIQUE-TAG: <5ac43ba71a883bd676092d9339fe67fb>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v3 0/2] phy: rockchip-emmc: fixes emmc-phy power on failed
 with rk3399 SoCs
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1515638427-15117-1-git-send-email-wxt@rock-chips.com>
From: Caesar Wang <wxt@rock-chips.com>
Message-ID: <e67da623-d6fe-92d9-e6b3-79b8290405c9@rock-chips.com>
Date: Wed, 7 Feb 2018 09:17:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515638427-15117-1-git-send-email-wxt@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

Can you help merge this in your  or next tree?  I'm hoping that we can 
land this somewhere.:-)


Thanks,
-Caesar
在 2018年01月11日 10:40, Caesar Wang 写道:
> Hi Kishon,
>
> Since the Shawn isn't available, I take over this series patches for now.
>
> As the original bug had tracked on https://issuetracker.google.com/71561742.
> In some cases, the mmc phy power on failed during booting up.
> The log as below:
> ...
> [   2.375333] rockchip_emmc_phy_power: caldone timeout.
> [    2.377815] phy phy-ff770000.syscon:phy@f780.4: phy poweron failed --> -110
> ...
> [    2.489295] mmc0: mmc_select_hs400es failed, error -110
> [    2.489302] mmc0: error -110 whilst initialising MMC card
> ..
>
> The actual emulate, the wait 5us for calpad busy trimming, that's no enough.
> We need give the enough margin for it.
>
> Verified on url =
>          https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4
> This series patches can apply and bring up with kernel-next on rk3399 chromebook.
>
> -Caesar
>
>
> Changes in v3:
> - As Doug commented on both upstream and gerrit.
>    Change "5, 50" to "0, 50", and the message of print.
> - As Doug commented on https://patchwork.kernel.org/patch/10154797,
>    Change "1, 50" to "0, 50".
>
> Changes in v2:
> - print the return valut with regmap_read_poll_timeout failing.
> - As Brian commented on https://patchwork.kernel.org/patch/10139891/,
>    changed the note and added to print error value with
>    regmap_read_poll_timeout API.
>
> Shawn Lin (2):
>    phy: rockchip-emmc: retry calpad busy trimming
>    phy: rockchip-emmc: use regmap_read_poll_timeout to poll dllrdy
>
>   drivers/phy/rockchip/phy-rockchip-emmc.c | 60 +++++++++++++++-----------------
>   1 file changed, 28 insertions(+), 32 deletions(-)
>
