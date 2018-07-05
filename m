Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AD8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3EE24037
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="VFh7BzPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3EE24037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeblueprint.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbeGENZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:25:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40509 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753887AbeGENZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:25:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so6350401edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GpHjCC3sAG9c1Mj6z2jbFAYti0u6GHYI4zcqQp3jiXs=;
        b=VFh7BzPmE5CAnPaFTOZDfTErBOqKvU+Gh+f5kGZWLCn33zz6qMQCsNLnBVRAVrXyQE
         JXAO0Wgk/iuFvT41ZiWxkQYDI/MyM8dgPmHU0kEVUt/Eunt5W0cM83G7qIvpOEYZxTem
         b0jhRKQLm5bWKvuLDyOGSZzZBYXVsk3GSS7Tufc7kxTC57UGpTirzTziqzkH1dbPYGzU
         X480R7xxVXRII2Kre4NL7ay2nCrfhwAn3wpc89SLjliYtVXjIUUqoXw8D1qXz3dyDA01
         pq1B/LGxiDpwhBjyU9QifHtyc80fyaLLLxw52HiBmC/ChIvtYDsJVOAQY+Vhawmw1yC5
         QdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GpHjCC3sAG9c1Mj6z2jbFAYti0u6GHYI4zcqQp3jiXs=;
        b=a7JVRsRhwMX3tQD9F5zTR83vTkPonr5KG27g3W05MqLxloIpFsDgdz8rcKg1nP4Tkh
         nXMhj6UR1Zv5qw6EUIlluNQTs678Tx5qAHqxdOpol7gGZuawhw0Go/OLvwaqO1RtjVHa
         dqv85lwz59+1NT7BpWWDuodWTEEbiTgODrgeD7DdlBouHn8VuhnGuCzU638JN7QpF3kR
         ncMO2gta1DE+mPQ3bRfM+FlBUY6y1Gw/QylUfkChzgvT6n4uN20cP67gPCkn7D/Tp3aa
         1j86KEriI7uy1SMYD7S2ddmyq5Q7y8Je1IJ5Ra94PgXiSJbISLiMT9Jpn2a6CqVAgxPp
         8cHA==
X-Gm-Message-State: APt69E2TERmGw26ZqVZJP4aKs6/fIoX0FwNB+7/Ac4uvL6HwW/jtEprr
        fKAaqUgIjP5pvMSZXkw5aibEeA==
X-Google-Smtp-Source: AAOMgpdFnwIsARoT7yoTw4ROCcYwoREDup/B/FQlV2X6Uvf18uatmm56r1jXhDncsRYJVXPY7hL18A==
X-Received: by 2002:a50:a519:: with SMTP id y25-v6mr6896289edb.105.1530797100707;
        Thu, 05 Jul 2018 06:25:00 -0700 (PDT)
Received: from localhost ([2a02:c7f:9214:6300:de53:60ff:fe39:5599])
        by smtp.gmail.com with ESMTPSA id e25-v6sm2981686edq.65.2018.07.05.06.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:25:00 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:24:58 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>, lkp@01.org
Subject: Re: [lkp-robot] [sched/fair] fbd5188493:
 WARNING:inconsistent_lock_state
Message-ID: <20180705132458.GA3864@codeblueprint.co.uk>
References: <20180705080227.GH23907@yexl-desktop>
 <0ac4845e-cf6b-c5e3-a16c-f2fc457c5ef5@arm.com>
 <7c3d20fa-4997-e6ed-3750-e054ce1bd610@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3d20fa-4997-e6ed-3750-e054ce1bd610@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul, at 11:52:21AM, Dietmar Eggemann wrote:
> 
> Moving the code from _nohz_idle_balance to nohz_idle_balance let it disappear:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02be51c9dcc1..070924f07c68 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9596,16 +9596,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>          */
>         smp_mb();
>  
> -       /*
> -        * Ensure this_rq's clock and load are up-to-date before we
> -        * rebalance since it's possible that they haven't been
> -        * updated for multiple schedule periods, i.e. many seconds.
> -        */
> -       raw_spin_lock_irq(&this_rq->lock);
> -       update_rq_clock(this_rq);
> -       cpu_load_update_idle(this_rq);
> -       raw_spin_unlock_irq(&this_rq->lock);
> -
>         for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>                 if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>                         continue;
> @@ -9701,6 +9691,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>         if (!(flags & NOHZ_KICK_MASK))
>                 return false;
>  
> +       /*
> +        * Ensure this_rq's clock and load are up-to-date before we
> +        * rebalance since it's possible that they haven't been
> +        * updated for multiple schedule periods, i.e. many seconds.
> +        */
> +       raw_spin_lock_irq(&this_rq->lock);
> +       update_rq_clock(this_rq);
> +       cpu_load_update_idle(this_rq);
> +       raw_spin_unlock_irq(&this_rq->lock);
> +
>         _nohz_idle_balance(this_rq, flags, idle);
>  
>         return true;
> 

Hmm.. it still looks to me like we should be saving and restoring IRQs
since this can be called from IRQ context, no?

The patch was a forward-port from one of our SLE kernels, and I messed
up the IRQ flag balancing for the v4.18-rc3 code :-(

