Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1E2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F51120779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F51120779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeGWPaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:30:11 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:16317 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbeGWPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:30:10 -0400
Received: from [192.168.90.67] (61.170.236.39) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 23 Jul
 2018 22:28:42 +0800
Subject: Re: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock
 controller
To:     Kevin Hilman <khilman@baylibre.com>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-2-yixun.lan@amlogic.com>
 <20180711194346.GA32414@rob-hp-laptop>
 <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
 <CABGGisw64MpYx7Pvp+XGt6gfZzie6EKeHdchqS6CPDjmAHBuVA@mail.gmail.com>
 <5442a2e8-eb49-2aa8-e53e-8db88cd0bd58@amlogic.com>
 <CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA@mail.gmail.com>
 <8bf565d3-dbfd-e06d-7076-ba78d7a2e766@amlogic.com>
 <7hbmay3ut6.fsf@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <405ff057-a14e-f9eb-19e0-8d467dda35a1@amlogic.com>
Date:   Mon, 23 Jul 2018 22:28:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <7hbmay3ut6.fsf@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.170.236.39]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Kevin

On 07/23/2018 10:12 PM, Kevin Hilman wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
> 
> [...]
> 
>>>
>>>> Second, we might like to convert eMMC driver to also use mmc-clkc model.
>>>
>>> IMO, this should be done as part of merging this series. Otherwise, we
>>> have duplicated code for the same thing.
>>
>> IMO, I'd leave this out of this series, since this patch series is quite
>> complete as itself. Although, the downside is code duplication.
>>
>> Still, I need to hear Jerome, or Kevin's option, to see if or how we
>> should proceed the eMMC's clock conversion.
>>
>> I could think of three option myself
>> 1) don't do the conversion, downside is code duplication, upside is NO
>> DT change, no compatibility issue
>> 2) add a syscon node into eMMC DT node, then only convert clock part
>> into this mmc-clkc model, while still leave other eMMC register access
>> as the usual iomap way (still no race condition)
>> 3) convert all eMMC register access by using regmap interface.
>>
>> both 2) and 3) need to update the DT.
>>
>> and probably 2) is a compromise way, and 1) is also OK, 3) is probably
>> the worst way due to dramatically change (I think this was already
>> rejected in the previous discussion)
> 
> Because the devices (NAND and eMMC_C) are mutually exclusive, taking the
> step-by-step approach is fine (and preferred) by me.
> 
> Phase 1:
> - add new mmc-clk provider
> - add NAND driver using new mmc-clk provider
> - boards using NAND should ensure emmc_c is disabled in DT
> 
> This allows us to not touch the MMC driver or existing upstream
> bindings.  Yes, this means there is duplicate code in the MMC driver and
> the new mmc-clk provider, but that can be removed in the next phase.
> 
Great, the approach to address this issue is reasonable.
We'd like to focus on phase 1 first, thanks

> Phase 2:
> - convert MMC driver to use new mmc-clk provider
> - update MMC users in DT and bindings
> 
Ok.


Yixun
