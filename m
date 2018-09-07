Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4CAC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7F02086D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWrFEj2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7F02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeIGVlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:41:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40290 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeIGVlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:41:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so12582536lfi.7;
        Fri, 07 Sep 2018 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9+9w8mFHYhhLc2FC65wXQI8Na2IOm1rOr1lFEgN8Igc=;
        b=VWrFEj2F3PwG7gZbfnOuaPy8stdIwfGID9w/xzfibAZhB4urrl0GkY11A7uVhhbgcn
         D5xw/CpQqRBikK5uAamVYe38+hVNCfiWZ8WalteiQpI0VUi7gNI5w4wmC2M/T6C24LuO
         4cfEs825Fctg+V+CnCzhkDaoi0zoZuBOmAIThW7jqdS1EGq6c+JqXr6srrNXimXpRAtr
         zuS+wjdNtN64ecxGjDyijwLPIMeGBd0+DEJ+u7EiMbks9Ks4f86Nni5vTUZjOweONQ/C
         W4SbWACp6J80grXj+6tHIwAfbPfLQ98AkxX//rSJATJohJ1zRTV5Re0mPKREAwh0n56v
         sjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+9w8mFHYhhLc2FC65wXQI8Na2IOm1rOr1lFEgN8Igc=;
        b=H+0e+j105YL0RChZgWQDCK8TYxhFfEjm14/VszpcOqK1kUxUrvlsc1AUXhe0APbRIy
         4EhzcFC7GG+k9CLwLI6ez6WwSN2GtzBBNLok3cr2OGBK5kuVTZiyBQzFepWr9o61JOfT
         eobycavkVUXVQt7tyEaf59rblpXjYYe1rtX5mguhz6V4Op3h1yrPZwgEkSr9VaF4Pcj/
         2b0J/WvIsAitFqSm2CecAugqlD91dZSg3jrlkZOi5O/wlSIXfp6BEvj4mDr7bGTDvC3k
         50uXVJztPuWEdloBE+sMzxzVa5DwOiZhCNr7nF6QnwgjyOrmu3P9aETYEPrGatzr4wk7
         bb/w==
X-Gm-Message-State: APzg51DxeOlPuFkXmges7ayq/aoIs/aQR43rHEL2tgsycIRwCjYtD+LN
        2kqG09Hhpn/O6yxC7ZEPNxMxQgcB
X-Google-Smtp-Source: ANB0Vdam+2YukykO8rEGQPwp+GZ2cQRCf9mFQwfYQkNifTMQUk4NLxvzk0/ak3EHV7bnS7GPJF6AWg==
X-Received: by 2002:a19:8c55:: with SMTP id i21-v6mr5733198lfj.90.1536339553852;
        Fri, 07 Sep 2018 09:59:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.googlemail.com with ESMTPSA id e26-v6sm1361343ljl.67.2018.09.07.09.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:59:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by
 tegra20-cpufreq driver
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20180830194356.14059-1-digetx@gmail.com>
 <1536237301.25080.22.camel@toradex.com>
Message-ID: <6c5b6eb4-f809-1a31-acbc-ea27e5cb891b@gmail.com>
Date:   Fri, 7 Sep 2018 19:59:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536237301.25080.22.camel@toradex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/18 3:35 PM, Marcel Ziswiler wrote:
> On Thu, 2018-08-30 at 22:43 +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series adds support for CPU frequency scaling on Tegra30 and
>> device
>> tree support that allows to implement thermal throttling and
>> customize
>> available CPU frequencies per-board. The tegra20-cpufreq driver has
>> been
>> re-worked to support that all.
>>
>> Note that Tegra30 support not strictly depends on the clock patches
>> that
>> are under review now, CPUFREQ driver will fail to probe until CCLKG
>> clock
>> will get exposed by the clock driver. Hence this series can be
>> applied
>> independently of the clock patches, CPUFREQ will start to work on
>> Tegra30
>> once both patchsets will be applied.
> 
> In general this seems to work fine both on Colibri T20 as well as
> Apalis/Colibri T30. However I did notice a few things plus have some
> additional questions:
> 
> - Both T20 as well as T30 currently limit the max frequency to 1 GHz
> while there are clearly T30 SKUs which may allow higher frequencies
> (e.g. our regular T30 aka Embedded SKU 1.3 GHz max resp. 1.4 GHz single
> core only, commercial T30 aka AP33 or T33 or whatever it is called up
> to 1.6 GHz max resp. 1.7 GHz single core only). Would I have to allow
> this via custom OPPs in my device tree?

