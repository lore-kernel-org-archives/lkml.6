Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF06218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsdDRWZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfBRE7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:59:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34401 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfBRE7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:59:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so7839517pgd.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 20:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ji4qijWchQhKqe3sjjll+6r6wGZG+I2KBzy3v6KY3mI=;
        b=UsdDRWZIMsnEesDE9xOtpvp4//Qkoh3LwPbdV9CBc/n2fs0ImMVq7pCbTjOUa606JT
         I9VlO84hw1mNeExOaqHk97r6E4gJMIY9uuc4ObX+jHIPZJFVzrNxP70JPhhdivokwrmy
         wtDjVA2JKHYyyPHt0wN8GcnXX8VqenwaUyWAZLiDQ819fhS07kh+IcXOMOwCqbrDEmal
         sMPY8erlijVCUnwXhRJpBAHRTY5qJPMbv8aj6a7DF8bT8nFH8WJPHz2TxrOLZEIDTV38
         TUNdfiAQTghqrBtCMYKnrxKINwb3sbduTLNyDnWoqLP0mkMn+qpJJO0Md6hbqp/Noma2
         +HMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ji4qijWchQhKqe3sjjll+6r6wGZG+I2KBzy3v6KY3mI=;
        b=dwDkqkebBFGDmIopz0MdaRhSS3MWtsObqstIJlIb/onrNW4l+ocCLGxk+q4FBzKJYn
         7c2/4M0seA/iiQfn2wxXkdz/muEMJnLErnjg5kWmpjK931tyAL4mz0Oz++8j9IVO9e0P
         mut30NoIOFH83d2fxvRpzpvgAm5bKdPTl/Q8W4Flwja37oziC51rcNwQMi8Sqd9GZua4
         oCzk7rRifBlHwC+6QMznjMHtBWrfEf9GQLWjQrmwTHdCIkhVG+kaE+kU7XkwHQ0YfP74
         qWzsc14eimUqaYMjd5vi7dVGJWdNmGAc3u/uXSnJVnxQnbbGAdKwJTMLBNbeGb7Ti4d7
         7VRw==
X-Gm-Message-State: AHQUAuYxKRzhUDz+E4+faVdZKxwbZ1/wkoK6KdFpzBxtmIYHXAcETYRP
        BqmVfkWJEZNZyUL9BuBQ1+HcuA==
X-Google-Smtp-Source: AHgI3IaNpJxdhWdywP27kn034v1NbUnLRQIbFeUlMmyDg/3JV67uV68Kq5r3VJt+h5f0dR4fGoRR+Q==
X-Received: by 2002:a63:2bc6:: with SMTP id r189mr16807816pgr.201.1550465988743;
        Sun, 17 Feb 2019 20:59:48 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f12sm14475110pgo.13.2019.02.17.20.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 20:59:48 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:29:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: speedstep: convert BUG() to BUG_ON()
Message-ID: <20190218045945.rsaj4vfarael4tbm@vireshk-i7>
References: <20190216161501.12168-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216161501.12168-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-19, 11:15, Yangtao Li wrote:
> To fix coccinelle WARNING.
> 
> WARNING: Use BUG_ON instead of if condition followed by BUG.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/speedstep-ich.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
> index fbbcb88db061..5d8a09b82efb 100644
> --- a/drivers/cpufreq/speedstep-ich.c
> +++ b/drivers/cpufreq/speedstep-ich.c
> @@ -243,8 +243,7 @@ static unsigned int speedstep_get(unsigned int cpu)
>  	unsigned int speed;
>  
>  	/* You're supposed to ensure CPU is online. */
> -	if (smp_call_function_single(cpu, get_freq_data, &speed, 1) != 0)
> -		BUG();
> +	BUG_ON(smp_call_function_single(cpu, get_freq_data, &speed, 1));
>  
>  	pr_debug("detected %u kHz as current frequency\n", speed);
>  	return speed;

Applied. Thanks.

-- 
viresh
