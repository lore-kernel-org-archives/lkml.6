Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A545C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD4820C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="s1QnbUN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfB0S6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:58:22 -0500
Received: from vps01.wiesinger.com ([46.36.37.179]:47670 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfB0S6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:58:22 -0500
Received: from wiesinger.com (wiesinger.com [84.113.44.87])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 30B399F294;
        Wed, 27 Feb 2019 19:58:17 +0100 (CET)
Received: from [192.168.0.14] ([192.168.0.14])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id x1RIwEJ7020957
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 19:58:15 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com x1RIwEJ7020957
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1551293895;
        bh=k9V2EgLm96FQo9l0q1BS4cpzhTR+vgKHSwE2UpAjRrc=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=s1QnbUN4fRYJIGa6ezZZ+UnTCx3fw/hjMGmbaKOgSC72VITdIzJDLnSWb3ai+cFgK
         1umlI9UiV0A9kL7hyOWGRGb3bsHKBB2W9PaAghQ2KfNyo0jhQX2XlPL5IBQe5BIStZ
         RbyBEINZATmchaySIHxqdjItCGHUkqdIyiZmN5fRtTIrH1tRORR2kwwT3dP/aXkCGA
         IIRg10h1zMY/uREuAgoVdDK/k2JUqhv8uE1XrKqj/Xe66LHXEmrc2s9KiMUMqAYd0X
         JNZ1FgIjTQPz+o6/NsYgCbNWzTb2hx2V3hre1zh7nV8IAlPLc961gByL+HRpT1g9hn
         I8S7HInr5yDOVa8OqsCeffIN9vnmlgXgGlDFGCjXlNrl3kqSEUAk7nPDf44QGS/ckI
         u/QRKRN+kCPbvTTtQN/RAldp65mftDxCFDPM4EAi6DSox0dCO0lgW99Yj5rTl8VZjV
         n0hiHN4CqgCYR5qYbjJHql3qm9RrfA+aAzw/jhPbd9YHUTukp1IwA67bbS8bPl6O7+
         7+sv63X39mE9S6Tns8D17iMIWzg3RHeEiDpeZXA8Muh8736EE2Gun/KGaD7TOdIK7t
         HG7oQo4XHWle1y35snQpOHBzXcreclq2zTPv8RD3EthGInZ9YWaa46V2M1OpFbdRyl
         w1s960iHnpC2PTni7LGG1n/Y=
From:   Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Banana Pi-R1 stabil
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
References: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
 <20190227092023.nvr34byfjranujfm@flea>
Message-ID: <5f63a2c6-abcb-736f-d382-18e8cea31b65@wiesinger.com>
Date:   Wed, 27 Feb 2019 19:58:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190227092023.nvr34byfjranujfm@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.2019 10:20, Maxime Ripard wrote:
> On Sun, Feb 24, 2019 at 09:04:57AM +0100, Gerhard Wiesinger wrote:
>> Hello,
>>
>> I've 3 Banana Pi R1, one running with self compiled kernel
>> 4.7.4-200.BPiR1.fc24.armv7hl and old Fedora 25 which is VERY STABLE, the 2
>> others are running with Fedora 29 latest, kernel 4.20.10-200.fc29.armv7hl. I
>> tried a lot of kernels between of around 4.11
>> (kernel-4.11.10-200.fc25.armv7hl) until 4.20.10 but all had crashes without
>> any output on the serial console or kernel panics after a short time of
>> period (minutes, hours, max. days)
>>
>> Latest known working and stable self compiled kernel: kernel
>> 4.7.4-200.BPiR1.fc24.armv7hl:
>>
>> https://www.wiesinger.com/opensource/fedora/kernel/BananaPi-R1/
>>
>> With 4.8.x the DSA b53 switch infrastructure has been introduced which
>> didn't work (until ca8931948344c485569b04821d1f6bcebccd376b and kernel
>> 4.18.x):
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/dsa/b53?h=v4.20.12
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/dsa/b53?h=v4.20.12
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/dsa/b53?h=v4.20.12&id=ca8931948344c485569b04821d1f6bcebccd376b
>>
>> I has been fixed with kernel 4.18.x:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/dsa/b53?h=linux-4.18.y
>>
>>
>> So current status is, that kernel crashes regularly, see some samples below.
>> It is typically a "Unable to handle kernel paging request at virtual addres"
>>
>> Another interesting thing: A Banana Pro works well (which has also an
>> Allwinner A20 in the same revision) running same Fedora 29 and latest
>> kernels (e.g. kernel 4.20.10-200.fc29.armv7hl.).
>>
>> Since it happens on 2 different devices and with different power supplies
>> (all with enough power) and also the same type which works well on the
>> working old kernel) a hardware issue is very unlikely.
>>
>> I guess it has something to do with virtual memory.
>>
>> Any ideas?
>> [47322.960193] Unable to handle kernel paging request at virtual addres 5675d0
> That line is a bit suspicious
>
> Anyway, cpufreq is known to cause those kind of errors when the
> voltage / frequency association is not correct.
>
> Given the stack trace and that the BananaPro doesn't have cpufreq
> enabled, my first guess would be that it's what's happening. Could you
> try using the performance governor and see if it's more stable?
>
> If it is, then using this:
> https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
>
> will help you find the offending voltage-frequency couple.
>
> Maxime
>
For me it looks like they have all the same config regarding cpu 
governor (Banana Pro, old kernel stable one, new kernel unstable ones)

