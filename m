Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2164128-1523444003-2-3847661127994796167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fi',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523444002; b=URnt1NAQmpv+BjYVdAvNKRmDY7Smsj3Bczt5EgQhiutgzUanWa
    d8F6ElVJ9XbStb5sUI/jNEuwQxnu4CIjRL8dqcn41KecbODfwFGl+E9jfWlmENCm
    64LiVloIgfIqoSFkRHm/JfhkXPxcEHtQSnqWDzQQyE6o8qYEIPVOoDnCGmqMg9Ho
    DB5aX0uoTEFC7zHefwnE35I/mi3/ScLoB0i2bp8R+zNo3Vcxyv3wxmZHZWw0Cit/
    t2wsDzjLYwsETUPayk1FHaMnWsJR0A5b6XskbhFVXMrm05/P1smatnFyh5dWDPi2
    VFiAcRRjZ7mcdEfS+SLlIvq0q7e+vhTWL8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523444002;
    bh=qlk5brFjN+vBOOAfYujARMR9/1AlSPqmklNNSgeey3E=; b=gvWIcjV4xCLs
    NMUZL4FgQA9JoWiGzuuRC7sRsmVElxiF99Q10j+uTeQMzA+AzQ1m8ouMPOyir0c1
    Q1ikgfGOmqJaqLhlCtvdAGe9uy9CgzO6r96JQygJni0ZBNVhg5lPVgQecCcNvciT
    c/AwHa4BTJ/vBC4B8vlkOq6kHCg01yULi5kB8pMyzI0vLHJAM5vosLFEyOvBYTxL
    qclULjFaV9EIiq+fTg6tuQCq96JNmSF6IjRImBkuxnBDjOAj2JeAE9WAQ1mF1pUc
    HGs6Do6UiB+z6bmkBq5bpC1qN7pNfqoMhgh80RM8e1CxlnV+vz+Vsjjrx98mT29u
    XJZAdRpyww==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGsnCErj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=iki.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=iki.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGsnCErj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=iki.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=iki.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI5L5Oacg6ENMyAIRcanaiiWj/y/p6IG6VnW1zdTM+YjasChYPNDkMFwGQjMSui3tMPfHB1NUDDkVSkDzGODZWWz/qiRHeh5OaU22jnxLEhAeZaraPHg
    lHEqDvFvZjyU1NU3H7OY1mMp+0DPA1wXlG/DkB6FApvj3WjXuMR0SPh1OaL1AIc9LqleO8/hOHtK0Ubs8pbhQFdBcniiOsM8iakKvhdRoKuAaO3eUltVRwAK
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=57SyGIRnAAAA:8 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8
    a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=uE1F9PVJpjgRIkcxqz0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=YzT4AsKTxtEdF6UtD8mD:22 a=TPcZfFuj8SYsoCJAFAiX:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeDKKxU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 06:53:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54877 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751668AbeDKKxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 06:53:19 -0400
X-ME-Sender: <xms:HunNWlpVwRlNQhQkX8U5zPPuLgD_lZkhhGtNvrlsM0slKDaC5BtIfw>
Subject: Re: [PATCH] mm, slab: reschedule cache_reap() on the same CPU
To: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
References: <20180410081531.18053-1-vbabka@suse.cz>
 <20180411070007.32225-1-vbabka@suse.cz>
From: Pekka Enberg <penberg@iki.fi>
Message-ID: <71010251-e1bc-e934-cecf-ae37a1cede90@iki.fi>
Date: Wed, 11 Apr 2018 13:53:12 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411070007.32225-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 11/04/2018 10.00, Vlastimil Babka wrote:
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

Acked-by: Pekka Enberg <penberg@kernel.org>

> ---
>   mm/slab.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 9095c3945425..a76006aae857 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -4074,7 +4074,8 @@ static void cache_reap(struct work_struct *w)
>   	next_reap_node();
>   out:
>   	/* Set up the next iteration */
> -	schedule_delayed_work(work, round_jiffies_relative(REAPTIMEOUT_AC));
> +	schedule_delayed_work_on(smp_processor_id(), work,
> +				round_jiffies_relative(REAPTIMEOUT_AC));
>   }
>   
>   void get_slabinfo(struct kmem_cache *cachep, struct slabinfo *sinfo)
> 
