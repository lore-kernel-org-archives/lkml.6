Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49B7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58917214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58917214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJNSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:18:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeJJNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:18:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so4186399wru.8;
        Tue, 09 Oct 2018 22:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PS8vdWamQdDGTH12Yz9r6bQcwo/hcp7vKzJCq68sXfo=;
        b=sD8OEUHdbtXb+0fCiUNN6oj8gAUesmj3QkmXs6qXQyB4mrXhBJlWskhtU6FFwN82y9
         kbcJAotE20oouFsY+YLnmY3G9wjspBo2URtsEwSPDSuwBlsZqlIAIje93Ef/V3Rf5HfY
         0zJgnk8sWTJ5eidH0OQnFh/WTMiOVX+K9rFrS4wIaXdwSMIWwnUCbfQaQfa7AoN2978/
         7/Zfc9GTueNZoXEheIe3T2fyMS9u4EGfgBQC/uZ49wdb/f+cWu9VWKXcr7xfFUAYqyQY
         24nEcKEau1jcznWeAg7MvVey6ooI1NLQ9SY0CRk7Ix4BD6n0thlcbXIqzTnXb0unRJHI
         FEDg==
X-Gm-Message-State: ABuFfohHNyIaRwCSEbCikDDT3egJOV7oD6U3GCdhCQgtWtuJAI01HSn7
        PoV7Hq848EJAiuG81WnxKg==
X-Google-Smtp-Source: ACcGV62f68iOoyHGO7Sdgew9U4yw5rABZWSVBjGWoWgsNiQer5r9wXjpBJ8i2c2Z6K+bGNvlhcbXrA==
X-Received: by 2002:a05:6000:111:: with SMTP id o17mr1998838wrx.279.1539151050276;
        Tue, 09 Oct 2018 22:57:30 -0700 (PDT)
Received: from tesla ([2a02:c7d:8eb4:4100:11b0:632:fc1e:e2c7])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm20008873wms.11.2018.10.09.22.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 22:57:29 -0700 (PDT)
Received: from javi by tesla with local (Exim 4.91)
        (envelope-from <javi@tesla>)
        id 1gA7Uo-0001ay-Kw; Wed, 10 Oct 2018 06:57:22 +0100
Date:   Wed, 10 Oct 2018 06:57:22 +0100
From:   Javi Merino <javi.merino@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org
Subject: Re: [RFC PATCH 6/7] sched/fair: update cpu_capcity to reflect
 thermal pressure
Message-ID: <20181010055722.GA5038@tesla>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <1539102302-9057-7-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1539102302-9057-7-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:25:01PM -0400, Thara Gopinath wrote:
> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
> pressure on a cpu means this maximum available capacity is reduced. This
> patch reduces the average thermal pressure for a cpu from its maximum
> available capacity so that cpu_capacity reflects the actual
> available capacity.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7deb1d0..8651e55 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7497,6 +7497,7 @@ static unsigned long scale_rt_capacity(int cpu)
>  
>  	used = READ_ONCE(rq->avg_rt.util_avg);
>  	used += READ_ONCE(rq->avg_dl.util_avg);
> +	used += READ_ONCE(rq->avg_thermal.load_avg);

IIUIC, you are treating thermal pressure as an artificial load on the
cpu.  If so, this sounds like a hard to maintain hack.  Thermal
pressure have different characteristics to utilization.  What happens
if thermal sets the cpu cooling state back to 0 because there is
thermal headroom again?  Do we keep adding this artificial load to the
cpu just because there was thermal pressure in the past and let it
decay as if it was cpu load?

Cheers,
Javi

