Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D6920700
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="juwE4Gq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfAHFBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:01:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfAHFBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:01:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so1161233pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 21:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JyJ6VQDNECiue1P5QSTufBFpRz9Fy0iZlzUs+dyRxnM=;
        b=juwE4Gq+5GNv9FOzrk700TUnWpEyvtqOzF6MSm+eTsfRDxMEJm1bMqFRUoKhjPnU1l
         VvuGoGjz2sRfhuIW5v1TDEYR8J3sVUTDMX2c3uLkCaPvUVBVKvg2PQUbSd+4O8MvazpT
         BHWpypWn9lHdBE52+9JCqg/vh84cY7cRexUCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JyJ6VQDNECiue1P5QSTufBFpRz9Fy0iZlzUs+dyRxnM=;
        b=Utz5Kc5LJJb0Pl/5w1i9FLY2737bdkCiy9VUCulYT9HkydTpX2NFnBRk9QH930mAEF
         kls2ayZIEuKPZRBL7Sz3GEzZakdzM2NaP+Msm1OBoTYATQ0wYJW0N/5+yliEPRvXpa0A
         ttgmoEMApCLdzrQFqSCMQ0+g2NgQp60ZlS24InVEV+JbG3IbKMfx0lXdGB9jEldQTcJP
         18R/WQsbFc5/47IlXh2iAA+Crz13XmYJ+csNkLxfVbOZ2py++N2aLjHLPJduw7V6etYs
         4tJCRs2AazN+BmOTj9p/ZUvV6JzlOyEmfvGVSZnUkG0FN8YC+xeMVfnaN5rW495V0u2O
         aW8g==
X-Gm-Message-State: AJcUukcyHwfdjXx4e5G2VilK/EHsh1P6A4v4kvVC7xJYbM2raMBvVyDl
        v0ODt958jfnRdVeHuLZaTcrK/w==
X-Google-Smtp-Source: ALg8bN7KAFJjfSrbpNrbUyhcPClsoEXgvjE0hwFw8w2j4r1ZI+aE4CRq2/ulZY30/CNsQjuvtTnscA==
X-Received: by 2002:a62:5b44:: with SMTP id p65mr309404pfb.47.1546923659821;
        Mon, 07 Jan 2019 21:00:59 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id e131sm116259147pfg.75.2019.01.07.21.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:00:59 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:30:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: e_powersaver: Use struct_size() in kzalloc()
Message-ID: <20190108050056.quckhd2d5ah4ywax@vireshk-i7>
References: <20190107173343.GA4258@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107173343.GA4258@embeddedor>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-19, 11:33, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/cpufreq/e_powersaver.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
> index 60bea302abbe..2d3ef208dd70 100644
> --- a/drivers/cpufreq/e_powersaver.c
> +++ b/drivers/cpufreq/e_powersaver.c
> @@ -323,9 +323,8 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
>  		states = 2;
>  
>  	/* Allocate private data and frequency table for current cpu */
> -	centaur = kzalloc(sizeof(*centaur)
> -		    + (states + 1) * sizeof(struct cpufreq_frequency_table),
> -		    GFP_KERNEL);
> +	centaur = kzalloc(struct_size(centaur, freq_table, states + 1),
> +			  GFP_KERNEL);
>  	if (!centaur)
>  		return -ENOMEM;
>  	eps_cpu[0] = centaur;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