Yes.

> - However, certain OPPs may also require adjusting core/cpu voltages
> which is not yet taken care of as far as I can tell, correct?

Yes, DVFS isn't implemented yet. That could be supported later.

> - I believe in downstream certain OPPs also take silicon parameters aka
> speedo whatever into account. Any comments/plans concerning this?

Good point. There is 'opp-supported-hw' device-tree property which seems is intended
for that purpose. I'll take a look at making use of the property in the next revision,
alternatively that could be implemented later in a distinct patch.

> - With "cpufreq-info -f" I could only observe like the top 3-4 OPPs
> while it does not to go further down even when idling. Why could that
> be resp. what could cause this?

What cpufreq governor are you using?

Here is my 'cpufreq-info --stats' output from Tegra30 after a several minutes of idling after boot:

408000:245884, 456000:445, 608000:251, 760000:151, 816000:82, 912000:75, 1000000:163  (561)

And full cpufreq-info:

cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
   driver: tegra
   CPUs which run at the same hardware frequency: 0 1 2 3
   CPUs which need to have their frequency coordinated by software: 0 1 2 3
   maximum transition latency: 50.0 us.
   hardware limits: 408 MHz - 1000 MHz
   available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816 MHz, 912 MHz, 1000 MHz
   available cpufreq governors: conservative, userspace, powersave, ondemand, performance, schedutil
   current policy: frequency should be within 408 MHz and 1000 MHz.
                   The governor "ondemand" may decide which speed to use
                   within this range.
   current CPU frequency is 608 MHz (asserted by call to hardware).
   cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760 MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
analyzing CPU 1:
   driver: tegra
   CPUs which run at the same hardware frequency: 0 1 2 3
   CPUs which need to have their frequency coordinated by software: 0 1 2 3
   maximum transition latency: 50.0 us.
   hardware limits: 408 MHz - 1000 MHz
   available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816 MHz, 912 MHz, 1000 MHz
   available cpufreq governors: conservative, userspace, powersave, ondemand, performance, schedutil
   current policy: frequency should be within 408 MHz and 1000 MHz.
                   The governor "ondemand" may decide which speed to use
                   within this range.
   current CPU frequency is 608 MHz (asserted by call to hardware).
   cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760 MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
analyzing CPU 2:
   driver: tegra
   CPUs which run at the same hardware frequency: 0 1 2 3
   CPUs which need to have their frequency coordinated by software: 0 1 2 3
   maximum transition latency: 50.0 us.
   hardware limits: 408 MHz - 1000 MHz
   available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816 MHz, 912 MHz, 1000 MHz
   available cpufreq governors: conservative, userspace, powersave, ondemand, performance, schedutil
   current policy: frequency should be within 408 MHz and 1000 MHz.
                   The governor "ondemand" may decide which speed to use
                   within this range.
   current CPU frequency is 608 MHz (asserted by call to hardware).
   cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760 MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
analyzing CPU 3:
   driver: tegra
   CPUs which run at the same hardware frequency: 0 1 2 3
   CPUs which need to have their frequency coordinated by software: 0 1 2 3
   maximum transition latency: 50.0 us.
   hardware limits: 408 MHz - 1000 MHz
   available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816 MHz, 912 MHz, 1000 MHz
   available cpufreq governors: conservative, userspace, powersave, ondemand, performance, schedutil
   current policy: frequency should be within 408 MHz and 1000 MHz.
                   The governor "ondemand" may decide which speed to use
                   within this range.
   current CPU frequency is 608 MHz (asserted by call to hardware).
   cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760 MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)


> - Unfortunately "cpufreq-info --stats" currently does not seem to
> output anything. Would that require something special to be
> implemented?

Make sure that CONFIG_CPU_FREQ_STAT is enabled in the kernels config.

> Other than that you may add the following to the whole series:
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Thank you very much!
