Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FE0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F2020857
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfA1NUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:20:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55581 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbfA1NUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:20:51 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SDGDEL026737;
        Mon, 28 Jan 2019 14:20:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2q8djan9qb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 28 Jan 2019 14:20:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6180F38;
        Mon, 28 Jan 2019 13:20:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25F452BA3;
        Mon, 28 Jan 2019 13:20:34 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.46) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 28 Jan
 2019 14:20:33 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com>
 <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
 <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com>
 <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
Message-ID: <47a3fe9f-8adb-8f47-e7c1-342f8fc318aa@st.com>
Date:   Mon, 28 Jan 2019 14:20:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 4:11 PM, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 3:10 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>
>> On 1/16/19 1:14 PM, Arnd Bergmann wrote:
>>> (sorry for the late reply, I just realized that I had never sent out the
>>> mail after Lee asked me for a review last year and I had drafted
>>> my reply).
>>
>> Hi Arnd,
>>
>> Many thanks for reviewing, no worries :-)
>>
>>>
>>> On Wed, Dec 12, 2018 at 9:48 AM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>>>
>>>> Some system control registers need to be clocked, so the registers can
>>>> be accessed. Add an optional clock and attach it to regmap.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>
>>> This looks ok to me in principle, but I have one question: When we
>>> do a clk_get() and clk_prepare() as part of regmap_mmio_attach_clk(),
>>> does that change the behavior of syscon nodes that are otherwise
>>> unused?
>>
>> I'm not sure I correctly understand this question. I don't think it will
>> change the behavior for "unused" nodes. These should remain unused with
>> this patch.
> 
> What I mean is that nodes that listed as 'compatible="syscon"' get
> probed by the syscon driver even when no other driver references
> them, and that in turn would acquire the clock, right?

Hi Arnd,

Sorry for the late reply.

When no other driver references them, nothing happens at probe time on
the clock: no calls to get/prepare... the clock.

=> The clock will remain unrequested & unused until another driver calls
one of "of_syscon_register()" variants:
- syscon_node_to_regmap
- syscon_regmap_lookup_by_compatible
- syscon_regmap_lookup_by_phandle

When another driver references them (e.g. one of the above calls), then
it will acquire the optional clock and use it, e.g.:
- clk_prepare() upon of_syscon_register() variants
- clk_enable & clk_disable when accessing the registers

I hope this clarifies.

Please advise,
Best Regards,
Fabrice

> 
>>> I think we have a bunch of devices that started out as a syscon but
>>> then we added a proper driver for them, which would handle the
>>> clocks explicitly. Is it guaranteed that this will keep working (including
>>> shutting down the clocks when they are unused) if we have two drivers
>>> that call clk_get() on the same device node?
>>
>> I'd expect nothing wrong happens when two drivers call clk_get() for the
>> same clock.
>> Are there some case where two drivers are bind (e.g. syscon driver +
>> another driver) for the same piece of hardware ?
> 
> You won't actually have two drivers binding to the same device, but you
> could have a driver and a syscon user that does relies on the
> syscon_regmap_lookup_by_*() functions.
> 
> I think we've had a couple of cases where we started out representing
> a device as syscon, and then later decided that a high-level abstraction
> would be needed because syscon didn't quite support all the needed
> features.
> 
> Since each syscon node should also have a more specific
> compatible value, you can then have another driver that binds
> to that compatible string.
> 
>       Arnd
> 
