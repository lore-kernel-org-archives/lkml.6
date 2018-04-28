Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeD1Btu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 21:49:50 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:57902 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD1Bts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 21:49:48 -0400
Subject: Re: [PATCH v7 0/7] clk: meson-axg: Add AO Cloclk and Reset driver
To: Kevin Hilman <khilman@baylibre.com>
References: <20180426084437.192394-1-yixun.lan@amlogic.com>
 <1524820841.4026.112.camel@baylibre.com>
 <fbd24a73-6793-76be-3ca5-04cbac5db198@amlogic.com>
 <1524823154.4026.123.camel@baylibre.com>
 <ab754711-f727-133c-7bc3-a9f3243c2278@amlogic.com>
 <7hsh7g1o3k.fsf@baylibre.com>
CC: <yixun.lan@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <973672c6-1cc1-7f38-ac30-263fd5f0b69c@amlogic.com>
Date: Sat, 28 Apr 2018 09:50:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7hsh7g1o3k.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin

On 04/28/18 02:49, Kevin Hilman wrote:
> Hi Yixun,
> 
> Yixun Lan <yixun.lan@amlogic.com> writes:
> 
>> On 04/27/2018 05:59 PM, Jerome Brunet wrote:
> 
> [...]
> 
>>>
>>> Looks to be the problem indeed. But it is still an issue with how your patchset
>>> in organized.
>>>
>>> I can't merge this until Kevin merges the patch above, which he can't merge
>>> until there is the clkc_ao support in axg, which is given by this series.
>>>
>>> 1# You should remove the axg part of the patch above. Kevin will be able to
>>> merge it w/o any dependencies. (BTW, the patch is broken for axg because 1) you
>>> did not include the dt-binding header for the clkc_ao in axg and 2) the clkc_ao
>>> does not exist at this stage)
>>> 2# I can then safely merge this series - w/o breaking gxbb and gxl.
>>> 3# Finally you'll have to make a DT change for the axg, enabling the clkc_ao and
>>> changes the uart clocks at the same time.
>>>
>>
>>   I didn't make myself clear in previous email
>>
>>   I mean, could you merge patch 1-6, just exclude the patch 7
>> then kevin can merge the DT part (there are three patches) [1]
>> after the DT patches merged, then you can take this patch 7
>> This way, it won't break gxl or any other SoCs
>>

>>   I'm sending patch 7 along with this series, it would be better if I
>> give a warning about it.
> 
> Your proposal requires extra work from a couple different maintainers to
> track all the dependencies, and is very error prone.  Sometimes
> maintainers may do this for you if they have time and are feeling
> generous, but you will have much more success if you can ease the
> process.
> 
Indeed

 I've actually put a note in the cover letter to highlight special
attention needed for patch 7, but turns out rely on maintainers to
handle the dependencies isn't a wise idea
 Lesson has been learned here, and I'll handle dependencies myself next
time.


> Jerome has provided lots of guidance throughout this series and just
> above has provided you with a very good proposal above which minimizes
> the dependencies, and provides the changes in the right order.
> 
> Please follow Jerome's suggestion,
> 
as already replied in my previous email, again here is my approach

a) I'll send patch 2-6, just leave out patch 7 for now, and as patch 1
is already accepted.. this way it won't break gxbb/gxl (the OLD SoC)
b) will pin you to require DT patch merged or re-send if necessary (as
till now the clkao driver is merged)
c) send out the patch 7 for UART AO clock fix

this is exactly what Jerome suggested..

Thank you

Yixun
