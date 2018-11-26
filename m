Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC57C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831AB205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjjStoop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831AB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeK0HDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:03:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54641 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbeK0HDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:03:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so4867639wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDdcgfcTuQZriqBwmuMwXXRPU2P6JnWM+lQvlN8bFWE=;
        b=HjjStoopAIC2B+G3TgxTttzGBvYcEJfFelUHCSP8nqbtpTqigJ/DmZIibQD15ATRJS
         23ONaZOzEP17nsnuu7t8wwjtRfCTMa+pdJxw4wKsMsrd4XaClTPlDW8Ju8++6BRFnYIu
         6GfZ5fUdeUATkUXdmXi1n3nu2pVj0K24CEois=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDdcgfcTuQZriqBwmuMwXXRPU2P6JnWM+lQvlN8bFWE=;
        b=ftwETjykTNGgp78YROVuRscouYzyTmcIROq0zGFNFFzCOLzswRr0YkyvAj8xsM79FP
         he9E8jiQeP+2dGiHsVN+BfSfSUqBv/SszZwtpc/8OafbuiFJmaiNJTyd092T7jOw6LBb
         2NXVFJzir+tVfeflLdZ9f/y6/lG9iNbswMIbTWvJR6OLivHJqQtMhJWNhXZ6rxZ6ldd9
         cDAZg9g/TrPJOJAlu6/0SRbM1JL73ABDpPxq0kokAI5irFhTiYmu95sipA4yqjg4Uo/V
         ejXbsp7/pGeWue/7UMGUVTowlkkjDDS+JGc8rXSd5YJjeG4LQBOi/k4tIpCatgsAdzfr
         UFoA==
X-Gm-Message-State: AGRZ1gJ5QtGwConhDcaIS8+jZsl3Me/BVwOzlwamte/c46OizsptAk4V
        WKD7TDVsKqLylbo0nqI6jASDhaN/DE8=
X-Google-Smtp-Source: AJdET5etdLY0oQyS1j9gUpf+lN83Yeu0oh/dd4E7YoXrrNtpVhtc2S7wKRlyDLUO5Bg9MzyyPhg70g==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr24494390wmg.122.1543262894924;
        Mon, 26 Nov 2018 12:08:14 -0800 (PST)
Received: from [192.168.0.40] (72.224.136.77.rev.sfr.net. [77.136.224.72])
        by smtp.googlemail.com with ESMTPSA id v4sm856882wme.6.2018.11.26.12.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 12:08:14 -0800 (PST)
Subject: Re: [PATCH V4 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
 <20181126150601.GD4637@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1ad863c3-2c78-52a1-2f0f-b7a3cc3ad80d@linaro.org>
Date:   Mon, 26 Nov 2018 21:08:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126150601.GD4637@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

thanks for the review.

On 26/11/2018 16:06, Greg Kroah-Hartman wrote:
> On Mon, Nov 26, 2018 at 01:20:43PM +0100, Daniel Lezcano wrote:
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
> 
> Why the extra blank line?
> 
> And what is userspace going to do with this noise?  Is this an error?
> Just normal operation?  A device should never be saying anything to the
> log for normal boot functionality.  When is this called?

It is not an error but a fallback path. It is called at init time when
the cpufreq notifier is called and when either the DT read failed or
nothing is specified. I agree this is noise, I will remove the trace.

> And no need for the "cpu_capacity:" right?  Shouldn't the pr_info() line
> handle the prefix for you?

Ah, right I did not pay attention to the prefix and blindly copied the
line from somewhere else. I think it is better to drop this trace in any
case.

I will provide a patch setting the pr_fmt in a separate series.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

