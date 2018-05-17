Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1376423-1526530121-2-8398820213986432046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526530121; b=LGOxEsoqskPFBSylBxB/JJPBGFKokcIwnkyCnqQLgi5MfnlWQx
    88asjwGKeTeIm2ivMS4hivdldwRPWf7SXx2AmPT6eZQAjT36MbZlcTvFHDayqklu
    KFE3u4wYZnmhOZoU1g/ichTVUBh+7IyxBs775l174+joOxR+pp8qQc6LTriskc4k
    lyXYLGv0UXt9Q6ame+Q2LSilHfrGojHS4ekgn1O92EjUFYV2mCQxtuzDDf3CymFz
    kcJQu0HX5xSmjZLpoM3ucq/c0jyQfpOMiT8GfrDu8N2+w/AR1m/vp2bJjyzsOJbe
    n3rLUMXpZf5Gw4TebqGNL1LsFuOQ4b8P004g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526530121; bh=sXcyi2HWfPCEwixeYlYuKxaAfwTFvJ
    ngsdzE/bwdz6I=; b=gGVb4AIDruzFqqI4HNEuHy7czyEEhc8YIlMS8F+5o9N+kZ
    alPSHyIvo7A95aQTy9RPa/a0PcxUbLANlBi3ijUemFIeTrOyPw1TWBrkvv85A3/V
    YKWoTr+FGJgeKFJSxxdZX2E+q/s2q0is5B7pi1ck4J3CP3wRlOyh0tAwr/vDPZR2
    ItCZoEJ0vH2h5Ikkvf+E/p0gO0+58QFNfmCLSh1jq29N1nE1fT5lLOWyluMYIiRQ
    zby46ofYE/Dh/ueUd5T71acI3hYm2mRBrMr1MKXgrovJU3l42ydQdCfucJbmqON+
    gn7JME6NLFsm7hmBIkYA7qjvuYFNCUtKp1VM1dxg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=gnJIOboQ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=LkE7IQTL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=gnJIOboQ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=LkE7IQTL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfACkPS5A/Yr82wJAp3Bh11slaxKmFH5FmYuTPmiDcEPBNL4NuiRpFayqrrZYF2S+VFIbKjYVwdM9Hh0RllJmfQSjyasZyhTPfM7tNpibU4eSCbMMG2MC
    bTLiWXnwumyO0ipmxLhw5Bv44ilTfAQJrYu6pkbtp0UAK5AyFb3yK6WTI0t5UPr4reWdMQDPCXdNLzESooqbTCP0M3TnbWPFCg11ljK3R9Xl4Yy++9UJf+Hb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=9copjtUFbhWBxmBh80sA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeEQEI2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 00:08:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42827 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQEI1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 00:08:27 -0400
X-Google-Smtp-Source: AB8JxZpy6OxPjD6mJoynSooodq5YMxwkQxfFVHcxNmm9PgonZ2owABeKQmXq5Q+I3BoPeWFJSg6RFw==
Date: Thu, 17 May 2018 09:38:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@arm.com,
        tglx@linutronix.de, efault@gmx.de, juri.lelli@redhat.com,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: Re: [PATCH] sched/rt: fix call to cpufreq_update_util
Message-ID: <20180517040822.t3zkbb2pxla7jnbp@vireshk-i7>
References: <1526494719-23361-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526494719-23361-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16-05-18, 20:18, Vincent Guittot wrote:
> With commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
> schedutil governor uses rq->rt.rt_nr_running to detect whether a RT task is
> currently running on the CPU and to set frequency to max if necessary.
> cpufreq_update_util() is called in enqueue/dequeue_top_rt_rq() but
> rq->rt.rt_nr_running as not been updated yet when dequeue_top_rt_rq() is
> called so schedutil still considers that a RT task is running when the
> last task is dequeued. The update of rq->rt.rt_nr_running happens later
> in dequeue_rt_stack()
> 
> Fixes: 8f111bc357aa ('cpufreq/schedutil: Rewrite CPUFREQ_RT support')
> Cc: <stable@vger.kernel.org> # v4.16+
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/rt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7aef6b4..6e74d3d 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1001,8 +1001,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
>  	sub_nr_running(rq, rt_rq->rt_nr_running);
>  	rt_rq->rt_queued = 0;
>  

Remove this blank line as well ?

> -	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -	cpufreq_update_util(rq, 0);
>  }
>  
>  static void
> @@ -1288,6 +1286,9 @@ static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>  		if (on_rt_rq(rt_se))
>  			__dequeue_rt_entity(rt_se, flags);
>  	}
> +
> +	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> +	cpufreq_update_util(rq_of_rt_rq(rt_rq_of_se(back)), 0);
>  }
>  
>  static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
> -- 
> 2.7.4

-- 
viresh
