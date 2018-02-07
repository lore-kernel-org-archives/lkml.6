Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeBGDMb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 22:12:31 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38437 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeBGDMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 22:12:30 -0500
X-Google-Smtp-Source: AH8x224XMM07zPDhJ2GjtLLGyvJGVC7bjAhc/q+VJ8wRT9PO5yd3Sz1HUs1AnsmZoM9NNaETYfbTHrHlazFt0rh8t/c=
MIME-Version: 1.0
In-Reply-To: <CAAfSe-uQqVPB5B0OYij-bx6Q7AnGnONNqYtwWkU_b2rSJfCpfw@mail.gmail.com>
References: <6fff71482ed7bb63afa46c024638c0a72810ce29.1517913264.git.baolin.wang@linaro.org>
 <CAAfSe-uQqVPB5B0OYij-bx6Q7AnGnONNqYtwWkU_b2rSJfCpfw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 7 Feb 2018 11:12:29 +0800
Message-ID: <CAMz4kuK9GAR8Ao7RbN5+QUo2-v-bDXaCbtGrzE7Qx_TY=xfTng@mail.gmail.com>
Subject: Re: [PATCH] arm64: Enable SPRD_TIMER
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?T3Jzb24gWmhhaSAo57+f5LqsKQ==?=
        <orson.zhai@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2018 at 10:31, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> Hi Baolin,
>
> On 6 February 2018 at 18:36, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Enable Spreadtrum timer driver for Spreadtrum plaform, which will be used
>> as tick broadcast device.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  arch/arm64/Kconfig.platforms |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index fbedbd8..3e0bbb0 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -224,6 +224,7 @@ config ARCH_TEGRA
>>
>>  config ARCH_SPRD
>>         bool "Spreadtrum SoC platform"
>> +       select SPRD_TIMER
>
> Do we have to select SPRD_TIMER here? SC9836, SC9860 have been working
> with a minimum system without SPRD TIMER.

Yes, we need register this timer as the tick broadcast device,
otherwise we will use one hrtimer to be registered the broadcast
device, which will affect the No-Hz of CPU attaching the
broadcast-hrtimer.

-- 
Baolin.wang
Best Regards
