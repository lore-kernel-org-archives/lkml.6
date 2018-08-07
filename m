Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A485C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352CF21A09
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UL8tFrz7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BZAEaXMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352CF21A09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbeHGIC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:02:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36334 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbeHGIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:02:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F65860AFF; Tue,  7 Aug 2018 05:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533620989;
        bh=pvtUDUXFgBqnIYL6skjsv0ZkUn2c7yZsw5nVUOqQMjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UL8tFrz7kFRcrS+Qge4bDxKzc7z2ROu20NPToTxkgMVFGr2bb+vgU2WtvxpCmmKBH
         z3E3MZrtV3snVTIrdOObwbqQEv8h5fKJ5glcNI4rpkO6JT+dsag8wBAHJe92r3y2Ts
         NidzbnlkdOkco9YASka3j2zaj6SYgjedakLa7498=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4CDF1606CF;
        Tue,  7 Aug 2018 05:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533620988;
        bh=pvtUDUXFgBqnIYL6skjsv0ZkUn2c7yZsw5nVUOqQMjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BZAEaXMCFp+g94RvFNxKs6fF7kx7PtDPka8IEdzLo5UuCOuXJbjfTrsjtudOJWgJT
         jzIwE2f5Y5ZBI6JJm7UcLp1g5grOsWjN+23WPwKrqoo3uVxPO2dIl3UXtUS3dCx9oS
         Jb8tYLRGTI5Fd3Y6Hq8UKSyIrmo0/yHambGZZHrk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 22:49:48 -0700
From:   skannan@codeaurora.org
To:     myungjoo.ham@samsung.com
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
In-Reply-To: <45c77ee02536e237c054399cad4c7669@codeaurora.org>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
 <CGME20180802005756epcas4p465a12f42a0e36f0af6fd276a3a56957f@epcms1p3>
 <20180802095608epcms1p33fb061543efc9ceb3ec12d5567ceffbc@epcms1p3>
 <45c77ee02536e237c054399cad4c7669@codeaurora.org>
Message-ID: <35ff3e303f5de9980979b49c89f9a687@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 14:00, skannan@codeaurora.org wrote:
> On 2018-08-02 02:56, MyungJoo Ham wrote:
>>> Many CPU architectures have caches that can scale independent of the 
>>> CPUs.
>>> Frequency scaling of the caches is necessary to make sure the cache 
>>> is not
>>> a performance bottleneck that leads to poor performance and power. 
>>> The same
>>> idea applies for RAM/DDR.
>>> 
>>> To achieve this, this patch adds a generic devfreq governor that 
>>> takes the
>>> current frequency of each CPU frequency domain and then adjusts the
>>> frequency of the cache (or any devfreq device) based on the frequency 
>>> of
>>> the CPUs. It listens to CPU frequency transition notifiers to keep 
>>> itself
>>> up to date on the current CPU frequency.
>>> 
>>> To decide the frequency of the device, the governor does one of the
>>> following:
>> 
>> This exactly has the same purpose with "passive" governor except for 
>> the
>> single part: passive governor depends on another devfreq driver, not
>> cpufreq driver.
>> 
>> If both governors have many features in common, can you merge them 
>> into one?
>> Passive governor also has "get_target_freq", which allows driver 
>> authors
>> to define the mapping.
> 
> Thanks for the review and pointing me to the passive governor. I agree
> that at a high level they are both doing the same. I can certainly
> stuff this CPU freq to dev freq mapping into passive governor, but I
> think it'll just make one huge set of code that's harder to understand
> and maintain because it trying to do different things under the hood.
> 
> There are also a bunch of complexities and optimizations that come
> with the cpufreq-map governor that don't fit with the passive
> governor.
> 
> 1. It's not one CPU who's frequency we have to listen to. There are
> multiple CPUs/policies we have to aggregate across.
> 2. We have to deal with big vs little having different needs/mappings.
> 3. Since it's always just CPUfreq, I can optimize the handling in the
> transition notifiers. If I have 4 different devices that are scaled
> based on CPU freq, I still use only 1 transition notifier. It becomes
> a bit harder to do with the passive governor.
> 4. It requires that the device explicitly support the passive governor
> and pick a mapping function. With cpufreq-map governor, the device
> drivers don't need to make any changes. Whoever is making a
> device/board can choose what devices to scale up base on CPU freq
> based on their board and their needs. Even an end user can say, scale
> the GPU based on my CPU based on interpolation if they choose to.
> 5. If a device has some other use for the private data, it can't work
> with passive governor, but can work with cpufreq-map governor.
> 6. I also want to improve cpufreq-map governor to handle hotplug
> correctly in later patches (needs more discussion) and that'll add
> more complexity.
> 
> I think for these reasons we shouldn't combine these two governors.
> Let me know what you think.

Friendly reminder.

Thanks,
Saravana
