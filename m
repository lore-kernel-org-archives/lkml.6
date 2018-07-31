Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46272C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59FC2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dK4H14jG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59FC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeGaXBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:01:12 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44122 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeGaXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:01:12 -0400
Received: by mail-yb0-f193.google.com with SMTP id l16-v6so6725415ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ob6YSoI2FTzytbl9os284TBslENz+9hsFsM7Bww77/s=;
        b=dK4H14jGitj/bGtvgXo2dZVABMeVRdVovaIb/alhywjqpcoVOOZfnZXg0vgkKQMB5+
         swQibkMnODKpf5PAfRrPM8um5FAqa5fWjECA0BYD/x+oAzWzkfalYS/l3zhtxEE4VCJG
         O9VA7jynfOFu6sPvob36c3ZLoADMpcD4QwWXvl4GojcqlO45aHaaZH2P07rOqD2944Hh
         ttnuYoeFZ3CdQh4T03qdRPVpq74S+f/ErqyMkg3OXHsZb5Lp1eg4bvoDjYarfPJDt+RP
         yXkRm+a8+AlHOaiVUmqdGGbaGGH9uXLGOja8i0Z0AnB9OYuNcpN3aYlZEoI8L5LPbGoY
         LISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ob6YSoI2FTzytbl9os284TBslENz+9hsFsM7Bww77/s=;
        b=JazbOQolZROSwbLDVi8QWMVsur3QqXXp7MPvURfm9HpTLCtkN4wnYoKm5+a//BaL7h
         ve9kRRSxCFqK3/7Dq9UmGSBYZaVgzbiadx6jpOMXT+VUE68Cv7sbJdBRFupsLLhiZQkU
         zAC4BqlxiPfJq7OnT2KMsDT2xIgu2X56C4voMyfIvpBWgUL63vdNCcMTDj0DJouHKnZx
         /EwyUUJ7Hm7J3jqxYfq6rPb1Hi9ZiViZ2DUegDAeujFhojyRkzJwmGaFA0WUiO7MF+kH
         q+jCe5v2I7y6gXGudYJriQ40q4i4GXdODWd3NETUDeGXx7m55jHMhodQXZNirOnE+AK5
         3C5A==
X-Gm-Message-State: AOUpUlFY4BWLBPCCxtnIOY8YnpDPrGFhmYPvJj66uqTAsEi9i+JPl26T
        gtaCORRjbbXIKJey2UfJnjggqQ==
X-Google-Smtp-Source: AAOMgpeOt2vGBMDZvVkd2O7rz9IH0wP6f3F5QMT7LsBGucNfz20bMitOsGuR1kTIS6Fmh9FXEYzPpQ==
X-Received: by 2002:a25:e441:: with SMTP id b62-v6mr12792889ybh.127.1533071936612;
        Tue, 31 Jul 2018 14:18:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:e414])
        by smtp.gmail.com with ESMTPSA id f82-v6sm21028633ywf.58.2018.07.31.14.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:18:55 -0700 (PDT)
Date:   Tue, 31 Jul 2018 17:21:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: make iolatency avg_lat exponentially decay
Message-ID: <20180731212150.GA7027@cmpxchg.org>
References: <20180731203647.19864-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731203647.19864-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

this generally looks good to me. Just two small nit picks:

On Tue, Jul 31, 2018 at 01:36:47PM -0700, Dennis Zhou wrote:
> @@ -135,6 +135,24 @@ struct iolatency_grp {
>  	struct child_latency_info child_lat;
>  };
>  
> +#define BLKIOLATENCY_MIN_WIN_SIZE (100 * NSEC_PER_MSEC)
> +#define BLKIOLATENCY_MAX_WIN_SIZE NSEC_PER_SEC
> +/*
> + * These are the constants used to fake the fixed-point moving average
> + * calculation just like load average. The latency window is bucketed to
> + * try to approximately calculate average latency for the last 1 minute.
> + */
> +#define BLKIOLATENCY_NR_EXP_FACTORS 5
> +#define BLKIOLATENCY_EXP_BUCKET_SIZE (BLKIOLATENCY_MAX_WIN_SIZE / \
> +				      (BLKIOLATENCY_NR_EXP_FACTORS - 1))
> +static const u64 iolatency_exp_factors[BLKIOLATENCY_NR_EXP_FACTORS] = {
> +	2045, // exp(1/600) - 600 samples
> +	2039, // exp(1/240) - 240 samples
> +	2031, // exp(1/120) - 120 samples
> +	2023, // exp(1/80)  - 80 samples
> +	2014, // exp(1/60)  - 60 samples

Might be useful to drop the FIXED_1 name in a comment here. It says
"fixed-point", and "load average", but since the numbers are directly
in relationship to that constant, it'd be good to name it I think.

> @@ -462,7 +480,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
>  	struct child_latency_info *lat_info;
>  	struct blk_rq_stat stat;
>  	unsigned long flags;
> -	int cpu;
> +	int cpu, exp_idx;
>  
>  	blk_rq_stat_init(&stat);
>  	preempt_disable();
> @@ -480,11 +498,10 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
>  
>  	lat_info = &parent->child_lat;
>  
> -	iolat->total_lat_avg =
> -		div64_u64((iolat->total_lat_avg * iolat->total_lat_nr) +
> -			  stat.mean, iolat->total_lat_nr + 1);
> -
> -	iolat->total_lat_nr++;
> +	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
> +			iolat->cur_win_nsec / BLKIOLATENCY_EXP_BUCKET_SIZE);
> +	CALC_LOAD(iolat->total_lat_avg, iolatency_exp_factors[exp_idx],
> +		  stat.mean);

The load average keeps the running value in fixed point presentation
to avoid rounding errors. I guess because this is IO time in ns, the
values are so much higher than the FIXED_1 denominator (2048) that
rounding errors are negligible, and we don't need to bother with it.

Can you mention that in a comment, please?
