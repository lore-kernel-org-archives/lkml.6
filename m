Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF5BC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ACE2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ha76+mpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ACE2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbeKGSlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:41:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42807 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeKGSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:41:11 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181107091142euoutp02deb2131507bb06438e613303f577e0c4~kzJKvUoJR0044900449euoutp02K
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 09:11:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181107091142euoutp02deb2131507bb06438e613303f577e0c4~kzJKvUoJR0044900449euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541581902;
        bh=xhQArIP8M90BiAOzhDQO9q3VCr4IVh2ihHjsdswmKik=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ha76+mpEugIVDm+PkQD5Ps93d8+lKWaozscdBzjQoQsOuFfxo84hY+bJGGhN3+2bt
         /VjLd5IZDbdxqJa98ioyTPwbRwu7IIREe7fy0MA3VRON0sM8GtFPrb+VIlDG8OW25R
         1CCE397Y6Y5+Tn5JP05oiA3kRbk5Nv5T5qYAPaSI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181107091141eucas1p17bd43d5d4302d09818122e72e5a080a1~kzJJrxx0_1434314343eucas1p1H;
        Wed,  7 Nov 2018 09:11:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 79.04.04806.D4CA2EB5; Wed,  7
        Nov 2018 09:11:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107091140eucas1p10c3728aab8af3ce7b8c739a057dcc59c~kzJId7IzP1434314343eucas1p1E;
        Wed,  7 Nov 2018 09:11:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181107091140eusmtrp2e72ceea270f09bbb3a8293fb102b918a~kzJIRNuyQ1205312053eusmtrp2r;
        Wed,  7 Nov 2018 09:11:40 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-97-5be2ac4d9c3e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.5E.04128.C4CA2EB5; Wed,  7
        Nov 2018 09:11:40 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181107091139eusmtip14453795dfd01f9c74430736af8e9703f~kzJHfd0f91038510385eusmtip1V;
        Wed,  7 Nov 2018 09:11:39 +0000 (GMT)
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <25c24350-4acd-68b8-ef5d-75a60094f0b6@samsung.com>
Date:   Wed, 7 Nov 2018 10:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRTG+7+3vYrTt2ntoF3XoBupkeAfkm4UvB+K6kuF+1ArXyx0Gpua
        KZgllqWCJhUOc5VZmYtqmTXTLmt5mWgzy7xQ2rJyhYnMWVZqbq+R337nPOfhOQcOS8rOM8Hs
        oYQkQZugjlcwvlR1/Vjrqm1GhyrcNj4f57c2ETi7/jPCQ9fyEDZYW2n82j3EYNfl9wQeMRUw
        +M0PJ4lNHztoPJz3nsbtNSUM/u2ol+Dyt20E7nM+Qdh2PJvCbbYtOLvOKsETHXcpPGZ5SWDn
        cCO1IYi/NdxL82VjEwRvLDUifqgzW8KXGtP5O45Kmjfr30n42sImhjfdPM3wD0b7aL43t4Hg
        7109xj/NL6J4l2nBDv9o36gYIf5QiqANW7fP96C5bd7h1oWpT5wGSSbKCj6DfFjgIqD9+w3m
        DPJlZdwNBF8KyymxGEHgNnQhsXAheDFgpf9ZBj6ck4jCdQQXMqumi0EE4+bn3qlATgMVnWMS
        DwdxK2G0+Js3hORyGai4e4nwCAy3HMbvdTEelnLrIPO302ugOCW8sDYhD8/h9kBOb+X0zGxo
        Ku6nPOzD7YTSjoveMJJbCA8GS0iR5dDdbyA8YcDZWZjscDHi3pvhc02tRORA+NpQNc3zYNJs
        IEQ+BieKX5OiOQdBY9n1afNaeN7QNpXGTiUsh9s1YWJ7I1T01HnbwPlD5+BscQd/OFt9gRTb
        Usg5KROnF0Nvy31SZDmU291MAVLoZ1ymn3GNfsY1+v+5lxB1E8mFZJ0mVtCtSRCOhOrUGl1y
        QmzogUSNCU19a/NEg/shevxnvwVxLFL4Se33P6hktDpFd1RjQcCSiiBpfqVDJZPGqI+mCdrE
        vdrkeEFnQSEspZBL02f1qWRcrDpJiBOEw4L2n0qwPsGZqIRWNn9d+kt56kDuklDqaWKSn41v
        8eeWRUpV0KnIeHM1NaObuhP3MSDCJ/xPS8+S2xk/Q/KWbVUGFHWHBTZGxay/OGD/pnenFeYH
        P9uUvlKo2nwia9GGCLMjLbpLbot+NLenLjXO70pkaGQ/q939alfz7pDtE7UOu3TS+Kl6S7tS
        QekOqlevILU69V/bj25pqQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsVy+t/xu7o+ax5FG/ReZbPoPXeSyaL12DNG
        i/fLehgt5h85x2px5et7NovPC+8xWXzZNIHN4ur3l8wWmx5fY7X42HOP1eLyrjlsFr8fHWO3
        WHr9IpPFg5f7GS1ONbayWFw85WrRuvcIu8W/axtZLH4eOs9k8fLjCRYHEY+1H++zeiz++Y/J
        Y828NYwe72+0snvMW1PtseHRalaPnbPusnvsmXiSzWPTqk42j+3fHrB63O8+zuSxeUm9x4He
        ySwenzfJBfBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW
        6dsl6GXsvChTcE6+Yv/L+ewNjM1SXYycHBICJhIvHk5l72Lk4hASWMoo8b9pByNEQlxi9/y3
        zBC2sMSfa11sEEWvGSWebXsBlhAWyJVYeeMnO4gtIqAt8W3ma7AiZoFeNomNC3qZIToOMUs8
        PHuSFaSKTUBT4u/mm2wgNq+AnUTD75dg3SwCKhJHj5wEWy0qECFx9uU6RogaQYmTM5+wgNic
        AoES867NBZvDLKAu8WfeJWYIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUo
        klpanJueW2ykV5yYW1yal66XnJ+7iRGYTLYd+7kFGDTvgg8xCnAwKvHwaux4GC3EmlhWXJl7
        iFGCg1lJhPd3wqNoId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJrq8knhDU0NzC0tDc2Nz
        YzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2Mobtvnt0U8NxE+k+fodYdcZ5s68r9p142
        mTDP3O4pPW/B/WPpx3fOvX9kc5aY7xMRYa2zQfW2+jvyN/tenPbgUaFoje5cz7Dts07sep88
        dapXsNXj8IlVkaeTOvexFuQ4Mkwv2fjqgj9r2eODD6TexF4O3d6oarhfYc7aU1Kr/l1m/HWf
        i8vnmxJLcUaioRZzUXEiAGGhe0I8AwAA
