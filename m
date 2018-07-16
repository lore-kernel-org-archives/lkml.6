Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C05208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 05:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C05208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeGPGYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:24:49 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:52038 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeGPGYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:24:47 -0400
Received: from [10.28.16.194] (10.28.16.194) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 16 Jul
 2018 13:59:01 +0800
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        <qianggui.song@amlogic.com>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <bo.yang@amlogic.com>,
        <qiufang.dai@amlogic.com>, <linux-arm-kernel@lists.infradead.org>,
        <carlo@caione.org>, <linux-amlogic@lists.infradead.org>,
        <sunny.luo@amlogic.com>, <linux-clk@vger.kernel.org>,
        <xingyu.chen@amlogic.com>, Rob Herring <robh@kernel.org>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com>
 <454887b2-6d29-4fe9-ee34-400363671746@amlogic.com>
 <1531316752.2708.113.camel@baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <d00bfbac-a041-3dc9-0cda-9a6eef5f3216@amlogic.com>
Date:   Mon, 16 Jul 2018 13:58:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531316752.2708.113.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.16.194]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

On 2018/7/11 21:45, Jerome Brunet wrote:
> On Wed, 2018-07-11 at 21:41 +0800, Jian Hu wrote:
>>>>>> +static struct clk_regmap g12a_mpll0 = {
>>>>>> +       .data = &(struct clk_regmap_gate_data){
>>>>>> +               .offset = HHI_MPLL_CNTL1,
>>>>>> +               .bit_idx = 31,
>>>>>> +       },
>>>>>> +       .hw.init = &(struct clk_init_data){
>>>>>> +               .name = "mpll0",
>>>>>> +               .ops = &clk_regmap_gate_ops,
>>>>>> +               .parent_names = (const char *[]){ "mpll0_div" },
>>>>>> +               .num_parents = 1,
>>>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>>>> +       },
>>>>>> +};
>>>
>>> The previous had a predivider (1 or 2) in front of these mpll. Even if the
>>> predivider is usually set to be a passthrough, it is better to model the tree
>>> correctly.
>>>
>>> Is this SoC any different ?
>>>
>>
>> I am not sure the difference, I will confirm with IC design guys.
> 
> I suggest that you have a look at the (upstream) axg and gxbb clock driver for
> this
> 
> Same goes for the fdiv gates.
> 
> Last, please trim your replies a bit. It will make easier to see what you are
> replying to.
> 
> .
> 

I have confirmed with IC design guys, axg and gxbb clock driver have a 
prediver in frount  of these mpll, according to the Spec, we can get the 
prediver function in HHI_MPLL_CNTL5 bit12, the G12A SoC have not the 
prediver function.
