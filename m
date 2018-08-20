Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0C82084A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEQT27FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0C82084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeHUDML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 23:12:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34836 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeHUDML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 23:12:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so7574631pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ProabIWFRWcsSx3ssb89N1/HcQ6+IF3f0nymr6V9ICs=;
        b=oEQT27FIXOCkvceykqi3HVUttZZMgxTC84NOTcY6ylbY+RPeVOUEjnmJGhPAO/O22/
         9WLWdkBfwUnnDIgJnN+dYJVLs8FCS2QS6z+sY6LVMVUTUK5j8w7RfJnAFiO7Wo01xLXZ
         n152gIVe2Hiuj7ATBjy5A04zMXemQCm5LFvSPxDaATxTwiDEOsGHF0THYGWxKdCKLT+m
         rLz2eQ1KoNqPX4mbpB9q9puH6jABwGhiGTSf9MLYNWnoJ+Qdi149c3sXo/jtz+RJqzuf
         ILQnIfJUIpqQ5hyUShnTQx7/WTDxURJf9d8iiyIpF8HD6KYeJcQ5+TK6ZhuJpzh24WJs
         C6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ProabIWFRWcsSx3ssb89N1/HcQ6+IF3f0nymr6V9ICs=;
        b=iOD+Z5ZjRWKD2Y/ZIpLK1u/GCRaXnlSOg1bTITlg1wNqQ67EqvhEWc9VnrsA63Dfpn
         1rtcEnBDoxJwdArbywIbGnhPu9PcaKznANeTjRZ8JvKOWHIYiVHSnYv8abgknkhCljoE
         79iLomZoxYdPsu8+Er6x4s1P96lSHSL0F4oGwpFD+ANta2D16PHKY48eK6vR9qr3n0gG
         EJNsUqLSpmm/VCBGthqZkME7uhpoPnLkTQ7s372VCMR/+RzdL0kNRkC+JgjvgwcENOIv
         bBTJaAQKPrp4JY6ZphNMqBGETDgy3Ntb3M+t0ZdKdQX2kB3ilu1Me6lHQiHZJdehq16O
         /ClA==
X-Gm-Message-State: AOUpUlEoex0e57X5D0foraf3sIUX99IorBs3m4Ohg5mT6BV9Wq2MKmgl
        l/AoU2PBkBQfEfLiu9Dp3Nyf7Q==
X-Google-Smtp-Source: AA+uWPybmdKhIT8rncdankTp+TETBKRX9QShQg+l43owoXWpfCJTxmh7m7FhTUoplBNoNqmpXJSuBA==
X-Received: by 2002:a62:2f84:: with SMTP id v126-v6mr50484879pfv.115.1534809267072;
        Mon, 20 Aug 2018 16:54:27 -0700 (PDT)
Received: from migueldedios.mtv.corp.google.com ([2620:0:1000:1612:aa81:3988:1747:ac7])
        by smtp.gmail.com with ESMTPSA id n4-v6sm6246948pgp.80.2018.08.20.16.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 16:54:26 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Steve Muckle <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
From:   Miguel de Dios <migueldedios@google.com>
Message-ID: <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
Date:   Mon, 20 Aug 2018 16:54:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180817182728.76129-1-smuckle@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 11:27 AM, Steve Muckle wrote:
> From: John Dias <joaodias@google.com>
>
> When rt_mutex_setprio changes a task's scheduling class to RT,
> we're seeing cases where the task's vruntime is not updated
> correctly upon return to the fair class.
> Specifically, the following is being observed:
> - task is deactivated while still in the fair class
> - task is boosted to RT via rt_mutex_setprio, which changes
>    the task to RT and calls check_class_changed.
> - check_class_changed leads to detach_task_cfs_rq, at which point
>    the vruntime_normalized check sees that the task's state is TASK_WAKING,
>    which results in skipping the subtraction of the rq's min_vruntime
>    from the task's vruntime
> - later, when the prio is deboosted and the task is moved back
>    to the fair class, the fair rq's min_vruntime is added to
>    the task's vruntime, even though it wasn't subtracted earlier.
> The immediate result is inflation of the task's vruntime, giving
> it lower priority (starving it if there's enough available work).
> The longer-term effect is inflation of all vruntimes because the
> task's vruntime becomes the rq's min_vruntime when the higher
> priority tasks go idle. That leads to a vicious cycle, where
> the vruntime inflation repeatedly doubled.
>
> The change here is to detect when vruntime_normalized is being
> called when the task is waking but is waking in another class,
> and to conclude that this is a case where vruntime has not
> been normalized.
>
> Signed-off-by: John Dias <joaodias@google.com>
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
>   kernel/sched/fair.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b39fb596f6c1..14011d7929d8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
>   	 * - A task which has been woken up by try_to_wake_up() and
>   	 *   waiting for actually being woken up by sched_ttwu_pending().
>   	 */
> -	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
> +	if (!se->sum_exec_runtime ||
> +	    (p->state == TASK_WAKING && p->sched_class == &fair_sched_class))
>   		return true;
>   
>   	return false;
The normalization of vruntime used to exist in task_waking but it was 
removed and the normalization was moved into migrate_task_rq_fair. The 
reasoning being that task_waking_fair was only hit when a task is queued 
onto a different core and migrate_task_rq_fair should do the same work.

However, we're finding that there's one case which migrate_task_rq_fair 
doesn't hit: that being the case where rt_mutex_setprio changes a task's 
scheduling class to RT when its scheduled out. The task never hits 
migrate_task_rq_fair because it is switched to RT and migrates as an RT 
task. Because of this we're getting an unbounded addition of 
min_vruntime when the task is re-attached to the CFS runqueue when it 
loses the inherited priority. The patch above works because now the 
kernel specifically checks for this case and normalizes accordingly.

Here's the patch I was talking about: 
https://lore.kernel.org/patchwork/patch/677689/. In our testing we were 
seeing vruntimes nearly double every time after rt_mutex_setprio boosts 
the task to RT.

Signed-off-by: Miguel de Dios <migueldedios@google.com>
Tested-by: Miguel de Dios <migueldedios@google.com>
