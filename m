Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBTJgS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:36:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57021 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBTJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:36:11 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180220093608euoutp021628ce46f866b9a615342745c81292e8~U-wRJSmXJ0545405454euoutp02f
X-AuditID: cbfec7f5-b5fff700000028a9-6c-5a8bec0654b5
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
Subject: Re: [PATCH 1/8] clk: Add clk_bulk_alloc functions
To: Robin Murphy <robin.murphy@arm.com>,
        Maciej Purski <m.purski@samsung.com>, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Kamil Debski <kamil@wypas.org>, Andrzej Hajda <a.hajda@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thibault Saunier <thibault.saunier@osg.samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, Jeongtae Park <jtp.park@samsung.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <f13fb12b-54e6-104b-4ec0-192d1bb72cc8@samsung.com>
Date: Tue, 20 Feb 2018 10:36:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <b67b5043-f5e5-826a-f0b8-f7cf722c61e6@arm.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO3eXi9My9lGhMRAkKJOKPiqitOJARUF/YkS59GSiTtnULj/K
        S6bO+7U5pDRSSyx1qZWR5ZSWZZuXZbPQIi2bl5x5Kcusnc4C/z3P+zzf+7zvy8fgslpqNROu
        juU1alWkgpIQTc/mLRuo8QzlJsfXVejtXQuJsiwdGDI4UglUr68lkW12kkLOvBKAJqt0FMp/
        n0ugd411BBqfqMFQ+53XGPoy2E2gkuepJMoZGsOR1VpHo1dJ4zQyDvWRaCpzkES9zaUUyqxr
        JJHe2oIhU9FjgMocbwlUaVzAUPeLfajVOUyitnFXk8W+egLpCxwUmn6aj+/25mqu1QCut68b
        5ybtKTRX+Kue5B4aBmjOWJ1OcffnPpDc+wwzxt27eYlryHHVsxuqATdt9OZs7Yn0EalSsjOU
        jwyP5zX+u4IlZx5/OxeTuvbcUJcNTwCJch3wYCC7BWaOFQMdkDAy9haAi0k2N5kGsOJ7M/nf
        lT12GROFSgBrRsy4IEjZFfBHwSAhYJzdDj8vppCiacRlchbSgrBSEDrncEHwYoswaP9toASC
        s+U0fN53+5+LYgOgbkJHiW13weTi6/8wwfrC0k69K5thVrHH4djCfqHswe6AvR9nMDHZB7ba
        RtxTyGFySj8h9IdsOQOTfzkpcYe9MHH2ixuvhKPmBlrEa2F6WismPshxXeCPw030ANZOpbhd
        O2CbuZsUI5bD/KaruDARZKUw7YpMtHAwO+sTIeI9sCS1CghYxiZhsPzWulzgbVhyMsOSkxmW
        LGFYskQZIKqBnI/TRoXx2s1q/uxGrSpKG6cO2xgSHWUErm/8ctE8+wC0LJwyAZYBCk/pigGd
        Ukaq4rXno0wAMrjCSxpYkaGUSUNV5y/wmuiTmrhIXmsCaxhCIZee8LuolLFhqlg+gudjeM1/
        FWM8VieAnTMHYsCTooMhzd9NzraC201HsZ+nY+3zXjc6ZSdDa03pgT1Oqx9GeZbZR/2HfSRp
        ni/3d01Y9M6qZe+ONXZt69lteeRXmvNZERwblJCFd5RfvVaoxuu3llmHmDcBn3qYiez54ROH
        k7y/5s3a+w9FkNhDtXzGQktH9b5BA8FbFIT2jCpgPa7Rqv4Cxbh008IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO7cdrdFxGX6YKa0UlPJSER8rLYLghBBB0I9R2dKDWk5tR03D
        SGdqTVPzxjasjLyAzXSbdkVp09S8TVNXKV5Q08SJmiZJITkt8N/D+1x/vDQuUpKudGR0HKeI
        lkWJKUeiY63VepC0ZUn9izPc0OCLbhI96P6IIe1MJoH06hoS9f+cp9DCQw1A85UqCuWP5hFo
        qL6WQLY5HYaaqwcw9H2kl0CatkwS5U7M4shiqRWgLqVNgAwTVhItZo+QqO9tCYWya+tJpLY0
        Yshc1ABQ6cwggSoMfzDU234amRYmSdRkWw9Zs+oJpC6YodDS+3z8pDure6wDbJ+1F2fnv6QL
        2MLfepJ9ox0WsIaq+xT7amWMZEezWjHWWHaHrctdv+fUVQF2yeDO9jenCs4JpY7Hw7ioyARO
        4Rd0xTGi4UdibKZb4kRPP54CUl1UwIGGzBGYM3sXUwFHWsSUAdjQPkDaCSHjBH8VjBB2jDNH
        4fJME7kpmgbQMJ6/IdrJSOBU5wpuJ5yZAgx2rCo3onCmXAC1BVpq06LE4FTzO9xuoZgAqJpT
        UZsdQTCt+MkGJhhPWNKpxux4F3MRFi3qNyocmGOwb3wZ29zhAU390/82ucC09K9EHmC0W+Zq
        t8zVbrFot1hKAVEFnLl4Xh4u5wN8eZmcj48O9w2NkRvA+me8bFk1vgaf9OfNgKGBeLuQGVZJ
        RaQsgU+SmwGkcbGz8FR5llQkDJMl3eIUMSGK+CiON4PdNCF2EVr8k6QiJlwWx13nuFhO8Z/F
        aAfXFHDGJBiadPlQXSqpDNyjvN3V6EmGDIZs0934Zl6bs7qLQcUJnbfY4ul1sz1euOPy1bHP
        QUOHY70uPPc2GoP3zXaI69sPPNub4KdRmvDC0OSFjP0elcGX9EUeLV6tAWclEm7p6aGaaxc0
        gTVtucu+kmA/zqkv+d6jpM7ekJ6MoTAfMcFHyAJ8cAUv+wtuTUaRFQMAAA==
