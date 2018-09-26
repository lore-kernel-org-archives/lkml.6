Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF981C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755D12089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755D12089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIZSvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:51:16 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:57009 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:51:16 -0400
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="20538275"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 05:38:27 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Wed, 26 Sep 2018
 05:38:27 -0700
Subject: Re: [PATCH] clocksource/drivers/timer-atmel-pit: properly handle
 error cases
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Cristian Birsan <Cristian.Birsan@microchip.com>
References: <20180425101439.28908-1-alexandre.belloni@bootlin.com>
 <20180501083626.GE27619@mai>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <d2b356f9-6a29-0ce2-c511-ac1aff8e91ca@microchip.com>
Date:   Wed, 26 Sep 2018 14:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180501083626.GE27619@mai>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On 01/05/2018 at 10:36, Daniel Lezcano wrote:
> On Wed, Apr 25, 2018 at 12:14:39PM +0200, Alexandre Belloni wrote:
>> smatch now reports a possible leak:
>>
>> smatch warnings:
>> drivers/clocksource/timer-atmel-pit.c:183 at91sam926x_pit_dt_init() warn: possible memory leak of 'data'
>>
>> Ensure data is freed before exiting with an error.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> ---
> 
> Applied for 4.17-rc

We don't see it in Mainline as of 4.19-rc neither in linux-next. Has it 
been forgotten?

Thanks for your help. Best regards,
-- 
Nicolas Ferre
