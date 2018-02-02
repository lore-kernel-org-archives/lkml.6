Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeBBKUE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:20:04 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47084 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBBKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:19:55 -0500
X-Google-Smtp-Source: AH8x226O+x6bIKnRw0DY7YmVukW2sw+fcNrtYD+RF/QbTv2gjIrDWBoxRaYrytPsQKSw9Fgvx3NhhA==
Date: Fri, 2 Feb 2018 11:19:51 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, lizefan@huawei.com, mingo@redhat.com,
        rostedt@goodmis.org, claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, luca.abeni@santannapisa.it,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/7] sched/topology: Adding function
 partition_sched_domains_locked()
Message-ID: <20180202101951.GS19535@localhost.localdomain>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
 <1517503869-3179-2-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517503869-3179-2-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 01/02/18 09:51, Mathieu Poirier wrote:
> Introducing function partition_sched_domains_locked() by taking
> the mutex locking code out of the original function.  That way
> the work done by partition_sched_domains_locked() can be reused
> without dropping the mutex lock.
> 
> This patch doesn't change the functionality provided by the
> original code.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

[...]

> +/*
> + * Call with hotplug lock held

Is this the one that we can actually check if it's locked with

lockdep_assert_cpus_held()

?

> + */
> +void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> +			     struct sched_domain_attr *dattr_new)
> +{
> +	mutex_lock(&sched_domains_mutex);
> +	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>  	mutex_unlock(&sched_domains_mutex);
>  }

Best,

- Juri
