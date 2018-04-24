Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757537AbeDXMh0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:37:26 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:59750 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeDXMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:37:21 -0400
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: jakob.unterwurzacher@theobroma-systems.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <1f3b2bcc8989d8a9981c46e2777ee7ae>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5ADF24F3.6070106@rock-chips.com>
Date: Tue, 24 Apr 2018 20:37:07 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-rockchip@lists.infradead.org
Subject: Re: [regression, bisected] rockchip rk3399 video output breakage
References: <3beabd18-0c39-be65-cfe7-8498dc7c296b@theobroma-systems.com>
In-Reply-To: <3beabd18-0c39-be65-cfe7-8498dc7c296b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

Thanks for your message.

On 04/24/2018 08:19 PM, Jakob Unterwurzacher wrote:
>
> Full dmesg:
> https://gist.github.com/jakob-tsd/33cf395e355bf9bb6956c36438d999e7
>
> I have bisected the "master bind failed" down to:
>
>> commit 9176a303d971dc0fb35469c531c0d263667d2277
>> Author: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Date:   Fri Mar 23 15:38:10 2018 +0800
>>
>>     iommu/rockchip: Use IOMMU device for dma mapping operations
>>
>>     Use the first registered IOMMU device for dma mapping operations, and
>>     drop the domain platform device.
>>
>>     This is similar to exynos iommu driver.
>>
>>     Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>     Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>     Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
>
> Moving to one commit earlier brings the screen to life. Just with
> colorful garbage, but I guess that's a different problem.
>
> Is this a known issue with the IOMMU change?

right, i think it's a known issue, as the iommu failed to get clks:
[    1.525153] rk_iommu ff8f3f00.iommu: Failed to get clk 'iface': -2
[    1.525316] rk_iommu: probe of ff8f3f00.iommu failed with error -2
[    1.525484] rk_iommu ff903f00.iommu: Failed to get clk 'iface': -2
[    1.525643] rk_iommu: probe of ff903f00.iommu failed with error -2


there's a followed patch to add those clks to the dtsi, and also a fix 
patch to make those clks optional(by heiko):

https://www.spinics.net/lists/arm-kernel/msg645696.html

http://lists.infradead.org/pipermail/linux-rockchip/2018-April/020349.html

>
> Thanks,
> Jakob
