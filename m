Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F0FC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50A520870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50A520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeLMMuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:50:11 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:29491 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbeLMMuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:50:09 -0500
Received: from [10.28.18.96] (10.28.18.96) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 13 Dec
 2018 20:50:28 +0800
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
To:     Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
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
 <20181213115345.GC10669@sirena.org.uk>
From:   Sunny Luo <sunny.luo@amlogic.com>
Message-ID: <cb02aadd-d317-fc66-de4a-519dc8d8bfb7@amlogic.com>
Date:   Thu, 13 Dec 2018 20:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213115345.GC10669@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.96]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark&Jerome,

On 2018/12/13 19:53, Mark Brown wrote:
> On Thu, Dec 13, 2018 at 10:04:56AM +0100, Jerome Brunet wrote:
>> On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:
> 
>>>   
>>>   	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
>>>   
>>> +	meson_spicc_oen_enable(spicc);
>>> +
> 
>> Any specific reason for doing this in prepare_message() ? It looks like
>> something that could/should be done during the probe ?
> 
> If it's for power management then there should be a matching disable in
> unprepare_message() (or this should just be in the runtime PM code,
> though it's possible there's stuff that's only needed while actually
> doing transfers in which case this could make sense).
> 
OEN is only used to avoid the signals floating in unexpected state, i 
will move it into probe next patch.

> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.
> 
OK.
