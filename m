Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeDDMqp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:46:45 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:35905 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDDMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:46:43 -0400
X-Google-Smtp-Source: AIpwx483KEl9hkdGc7/eIMPbChRh6+nCIEW30BmtbOKTehWPtKyiV/sdnqEWJmgAUvznU8RpyROMc9QT2MTlgBAvdrE=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT3AN1sKHJyH-mfbKfSd2hB3S2GT87=9PhLAnTRJ4CYJA@mail.gmail.com>
References: <1522142993-25654-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFpgrHTD9_FcfAi7kU3_N0=Hqty4tS7suTotPF98kzxM-w@mail.gmail.com> <CAK7LNAT3AN1sKHJyH-mfbKfSd2hB3S2GT87=9PhLAnTRJ4CYJA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Apr 2018 14:46:42 +0200
Message-ID: <CAPDyKFonDVCeto_wwmpTPt9pE0WLbMWS4dK2rPvrH2-_e3G0=A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: send tune request twice to work
 around errata
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Piotr Sroka <piotrs@cadence.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 April 2018 at 11:05, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Hi.
>
> 2018-04-04 16:35 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 27 March 2018 at 11:29, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> Cadence sent out an errata report to their customers of this IP.
>>> This errata is not so severe, but the tune request should be sent
>>> twice to avoid the potential issue.
>>>
>>> Quote from the report:
>>>
>>> Problem Summary
>>> ---------------
>>> The IP6116 SD/eMMC PHY design has a timing issue on receive data path.
>>> This issue may lead to an incorrect values of read/write pointers of
>>> the synchronization FIFO. Such a situation can happen at the SDR104
>>> and HS200 tuning procedure when the PHY is requested to change a phase
>>> of sampling clock when moving to the next tuning iteration.
>>>
>>> Workarounds
>>> -----------
>>> The following are valid workarounds to resolve the issue:
>>>
>>> 1. In eMMC mode, software sends tune request twice instead of once at
>>>    each iteration. This means that the clock phase is not changed on
>>>    the second request so there is no potential for clock instability.
>>> 2. In SD mode, software must not use the hardware tuning and instead
>>>    perform an almost identical procedure to eMMC, using the HRS34 Tune
>>>    Force register.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> Do you want this to be tagged for stable as well? And perhaps you
>> could add a fixes tag?
>
>
> It would be nicer to make it a back-port candidate,
> but this patch can not cleanly apply to the initial commit of this driver.
>
>
> If you apply it for -next, it would be fine with me.

Okay, so I have queued it up for 4.18, thanks!

Kind regards
Uffe
