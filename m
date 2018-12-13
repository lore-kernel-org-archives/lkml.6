Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CD72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CD72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeLMNbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:31:02 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:51927 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbeLMNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:31:01 -0500
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 21:31:13 +0800
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
From:   Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <bc4b5951-7760-f927-653f-2c7afac1df46@amlogic.com>
Date:   Thu, 13 Dec 2018 21:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
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

Hi Jerome,

On 2018/12/13 17:04, Jerome Brunet wrote:
> On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
>> signal lines through the idle state (between two transmission operation),
>> which avoid the signals floating in unexpected state.
>>

>> @@ -453,6 +474,8 @@ static int meson_spicc_prepare_message(struct spi_master
>> *master,
>>   
>>   	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
>>   
>> +	meson_spicc_oen_enable(spicc);
>> +
> 
> Any specific reason for doing this in prepare_message() ? It looks like
> something that could/should be done during the probe

Yes, as replied in Mark's mail, i will move it into probe next patch.
