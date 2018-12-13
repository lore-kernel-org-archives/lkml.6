Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3C3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA7F20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA7F20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeLMNMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:12:06 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:41518 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbeLMNMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:12:06 -0500
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 21:12:23 +0800
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <6ba11b0a-3629-5378-61c7-3cc364237f5c@baylibre.com>
From:   Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <c85195d4-29e5-0e66-da09-cb86248660a3@amlogic.com>
Date:   Thu, 13 Dec 2018 21:12:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <6ba11b0a-3629-5378-61c7-3cc364237f5c@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.96]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2018/12/13 16:53, Neil Armstrong wrote:
> Hi Sunny,
> 
> On 13/12/2018 09:39, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
>> signal lines through the idle state (between two transmission operation),
>> which avoid the signals floating in unexpected state.
> 
> This is welcome, because it's really missing on GX...
> I tried implementing it with pinctrl at [1], but it's complex.
> 
> Can you provide more info on how we should implement in on GX to be on par ?
> 
> [1] https://github.com/superna9999/linux/commit/9c3a95659dd532d186556c1570c54d79ea5a4d45
> 
GX is incapable of OEN. To be on par with it ,we have to pullup/down clk 
pin as
you did at[1].

>>   static const struct meson_spicc_data meson_spicc_gx_data = {
>> -	.max_speed_hz	= 30000000,
>> +	.max_speed_hz		= 30000000,
> 
> Nitpick, but I would have kept the indentation here ...
> 
>>   };
>>   
>>   static const struct meson_spicc_data meson_spicc_axg_data = {
>> -	.max_speed_hz	= 80000000,
>> +	.max_speed_hz		= 80000000,
>> +	.has_oen		= true,
> 
> same here
> 
> Anywy it's nitpick,
>  
ok, i will revert it next patch.