X-CMS-MailID: 20180220093605eucas1p1ecfc5f4919bd01ec1b3768f63d71d008
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c
X-RootMTR: 20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c
References: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
        <CGME20180219154456eucas1p15f4073beaf61312238f142f217a8bb3c@eucas1p1.samsung.com>
        <1519055046-2399-2-git-send-email-m.purski@samsung.com>
        <b67b5043-f5e5-826a-f0b8-f7cf722c61e6@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2018-02-19 17:29, Robin Murphy wrote:
> Hi Maciej,
>
> On 19/02/18 15:43, Maciej Purski wrote:
>> When a driver is going to use clk_bulk_get() function, it has to
>> initialize an array of clk_bulk_data, by filling its id fields.
>>
>> Add a new function to the core, which dynamically allocates
>> clk_bulk_data array and fills its id fields. Add clk_bulk_free()
>> function, which frees the array allocated by clk_bulk_alloc() function.
>> Add a managed version of clk_bulk_alloc().
>
> Seeing how every subsequent patch ends up with the roughly this same 
> stanza:
>
>     x = devm_clk_bulk_alloc(dev, num, names);
>     if (IS_ERR(x)
>         return PTR_ERR(x);
>     ret = devm_clk_bulk_get(dev, x, num);
>
> I wonder if it might be better to simply implement:
>
>     int devm_clk_bulk_alloc_get(dev, &x, num, names)
>
> that does the whole lot in one go, and let drivers that want to do 
> more fiddly things continue to open-code the allocation.
>
> But perhaps that's an abstraction too far... I'm not all that familiar 
> with the lie of the land here.

Hmmm. This patchset clearly shows, that it would be much simpler if we
get rid of clk_bulk_data structure at all and let clk_bulk_* functions
to operate on struct clk *array[]. Typically the list of clock names
is already in some kind of array (taken from driver data or statically
embedded into driver), so there is little benefit from duplicating it
in clk_bulk_data. Sadly, I missed clk_bulk_* api discussion and maybe
there are other benefits from this approach.

If not, I suggest simplifying clk_bulk_* api by dropping clk_bulk_data
structure and switching to clock ptr array:

int clk_bulk_get(struct device *dev, int num_clock, struct clk *clocks[],
                  const char *clk_names[]);
int clk_bulk_prepare(int num_clks, struct clk *clks[]);
int clk_bulk_enable(int num_clks, struct clk *clks[]);
...



>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> ---
>>   drivers/clk/clk-bulk.c   | 16 ++++++++++++
>>   drivers/clk/clk-devres.c | 37 +++++++++++++++++++++++++---
>>   include/linux/clk.h      | 64 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 113 insertions(+), 4 deletions(-)
>>
>
> [...]
>> @@ -598,6 +645,23 @@ struct clk *clk_get_sys(const char *dev_id, 
>> const char *con_id);
>>     #else /* !CONFIG_HAVE_CLK */
>>   +static inline struct clk_bulk_data *clk_bulk_alloc(int num_clks,
>> +                           const char **clk_ids)
>> +{
>> +    return NULL;
>
> Either way, is it intentional not returning an ERR_PTR() value in this 
> case? Since NULL will pass an IS_ERR() check, it seems a bit fragile 
> for an allocation call to apparently succeed when the whole API is 
> configured out (and I believe introducing new uses of IS_ERR_OR_NULL() 
> is in general strongly discouraged.)
>
> Robin.
>
>> +}
>> +
>> +static inline struct clk_bulk_data *devm_clk_bulk_alloc(struct 
>> device *dev,
>> +                            int num_clks,
>> +                            const char **clk_ids)
>> +{
>> +    return NULL;
>> +}
>> +
>> +static inline void clk_bulk_free(struct clk_bulk_data *clks)
>> +{
>> +}
>> +
>>   static inline struct clk *clk_get(struct device *dev, const char *id)
>>   {
>>       return NULL;
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
