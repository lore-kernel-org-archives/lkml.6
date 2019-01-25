Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23520881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ae9Ce5Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfAYN4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:56:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40999 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfAYN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:56:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so10384042wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=isKIZLHvDy4G7/JJd0SWz3JorDTm2gi1KhTLX9kC+50=;
        b=ae9Ce5HfcC42GyeyRAtkqlER6uZQRYfuTBWKl17hZwU3ygeEuuN6SOIR9MhwuDjiHm
         Qy+ekSlS06P2HWILFZIWmBc5iQT5QVGqL7VRoXFsVnH9bCEyZ6lbiIbvziWzDA+tyK7W
         olYPoGA9nUwxgSIVaJ7DoxnoWx2fRGyJ9jsfsdJUwzYpjPFepK2yKSJ+cVGRow+TcCIC
         rieIvr2fqEP/+N0pTNAziOeVa2U/yPytfLnz2pbnWQlxrXM2ifwrK2B2dir9vL/oiXLg
         hZuih3nUNKEilCaRjP3G72nYWi5nc9JBBH1qC94hg5L9Gi38pR5Lb8dlfiB+Ba6HKKxw
         etIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=isKIZLHvDy4G7/JJd0SWz3JorDTm2gi1KhTLX9kC+50=;
        b=lMvsHlCGr8jTqFn4LU5kYQtnTJCjFZynLhAyDeb4hfL+QrWd5yamSJGg5eb2to/CSz
         NjKINqnYaXgtAayNgySjqgyjK5ShqNUe5jUIUGmb4DwWD+rhui+iqD3cqAMs6vbCclIV
         pvY+xBQjDQItXsi6oInw5x1NDZKjj9QIwXsoie/UDi3ZIBOLRPa1JBsP3hWgYSlMmgJB
         r2Qd7aGmf5Bwavm18cxAr+Z4Aozwr+QV21pBTCNUPpyLcIzTCPUlPqQcLpjfygyTqAhd
         Qt95QBJRZcGuZWQrXtls/tOMoZ8lXb+oNpOKyw9YBEO7cTZo6LKB9RtpoPutbSgohuYf
         xVkw==
X-Gm-Message-State: AJcUukd7uqnvc//Sk8FWkfEqSBExODg9khvolfakAOAvNYzHBd37UUeJ
        lI203Nl9/ZWjkUJ0+jNM9vNMhg==
X-Google-Smtp-Source: ALg8bN6HvHT7B4hYeesrm4wh8OywkbZ8E9Qb4u1i+q8m5hyMF6/h5YH+L9r2Phu7heKZF1ysrzyKwQ==
X-Received: by 2002:adf:f091:: with SMTP id n17mr11537008wro.292.1548424608755;
        Fri, 25 Jan 2019 05:56:48 -0800 (PST)
Received: from google.com ([2a00:79e0:d:203:9bb:78dc:3222:caef])
        by smtp.gmail.com with ESMTPSA id p6sm135680949wrx.50.2019.01.25.05.56.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 25 Jan 2019 05:56:48 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:56:46 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 01/16] sched/core: Allow sched_setattr() to use the
 current policy
Message-ID: <20190125135646.j4j2onitam4mwvcw@google.com>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-2-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Patrick,

What do you think about the following minor changes:

On Tue, Jan 15, 2019 at 10:14:58AM +0000, Patrick Bellasi wrote:
>  /* SCHED_ISO: reserved but not implemented yet */
>  #define SCHED_IDLE		5
>  #define SCHED_DEADLINE		6
> +/* Must be the last entry: used to sanity check attr.policy values */

I would remove this comment:
- the meaning of SCHED_POLICY_MAX is evident, and
- should we hint on how the value is used? That comment will be removed
  the next time SCHED_POLICY_MAX is used for something else.
  This is what should also happen to the comment of SETPARAM_POLICY:
  now sched_setparam() is no more the only code path accessing
  SETPARAM_POLICY.

> +#define SCHED_POLICY_MAX	7

+#define SCHED_POLICY_MAX    SCHED_DEADLINE

This would make it compliant with the definition of MAX.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4560,8 +4560,17 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	if (retval)
>  		return retval;
>  
> -	if ((int)attr.sched_policy < 0)
> +	/*
> +	 * A valid policy is always required from userspace, unless
> +	 * SCHED_FLAG_KEEP_POLICY is set and the current policy
> +	 * is enforced for this call.
> +	 */
> +	if (attr.sched_policy >= SCHED_POLICY_MAX &&

+	if (attr.sched_policy > SCHED_POLICY_MAX &&

In line with the previous update.

> +	    !(attr.sched_flags & SCHED_FLAG_KEEP_POLICY)) {
>  		return -EINVAL;

Thanks,
Alessio
