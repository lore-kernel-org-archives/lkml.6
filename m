Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3729524-1523494079-2-4978776644658434701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494078; b=qZzw9MobVIkBBoXBeGo81lmGaYYnMIKLX6ZscXkWBeth3Vl5wh
    onoISo1u4Cb1Z2+mp7FX8WGwude2oNE5Ld1SDA50rMmHOr3OdDDDln+ZnlgSByoz
    XB0zNLQ3m5EpxCfrA/jADE8hOBkCiV3rjEq0uFSJX4qCofAzxCPaQ3jD9TuRah7K
    dwMqATEdgHynxhGxpmgR4umPc1h/KbxqRB3OCYGhi0IEjE7DMegO2mOmk9BEXOVF
    UgdOC/+wN25rRH27TVY+VWvubWubghT1zVeH2mFxeKkFzkrnIDYvt+8nLoc3tMWV
    9It+VbzkUxnYkSHeolUHpEFndwU6sXYdvjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523494078; bh=3Nh3WCDESuJMjEpn9vfVkH6Cbmd5a1
    Y0RTvLMzScBUI=; b=FPhZQKsN1TwJEhTqSOzU16ZUlWNU+slwKnjPJ1UAcCzr7W
    s7MPMqnB+L8KlWe7ko9XWcjkUvyNemjOEEm2mdZ++2IJuW+hSIYDYwPt6Jh/0uSR
    quqQje4sLEqqAN6gOCzu+qNqzHwsXbx1twrfEKjV9jofb4VpeICOMqVUlbs0mMC7
    NgMFUn2fhSSa1YpWJgULdm4lpTS+Qid+DJPdgCPI46aGE0ovIF3T9bN+fjWBmX+r
    NW26USYRyEsBEjZvBpZ3WL58FYl5LlYru/UOVB8nhMM039INc0WkYDr4HtVvDqk6
    9weoyLRXB5UFGdCTKt0uIXg9qPNfpGFs97MQVv2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N+7aiN2v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A3Trsb2f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N+7aiN2v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=A3Trsb2f;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG4o8SDlUq7N1xb+Q+TJ9u/UauP28A1b4fTXIIwH23Zg2MBZHojKjV5A4YU+21F6whmhN5VPduQJR2ZdD8gYtgm04zDZm2co1uZzlOuOzKXq/YEwHdWU
    hhJPPmTmkFzPMKrgFpZnJKWMeFf/VYkERzP1BsYaO+HdlFBFu36inc0AqfAyfnxMJnE7E5bp+jCyW2Kb3/ZjuCBRkarRkBsUQ7Gu9MkpAneMwEqFwhf+7Yce
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=57SyGIRnAAAA:8 a=1XWaLZrsAAAA:8
    a=NufY4J3AAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=uE1F9PVJpjgRIkcxqz0A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22
    a=TPcZfFuj8SYsoCJAFAiX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeDLAr4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:47:56 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33482 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDLArz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:47:55 -0400
X-Google-Smtp-Source: AIpwx49Tq9p4BKIxhJ8JZMKHVh2IjHozKAO7XG3/kQBWOLPlZF/dW6NMeaGTZA9RoWGtGeIiB3tjhA==
Date: Thu, 12 Apr 2018 09:47:47 +0900
From: Minchan Kim <minchan@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] mm, slab: reschedule cache_reap() on the same CPU
Message-ID: <20180412004747.GA253442@rodete-desktop-imager.corp.google.com>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <20180411070007.32225-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411070007.32225-1-vbabka@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 09:00:07AM +0200, Vlastimil Babka wrote:
> cache_reap() is initially scheduled in start_cpu_timer() via
> schedule_delayed_work_on(). But then the next iterations are scheduled via
> schedule_delayed_work(), i.e. using WORK_CPU_UNBOUND.
> 
> Thus since commit ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on
> wq_unbound_cpumask CPUs") there is no guarantee the future iterations will run
> on the originally intended cpu, although it's still preferred. I was able to
> demonstrate this with /sys/module/workqueue/parameters/debug_force_rr_cpu.
> IIUC, it may also happen due to migrating timers in nohz context. As a result,
> some cpu's would be calling cache_reap() more frequently and others never.
> 
> This patch uses schedule_delayed_work_on() with the current cpu when scheduling
> the next iteration.

Could you write down part about "so what's the user effect on some condition?".
It would really help to pick up the patch.

> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Fixes: ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs")
> CC: <stable@vger.kernel.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> ---
>  mm/slab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 9095c3945425..a76006aae857 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -4074,7 +4074,8 @@ static void cache_reap(struct work_struct *w)
>  	next_reap_node();
>  out:
>  	/* Set up the next iteration */
> -	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
> +	schedule_delayed_work_on(smp_processor_id(), work,
> +				round_jiffies_relative(REAPTIMEOUT_AC));
>  }
>  
>  void get_slabinfo(struct kmem_cache *cachep, struct slabinfo *sinfo)
> -- 
> 2.16.3
> 
