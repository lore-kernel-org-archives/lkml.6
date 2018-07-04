Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C13C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6E32064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="b2mrbfu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMUxA9cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6E32064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeGDPXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:23:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54063 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752114AbeGDPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:23:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A75021ACF;
        Wed,  4 Jul 2018 11:23:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 04 Jul 2018 11:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=GyU5N5uEVT3hOOUFWCzNEZTgSjLCA
        hQLmSs69Dss2cU=; b=b2mrbfu5Cw0K+m1vATUlgwzFZL5qzhAo9n8pr6GwAd2zI
        PC1mpeAhgcoKnvv6ENmE4luHheB8J76hac79wt+2bEToVJoSgMvM90RH/0n0QjXi
        bruRIhySaly3lL+BUDR8DrQ/tg42chliCaGq+w6aCy8P0C9B5s9ZH4HDivMxJ7BE
        RVgJeIthzFZcid4BTI7Tc40lKmqowCJlXomNocLGGuVycDWs0hDq/BpcZpqZecWP
        6/XQ4nmnFQJjNZdWGcT7IznwwfzBe+U5Ms+IfBIuGXEw9Ta9N/GFkcIMDfG2HxIh
        T74WjKfkGZSZAV1GA5HouyPK9UW8rMOUJfEnAc8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GyU5N5
        uEVT3hOOUFWCzNEZTgSjLCAhQLmSs69Dss2cU=; b=PMUxA9cfiRa0nyAyYbB0jT
        kZhwnzeZDUMkiE3hIADLDFJHiwa2azrBP5A4NBquU5QJ4GXDNW/byf5d2ZKMVzIy
        LHi5DSKhCIACRZQduHexL7xepWsrTRH9ZCAUd3OuIDQLSzuB8hdbL2HhFGAkHYMW
        uFB0kfiu2NcuDyE/XDPK2PyPjleyyJ5C14Yy5Fju0r/5DzRGNKNADfZgneoxahZR
        fC17krS47jj4zyl4Dco5eyffAoIE1c1wfV+GOxNXZNIOn1sgtR/FajQLndGIRroL
        PDzlsYes0cVkf4UsBcSvLELN9Pf2FLeU+nEXlPM77aUx+tCiFQf29kZ/QtlZndjQ
        ==
X-ME-Proxy: <xmx:aOY8W3spNsC8n-6HEGojRBGzxBlfM63bZoPcEKQ5R3JKEWgIaf6cPg>
    <xmx:aOY8W93WQFr_2Yp8Ohz8mOot_MTqgBpR45KdyL7YbK000cKaAk2kLg>
    <xmx:aOY8W-aEt-EWXWgWb2CqnrvqtT7tCawRBrJBi8UW2_nhqZDRBlzU3Q>
    <xmx:aOY8W2Gzcj1ZMRaWuUEb1XvMHIB3dEolrjAQYs7JIblDcTG-1SYRGQ>
    <xmx:aOY8W1yiW35Pfv391CfRQMJzFn2fqiO6CU9K8Sr5fRS4eX8KLQhEDQ>
    <xmx:aeY8W2DPU-pPxFS62qjgXBxvTV1wDmET1QQL7Hqjm6nCMNsQNjixwg>
X-ME-Sender: <xms:aOY8W-xfJgVJbRClCKIEnkAs39SjZLJdAqOmz3pOb6Srw3ffrIMOxw>
Received: from [192.168.34.162] (unknown [99.198.199.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4722CE4329;
        Wed,  4 Jul 2018 11:23:19 -0400 (EDT)
Subject: Re: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
 <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com>
 <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
 <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com>
 <alpine.DEB.2.21.1807041628440.1752@nanos.tec.linutronix.de>
 <55fc9e48-6329-df75-3a12-60cc42d91a31@arm.com>
 <861scjyrio.wl-marc.zyngier@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0cfd26d9-e1a5-3755-09b2-044eff37ff99@sholland.org>
Date:   Wed, 4 Jul 2018 10:23:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <861scjyrio.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/18 10:01, Marc Zyngier wrote:
> On Wed, 04 Jul 2018 15:44:36, Andre Przywara <andre.przywara@arm.com> wrote:
>> On 04/07/18 15:31, Thomas Gleixner wrote:
>>> On Wed, 4 Jul 2018, Andre Przywara wrote:
>>>> On 04/07/18 11:00, Thomas Gleixner wrote:
>>>>> On Wed, 4 Jul 2018, Marc Zyngier wrote:
>>>>>> On 04/07/18 09:23, Daniel Lezcano wrote:
>>>>>>> 
>>>>>>> If the patches fix a bug which already exist, it makes sense to 
>>>>>>> propagated the fix back to the stable versions.
>>>>>> 
>>>>>> That's your call, but I'm not supportive of that decision, 
>>>>>> specially as we have information from the person developing the 
>>>>>> workaround that this doesn't fully address the issue.
>>>>> 
>>>>> The patches should not be applied at all. Simply because they don't 
>>>>> fix the issue completely.
>>>>> 
>>>>> From a quick glance at various links and information about this,
>>>>> this very much smells like the FSL_ERRATUM_A008585. Has that been
>>>>> tried? It looks way more robust than the magic 11 bit crystal ball
>>>>> logic.
>>>> 
>>>> The Freescale erratum is similar, but not identical [1]. It seems like 
>>>> the A64 is less variable, so we can use a cheaper workaround, which 
>>>> gets away with normally just one sysreg read. But then again the newer 
>>>> error reports may actually suggest otherwise ...
>>>> 
>>>> And as it currently stands, the Freescale erratum has the drawback of 
>>>> relying on the CPU running much faster than the timer. The A64 can run
>>>>  at 24 MHz (for power savings, or possibly during DVFS transitions), 
>>>> which is the timer frequency. So subsequent counter reads will never 
>>>> return the same value and the workaround times out.
>>> 
>>> If that's the case then you need to find a different functional timer for
>>> time keeping. Having an erratic behaving timer for time keeping is not an
>>> option at all.
>> 
>> That's not an option on arm64. There are other usable time sources in the 
>> SoC, but the arch timer is somewhat mandatory for all practical purposes
>> on arm64. We rely on it in some many places that it's not feasible to run 
>> without it. That's why we call it "architected" timer after all ;-) But I 
>> am quite confident that we can find a correct workaround. Maybe it's
>> really the TVAL (the downcounter) write which is the culprit here, since
>> the hardware actually writes "now() + TVAL" into the CVAL (upcounter)
>> register. This internal counter access may be flawed as well.
> 
> You got it backward: CVAL is not a counter at all. It is a Comparator. And 
> TVAL has an implicit read from the counter, as it is defined as "CVAL - CNT" 
> (i.e. the number of ticks until the timer expires).
> 
> So it might be worth trying to handle TVAL entirely in SW.
> 
> But this relies on being able to read the timer and get a number of correct 
> values out of it. One possibility would be to sacrifice precision and always 
> ignore some of the bottom bits, but this is always going to suck terribly.
> 
> The alternative is burn that thing, and pretend it never existed.

From the testing I have done, this patch series fully stabilizes reading CNTPCT
and CNTVCT. So with the workaround, the timer *can* accurately count time. So
merging this would be an improvement on the current situation.

The system clock jumps might be explained by interaction with CVAL/TVAL, and
that's the part I haven't investigated yet. As I mentioned before, and Andre
just mentioned again, the BSP provided by the vendor has another workaround for
writing the TVAL register. Hopefully, that's the missing piece which will fix
the clock jumps.

Thanks,
Samuel
