Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933561AbeCEJHB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:07:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42193 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932868AbeCEJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:06:51 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180305090648euoutp01e2d2df4435c73e34831d0dfd1e525cd2~Y_vYOTFok2892228922euoutp01F
X-AuditID: cbfec7f2-5ffe19c000011644-bc-5a9d08a70e92
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [PATCH v2 4/8] clk: migrate the count of orphaned clocks at
 init
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Message-id: <40e6c987-633c-b806-02e8-5299187bbcf0@samsung.com>
Date: Mon, 05 Mar 2018 10:06:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <7c9b0ac1-582c-9b25-4d62-844667e80507@samsung.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7rLOeZGGXyfZGjxZeouZos3j44w
        W5w/v4Hd4mPPPVaLy7vmsFlcPOVq8eNMN4vFv2sbWSxebBF34PR4f6OV3eNyXy+Tx6ZVnWwe
        G9/tYPL4vEkugDWKyyYlNSezLLVI3y6BK2PJLLmC1ToVZ1f+Ymlg7FTtYuTkkBAwkdjydSFr
        FyMXh5DACkaJWQe6oJzPjBKPD01kgana37GdCSKxjFHi/qu9YAleAUGJH5PvgdnMAlYSz/61
        QnU/Z5R4dOYKI0hCWMBf4vTLl8wgNpuAoUTX2y42EFtEoEJiw78tbCANzAIXGSVed14AmsQB
        NNVO4vz8eBCTRUBV4veJLBBTVCBG4vUfN5BOTgF7iVnLj7BBrJWXOHjlOdQJ4hLNrTdZQCZK
        CFxmk/jU0s8G8YCLRNuTGVC2sMSr41vYIWwZic6Og0wQdr1E3/cjTBDNPYwSe1umQiWsJQ4f
        v8gKsYFPYtK26cwgB0kI8Ep0tAlBlHhIbFywBRpYjhJzlm8FKxcS+MQosepx0gRGuVlIwTUL
        KbhmIflhFpIfFjCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMMaf/Hf+0g/HrpaRD
        jAIcjEo8vDvy5kQJsSaWFVfmHmKU4GBWEuEt+wwU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzhun
        URclJJCeWJKanZpakFoEk2Xi4JRqYAwM3H2/epc4J4e0A5PstiL3f+eW5qYqsO27mbpKslJS
        +NOfVhndV2XGefUZ0vUPy3d596q5/5q5li2sSOhm7NHvEvkxngdeizN/cxe1esPCn/91l9O/
        v6v+v+RiL5VYwTpbJCtoop76FuZP++8Y/qqYuGPKEn+bw0vWBVt6BHqeztu4TX+FkRJLcUai
        oRZzUXEiAPv3dUwtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xa7rLOeZGGTz/zGbxZeouZos3j44w
        W5w/v4Hd4mPPPVaLy7vmsFlcPOVq8eNMN4vFv2sbWSxebBF34PR4f6OV3eNyXy+Tx6ZVnWwe
        G9/tYPL4vEkugDWKyyYlNSezLLVI3y6BK2PJLLmC1ToVZ1f+Ymlg7FTtYuTkkBAwkdjfsZ2p
        i5GLQ0hgCaPE5oZrrCAJXgFBiR+T77GA2MwCZhJfXh5mhSh6ziix7cBDZpCEsICvxNv2NWwg
        NpuAoUTX2y4wW0SgQuLm9I/sEM0XGSX+HK+HaJ7HKNG57jpQggNog53E+fnxICaLgKrE7xNZ
        IOWiAjESUz9uBLuBU8BeYtbyI2wQY+QlDl55DnWPuERz602WCYwCs5CcOgvJqbOQtMxC0rKA
        kWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYCRsO/Zz8w7GSxuDDzEKcDAq8fAKFM6JEmJN
        LCuuzD3EKMHBrCTCW/YZKMSbklhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBAemJJanZqakFq
        EUyWiYNTqoFRIL74u3da4FvD8D73mhdTfU9p6mht9GUV7Hqpy34pVinKsuzOkbsc60KEtswy
        bOs47nPv0cEzc3Pz7D5//vN0fqeW8tkZKoGnVxjIqNde4ZdUtXrCtdxr4hGf98+6dmVJss0+
        nPqb/XKVrVjCcrVC66c7S9+zWXpKz9O+bH2jiml31eOktcuVWIozEg21mIuKEwElPb2xgAIA
        AA==
X-CMS-MailID: 20180305090647eucas1p14c01d34dd2eef3eaab8752bf90591c4c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180305090647eucas1p14c01d34dd2eef3eaab8752bf90591c4c
X-RootMTR: 20180305090647eucas1p14c01d34dd2eef3eaab8752bf90591c4c
References: <20180214134340.17242-1-jbrunet@baylibre.com>
        <20180214134340.17242-5-jbrunet@baylibre.com>
        <7c9b0ac1-582c-9b25-4d62-844667e80507@samsung.com>
        <CGME20180305090647eucas1p14c01d34dd2eef3eaab8752bf90591c4c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018-02-15 13:55, Marek Szyprowski wrote:
