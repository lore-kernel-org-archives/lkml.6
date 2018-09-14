Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD4DECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A7220882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYMnJpWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A7220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeINPoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:44:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44320 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:44:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so4009755plb.11;
        Fri, 14 Sep 2018 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2G1ip7pKnE3PFREYPCnPsrmEMd6lhHEJ5IOLhADkF4M=;
        b=KYMnJpWrp7iqhTKlN7HJ++95yoWJjFxW98uxLnb14T9/hFPE5tQi0xLA/YuZp4KVSu
         ZzHYIpzW3I7VIVwGHWDLicbN/80RfNvcVj1Ix8oHQc9ulRD7fEyJ3SD7Xrw0e26MdNNh
         lXD5HiLDxSqOEPzZiUMtu3FYZfCMyTfnHajrb6yUjqE+nni4BE+/pDeAE18uf3DeRK2r
         d514CKPPDZjELET/7Wij3yI92Cm6BOLkexqYeEi4L6R/X16kHB03qEyn1wjAi0IxnzVb
         SxQt46tuCr5/iaG2TnT/UW3w3wApaIMZrnaFCpvKViJQ3dTrraiMHXWgDOpG7KxlxJt/
         eQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2G1ip7pKnE3PFREYPCnPsrmEMd6lhHEJ5IOLhADkF4M=;
        b=IivQApGMhQ7WLCJdQWqin4+X+togNxPXmDXR6AEPuFqf1IkxbiWeNecPsuyZ7nar6t
         Oy+mTbh+u5FTPpr+yXNNvYWJZynSo717ZDJeE5tJc8aNCffYX3Z++WwFPCV1Nri898hL
         aYadTUrD0NRhLpPUdSEIXDj4qLgHKSGaWh9RC55Cq7AkIFEnED80wEqb4OwM3Y+lLY9g
         JQVBaqse+oZbjH3U7vCIkTttksEIDxudxglj+rVmXHaP2ojwzberUZ31guroBMv4HYIY
         Ac09kfjx/7WyQjafTWmlGHOUYzQ6m0qpfAiA+3XtKq+nq+MyxZoJsy0SbB2GQXYteSuy
         ZYWg==
X-Gm-Message-State: APzg51DQMg0KtfHzFgtG3KnUUf3YCow68D+2bCPtwwBC1GzocDtqCjyg
        S4LcW7jmfm/gzvm29IULkPY1AahY
X-Google-Smtp-Source: ANB0VdY+EtApFQrGB+xfOXLbRgBJtNHA3CPhfgG8St0upAUPqEyz/2UsWWg81qnEkNa6nyMPUPR01Q==
X-Received: by 2002:a17:902:274a:: with SMTP id j10-v6mr11742087plg.152.1536921023783;
        Fri, 14 Sep 2018 03:30:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-90-36.nat.spd-mgts.ru. [109.252.90.36])
        by smtp.googlemail.com with ESMTPSA id e73-v6sm11728211pfb.153.2018.09.14.03.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 03:30:22 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] CPUFREQ OPP's and Tegra30 support by
 tegra20-cpufreq driver
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20180830194356.14059-1-digetx@gmail.com>
 <1536237301.25080.22.camel@toradex.com>
 <6c5b6eb4-f809-1a31-acbc-ea27e5cb891b@gmail.com>
 <1536654470.32292.31.camel@toradex.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <09451207-ee77-7b4e-54cf-7a7a7ab67400@gmail.com>
Date:   Fri, 14 Sep 2018 13:30:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1536654470.32292.31.camel@toradex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 11:27 AM, Marcel Ziswiler wrote:
> On Fri, 2018-09-07 at 19:59 +0300, Dmitry Osipenko wrote:
> 
> - snip -
> 
>>> - With "cpufreq-info -f" I could only observe like the top 3-4 OPPs
>>> while it does not to go further down even when idling. Why could
>>> that
>>> be resp. what could cause this?
>>
>> What cpufreq governor are you using?
> 
> ondemand
> 
>> Here is my 'cpufreq-info --stats' output from Tegra30 after a several
>> minutes of idling after boot:
>>
>> 408000:245884, 456000:445, 608000:251, 760000:151, 816000:82,
>> 912000:75, 1000000:163  (561)
>>
>> And full cpufreq-info:
>>
>> cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
>> Report errors and bugs to cpufreq@vger.kernel.org, please.
>> analyzing CPU 0:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>> analyzing CPU 1:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>> analyzing CPU 2:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>> analyzing CPU 3:
>>     driver: tegra
>>     CPUs which run at the same hardware frequency: 0 1 2 3
>>     CPUs which need to have their frequency coordinated by software: 0
>> 1 2 3
>>     maximum transition latency: 50.0 us.
>>     hardware limits: 408 MHz - 1000 MHz
>>     available frequency steps: 408 MHz, 456 MHz, 608 MHz, 760 MHz, 816
>> MHz, 912 MHz, 1000 MHz
>>     available cpufreq governors: conservative, userspace, powersave,
>> ondemand, performance, schedutil
>>     current policy: frequency should be within 408 MHz and 1000 MHz.
>>                     The governor "ondemand" may decide which speed to
>> use
>>                     within this range.
>>     current CPU frequency is 608 MHz (asserted by call to hardware).
>>     cpufreq stats: 408 MHz:99.53%, 456 MHz:0.18%, 608 MHz:0.10%, 760
>> MHz:0.06%, 816 MHz:0.03%, 912 MHz:0.03%, 1000 MHz:0.07%  (563)
>>
>>
>>> - Unfortunately "cpufreq-info --stats" currently does not seem to
>>> output anything. Would that require something special to be
>>> implemented?
>>
>> Make sure that CONFIG_CPU_FREQ_STAT is enabled in the kernels config.
> 
> Yes, sorry. That was it, of course. Just wondering why that one isn't
> enabled in tegra_defconfig...

That option isn't essential for the kernel, though usually such useful and 
low-overhead features are welcome. IIRC, tegra_defconfig misses more important 
options (like namespaces) that are required by Linux distro's to work properly.

>>> Other than that you may add the following to the whole series:
>>>
>>> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Thank you very much!
> 
> You are very welcome. Thank you!
> 

