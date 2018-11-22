Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D5920866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D5920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbeKVRo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:44:29 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:40452 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbeKVRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:44:29 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gPj43-00022d-Uz from Jiada_Wang@mentor.com ; Wed, 21 Nov 2018 23:06:15 -0800
Received: from [172.30.112.131] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 21 Nov 2018 23:06:12 -0800
Subject: Re: [PATCH linux-next v1 2/4] clk: renesas: Add binding document for
 AVB Counter Clock
To:     Stephen Boyd <sboyd@kernel.org>, <geert+renesas@glider.be>,
        <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <kuninori.morimoto.gx@renesas.com>
References: <20181025072349.15173-1-jiada_wang@mentor.com>
 <20181025072349.15173-3-jiada_wang@mentor.com>
 <154083775062.98144.11157403961171783929@swboyd.mtv.corp.google.com>
 <9f9fbf3a-4455-bdf3-0438-b39b9cdda112@mentor.com>
 <154130125117.88331.5969014008610987799@swboyd.mtv.corp.google.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <7f8827a5-c65d-0e1e-a0f9-23b31305d26a@mentor.com>
Date:   Thu, 22 Nov 2018 16:06:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154130125117.88331.5969014008610987799@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen


On 2018/11/04 12:14, Stephen Boyd wrote:
> Quoting Jiada Wang (2018-10-31 05:00:49)
>> On 2018/10/30 3:29, Stephen Boyd wrote:
>>> Quoting jiada_wang@mentor.com (2018-10-25 00:23:47)
>>>> +Required Properties:
>>>> +  - compatible: Must be "renesas,clk-avb"
>>>> +  - reg: Base address and length of the memory resource used by the AVB
>>>> +  - #clock-cells: Must be 1
>>>> +
>>>> +Example
>>>> +-------
>>>> +
>>>> +       clk_avb: avb-clock@ec5a011c {
>>>> +               compatible = "renesas,clk-avb";
>>>> +               reg = <0 0xec5a011c 0 0x24>;
>>> This is an odd register offset. Is this just one clk inside of a larger
>>> clk controller?
>>>
>> Yes, avb_counter clock is part of Audio Clock Generator reg: <0
>> 0xec5a0000 0 0x140>,
>> but "adg" has already been declared in R-Car GEN2/GEN3 SoC .dtsi file,
>> with reg: <0 0xec5a0000 0 0x100>,
>> which leaves <0 0xec5a0100 0 0x140> currently not used by any module.
>>
> So why can't we expand the register size in the dts file and update the
> audio clock generator driver to register this avb clock too? Presumably
> the mapping is large enough to cover the clk registers already so it is
> more of a formality to expand the register size than a requirement.
I am working on ver2 to expend register size to cover <0 0xec5a0100 0 0x140>
in audio clock generator (ADG) driver, but as provider of newly added 
"AVB_COUNTER" clock,
ADG driver also uses these clocks if necessary, so it keeps itself BUSY,
and cause ADG driver can't be unloaded.
my question is, is such use case allowed? (clock provider is also client 
of clocks).


Thanks,
Jiada

