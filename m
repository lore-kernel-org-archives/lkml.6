Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3292DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AF1214D5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vuu6CLn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AF1214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJRSOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:14:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40253 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbeJRSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:14:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so33016701wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dfz7bQUjgxu94yc7QGFmsUgmmwaOo2igk2335i5OuqQ=;
        b=Vuu6CLn0ZFwakpjWLWMxRWMV5TatApdPIrRjqCh4vUgeIpK6Alc6tZxhOH8YZvlSvE
         E0xFw5/iDxKaFZPIJi45ccz1ZOtICK8L236SWptmfYjgSKntGZDdhFq7R1lE9/NYcS6S
         aJvfXPs/wNe/RwetjMHUFvI3FNbrYDaUrBI68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dfz7bQUjgxu94yc7QGFmsUgmmwaOo2igk2335i5OuqQ=;
        b=a2K9ijv4PnIBUdARSVCMKwazkqTqw07rJux8mQNtWdSARcKJmIAJZyx8NmdYhmD9zj
         yhgL8SnjGn2d5hxdVKbpV8YbE++TdKA9TGt5te7y8gX+mwWN/cJbvhFuRNWQM8NJhgn5
         KJfgcQhbAJ6vHnEwnoCezqThos/CggLi3La+epo9xcdc7UvbibW/gu2Cbks6pmVl9JQJ
         LIAAnTaB6Y2cJ/4t7YitLBQZIqEROaIL7UE2lddHUwlEG0rSv1VwSF/YSqAMWPtUockw
         QnXm7aGVT1lmyITiAgxz9rEYRQy65gUAQqTDUP4bDP+0sGmUNRHIjoXQtbCNvqpDbgte
         3bEw==
X-Gm-Message-State: ABuFfojnSYWG5Ui073MDcZrxtwZAaPxNQhIc3VuXVXjun57ltejCy2/n
        YN4bepx5AQlM2SXBigPYV4cmsQ==
X-Google-Smtp-Source: ACcGV60S9G8WQ+KDFCUKUbbH2zS9VeSzDxzwGxoWa5McY9Be96RjdKRbIsJwRBqPrnMAJtiyVQruBw==
X-Received: by 2002:adf:ebcf:: with SMTP id v15-v6mr28397745wrn.76.1539857625610;
        Thu, 18 Oct 2018 03:13:45 -0700 (PDT)
Received: from [192.168.0.40] (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.googlemail.com with ESMTPSA id m143-v6sm7107999wmd.29.2018.10.18.03.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 03:13:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0ikpPk12PshjB7EwtGSz6kF5WJyKgDHB8cnXaEusy38UQ@mail.gmail.com>
 <8585bac0-c72c-edf4-2e93-c8740a3b1b6c@linaro.org>
 <CAJZ5v0ia6jc80=xTkOSZofhmx80UXn2Kv-mPJ6B4JZ-Sc75kBA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a662abc2-a44a-de58-3fec-76f477e3bfd2@linaro.org>
Date:   Thu, 18 Oct 2018 12:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ia6jc80=xTkOSZofhmx80UXn2Kv-mPJ6B4JZ-Sc75kBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 12:06, Rafael J. Wysocki wrote:
> On Thu, Oct 18, 2018 at 11:54 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 18/10/2018 11:42, Rafael J. Wysocki wrote:
>>> On Thu, Oct 18, 2018 at 11:36 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> It was suggested to set the scene for the PM components in the
>>>> scheduler code organization in the recent discussion about making the
>>>> scheduler aware of the capacity capping from the thermal framework.
>>>>
>>>> Move the cpufreq files into its own directory as suggested at:
>>>>
>>>> https://lkml.org/lkml/2018/10/18/353
>>>> https://lkml.org/lkml/2018/10/18/408
>>>
>>> Fair enough, but do we need to do that right now?
>>
>> I'm not planning to do more code reorg than this patch right now. Up to
>> you to decide if you are willing to take them.
> 
> The SPDX one certainly is applicable, but I'm not sure about the other one TBH.
> 
> Why don't you add the SPDX IDs to those files as they are for now?

Yes, sure.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

