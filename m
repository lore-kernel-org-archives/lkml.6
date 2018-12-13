Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A8CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C1920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C1920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeLMNZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:25:15 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:48791 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbeLMNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:25:14 -0500
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 21:25:38 +0800
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider support
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
 <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
 <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
From:   Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <35518e71-027c-749e-1075-19ddc0410b19@amlogic.com>
Date:   Thu, 13 Dec 2018 21:25:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
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

On 2018/12/13 16:55, Neil Armstrong wrote:
> Hi Sunny,
> 
> On 13/12/2018 09:39, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG SoC is capable of using
>> a linear clock divider to reach a much fine tuned range of clocks,
>> while the old controller only use a power of two clock divider,
>> result at a more coarse clock range.
> 
> This patch should definitely go before patch 1.
Would you please show the reason?
> 
>>  
>> +	/* Set master mode and enable controller */
>> +	writel_relaxed(SPICC_ENABLE | SPICC_MODE_MASTER,
>> +		       spicc->base + SPICC_CONREG);
> 
> Please remove it from meson_spicc_prepare_message() now.
>
Yes, I moved it here and forgot remove it at prepare_message().
