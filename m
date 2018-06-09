Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oZlAG/GpG1u3fQAAmS7hNA
	; Sat, 09 Jun 2018 10:20:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ADE8E607BB; Sat,  9 Jun 2018 10:20:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ztn7yHM7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E1B7F605A5;
	Sat,  9 Jun 2018 10:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1B7F605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeFIKUe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 06:20:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36715 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeFIKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 06:20:31 -0400
Received: by mail-lf0-f66.google.com with SMTP id u4-v6so23692502lff.3;
        Sat, 09 Jun 2018 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/b/SDyZlKUK9NczL3oeJkSsoYXoRsv/cYJN0usziws=;
        b=Ztn7yHM797MQ0aa7fINHJH/f9aPJmXsbzC7WSmuhar2G26Xal3/KYmPBDi5HjEsXWx
         7+IYH9AV0P55r6wXjyRjyPxwuRybkoYx9uPaHw4+HYrtqhescpk6YFVQXwFjOTQ5/ryq
         tsYhzHXFSHDmjSuBaNJTYIC+chAYuIcgKBztvVe3KUEnRUZ5R2WrG62rCruY3isu/qy/
         MROQRgTVvS15ZGwzmTtyRoQtZ1KQ7RoC5Czc/G49ot/JeUtqv0dk5HS88OpzyonvK1RC
         pT0kF7ROiZTjK7/yzYPy/U5IWdck5qCAcCtraGKaguQJQgyU1H2bgCMLGEOSi1ru1tJm
         UpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/b/SDyZlKUK9NczL3oeJkSsoYXoRsv/cYJN0usziws=;
        b=IIJXLLE3FnbhBUnMzrv5pAEv6VDXRqXz9r/qfuJXtVxo/mVIkyVDcpRY5byWdnaShT
         Xzxvc47u07ZwzxDvOnlqTupBWHJeUHK1vNLKiEKInJJmvj3qQXvhrWD2wda8z9KG2f9W
         k5z4GhfK68XGSZnzBvU0B8DS8dfEy0vtTRefx+DPhPJcurhW06mu1PkWgek7Svj2O0jw
         RtmsyF8OB4disyW+jBQYNy/ETsiJwBilpsA7DaucBZPO38H1D+DP5kWNF8Q8FBXTY1zu
         7Y9DCAfbNRhyFDOy8y+bQpX0BZQcsuBFWa5YCOGCRHf3bjgSijkFYAZXE5+5f+3EDUZZ
         l+iw==
X-Gm-Message-State: APt69E3QJ9R+1dvVmulRBmQJtS8GnScJFPjpvDyzBSCrT0B6ka4WYHeu
        rSbd6bTljSfpyx2ISBTRPbE=
X-Google-Smtp-Source: ADUXVKJ1oMbgQDAtzBlSU93c+S1OWyzkYzMq66D+cmyntA+JqR+168T+w2x+vITiYRCckuWs/WUz6Q==
X-Received: by 2002:a19:2813:: with SMTP id o19-v6mr3637442lfo.108.1528539630316;
        Sat, 09 Jun 2018 03:20:30 -0700 (PDT)
Received: from esperanza ([185.6.245.156])
        by smtp.gmail.com with ESMTPSA id 90-v6sm964257ljs.23.2018.06.09.03.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 03:20:29 -0700 (PDT)
Date: Sat, 9 Jun 2018 13:20:27 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Shakeel Butt <shakeelb@google.com>
Cc: Michal Hocko <mhocko@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: fix race between kmem_cache destroy, create and
 deactivate
Message-ID: <20180609102027.5vkqucnzvh6nfdxu@esperanza>
References: <20180530001204.183758-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530001204.183758-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 05:12:04PM -0700, Shakeel Butt wrote:
> The memcg kmem cache creation and deactivation (SLUB only) is
> asynchronous. If a root kmem cache is destroyed whose memcg cache is in
> the process of creation or deactivation, the kernel may crash.
> 
> Example of one such crash:
> 	general protection fault: 0000 [#1] SMP PTI
> 	CPU: 1 PID: 1721 Comm: kworker/14:1 Not tainted 4.17.0-smp
> 	...
> 	Workqueue: memcg_kmem_cache kmemcg_deactivate_workfn
> 	RIP: 0010:has_cpu_slab
> 	...
> 	Call Trace:
> 	? on_each_cpu_cond
> 	__kmem_cache_shrink
> 	kmemcg_cache_deact_after_rcu
> 	kmemcg_deactivate_workfn
> 	process_one_work
> 	worker_thread
> 	kthread
> 	ret_from_fork+0x35/0x40
> 
> To fix this race, on root kmem cache destruction, mark the cache as
> dying and flush the workqueue used for memcg kmem cache creation and
> deactivation.

> @@ -845,6 +862,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  	if (unlikely(!s))
>  		return;
>  
> +	flush_memcg_workqueue(s);
> +

This should definitely help against async memcg_kmem_cache_create(),
but I'm afraid it doesn't eliminate the race with async destruction,
unfortunately, because the latter uses call_rcu_sched():

  memcg_deactivate_kmem_caches
   __kmem_cache_deactivate
    slab_deactivate_memcg_cache_rcu_sched
     call_rcu_sched
                                            kmem_cache_destroy
                                             shutdown_memcg_caches
                                              shutdown_cache
      memcg_deactivate_rcufn
       <dereference destroyed cache>

Can we somehow flush those pending rcu requests?
