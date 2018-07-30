Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B120C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A820920870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J/LuEUIC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nEC124Go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A820920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeG3UfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:35:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbeG3Ue7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:34:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 939B0605BD; Mon, 30 Jul 2018 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532977117;
        bh=8/MjThK2c5ABUIfk7l9QOY+sdXH2IMiB6GT1iSQJJJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J/LuEUICBgr1N7daxw7OwVyGkTT4087QBCkq63RvjzhGx5o+VCdoScFv/YKvcz8aV
         ur76S+KUJOwacI0WFAiq+n/W2dtgTVPdWPk+/5jL2YNyNaMdIdXTAXZc0nxsjyXP+f
         d4jPITGQWJh0eg+6Azupfp3X10czPof3oyzPaoL8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AE03F60117;
        Mon, 30 Jul 2018 18:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532977116;
        bh=8/MjThK2c5ABUIfk7l9QOY+sdXH2IMiB6GT1iSQJJJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nEC124Gohu3WhQaKb1aVoTkJB+TmxJMk3dwI2ssSHqgRxmXbFLOHTz1jiaMGsiznc
         eMhEs0Ti6WqOMPYupbKyw/MzDoU/aeM8uEW51A1J3nJgypQEBO12G8rBSfVV587ybk
         ZeqcqTP+7csaiuGxnxgoSKzLHHk9/v6GNfeFTjsg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Jul 2018 11:58:36 -0700
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
In-Reply-To: <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
 <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com>
Message-ID: <534629d03437bc8e72a62d89e726dbe5@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-29 03:52, Rafael J. Wysocki wrote:
> On Sat, Jul 28, 2018 at 5:56 AM, Saravana Kannan 
> <skannan@codeaurora.org> wrote:
>> Many CPU architectures have caches that can scale independent of the 
>> CPUs.
>> Frequency scaling of the caches is necessary to make sure the cache is 
>> not
>> a performance bottleneck that leads to poor performance and power. The 
>> same
>> idea applies for RAM/DDR.
>> 
>> To achieve this, this patch adds a generic devfreq governor that can 
>> listen
>> to the frequency transitions of each CPU frequency domain and then 
>> adjusts
>> the frequency of the cache (or any devfreq device) based on the 
>> frequency
>> of the CPUs.
>> 
>> To decide the frequency of the device, the governor does one of the
>> following:
>> 
>> * Uses a CPU frequency to device frequency mapping table
>>   - Either one mapping table used for all CPU freq policies (typically 
>> used
>>     for system with homogeneous cores/clusters that have the same 
>> OPPs.
>>   - One mapping table per CPU freq policy (typically used for ASMP 
>> systems
>>     with heterogeneous CPUs with different OPPs)
>> 
>> OR
>> 
>> * Scales the device frequency in proportion to the CPU frequency. So, 
>> if
>>   the CPUs are running at their max frequency, the device runs at its 
>> max
>>   frequency.  If the CPUs are running at their min frequency, the 
>> device
>>   runs at its min frequency. And interpolated for frequencies in 
>> between.
> 
> While not having looked at the details of the patch yet, I would
> change the name of the feature to "Generic cpufreq transition
> governor" to make it somewhat less ambiguous.

In my opinion it makes it look MORE like this is a cpufreq governor. How 
about the following?
PM / devfreq: Generic cpufreq to devfreq mapping governor
Seem a lot more clear to me.

I'm open to suggestions for the devfreq governor name too. "cpufreq" has 
been very confusing so far.
cpufreq-map maybe?

Thanks,
Saravana
