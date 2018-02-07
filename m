Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbeBGFcE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 00:32:04 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:58561 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeBGFcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 00:32:03 -0500
Subject: Re: [PATCH v3 0/2] phy: rockchip-emmc: fixes emmc-phy power on failed
 with rk3399 SoCs
To: Caesar Wang <wxt@rock-chips.com>
References: <1515638427-15117-1-git-send-email-wxt@rock-chips.com>
 <e67da623-d6fe-92d9-e6b3-79b8290405c9@rock-chips.com>
CC: Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <64bd750a-16b9-95ca-fa53-b7c1ab727a29@ti.com>
Date: Wed, 7 Feb 2018 11:01:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <e67da623-d6fe-92d9-e6b3-79b8290405c9@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 07 February 2018 06:47 AM, Caesar Wang wrote:
> Kishon,
> 
> Can you help merge this in your  or next tree?  I'm hoping that we can land
> this somewhere.:-)

sure, I'll merge once -rc1 is tagged.

Thanks
Kishon

> 
> 
> Thanks,
> -Caesar
> 在 2018年01月11日 10:40, Caesar Wang 写道:
>> Hi Kishon,
>>
>> Since the Shawn isn't available, I take over this series patches for now.
>>
>> As the original bug had tracked on https://issuetracker.google.com/71561742.
>> In some cases, the mmc phy power on failed during booting up.
>> The log as below:
>> ...
>> [   2.375333] rockchip_emmc_phy_power: caldone timeout.
>> [    2.377815] phy phy-ff770000.syscon:phy@f780.4: phy poweron failed --> -110
>> ...
>> [    2.489295] mmc0: mmc_select_hs400es failed, error -110
>> [    2.489302] mmc0: error -110 whilst initialising MMC card
>> ..
>>
>> The actual emulate, the wait 5us for calpad busy trimming, that's no enough.
>> We need give the enough margin for it.
>>
>> Verified on url =
>>         
>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4
>> This series patches can apply and bring up with kernel-next on rk3399
>> chromebook.
>>
>> -Caesar
>>
>>
>> Changes in v3:
>> - As Doug commented on both upstream and gerrit.
>>    Change "5, 50" to "0, 50", and the message of print.
>> - As Doug commented on https://patchwork.kernel.org/patch/10154797,
>>    Change "1, 50" to "0, 50".
>>
>> Changes in v2:
>> - print the return valut with regmap_read_poll_timeout failing.
>> - As Brian commented on https://patchwork.kernel.org/patch/10139891/,
>>    changed the note and added to print error value with
>>    regmap_read_poll_timeout API.
>>
>> Shawn Lin (2):
>>    phy: rockchip-emmc: retry calpad busy trimming
>>    phy: rockchip-emmc: use regmap_read_poll_timeout to poll dllrdy
>>
>>   drivers/phy/rockchip/phy-rockchip-emmc.c | 60 +++++++++++++++-----------------
>>   1 file changed, 28 insertions(+), 32 deletions(-)
>>
> 
> 