They all have the ondemand governor set:

I set on the 2 unstable "new kernel Banana Pi R1":

# Set to max performance
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor

Running some stress tests are ok (I did that already in the past, but 
without setting maximum performance governor).

Let's see if it helps.

Thnx.

Ciao,

Gerhard

# Banana Pro: Stable

./cpu_freq.sh
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors: 
conservative userspace powersave ondemand performance schedutil
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed: <unsupported>
/sys/devices/system/cpu/cpu1/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq: 912000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu1/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors: 
conservative userspace powersave ondemand performance schedutil
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq: 912000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed: <unsupported>

# Banana Pi R1: The one which is running kernel 4.7.4 and stable
./cpu_freq.sh
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors: 
conservative userspace powersave schedutil ondemand performance
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq: 312000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed: <unsupported>
/sys/devices/system/cpu/cpu1/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq: 720000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu1/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors: 
conservative userspace powersave schedutil ondemand performance
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq: 720000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed: <unsupported>

# Non Stable, Banana Pi R1 #1
./cpu_freq.sh
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: 912000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors: 
conservative userspace powersave ondemand performance schedutil
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq: 912000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed: <unsupported>
/sys/devices/system/cpu/cpu1/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu1/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors: 
conservative userspace powersave ondemand performance schedutil
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq: 912000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed: <unsupported>

# Non Stable, Banana Pi R1 #2

./cpu_freq.sh
/sys/devices/system/cpu/cpu0/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: 912000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu0/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors: 
conservative userspace powersave ondemand performance schedutil
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq: 912000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed: <unsupported>
/sys/devices/system/cpu/cpu1/cpufreq/affected_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_transition_latency: 244144
/sys/devices/system/cpu/cpu1/cpufreq/related_cpus: 0 1
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_frequencies: 
144000 312000 528000 720000 864000 912000 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors: 
conservative userspace powersave ondemand performance schedutil
/sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq: 912000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_driver: cpufreq-dt
/sys/devices/system/cpu/cpu1/cpufreq/scaling_governor: ondemand
/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq: 960000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq: 144000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed: <unsupported>

cat cpu_freq.sh
#!/bin/sh

MAX_CPU=2
let MAX_CPU_1=MAX_CPU-1

CPUS=`seq 0 ${MAX_CPU_1}`

for CPU in ${CPUS}; do
   for i in /sys/devices/system/cpu/cpu${CPU}/cpufreq/*; do
     if [ -f $i ]; then
       echo $i: `cat $i`
     fi
   done
done

