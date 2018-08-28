Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285BB2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285BB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeH1HY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:24:56 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:19194 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1HY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:24:56 -0400
Received: from [10.28.16.194] (10.28.16.194) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 28 Aug
 2018 11:35:32 +0800
Subject: Re: [PATCH 2/2] clk: meson-g12a: Add AO Clock controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
 <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
 <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
 <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
 <89b058a7bba26058fab95dea01155221dbb642ce.camel@baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <977d8010-6d82-5eac-5da5-6dbe0f73971a@amlogic.com>
Date:   Tue, 28 Aug 2018 11:35:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <89b058a7bba26058fab95dea01155221dbb642ce.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.16.194]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi: Jerome

On 2018/8/27 21:07, Jerome Brunet wrote:
> On Fri, 2018-08-24 at 21:34 +0800, Jian Hu wrote:
>>>
>>
>> I am confued about aoclk81's parent clocks.
>>
>> I can not get the example of axg audio clock driver, Could you provide
>> the link? Had it merged into clk-meson.git?
> 
> Yes and mainline as well : drivers/clk/meson/axg-audio.c
> 
> Basically this driver is creating bypass input clocks (audio_pclk, mst_in[0-9],
> etc...) .
> 
> This allows to collect input clocks from DT (like any consumer should) will
> keeping constant in the controller clock tree.
> 
>>From what I've seen of your controller drivers, the EE controller should have
> one input, the AO should have 3.
> 
> 
> 
> .
> 
I still can not get the example meaning in axg audio driver.

In 26 page of A113D_Datasheet V0.7 20170725-Baylibre.pdf,We can see the 
aoclk81 has two parents. clk81 and ao_slow_clk. I can not get 3 parents.

                          clk81|\
                        -------| \        aoclk81
src0 |\                       |  |-------------------
-----| \     ao_slow_clk      |  |
      |  |---------------------| /
-----| /                      |/
  src1|/


src0 is from xtal, if can generate 32k clock, but it is never used.
src1 is from gpio clock, It is never used. If necessary， the ao_slow_clk 
maybe described.

So why aoclk81 has 3 parents?
