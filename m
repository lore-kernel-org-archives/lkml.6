Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C2FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804220894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6LLUEzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8804220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbeHAJOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:14:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39162 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbeHAJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:14:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so32824482oib.6;
        Wed, 01 Aug 2018 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gsycYbpYFp2jXZP7zX4tQ84vBv0tzFPNmhPdpavN4ng=;
        b=j6LLUEzOpbsFxgOZQo5MrxZffQ9FBGy6679I8lcUHDl0yNJdo/YnsUgXmEO/FmfSNT
         ayu55rcX6WsytmMdOplLMbzzCyqaGZGnryJ2L3R1LUZ2Y0gQNJD7dGi8lqssp5i8ohVY
         FoBGbRnNyFKx+KI9m+hkgrgepkFqZhjPati2pO+a7g84/9hka+kPmp5gvlLbyYC6TDad
         NcAIA1aNfPvYrUkusn+XaVIjncZ4fruxz3KZ4SC5F3C7jW74Ee4pitJNHS6Q4mjTRrCY
         lCRZWN0ss4lhIseJxNwbrqkZy+bBjY7bH0J/nHJ4F69b7lxXLDbkiN+bGgh/n+qmBhWT
         U2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gsycYbpYFp2jXZP7zX4tQ84vBv0tzFPNmhPdpavN4ng=;
        b=XnZvdO2g8tckK8BUqdL3PW97DVTnrSKr2MdSpRNx1WuL0qQd69J6Lr8VIkrBUVtjNs
         9AgiHqzxznkMGCa56ybjc20cCQh2XVQyUjhPxugA9AGLiD3dP+YPW9SKZM+uI3kecz2N
         eXRezyaSd2jqmTSeOZZYTzN4J5AFuEJkiqOQFHu3lk47sag07ryn1i4u0O2wznybairH
         O/yRcpULxtKxzSflQYpwhpwudoWutEGQjkWsDrcus8mmRG+NhG52Rf/Ysogf8jM6OlXg
         /5gkPs1zTSDQcOnat7Bqnl7M9zQ1bXnqKYNI1ECOik6BlFVhvjZ3JKf5daOvh/8X0wnQ
         pcLA==
X-Gm-Message-State: AOUpUlFwKvCqgdpY6ZQbTwdLffNsfsfxISpZoEQ0gDeapcUNTnMudwDh
        o6HITdY4/ImjUGL6SrNLNEOQLFUlZKT8XeFZbDw=
X-Google-Smtp-Source: AAOMgpfYYOJYm6msllfPPeTuSKKhiDaCsdoizsZpbYdsH0LcpdqTlRyDkvrzO8/RjIGBYmFaVS9Y8Dqf6EM1HdRDHYM=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr2471501oie.174.1533108604885;
 Wed, 01 Aug 2018 00:30:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 00:30:04 -0700 (PDT)
In-Reply-To: <84cdf95b1e3f8b580f4d1df138aaf42b@codeaurora.org>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
 <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com>
 <534629d03437bc8e72a62d89e726dbe5@codeaurora.org> <CAJZ5v0jYmy9z488bg8gbAGceRqv-c-ONhW0DtaKD6GUGUnCTLw@mail.gmail.com>
 <84cdf95b1e3f8b580f4d1df138aaf42b@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Aug 2018 09:30:04 +0200
X-Google-Sender-Auth: f6vwnJ1bhSJ9l0s7rSXAnNq7t5Q
Message-ID: <CAJZ5v0ihgmR0Dx+BYQAkWKtggov0vk0nqewWiMthcKG-WfqP3Q@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:21 PM,  <skannan@codeaurora.org> wrote:
> On 2018-07-31 01:00, Rafael J. Wysocki wrote:
>>
>> On Mon, Jul 30, 2018 at 8:58 PM,  <skannan@codeaurora.org> wrote:
>>>
>>> On 2018-07-29 03:52, Rafael J. Wysocki wrote:
>>>>
>>>>
>>>> On Sat, Jul 28, 2018 at 5:56 AM, Saravana Kannan
>>>> <skannan@codeaurora.org>
>>>> wrote:
>>>>>
>>>>>
>>>>> Many CPU architectures have caches that can scale independent of the
>>>>> CPUs.
>>>>> Frequency scaling of the caches is necessary to make sure the cache is
>>>>> not
>>>>> a performance bottleneck that leads to poor performance and power. The
>>>>> same
>>>>> idea applies for RAM/DDR.
>>>>>
>>>>> To achieve this, this patch adds a generic devfreq governor that can
>>>>> listen
>>>>> to the frequency transitions of each CPU frequency domain and then
>>>>> adjusts
>>>>> the frequency of the cache (or any devfreq device) based on the
>>>>> frequency
>>>>> of the CPUs.
>>>>>
>>>>> To decide the frequency of the device, the governor does one of the
>>>>> following:
>>>>>
>>>>> * Uses a CPU frequency to device frequency mapping table
>>>>>   - Either one mapping table used for all CPU freq policies (typically
>>>>> used
>>>>>     for system with homogeneous cores/clusters that have the same OPPs.
>>>>>   - One mapping table per CPU freq policy (typically used for ASMP
>>>>> systems
>>>>>     with heterogeneous CPUs with different OPPs)
>>>>>
>>>>> OR
>>>>>
>>>>> * Scales the device frequency in proportion to the CPU frequency. So,
>>>>> if
>>>>>   the CPUs are running at their max frequency, the device runs at its
>>>>> max
>>>>>   frequency.  If the CPUs are running at their min frequency, the
>>>>> device
>>>>>   runs at its min frequency. And interpolated for frequencies in
>>>>> between.
>>>>
>>>>
>>>>
>>>> While not having looked at the details of the patch yet, I would
>>>> change the name of the feature to "Generic cpufreq transition
>>>> governor" to make it somewhat less ambiguous.
>>>
>>>
>>>
>>> In my opinion it makes it look MORE like this is a cpufreq governor. How
>>> about the following?
>>> PM / devfreq: Generic cpufreq to devfreq mapping governor
>>> Seem a lot more clear to me.
>>
>>
>> Well, it's not just mapping, but also it triggers on cpufreq transitions
>> AFAICS.
>
>
> Right, but I'm not sure that's the most important aspect of this governor.

What are the other events triggering it, then?

>> Which makes me wonder if the approach here is the right one at all.
>>
>> Shouldn't the cpufreq driver be hooked up to the related HW through
>> the OPP framework and sharing access with devfreq rather?
>
> Not sure what you mean here. This devfreq governor is orthogonal to what the
> cpufreq driver does with its HW. This is just trying to scale L3 or DDR or
> whatever other device based on current CPU frequency. Not all CPUfreq
> drivers support OPP. And even if they do, I don't see how it's relevant
> here.

OK, fair enough.
