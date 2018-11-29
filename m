Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B3AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206282145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206282145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeK3Csf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:48:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728363AbeK3Cse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:48:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C275AF74A7ED;
        Thu, 29 Nov 2018 23:42:40 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:42:40 +0800
Subject: Re: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
To:     Linus Walleij <linus.walleij@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <CACRpkdYThcGjdV9Ezs4qMr8K6_jH40SDUgt0Tps8d+_4sSESyg@mail.gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        <ezequiel@collabora.com>, Michal Simek <michal.simek@xilinx.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Gross <andy.gross@linaro.org>,
        <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Koen Kooi <koen.kooi@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C0008E5.5080401@hisilicon.com>
Date:   Thu, 29 Nov 2018 15:42:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYThcGjdV9Ezs4qMr8K6_jH40SDUgt0Tps8d+_4sSESyg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On 2018/10/31 13:38, Linus Walleij wrote:
> On Mon, Oct 29, 2018 at 10:43 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
>> This patchset standardizes the onboard LEDs on 96Boards by maintaining
>> common labels and triggers as below:
>>
>> green:user1  default-trigger: heartbeat
>> green:user2  default-trigger: mmc0/disk-activity (onboard-storage)
>> green:user3  default-trigger: mmc1 (SD card)
>> green:user4  default-trigger: none, panic-indicator
>> yellow:wlan  default-trigger: phy0tx
>> blue:bt      default-trigger: hci0-power
>>
>> This standardization is required to provide a common behaviour of LEDs
>> across all mainline supported 96Boards and also making it easier to
>> control it using an userspace library like MRAA.
>>
>> For Rock960 and Ficus boards, the LED support is added in this patchset.
>> Rest of the boards are converted to adopt the standard.
>>
>> Note: Since there is no UFS trigger available for now, user2 LED trigger
>> is set to none on HiKey960.
> 
> This series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It makes a lot of sense to try to unify the userspace ABI so we get
> some kind of order here instead of trying to counteract it with
> per-device kludges in userspace. It definately makes things better!
> 
> Yours,
> Linus Walleij
> 
> .
> 

Applied hisilicon part(patch 3,4 and 5) to the hisilicon soc dt tree.
Thanks!

Best Regards,
Wei

