Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDE824ECE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="OwYDNWe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDE824ECE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeGBPd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:33:58 -0400
Received: from vern.gendns.com ([206.190.152.46]:37800 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752184AbeGBPd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c7WgQN8f4KVdAgRpxJwouAFaex9x5PPeIrwDe8OSjo4=; b=OwYDNWe2VlSiZj2YKUhSH+rC1I
        9C5GNB5zh9e6panR2dYT3EhM9FsLhVcs/BG7aMjUbAmhWgaeTOMAAFQ/JeCXzpdscSUf6OcUHh+oX
        6OPJwoLDD4HDooERG+Pq0/w7k+MWqWMePfNARgvCBuaZo0+tjZTvTjZryFfb4J9dUPvwK2FHc2UZm
        RV4nUiUINjSBN4sUO1QDfEiKU7Eb/b4JByNV4funvgEzssK4V8/pDBZRXoRf6Ta+DYuS8Lzt3k13w
        mY5s8bLy5+1LSlbZHBO07YSly4c2D1LHzPRb0zsUM4alllNd3tXavFcnC8anee5D9CpQaVXkZnrgW
        E9HwrgeA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59394 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fa0pu-00DEL1-8u; Mon, 02 Jul 2018 11:33:54 -0400
Subject: Re: [PATCH] iio: add channel type for frequency
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
References: <20180701025953.3561-1-david@lechnology.com>
 <308015e8-d203-c4d1-ba80-3c2adf4b377a@metafoo.de>
 <74c98fdc-b498-c593-e0b1-6aeb7057398a@lechnology.com>
 <20180702140352.00002c6c@huawei.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <51fa1708-a19e-aa05-6145-b2479a89805b@lechnology.com>
Date:   Mon, 2 Jul 2018 10:33:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702140352.00002c6c@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 08:03 AM, Jonathan Cameron wrote:
> On Sun, 1 Jul 2018 17:24:34 -0500
> David Lechner <david@lechnology.com> wrote:
> 
>> On 07/01/2018 02:18 AM, Lars-Peter Clausen wrote:
>>> On 07/01/2018 04:59 AM, David Lechner wrote:
>>>> This adds a new type for frequency to the IIO channel type enumeration.
>>>>
>>>> Units are in Hz.
>>>>   
>>>
>>> Documentation?
>>
>> I take it that you mean Documentation/ABI/testing/sysfs-bus-iio? Or
>> somewhere else too?
> 
> Yes.
> 
>>
>>>
>>> We already have the altvoltage channel type with the frequency attribute.
>>> Difficult to say if there are any overlaps without documentation on how this
>>> new attribute is supposed to be used.
>>
>> I'm basically trying to implement a quadrature encoder in iio. I want to be
>> able to use it in-kernel to get a rotational speed value for a motor.
> 
> Have you seen the counters subsystem work that is pretty much ready to merge?

I hadn't seen that. Thanks. It sounds like the way to go since I am dealing with
a quadrature encoder.

> 
> https://lkml.org/lkml/2018/6/21/659
> 
>>
>> The motors (and encoder wheels) are hot-swapable, so we don't know how many
>> counts from the quadrature encoder equals one rotation because it depends on
>> which motor is being used. So using IIO_ANGL_VEL doesn't work for this case.
> 
> Hmm. This always ugly when we have hotswappable external devices.  Ideal is
> to describe them with device tree or similar none the less as this stuff isn't
> really something userspace should have to figure out.
> 
>>
>> It seems to me that the proper generic unit for "speed" from the quadrature
>> encoder would be counts per second, hence the suggestion of a frequency unit.
> 
> It is probably not that clear cut, as what is it frequency of?  All depends on
> what mode the quadrature counter is working in x4 or x1 for simplest options.
> 
> 
>> I'm not sure if voltage frequency works here since a "count" on a quadrature
>> encoder is derived from two different voltage signals (and may vary depending
>> on how the encoder determines what one count it).
>>
>> Also, unrelated to my quadrature encoder project, I was thinking that
>> frequency counters would use this unit as well (although the voltage alt
>> makes more sense for this case).
>>
>> There are also sound sensors that measure frequency that could use this unit.
> 
> I have not fundamental issue with having a frequency channel, but only
> if we have a clear cut use case.  I suspect the right option here is to
> look at what extensions are needed to William's counter subsystem instead
> of in IIO (which frankly failed to stretch far enough to support counters
> well).
> 

Agreed. Let's drop this patch.
