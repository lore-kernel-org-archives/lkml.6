Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeA3S7c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:59:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37012 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeA3S7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:59:30 -0500
X-Google-Smtp-Source: AH8x2276wMben1MIOiKmxMHV6RfU2YLoBfSobUbFoPj1Tew8ObJ/FcQz/1wyKB5iarXFVB5d+W63cA==
Subject: Re: [PATCH v2] of: use hash based search in of_find_node_by_phandle
To: Chintan Pandya <cpandya@codeaurora.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1516955496-17236-1-git-send-email-cpandya@codeaurora.org>
 <2d877704-47c5-c1fc-1b89-976cd9b1ccaa@gmail.com>
 <7ebd275d-07ba-1972-011a-d05e53233a01@codeaurora.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <b97a5447-eb1c-ab35-a0c2-487275b3f3d2@gmail.com>
Date: Tue, 30 Jan 2018 10:59:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <7ebd275d-07ba-1972-011a-d05e53233a01@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/18 00:04, Chintan Pandya wrote:
>> (1)
>>
>> Can you point me to the driver code that is invoking
>> the search?
> There are many locations. Few of them being,
> https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/of/irq.c?h=msm-4.9#n214
> https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/irqchip/irq-gic-v3.c?h=msm-4.9#n1107
> https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/clk/msm/msm-clock-controller.c?h=msm-4.9#n492
>>
>> (2)
>>
>> And also the .dts devicetree source file that you are seeing
>> large overhead with.
> SDM670 DTS tree starts here.
> https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/arch/arm64/boot/dts/qcom/sdm670.dtsi?h=msm-4.9

Thanks, I'm starting to get a picture of what you are facing.

The file you point at is a .dtsi, not a .dts.  There are quite a
few sdm670*.dts files in that tree.  Which one corresponds to
the system you are working on?

I picked a random one (sdm670-cdp.dts), but I need to be looking
at the .dts that you are using to be able to ask reasonable
questions instead of poking around in the dark.

Also, when I clone that git tree there is not a valid HEAD.  I
picked what looked like a reasonable commit to checkout, but I
would prefer to be looking at the same exact source that you
are working with.  Can you give me the commit id  of the branch
that you are working on?

-Frank


>>
>>
>> (3) -- this one is less important, but if the info is easily
>>         available to you
>>
>> Sorry about dribbling out questions instead of all at once....
>>
>> What is the hardware you are testing this on?
> SDM670
>> Processor?
> Kryo-300 Silver
>> Cache size?
> From DT,
> L1 32KB (per CPU)
> L2 128KB (per CPU)
> L3 1MB (total)
>> Memory size?
> 6GB
>> Processor frequency?
> Max 1.7GHz for core 0. Not sure about boot time frequency.
>> Any other attribute of the system that will help me understand
>> the boot performance you are seeing?
> I'm not able to profile of_find_node_by_phandle specifically as timers are
> not up by then. So, just observing overall boot time for comparison.
> 
> My recent results were taken on debug_defconfig which has many performance
> slowing code. So, gap between base-build and w/ the test patches would be
> more than the actual production build.
> 
> Thanks,
> Chintan
> 
