Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDFACC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A683208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeRA1N25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A683208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935548AbeFMUAo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:00:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42931 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935291AbeFMUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:00:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so4001130wrk.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bOg2KcNwWD2Qje7khkisCuX0H1RYBryxyoUv0g7zffQ=;
        b=NeRA1N25hrBQmxvy/4JGQJdw1OasNTC1x/xMa5MukHNTycOp8gP7rrtB/5Yi48wYHl
         SzeR0PScr2luEccwCDOgccMWIStvx8yg3xRmVQhXEYRJwpP5FxpPN47mxzyS7ZGi0Z+i
         F56E3hrbRmLSU1LmazGYzY11a7Ep3S5mau7bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bOg2KcNwWD2Qje7khkisCuX0H1RYBryxyoUv0g7zffQ=;
        b=gCYbrXg08t2j0/I+Nn+KIFhaG3bcWa6bgvA5UBJ7+IhPRMXhiOa8WhWT56DvZgNm/D
         HPAN68jpii1L+YTU9OFE4yBibtA9t6cfHdVVjXSZzPTwZOcSZ3RB+sADtlK2ag/+4ji0
         Pmw9B0RXDggtskKcTrceKNI6xCs3jX8PBOvJ3UjbNCYt5jwgp1XAzvzA+NHu+SvEWbCd
         Dis71PngfeRxBhAaRx0i2U6d+kIwEcFGaeMR2M45irtIEYPLZ4T0gW7nXQVaS+cY1w3y
         OU/ZF+L0LH03jmGnhvyYeQqIGVTZ/I4xDdKmEXsj0r0pDe967H2ObE36PWSvI2Hg4IFp
         ohKw==
X-Gm-Message-State: APt69E09a5mDpjP9x5JSg8WQgdHnkjUW0+uDYuenLo5gdUpdF3taODA5
        VlG/dN4HibqIsHG8q98a/cr56Q==
X-Google-Smtp-Source: ADUXVKLecpgwCFu/LGYnfCdZofgbrqYELBxuEhxs6ymgB46r1iliCUJCvPLe2u9GDEBc/IGdlDflng==
X-Received: by 2002:adf:e447:: with SMTP id t7-v6mr5443012wrm.145.1528920041326;
        Wed, 13 Jun 2018 13:00:41 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:b0fb:9cfa:79ac:305e? ([2001:41d0:fe90:b800:b0fb:9cfa:79ac:305e])
        by smtp.googlemail.com with ESMTPSA id h77-v6sm5751644wmd.9.2018.06.13.13.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 13:00:40 -0700 (PDT)
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "kevin.wangtao@linaro.org" <kevin.wangtao@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "javi.merino@kernel.org" <javi.merino@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <1528905257.48473.4.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0b72e862-6bbe-e706-79f8-e1b690982920@linaro.org>
Date:   Wed, 13 Jun 2018 22:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528905257.48473.4.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2018 17:54, Pandruvada, Srinivas wrote:
> On Tue, 2018-06-12 at 14:00 +0200, Daniel Lezcano wrote:
>> Initially, the cpu_cooling device for ARM was changed by adding a new
>> policy inserting idle cycles. The intel_powerclamp driver does a
>> similar action.
>>
>> Instead of implementing idle injections privately in the cpu_cooling
>> device, move the idle injection code in a dedicated framework and
>> give
>> the opportunity to other frameworks to make use of it.
>>
>> The framework relies on the smpboot kthreads which handles via its
>> main loop the common code for hotplugging and [un]parking.
>>
>> This code was previously tested with the cpu cooling device and went
>> through several iterations. It results now in split code and API
>> exported in the header file. It was tested with the cpu cooling
>> device
>> with success.
>>
> May be I have missed, but I don't see any use of powercap sysfs.
> 
> We created powercap sys that user space is presented a common interface
> for power capping. The RAPL driver was also submitted as cooling device
> before, but suggestion was to create this powercap.
> 
> So if powercap interface is not enough then may be we should enhance
> that.

We are creating a framework for idle injection. This framework can then
be used by the cpu_cooling device, the power_clamp and in addition a
power capping for ARM (if it makes sense).



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

