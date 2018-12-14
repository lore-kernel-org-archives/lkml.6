Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A29AC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112502080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112502080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeLNETs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:19:48 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:31664 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLNETr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:19:47 -0500
Received: from [10.18.29.207] (10.18.29.207) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 14 Dec
 2018 12:19:59 +0800
Subject: Re: [PATCH RESEND v7 3/4] clk: meson: add sub MMC clock controller
 driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-4-git-send-email-jianxin.pan@amlogic.com>
 <10f2875c9724d9d9dd4bd32eab1fa3f8e42a809c.camel@baylibre.com>
 <11bb5068-2c93-a415-b295-6ca994621280@amlogic.com>
 <2ed764a1c6a0fea5cb3e16dd48577c930ae28ca9.camel@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <510be84d-5c47-cf94-254f-55dba6977f7e@amlogic.com>
Date:   Fri, 14 Dec 2018 12:19:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <2ed764a1c6a0fea5cb3e16dd48577c930ae28ca9.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.207]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/13 17:01, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 12:55 +0800, Jianxin Pan wrote:
>> On 2018/12/12 0:59, Jerome Brunet wrote:
>>> On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
>>>> From: Yixun Lan <yixun.lan@amlogic.com>
>>>>
>> [...]
>>>>  
>>>> +config COMMON_CLK_MMC_MESON
>>>> +	tristate "Meson MMC Sub Clock Controller Driver"
>>>> +	select MFD_SYSCON
>>>> +	select COMMON_CLK_AMLOGIC
>>>> +	select COMMON_CLK_AMLOGIC_AUDIO
>>>
>>> No it is wrong for the mmc to select AUDIO clocks.
>>> If as a result of your patch sclk is needed for things, make the necessary
>>> change in the Makefile.
>> OK, I will add COMMON_CLK_AMLOGIC_SCLKDIV for sclk-div.
> 
> No! There is no reason to create a specific configuration for this.
> please put it under COMMON_CLK_AMLOGIC
OK, I will use COMMON_CLK_AMLOGIC and clkc.h for sclk-div in the next version. Thank you.
> 
>> [...]>> +#include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/mfd/syscon.h>
[...]


