Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F68CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A732075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A732075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJWPoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:44:23 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:40802 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeJWPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:44:22 -0400
Received: from tony.xie?rock-chips.com (unknown [192.168.167.12])
        by lucky1.263xmail.com (Postfix) with ESMTP id E4C2C5EF;
        Tue, 23 Oct 2018 15:21:57 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.36] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id E025F3CB;
        Tue, 23 Oct 2018 15:21:52 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: tony.xie@rock-chips.com
X-FST-TO: tony.xie@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: tony.xie@rock-chips.com
X-UNIQUE-TAG: <cc3f527087c8e6a1cd530f1fd272a160>
X-ATTACHMENT-NUM: 0
X-SENDER: xxx@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.36] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 15439NZS84B;
        Tue, 23 Oct 2018 15:21:56 +0800 (CST)
Subject: Re: [PATCH v3 1/5] mfd: rk808: Add RK817 and RK809 support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
References: <1535081441-20718-1-git-send-email-tony.xie@rock-chips.com>
 <1535081441-20718-2-git-send-email-tony.xie@rock-chips.com>
 <20180911114732.GL4185@dell>
 <b0f9fff3-3084-91b3-fa78-5163ebd43bbb@rock-chips.com>
 <20181023062601.GS4939@dell>
From:   tony <tony.xie@rock-chips.com>
Message-ID: <3d96be69-e50c-187e-7d3a-75eec63d2be0@rock-chips.com>
Date:   Tue, 23 Oct 2018 15:21:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023062601.GS4939@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2018/10/23 14:26, Lee Jones 写道:
>>>>       The rk809 and rk817 are a Power Management IC (PMIC) for multimedia
>>>>       and handheld devices. It contains the following components:
>>>>
>>>>           - Regulators
>>>>           - RTC
>>>>           - Clocking
>>>>
>>>>       Both RK809 and RK817 chips are using a similar register map,
>>>>       so we can reuse the RTC and Clocking and regulators functionality.
>>>>
>>>> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
>>>> ---
>>>>    drivers/mfd/Kconfig       |   6 +-
>>>>    drivers/mfd/rk808.c       | 218 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>    include/linux/mfd/rk808.h | 172 ++++++++++++++++++++++++++++++++++++
>>>>    kernel/reboot.c           |   1 +
>>>>    4 files changed, 391 insertions(+), 6 deletions(-)
> [...]
>
>>>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>>>> index e4ced88..83810d7 100644
>>>> --- a/kernel/reboot.c
>>>> +++ b/kernel/reboot.c
>>>> @@ -49,6 +49,7 @@
>>>>     */
>>>>    void (*pm_power_off_prepare)(void);
>>>> +EXPORT_SYMBOL_GPL(pm_power_off_prepare);
>>> Why do you need this where no other driver in the kernel does?
>>      There is a gpio_slp pin for RK809 and RK817，this pin has reset、power
>> down and sleep functions，so
>>      when system is going to power down, this pin is needed to switch to
>> power down function，and then we just only control
>>      this pin to high to power down the system in atf at last。
> There are other PM call-backs that you can use for this.  There
> shouldn't be any requirement to export and call functions at this
> level directly.
     I will use a shutdown call-backs from syscore to implement it.
>


