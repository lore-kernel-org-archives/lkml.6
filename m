Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937500AbeBUQqe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:46:34 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:38712 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933280AbeBUQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:46:31 -0500
Subject: Re: [PATCH] ARM: dtc: tegra: enable front panel leds in TrimSlice
To: Tomasz Maciej Nowak <tmn505@gmail.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180219201623.6987-1-tmn505@gmail.com>
 <57945bd2-d8c2-f7bc-f01f-29d679762446@wwwdotorg.org>
 <873b01dc-3ca5-3151-2654-a8272cb9dd88@gmail.com>
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <f291dd94-107f-cf03-a8e8-bc0806421c2d@wwwdotorg.org>
Date: Wed, 21 Feb 2018 09:46:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <873b01dc-3ca5-3151-2654-a8272cb9dd88@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 09:20 AM, Tomasz Maciej Nowak wrote:
> W dniu 20.02.2018 o 20:55, Stephen Warren pisze:
>> On 02/19/2018 01:16 PM, Tomasz Maciej Nowak wrote:
>>> Adds device nodes for two front panel LEDs.
>>
>> Why do you need to change the pinmux settings? Configuring a pin as a 
>> GPIO should override any pinmux special function selection and hence 
>> make it irrelevant, so I don't think you should need to change the 
>> pinmux.
> 
> At first I did exactly that without changing the pinmux, but the LEDs 
> didn't light up. After that I compared with CompuLab source tree [1]. 
> The pinmux was specified as in my patch. With this change the LEDs are 
> fully functional.
> 
> 1. 
> https://gitorious.org/trimslice-kernel/trimslice-kernel?p=trimslice-kernel:trimslice-kernel.git;a=blob;f=arch/arm/mach-tegra/board-trimslice-pinmux.c;h=cc6d5225d97eb9327c820bf1d5b2bc16ab8c6dda;hb=d25bf45d6314089489b30d218ed8a0d6d94417f9#l45 

Oh I see. Your patch isn't changing the pinmux function selection but 
the other configuration bits, which are relevant even when the pin is in 
GPIO mode. In particular, it clears the tristate bit for the dte 
pingroup. That makes perfect sense.