> Hi Jerome,
>
> On 2018-02-14 14:43, Jerome Brunet wrote:
>> The orphan clocks reparents should migrate any existing count from the
>> orphan clock to its new acestor clocks, otherwise we may have
>> inconsistent counts in the tree and end-up with gated critical clocks
>>
>> Assuming we have two clocks, A and B.
>> * Clock A has CLK_IS_CRITICAL flag set.
>> * Clock B is an ancestor of A which can gate. Clock B gate is left
>>    enabled by the bootloader.
>>
>> Step 1: Clock A is registered. Since it is a critical clock, it is
>> enabled. The clock being still an orphan, no parent are enabled.
>>
>> Step 2: Clock B is registered and reparented to clock A (potentially
>> through several other clocks). We are now in situation where the enable
>> count of clock A is 1 while the enable count of its ancestors is 0, 
>> which
>> is not good.
>>
>> Step 3: in lateinit, clk_disable_unused() is called, the enable_count of
>> clock B being 0, clock B is gated and and critical clock A actually gets
>> disabled.
>>
>> This situation was found while adding fdiv_clk gates to the meson8b
>> platform.  These clocks parent clk81 critical clock, which is the mother
>> of all peripheral clocks in this system. Because of the issue described
>> here, the system is crashing when clk_disable_unused() is called.
>>
>> The situation is solved by reverting
>> commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting 
>> during registration").
>> To avoid breaking again the situation described in this commit
>> description, enabling critical clock should be done before walking the
>> orphan list. This way, a parent critical clock may not be accidentally
>> disabled due to the CLK_OPS_PARENT_ENABLE mechanism.
>>
>> Fixes: f8f8f1d04494 ("clk: Don't touch hardware when reparenting 
>> during registration")
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Dong Aisheng <aisheng.dong@nxp.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> This patch fixes kernel oops on Exynos5422-based boards (Odroid XU3/XU4)
> mentioned in the following threads:
> https://patchwork.kernel.org/patch/10185357/
> https://www.spinics.net/lists/linux-samsung-soc/msg61766.html

Stephen, Michael: v4.16-rc4 is out today and this regression (which got 
merged
on 22 Dec 2017) is still not fixed yet...

Is there a chance to get it into final v4.16 release?

>> ---
>>   drivers/clk/clk.c | 37 +++++++++++++++++++++----------------
>>   1 file changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index a4b4e4d6df5e..cca05ea2c058 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -2969,23 +2969,38 @@ static int __clk_core_init(struct clk_core 
>> *core)
>>           rate = 0;
>>       core->rate = core->req_rate = rate;
>>   +    /*
>> +     * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
>> +     * don't get accidentally disabled when walking the orphan tree and
>> +     * reparenting clocks
>> +     */
>> +    if (core->flags & CLK_IS_CRITICAL) {
>> +        unsigned long flags;
>> +
>> +        clk_core_prepare(core);
>> +
>> +        flags = clk_enable_lock();
>> +        clk_core_enable(core);
>> +        clk_enable_unlock(flags);
>> +    }
>> +
>>       /*
>>        * walk the list of orphan clocks and reparent any that newly 
>> finds a
>>        * parent.
>>        */
>>       hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, 
>> child_node) {
>>           struct clk_core *parent = __clk_init_parent(orphan);
>> -        unsigned long flags;
>>             /*
>> -         * we could call __clk_set_parent, but that would result in a
>> -         * redundant call to the .set_rate op, if it exists
>> +         * We need to use __clk_set_parent_before() and _after() to
>> +         * to properly migrate any prepare/enable count of the orphan
>> +         * clock. This is important for CLK_IS_CRITICAL clocks, which
>> +         * are enabled during init but might not have a parent yet.
>>            */
>>           if (parent) {
>>               /* update the clk tree topology */
>> -            flags = clk_enable_lock();
>> -            clk_reparent(orphan, parent);
>> -            clk_enable_unlock(flags);
>> +            __clk_set_parent_before(orphan, parent);
>> +            __clk_set_parent_after(orphan, parent, NULL);
>>               __clk_recalc_accuracies(orphan);
>>               __clk_recalc_rates(orphan, 0);
>>           }
>> @@ -3002,16 +3017,6 @@ static int __clk_core_init(struct clk_core *core)
>>       if (core->ops->init)
>>           core->ops->init(core->hw);
>>   -    if (core->flags & CLK_IS_CRITICAL) {
>> -        unsigned long flags;
>> -
>> -        clk_core_prepare(core);
>> -
>> -        flags = clk_enable_lock();
>> -        clk_core_enable(core);
>> -        clk_enable_unlock(flags);
>> -    }
>> -
>>       kref_init(&core->ref);
>>   out:
>>       clk_pm_runtime_put(core);
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
