Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D18C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C174921104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3RR1d6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C174921104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeKZXnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:43:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZXnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:43:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so10805421wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3nGJJA5ga02Piol9iePKkcZXoIs3Egzd+DCJl39HAio=;
        b=j3RR1d6TFHW4LVz3uVJeOnxfk1K9VzpIVMUIDRVUdXmoAu1gLZl5qnmz8/Wkm9ye+x
         hk13NGC6fEyRei46LB/gyHl84wKRRRtUAuJ4VpoJbYY03IxdJWGxhWEnRcZehZgv6UF8
         D5hQgqdUU8R7I7jbxMb0j/ns9VLWcrzcVHyj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3nGJJA5ga02Piol9iePKkcZXoIs3Egzd+DCJl39HAio=;
        b=Z0dAhOA9v5YQXcwvaWvE5Pg+Sr5aq24SmuR81zttuOmRnUGvXhCTl76Yz2lnyQgOZj
         jR7yFz6WKF5Pmww9OLJRZi6o69qyg6EMJWkObXU5x5tZip1oIVbDgyUit0V0Z5KmAzaI
         pgF29JeE0imINjJAHoTOdbCfqU49IfpTIxCvShKlQ+i96OpanlcY95yIOjbEdm6S0OcR
         spsyUXvMEEQxusXuGnLwHznzjhPyjvX2yxFkvUPdqawCSI0xtOaV8lhziJkyWxPGn9s8
         mGl/jdwn9+h6sl8Slu4ionLiZhpEUxiaq12n1YHa08ewECWIxOD6q7amL6TbVrX1byUl
         UEng==
X-Gm-Message-State: AA+aEWYbvp0SY0as7dc7hOvMVM44EPteKbSMVDvH+KRKlSt7QP+L6Q5P
        PSyiLJclzW33HEebK/8w74XOIA==
X-Google-Smtp-Source: AFSGD/Xmtj3t+xlVONj05dWfXAjtEGvQvQSNnIYIk+Q48aKYHSZ9B+6p+A30BV14iyiKi2ThnvvRCg==
X-Received: by 2002:adf:91a3:: with SMTP id 32mr21432172wri.99.1543236586641;
        Mon, 26 Nov 2018 04:49:46 -0800 (PST)
Received: from [192.168.0.40] (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm1211750wmf.22.2018.11.26.04.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 04:49:45 -0800 (PST)
Subject: Re: [PATCH V4 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
 <20181126124821.hcagb4ai7z6qldr3@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d284936d-6dc9-8421-46fd-6397d25d4a38@linaro.org>
Date:   Mon, 26 Nov 2018 13:49:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126124821.hcagb4ai7z6qldr3@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 13:48, Quentin Perret wrote:
> On Monday 26 Nov 2018 at 13:20:43 (+0100), Daniel Lezcano wrote:
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index fd5325b..e0c5b60 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -243,9 +243,20 @@ static int __init register_cpufreq_notifier(void)
>>  	 * until we have the necessary code to parse the cpu capacity, so
>>  	 * skip registering cpufreq notifier.
>>  	 */
>> -	if (!acpi_disabled || !raw_capacity)
>> +	if (!acpi_disabled)
>>  		return -EINVAL;
>>  
>> +	if (!raw_capacity) {
>> +
>> +		pr_info("cpu_capacity: No capacity defined in DT, set default "
>> +		       "values to %ld\n", SCHED_CAPACITY_SCALE);
>> +
>> +		raw_capacity = kmalloc_array(num_possible_cpus(),
>> +					     sizeof(*raw_capacity), GFP_KERNEL);
>> +		if (!raw_capacity)
>> +			return -ENOMEM;
>> +	}
>> +
>>  	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
>>  		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
>>  		return -ENOMEM;
> 
> I just tried on my Juno by removing the capacity-dmips-mhz values from
> the DT and got the following:
> 
>   $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
>   450000 575000 700000 775000 850000
>   450000 625000 800000 950000 1100000
>   $ cat /sys/devices/system/cpu/cpu*/cpu_capacity
>   791
>   1024
>   1024
>   791
>   791
>   791
> 
> Same thing with a partially-filled DT (which is the expected behaviour
> now). So feel free to add:
> 
> Tested-by: Quentin Perret <quentin.perret@arm.com>

Thanks for testing!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

