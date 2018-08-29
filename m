Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECFCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B3B20658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B3B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeH2Tau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:30:50 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:1878 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeH2Tat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:30:49 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="16202020"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 08:33:20 -0700
Received: from [10.145.4.68] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Wed, 29 Aug 2018
 08:33:19 -0700
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a
 WM8731)
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <nicolas.ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <florian.meier@koalo.de>,
        <cristian.birsan@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
 <20180829145355.GD27808@sirena.org.uk>
 <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
Message-ID: <54d79485-81ef-763a-c896-c6ab3e33b5d1@microchip.com>
Date:   Wed, 29 Aug 2018 18:33:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2018 18:20, Codrin Ciubotariu wrote:
> On 29.08.2018 17:53, Mark Brown wrote:
>> On Wed, Aug 29, 2018 at 05:47:26PM +0300, Codrin Ciubotariu wrote:
>>
>>> +static const unsigned int wm8731_rates_12288000[] = {
>>> +    8000, 32000, 48000, 96000,
>>> +};
>>> +
>>> +static struct snd_pcm_hw_constraint_list wm8731_constraints_12288000 
>>> = {
>>> +    .list = wm8731_rates_12288000,
>>> +    .count = ARRAY_SIZE(wm8731_rates_12288000),
>>> +};
>>> +
>>> +static int snd_proto_startup(struct snd_pcm_substream *substream)
>>> +{
>>> +    /* Setup constraints, because there is a 12.288 MHz XTAL on the 
>>> board */
>>> +    snd_pcm_hw_constraint_list(substream->runtime, 0,
>>> +                   SNDRV_PCM_HW_PARAM_RATE,
>>> +                   &wm8731_constraints_12288000);
>>> +    return 0;
>>> +}
>>
>> This bit is better added to the CODEC driver since it'll apply to any
>> system where there's this clock rate (someone else could come in and add
>> other rates, no need to do that yourself though it'd be nice of course).
> 
> I could do it.

It looks like these constraints are already in the wm8731 driver. I will 
wait for more comments and then I will send a v2 without this part.

Thanks and best regards,
Codrin
