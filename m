Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26847C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A16208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A16208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755306AbeFNNd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755084AbeFNNd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:33:27 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11EB208CB;
        Thu, 14 Jun 2018 13:33:25 +0000 (UTC)
Date:   Thu, 14 Jun 2018 09:33:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 1/5] sched/topology: Add check to backup comment
 about hotplug lock
Message-ID: <20180614093324.7ea45448@gandalf.local.home>
In-Reply-To: <20180613121711.5018-2-juri.lelli@redhat.com>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
        <20180613121711.5018-2-juri.lelli@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 14:17:07 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> The comment above function partition_sched_domains() clearly state that
> the cpu_hotplug_lock should be held but doesn't mandate one to abide to
> it.
> 
> Add an explicit check backing that comment, so to make it impossible
> for anyone to miss the requirement.
> 
> Suggested-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> [modified changelog]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/sched/topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 61a1125c1ae4..96eee22fafe8 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1858,6 +1858,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  	int i, j, n;
>  	int new_topology;
>  
> +	lockdep_assert_cpus_held();
>  	mutex_lock(&sched_domains_mutex);
>  
>  	/* Always unregister in case we don't destroy any domains: */

