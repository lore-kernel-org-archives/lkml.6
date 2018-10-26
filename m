Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8489FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B7B2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="usaN2Swv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B7B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJZXCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:02:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45208 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZXCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:02:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so1373537qtj.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PQPuqnIiTbpovh3AcyPOUF01wLMiFIwNw9LC2etHdjI=;
        b=usaN2Swv8uJxg/xGtxbJ9kBTExP19zDcowiCUyCz5TiDNFus1vGeW6CVUhZ/Sc8Xcu
         1jYMUoYfCgO9CHuUIm8aWbl8g25XU7sBiiH7/fEZPdKXA7M7cfPU1koxLJXPgfFO6dnN
         0o8IA3NjeMzsd/id0v6k/Fp6QpoB+tJZYeiZxP5bsJ6B8/Ui/4bYsGNmSUffgTgrkiQM
         oX1yJEzFdjCY++f4BqORC0lZ/Ln1wwLgGoUaAg/me9dirbDMJ/fJtvIF7LJgAjybWpJE
         ZBfukyBpbQvIhyi6ViS5J7VgoME8jO6Nv5v5x3Gjjicom6rCKdJeYDdSAOapJHn9MK7X
         SKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PQPuqnIiTbpovh3AcyPOUF01wLMiFIwNw9LC2etHdjI=;
        b=RrLOnIoFbXEF949S6BzfrxzhtESDRgKDBbJOEP09thJULJci3E5csxZYZ3xnzBhXHe
         G21Ryd/zk6KWLzLUuFhCzWcwbWnVnOLWy7kCjBlEBEvjzUgPaG6HBBf9QX0t6c0Qv9oY
         gqvWRUnd3xCsHYCQH9Xc3r6JbMlgHP1mhWoRCDVvkeeO2TqXMurZP3IxaZzdC1KZE8of
         RCktkmLk9wzFCSAR4DOFy8K+tskJA3eIRZCVKc7ZQRRArXT3hDfklKQOnpCXKWr7slws
         BNR/z1v+gkk09X9DzcCtasgtCU3pEl/2bHaPAhxGMzc6zMiEKqV2t60DAhLowD78FQTY
         30DQ==
X-Gm-Message-State: AGRZ1gIjX6xgVqQc/VKCcSMiHT5YGab87ymGGYl18g7QCpy4hV4wngP8
        j/PdTyshq8lc5YCnGX8Nq5jVsw==
X-Google-Smtp-Source: AJdET5cuWdYEzZzEsMisDZVw9oqKhwJkwnzlf6HxCLN+JAsf6i1E45407VBiQDKZefhxYJ1lUaKj5w==
X-Received: by 2002:a0c:9023:: with SMTP id o32mr3372983qvo.17.1540563934025;
        Fri, 26 Oct 2018 07:25:34 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id 26-v6sm5632568qtq.57.2018.10.26.07.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 07:25:32 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:25:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20181026142531.GA27370@cmpxchg.org>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022071323.9550-3-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 09:13:23AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Tetsuo has reported [1] that a single process group memcg might easily
> swamp the log with no-eligible oom victim reports due to race between
> the memcg charge and oom_reaper
> 
> Thread 1		Thread2				oom_reaper
> try_charge		try_charge
> 			  mem_cgroup_out_of_memory
> 			    mutex_lock(oom_lock)
>   mem_cgroup_out_of_memory
>     mutex_lock(oom_lock)
> 			      out_of_memory
> 			        select_bad_process
> 				oom_kill_process(current)
> 				  wake_oom_reaper
> 							  oom_reap_task
> 							  MMF_OOM_SKIP->victim
> 			    mutex_unlock(oom_lock)
>     out_of_memory
>       select_bad_process # no task
> 
> If Thread1 didn't race it would bail out from try_charge and force the
> charge. We can achieve the same by checking tsk_is_oom_victim inside
> the oom_lock and therefore close the race.
> 
> [1] http://lkml.kernel.org/r/bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memcontrol.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e79cb59552d9..a9dfed29967b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1380,10 +1380,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		.gfp_mask = gfp_mask,
>  		.order = order,
>  	};
> -	bool ret;
> +	bool ret = true;
>  
>  	mutex_lock(&oom_lock);
> +
> +	/*
> +	 * multi-threaded tasks might race with oom_reaper and gain
> +	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
> +	 * to out_of_memory failure if the task is the last one in
> +	 * memcg which would be a false possitive failure reported
> +	 */
> +	if (tsk_is_oom_victim(current))
> +		goto unlock;
> +
>  	ret = out_of_memory(&oc);

We already check tsk_is_oom_victim(current) in try_charge() before
looping on the OOM killer, so at most we'd have a single "no eligible
tasks" message from such a race before we force the charge - right?

While that's not perfect, I don't think it warrants complicating this
code even more. I honestly find it near-impossible to follow the code
and the possible scenarios at this point.

out_of_memory() bails on task_will_free_mem(current), which
specifically *excludes* already reaped tasks. Why are we then adding a
separate check before that to bail on already reaped victims?

Do we want to bail if current is a reaped victim or not?

I don't see how we could skip it safely in general: the current task
might have been killed and reaped and gotten access to the memory
reserve and still fail to allocate on its way out. It needs to kill
the next task if there is one, or warn if there isn't another
one. Because we're genuinely oom without reclaimable tasks.

There is of course the scenario brought forward in this thread, where
multiple threads of a process race and the second one enters oom even
though it doesn't need to anymore. What the global case does to catch
this is to grab the oom lock and do one last alloc attempt. Should
memcg lock the oom_lock and try one more time to charge the memcg?

Some simplification in this area would really be great. I'm reluctant
to ack patches like the above, even if they have some optical benefits
for the user, because the code is already too tricky for what it does.
