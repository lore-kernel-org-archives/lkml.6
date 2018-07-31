Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D43C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6768220857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k8hz+uow";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DlvhvW0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6768220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeGaVDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:03:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGaVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:03:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B49860481; Tue, 31 Jul 2018 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533064910;
        bh=G8fSbYvAX7R/oIztjQ9MgUYm0WEtwr5EgJ6Okp0t/EI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k8hz+uowMnoOkjgBgY+xbcB8HE/s8gt7MGgYn1GkEWDxXJnYWbT9A+u5vnv+Vmvdy
         dN2YQrdyXtRdSK1yRpVDFIE79yfTWFAXh6oPEBXKoiW+xERi8j4Tp+e3zR6d7ySDhG
         CaF5kbXvbbOi72tGfrSgYgm6oJjIssb2iRC+yMXs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CADEB60328;
        Tue, 31 Jul 2018 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533064909;
        bh=G8fSbYvAX7R/oIztjQ9MgUYm0WEtwr5EgJ6Okp0t/EI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DlvhvW0iHmC6Ut+766HW+E+AUswcpe3H9YGknMb7ft/c4OdAfDIEo3UV2h2vuWUv8
         /1Le3GLSgZtSYI1Bj65FzTOhheF+QKtqycv57jKsZu6xfzYUEMlZuHhtTi9aWoZ2Ic
         owpbVNzuQme5WF9KHazawoNGDHNhvQYAG2W5SF28=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 12:21:49 -0700
From:   skannan@codeaurora.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rjwysocki@gmail.com
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
In-Reply-To: <CAJZ5v0jYmy9z488bg8gbAGceRqv-c-ONhW0DtaKD6GUGUnCTLw@mail.gmail.com>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
 <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com>
 <534629d03437bc8e72a62d89e726dbe5@codeaurora.org>
 <CAJZ5v0jYmy9z488bg8gbAGceRqv-c-ONhW0DtaKD6GUGUnCTLw@mail.gmail.com>
Message-ID: <84cdf95b1e3f8b580f4d1df138aaf42b@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 01:00, Rafael J. Wysocki wrote:
> On Mon, Jul 30, 2018 at 8:58 PM,  <skannan@codeaurora.org> wrote:
>> On 2018-07-29 03:52, Rafael J. Wysocki wrote:
>>> 
>>> On Sat, Jul 28, 2018 at 5:56 AM, Saravana Kannan 
>>> <skannan@codeaurora.org>
>>> wrote:
>>>> 
>>>> Many CPU architectures have caches that can scale independent of the
>>>> CPUs.
>>>> Frequency scaling of the caches is necessary to make sure the cache 
>>>> is
>>>> not
>>>> a performance bottleneck that leads to poor performance and power. 
>>>> The
>>>> same
>>>> idea applies for RAM/DDR.
>>>> 
>>>> To achieve this, this patch adds a generic devfreq governor that can
>>>> listen
>>>> to the frequency transitions of each CPU frequency domain and then
>>>> adjusts
>>>> the frequency of the cache (or any devfreq device) based on the 
>>>> frequency
>>>> of the CPUs.
>>>> 
>>>> To decide the frequency of the device, the governor does one of the
>>>> following:
>>>> 
>>>> * Uses a CPU frequency to device frequency mapping table
>>>>   - Either one mapping table used for all CPU freq policies 
>>>> (typically
>>>> used
>>>>     for system with homogeneous cores/clusters that have the same 
>>>> OPPs.
>>>>   - One mapping table per CPU freq policy (typically used for ASMP
>>>> systems
>>>>     with heterogeneous CPUs with different OPPs)
>>>> 
>>>> OR
>>>> 
>>>> * Scales the device frequency in proportion to the CPU frequency. 
>>>> So, if
>>>>   the CPUs are running at their max frequency, the device runs at 
>>>> its max
>>>>   frequency.  If the CPUs are running at their min frequency, the 
>>>> device
>>>>   runs at its min frequency. And interpolated for frequencies in 
>>>> between.
>>> 
>>> 
>>> While not having looked at the details of the patch yet, I would
>>> change the name of the feature to "Generic cpufreq transition
>>> governor" to make it somewhat less ambiguous.
>> 
>> 
>> In my opinion it makes it look MORE like this is a cpufreq governor. 
>> How
>> about the following?
>> PM / devfreq: Generic cpufreq to devfreq mapping governor
>> Seem a lot more clear to me.
> 
> Well, it's not just mapping, but also it triggers on cpufreq 
> transitions AFAICS.

Right, but I'm not sure that's the most important aspect of this 
governor.

> Which makes me wonder if the approach here is the right one at all.
> 
> Shouldn't the cpufreq driver be hooked up to the related HW through
> the OPP framework and sharing access with devfreq rather?

Not sure what you mean here. This devfreq governor is orthogonal to what 
the cpufreq driver does with its HW. This is just trying to scale L3 or 
DDR or whatever other device based on current CPU frequency. Not all 
CPUfreq drivers support OPP. And even if they do, I don't see how it's 
relevant here.

Thanks,
Saravana
