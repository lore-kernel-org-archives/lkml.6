Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeDDJGa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:06:30 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:46526 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeDDJG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:06:28 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3496NTp024569
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AIpwx48gZMCMUD13Jui6n2e9HaY/3BWdi0PsZSGxVGIY1fUKzm4WEncGhBAHbkkOWgPpNePYulUcH2mM/cdMnlDOp7I=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpgrHTD9_FcfAi7kU3_N0=Hqty4tS7suTotPF98kzxM-w@mail.gmail.com>
References: <1522142993-25654-1-git-send-email-yamada.masahiro@socionext.com> <CAPDyKFpgrHTD9_FcfAi7kU3_N0=Hqty4tS7suTotPF98kzxM-w@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Apr 2018 18:05:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3AN1sKHJyH-mfbKfSd2hB3S2GT87=9PhLAnTRJ4CYJA@mail.gmail.com>
Message-ID: <CAK7LNAT3AN1sKHJyH-mfbKfSd2hB3S2GT87=9PhLAnTRJ4CYJA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: send tune request twice to work
 around errata
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Piotr Sroka <piotrs@cadence.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-04-04 16:35 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 27 March 2018 at 11:29, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Cadence sent out an errata report to their customers of this IP.
>> This errata is not so severe, but the tune request should be sent
>> twice to avoid the potential issue.
>>
>> Quote from the report:
>>
>> Problem Summary
>> ---------------
>> The IP6116 SD/eMMC PHY design has a timing issue on receive data path.
>> This issue may lead to an incorrect values of read/write pointers of
>> the synchronization FIFO. Such a situation can happen at the SDR104
>> and HS200 tuning procedure when the PHY is requested to change a phase
>> of sampling clock when moving to the next tuning iteration.
>>
>> Workarounds
>> -----------
>> The following are valid workarounds to resolve the issue:
>>
>> 1. In eMMC mode, software sends tune request twice instead of once at
>>    each iteration. This means that the clock phase is not changed on
>>    the second request so there is no potential for clock instability.
>> 2. In SD mode, software must not use the hardware tuning and instead
>>    perform an almost identical procedure to eMMC, using the HRS34 Tune
>>    Force register.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Do you want this to be tagged for stable as well? And perhaps you
> could add a fixes tag?


It would be nicer to make it a back-port candidate,
but this patch can not cleanly apply to the initial commit of this driver.


If you apply it for -next, it would be fine with me.






-- 
Best Regards
Masahiro Yamada
