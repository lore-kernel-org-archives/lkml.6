Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE8EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D929820844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfA2LaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:30:13 -0500
Received: from mail1.skidata.com ([91.230.2.99]:36103 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2LaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:30:13 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 06:30:12 EST
X-IronPort-AV: E=Sophos;i="5.56,537,1539640800"; 
   d="scan'208";a="14781705"
Subject: Re: [RESEND PATCH v2 8/8] Input: sx8654 - convert #defined flags to
 BIT(x)
To:     Joe Perches <joe@perches.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218084002.19454-1-richard.leitner@skidata.com>
 <20190129002518.GH34692@dtor-ws>
 <533e48bd35d360cec8d749f3b70425c1eb5e6e9d.camel@perches.com>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <50c0a3a5-7039-abc0-9b9e-4314504bcb6f@skidata.com>
Date:   Tue, 29 Jan 2019 12:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <533e48bd35d360cec8d749f3b70425c1eb5e6e9d.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 29/01/2019 06:40, Joe Perches wrote:
> On Mon, 2019-01-28 at 16:25 -0800, Dmitry Torokhov wrote:
>> On Tue, Dec 18, 2018 at 09:40:02AM +0100, Richard Leitner wrote:
>>> Some of the #defined register values are one-bit flags. Convert them to
>>> use the BIT(x) macro instead of 1 byte hexadecimal values. This improves
>>> readability and clarifies the intent.
>>>
>>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>>
>> Applied, thank you.
> 
> Not so sure this should be applied.
> 
>>> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> []
>>> @@ -46,7 +47,7 @@
> []
>>>   /* bits for I2C_REG_IRQSRC */
>>> -#define IRQ_PENTOUCH_TOUCHCONVDONE	0x08
>>> -#define IRQ_PENRELEASE			0x04
>>> +#define IRQ_PENTOUCH_TOUCHCONVDONE	BIT(7)
>>> +#define IRQ_PENRELEASE			BIT(6)
> 
> Shouldn't this be BIT(3) and BIT(2)
> or did you mean to change the values too?
> 
> If so, this change should be noted in the commit message.
> 

That's true, those values should stay the same. Thanks for the catch!

@Dimitry: Should I send an updated version or do you fix it yourself?

regards;Richard.L
