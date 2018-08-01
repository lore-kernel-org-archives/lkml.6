Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9865FC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EC5208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0uEoSem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EC5208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbeHAB4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:56:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45403 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732833AbeHAB4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:56:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so7883529pll.12;
        Tue, 31 Jul 2018 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hbCxSSvjynegbwc6JUA/AjSJv2dQtfCLL+Gbz5ydr4=;
        b=g0uEoSemwGBnKorEKlHXZFpt46haBEVpI+8ytpoH4QDYP98CKLLlI7eFRH/eHd3qYN
         S15sqGDdvYft5FGdbWNIR5415XaGYyl6zTdeNGsgSAcjx3hiYRMNMtNwBm4NJ7tEa4is
         ty1EGWUdifHJr01o4/1bc9KIwZe4GTlgxB1JgyMh4zimgqimBgVVM39x7f7kPne/EDCk
         xz8tkj4uoICc5RMNJodht4k7dOvFnxWAlGO+dvW0kwPQ67EGLaL6zyqP5NTfIEQqUAoq
         M3SHC8BoGDvpo0kK9UEnuDFZppAI1BD8OiqfHb5MigZ2pQWTWTvnphgYcRXPIyhFcXLY
         PYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hbCxSSvjynegbwc6JUA/AjSJv2dQtfCLL+Gbz5ydr4=;
        b=HuxJryNi8mybzjpQRfU3oXf1S4dycK3lLgoZsghne3Wlh3HfYseOjs+QmKxinZui7i
         Fd2M6hm3Fxrx6G/UxovpOaPSQDLhQnZqrkhGBooyDoIjthCNHOvs6N9qUepDAJjmFfeU
         q2KaAeRLhW95xDty38DXcnxu78NDnIp0DY65tuqA+hJUEfP7mfpbiJL9Ee0pDIZqPMyI
         jGKo1Fb0VojDUn+VCCcB8gWBo9ubs1e+HgYw8sv2AIeT412I/YykF60KLpLQCun6F1Gx
         LnaUcRjpZXY51PDAv+6mw8g4+gPy4M7+wcKnECdWH/KHCG8vaXwr080k5fVDTJhigJ/X
         9DKg==
X-Gm-Message-State: AOUpUlERcjCaLzfmu4foZavpqq/WqF0qxhHHtDE0dVqYeXUHiiQ1L8Ds
        fnD9h6yU++Jo3BQhcb2Py9VnOATXMqV3xw==
X-Google-Smtp-Source: AAOMgpeA6KH5u7l+CdirYafnhRoQ2dsXRlyjMRlxcZXn32KMuMYSFU9F9/GcuXHjXhjjxv6/PW+UVw==
X-Received: by 2002:a17:902:e088:: with SMTP id cb8-v6mr22572963plb.189.1533082422478;
        Tue, 31 Jul 2018 17:13:42 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:6163])
        by smtp.gmail.com with ESMTPSA id c142-v6sm20029114pfb.62.2018.07.31.17.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 17:13:41 -0700 (PDT)
Date:   Tue, 31 Jul 2018 17:13:28 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: make iolatency avg_lat exponentially decay
Message-ID: <20180801001326.GA34556@dennisz-mbp.dhcp.thefacebook.com>
References: <20180731203647.19864-1-dennisszhou@gmail.com>
 <20180731212150.GA7027@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731212150.GA7027@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Tue, Jul 31, 2018 at 05:21:50PM -0400, Johannes Weiner wrote:
> Hi Dennis,
> 
> this generally looks good to me. Just two small nit picks:
> 
> On Tue, Jul 31, 2018 at 01:36:47PM -0700, Dennis Zhou wrote:
> > @@ -135,6 +135,24 @@ struct iolatency_grp {
> >  	struct child_latency_info child_lat;
> >  };
> >  
> > +#define BLKIOLATENCY_MIN_WIN_SIZE (100 * NSEC_PER_MSEC)
> > +#define BLKIOLATENCY_MAX_WIN_SIZE NSEC_PER_SEC
> > +/*
> > + * These are the constants used to fake the fixed-point moving average
> > + * calculation just like load average. The latency window is bucketed to
> > + * try to approximately calculate average latency for the last 1 minute.
> > + */
> > +#define BLKIOLATENCY_NR_EXP_FACTORS 5
> > +#define BLKIOLATENCY_EXP_BUCKET_SIZE (BLKIOLATENCY_MAX_WIN_SIZE / \
> > +				      (BLKIOLATENCY_NR_EXP_FACTORS - 1))
> > +static const u64 iolatency_exp_factors[BLKIOLATENCY_NR_EXP_FACTORS] = {
> > +	2045, // exp(1/600) - 600 samples
> > +	2039, // exp(1/240) - 240 samples
> > +	2031, // exp(1/120) - 120 samples
> > +	2023, // exp(1/80)  - 80 samples
> > +	2014, // exp(1/60)  - 60 samples
> 
> Might be useful to drop the FIXED_1 name in a comment here. It says
> "fixed-point", and "load average", but since the numbers are directly
> in relationship to that constant, it'd be good to name it I think.
> 

I've added a comment in v2 that points out FIXED_1 and mentions its
value is 2048. I also explained a little more about the samples and
binding the 1/exp window.

> > +	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
> > +			iolat->cur_win_nsec / BLKIOLATENCY_EXP_BUCKET_SIZE);
> > +	CALC_LOAD(iolat->total_lat_avg, iolatency_exp_factors[exp_idx],
> > +		  stat.mean);
> 
> The load average keeps the running value in fixed point presentation
> to avoid rounding errors. I guess because this is IO time in ns, the
> values are so much higher than the FIXED_1 denominator (2048) that
> rounding errors are negligible, and we don't need to bother with it.
> 
> Can you mention that in a comment, please?

I've added what you said here in a comment above this.

Thanks,
Dennis