X-CMS-MailID: 20181107091140eucas1p10c3728aab8af3ce7b8c739a057dcc59c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
        <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
        <20181026144344.27778-18-jagan@amarulasolutions.com>
        <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
        <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
        <bfe28e8d-3786-d35d-a589-abed9ee8e7d5@samsung.com>
        <CAMty3ZAWkX8YSRzFs_GS2O4+=pf68e4EuSMym+_XpCe3_4-2yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2018 19:08, Jagan Teki wrote:
> On Wed, Oct 31, 2018 at 2:45 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> On 31.10.2018 09:58, Chen-Yu Tsai wrote:
>>> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 26.10.2018 16:43, Jagan Teki wrote:
>>>>> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
>>>>> bridge panel, which is available on same PCB with 24-bit RGB interface.
>>>>>
>>>>> So, this patch adds DSI specific binding details on existing
>>>>> dt-bindings file.
>>>>>
>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>>> ---
>>>>> Changes for v3:
>>>>> - Use existing binding doc and update dsi details
>>>>> Changes for v2:
>>>>> - none
>>>>>
>>>>>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>> index 35bc0c839f49..b7855dc7c66f 100644
>>>>> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
>>>>> @@ -1,12 +1,39 @@
>>>>>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>>>>>
>>>>> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
>>>>> +
>>>>> +Depending on the variant, the PCB attached to the panel module either
>>>>> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
>>>>> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
>>>>> +itself
>>>> As I understand this is display board, which contains 'pure' RGB panel
>>>> S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
>>>> These are separate devices, just connected by vendor to simplify its
>>>> assembly. Why don't you create then bridge driver for ICN6211 and RGB
>>>> panel driver for S070WV20-CT16 - it looks more generic.
>>>> Then you can describe both in dts and voila.
>>>> Creating drivers for every combo of devices (panel + bridge), just
>>>> because some vendor sells them together seems incorrect - we have
>>>> devicetree for it.
>>> Rob suggested this, and also the opposite: using the same
>>> "bananapi,s070wv20-ct16"
>>> compatible string for both types of connections, and have the driver deal with
>>> detecting the bus type.
>>>
>>> The thing about the bridge chip is that there's no available datasheet that
>>> describes all the parts of the init sequence, in fact none at all. I managed
>>> to work out some bits, but the others remain a mystery and must be hard-coded
>>> to match the panel. That would work against having a generic bridge driver.
>>
>> But it is common for many chips - 1st version of the driver is developed
>> on one platform and it supports only one configuration, if next platform
>> with the same cheap appears the driver is augmented if necessary.
> At-least few of the commands from panel initialization code, the
> respective opcode data values are based on panel timings and even
> clock value is different in DSI. I think it look hard to try bridge
> driver for these restrictions, do you have any suggestions?


Where do you see an issue? Since panel is RGB it should have no
initialization sequence (beside regulator/gpio power on/off), so the
only thing to do is to figure out which regulators/gpios belongs to
which component - with publicly available specs it should be doable.

The whole initialization sequence is for the bridge, so you put it into
bridge driver, for starters it can be hardcoded.

Then you can:

1. Try to find other users of this ICN6211 chip and compare
initialization sequences to guess purpose of registers.

2. Try to get specs of the chip (ask vendor, distributor, grep Internet).

3. Do nothing - if there will be other users of the bridge they will do
this work.


Regards

Andrzej


