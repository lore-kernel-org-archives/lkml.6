Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB808C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8496625333
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ci1NDGNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8496625333
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeFXWkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 18:40:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40063 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFXWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 18:40:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id g18-v6so11680558wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 15:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:cc:references:to:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kckc2JON4bIyfqUbuOt5vK735Ow6/bMXuJfQPvyhsjw=;
        b=ci1NDGNLdLnCzu9BkCmSCGNWfrCBORGwCCi7LCosfExHcZ6g2ExB/ejEe2+wjx7TVu
         +kPkv0ahtMVHbl/2AZ1EiQPD+WU3LN7OYa4YEpFfx79mOMwa3OymMfNIA7TzKhhUWyDF
         R8lyL5WICqq0KMB7YVlj/h4NkXF0tokvAaV5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kckc2JON4bIyfqUbuOt5vK735Ow6/bMXuJfQPvyhsjw=;
        b=qJGWRafZclSAqv1s5sIHSyeDgE1hV/1zxMN3ZSX5qvy5Qw93dljM310MGme7S+slZh
         Msmy5LiDj8Eas/5WEZvA4QGy33jbjTvp1iF65QRh2IrZfqfaoITGpvLRK/4XtoeDdBUY
         r7804JeY31EPa+iFsBPrDcFu6Ijz0io2rGBjP2/sB2PE/ynNp90ZTAjYGeqn/WHfBUa5
         Y5yuYaDashrTMf9cUGZbLVNMdNie+6mCE2zDAOEJnRtNR5nrF5iggTfVZN50jH4usR3C
         Kj7uxWAHNNNGrZgx5KAdvs8uDBYXoLXqQEECnkBURR7aYK5pZ2stB8QzhZoC/JOpvNr0
         jcWg==
X-Gm-Message-State: APt69E0DiExlZP+OdwKvwUsyce1wvokiTtgBFmgQ8Ee0l0QMlgz+FjTD
        BMS+71DGwaXEvtM2KxyAMj4R6g==
X-Google-Smtp-Source: AAOMgpfV4VW/J3Mpbt8seEEpKmTMnbeAmDJcp1NYrNGRcvGEGaOO+ZppkByr72hZQxZJwp1ApGb9bg==
X-Received: by 2002:adf:8747:: with SMTP id 7-v6mr7580415wrz.117.1529880013999;
        Sun, 24 Jun 2018 15:40:13 -0700 (PDT)
Received: from [192.168.8.101] ([37.171.249.253])
        by smtp.googlemail.com with ESMTPSA id z18-v6sm4304661wrp.59.2018.06.24.15.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 15:40:13 -0700 (PDT)
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
To:     rjw@rjwysocki.net
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fc2ef4e9-7ec8-c644-9495-e33f000531b2@linaro.org>
Date:   Mon, 25 Jun 2018 00:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

do you think this patch is acceptable for merging ?



On 20/06/2018 06:34, Viresh Kumar wrote:
> On 19-06-18, 15:23, Daniel Lezcano wrote:
>> Initially, the cpu_cooling device for ARM was changed by adding a new
>> policy inserting idle cycles. The intel_powerclamp driver does a
>> similar action.
>>
>> Instead of implementing idle injections privately in the cpu_cooling
>> device, move the idle injection code in a dedicated framework and give
>> the opportunity to other frameworks to make use of it.
>>
>> The framework relies on the smpboot kthreads which handles via its
>> main loop the common code for hotplugging and [un]parking.
>>
>> This code was previously tested with the cpu cooling device and went
>> through several iterations. It results now in split code and API
>> exported in the header file. It was tested with the cpu cooling device
>> with success.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Javi Merino <javi.merino@kernel.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Rui Zhang <rui.zhang@intel.com>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>> ---
>>
>> V9:
>>    - Unconditionnally reset the should_run flag for all kthreads
>>      belonging to the cpumask and remove the park() callback (Viresh Kumar)
>>    - Fix up the typos in the comments (Viresh Kumar)
> 
> Looks great now. Can't think of any more races :)
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

