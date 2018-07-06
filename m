Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DEEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A3A2089D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="pWuoNb9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A3A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934335AbeGFSXF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:23:05 -0400
Received: from vern.gendns.com ([206.190.152.46]:51321 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933999AbeGFSXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pa1vm1q+kkQVDnhcNRAsMvEX3GoIyMfiqpgNhPn01Qs=; b=pWuoNb9CB7DjCgs/1+yV6j0jLb
        5VE+4nOKzZVuwwrCTsMyRmM9uAqfgk6vtocbonBprM2Ox7N77tCPQOjTS9KTrYT4LehGBkh3EHD4Q
        dm7NcGAi3g9RsMDZJUb3JDIuUhUx5uVyP4JkAEJ3G681a89T6o1su3vfpqQbg1t6xn5C0JXP2MDYi
        D15r7/ozy8mle3PO2YNnOjCuvZc2Zv+2O8lYxobtzTvAyuI4S951HkgLw5PRa0WIt/6dtwFIvFdBk
        pOUTBHTLWaKZHE6JWxSWVV9Dpk/ROeaAyOt2sxjPIJFSUkkEs2l7Za3QnbCFREp+58cZKVoPnvyZD
        S3SM/V8Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37140 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fbVNk-00BUi0-7O; Fri, 06 Jul 2018 14:23:00 -0400
Subject: Re: [PATCH v7 00/10] Introduce the Counter subsystem
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
 <20180703024835.GA9493@sophia> <20180706182154.0000002d@huawei.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <59b0950e-ef39-4ad4-a32b-316992e1f236@lechnology.com>
Date:   Fri, 6 Jul 2018 13:22:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706182154.0000002d@huawei.com>
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

On 07/06/2018 12:21 PM, Jonathan Cameron wrote:
> On Mon, 2 Jul 2018 22:48:35 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
>> On Mon, Jul 02, 2018 at 01:13:40PM -0500, David Lechner wrote:
>>> On 06/21/2018 04:06 PM, William Breathitt Gray wrote:
>>>> I decided to strip down these devices to arrive at the core essence of
>>>> what constitutes a "counter device" and therefore design a "generic
>>>> counter" abstraction to better represent these devices and prevent the
>>>> ambiguity we discovered with the existing IIO Counter interface. This
>>>> abstraction became the Generic Counter paradigm, which is explained in
>>>> detail within the Documentation/driver-api/generic-counter.rst file
>>>> introduced by this patchset.
>>>
>>> I'm curious if you have given any thought to the time aspect of counters.
>>> I am interested in the rate at which the counters are counting (e.g. how
>>> many counts per second). I realize that you can calculate this in
>>> userspace or in the kernel using the system timer, but it is not very
>>> accurate since Linux is not a realtime OS. So, I would like to get the
>>> rate directly from the hardware. For example, the TI eQEP[1], like the
>>> one found in BeagleBones, has a couple ways of measuring time (see link
>>> for details).
>>>
>>> [1]: http://www.ti.com/lit/ug/sprug05a/sprug05a.pdf
> 
> Cool in eQEP if that is what you are targetting - been wanting to see
> nice kernel support implemented for that for a long time, but never
> got the spare cycles to do it myself!
> 
>>
>> Ah yes, I see you initially attempted adding a frequency channel type to
>> the IIO code. I agree with you that this calculation is best kept away
>> from the operating system, not just because of the realtime requirement
>> considerations, but also because the hardware likely knows best its own
>> data, so let's expose it!
>>
>> Regarding the Generic Counter interface, a frequency attribute can be
>> added quite easily in a technical sense, so this discussion should be
>> focused more on the warrant for exposing this data. I understand from
>> the discussion thread on your initial patch submission that you're
>> working with hot-swappable encoder wheels and would like to expose a
>> counting rate since you have trouble otherwise knowing the number of
>> counts equal to one revolution due to the various possible encoder
>> wheels that could be installed -- do I understand this correctly?
>>
>> Luckily the Generic Counter interface is a more abstract paradigm, so
>> the hot-swappable encoder wheels should not be a problem for us as long
>> as we nail down a consistent and thorough definition for this attribute.
>> To that end, since the Generic Counter paradigm is designed to abstract
>> away specifics of counter devices in order to present the final data of
>> interest to users (e.g. the count value, the mode of operation, etc.),
>> let's make sure frequency is actually what we want to expose and not
>> just a middle-step datum on the path to the final result.
>>
>> What is the real life use-case for this information (are you tracking
>> position)?

We are attempting to control the speed of the motors well enough to make
a balancing (inverted pendulum) robot and also synchronize two motors
when driving a robot (e.g. if one gets "stuck", the other slows down and
waits for the first to catch up).

>> Does the relevant hardware report the number of counts equal
>> to one revolution, or are you calculating this from frequency?

Not exactly. For the most part, the motors are the same, so we assume
that as default, but have a way for changing the parameters from
userspace.

>> Are you
>> using this frequency to simply track the number of revolutions?

No, we are using it to calculate the rotational speed of the motor.

>> Should
>> revolution count also be exposed?

I don't think so. The raw count value is good enough.

>> Is frequency useful for other
>> applications on its own (perhaps velocity of an automobile device
>> equipped with an encoder wheel for some reason or other)?

Since we are just dealing with counters here, I think we should call
it "rate" instead of "frequency". At least that seems to be the common
name in industrial automation.

Another possible use case for "rate" would be flow meters. Some
flow meters generate a pulse every X gallons. Assuming that the
counter also has a rate output, then you can scale the rate (e.g.
counts/second) into flow in gallons per minute.

>>
>> Once we figure out how this data is used, we can determine the best
>> design and place to introduce it into the Generic Counter interface,
>> then move on to integration from there.
> 
> Great - as long as this fits reasonably well in ABI wise (whatever the
> details) sounds like we don't need to solve it today.  I'm anxious not
> to delay merging this counter subsystem for another cycle.

Certainly don't delay things on account of me. I'm just trying to get
a feel for where things are headed since I missed the earlier discussions.
I don't see any major problems with the current state of things.

Once this lands, I may have a go at the eQEP and see how it looks.
