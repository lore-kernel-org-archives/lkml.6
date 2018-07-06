Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8E5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837EC23D91
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JND2kZUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837EC23D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeGFKSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:18:30 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37351 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeGFKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:18:29 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so16385530itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bBpS1CySck4iMutFXZKSncNUzLB7qXd8TXn9xIrcCQ=;
        b=JND2kZUSgNc+G96FtXPYdvyED1o1fYQC6Do2XzLhN3tqxYvpXdSrW26BMdKD9Ta/DU
         YNuFuEQjBrSuYfBIY/GEZTq6Uw8Utjq5jXpcyHMF88bhUQ7SVuu1jB9iNTWsgN3yIIBH
         +ET+Ex2qBlEgNLMELm47BnIsPXGFMhr9X3s88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bBpS1CySck4iMutFXZKSncNUzLB7qXd8TXn9xIrcCQ=;
        b=AaoOo6S111U4c+k5eFugm3GQg+5xlRJC26TPEnMhceOSNKPTrZsUb1hfoAOi99C4fY
         aAtsFGCRPX/PWhr7h/tVQ5D4Llz0KR+XafRW/SbsfuhTEKqsyJaK+KRwdRHYP7Ru59gU
         vjOuGuW8wkAnZDNDdhg3wq84IycVPCr0+ImTDnvx6xEMYDTO2qljCiMQZNjvqZenSa5F
         st/b86wma2KyehVNv9CbZMNp7NcGsl7Z9LoAIx5Dlb4ZsSqpZ8Q5A1KOLV2jkll/CXE+
         9y7Y7jOFskp+75Adiko5IE9u65JvudXYlW6bZgd+4NKNcgEEkFuC4ITczwAHjJ0hzkcV
         CRbQ==
X-Gm-Message-State: APt69E0xSgD4FphO4RGOxKu7wOC+LpM/xxVbBGbVJNjKefeQv9QzgPBp
        G3BTubquKNh85v3v0OMrfOzpAPl8tyF4yjZyJ683KA==
X-Google-Smtp-Source: AAOMgpfTW3N9PgdcqVEZ5PcJj1Knw1Fj7lGANMiAqSbtcZRTDpAPZiBnbyVuuYMJr+HoLkCnDB9qPSjUYlpbUhDBwkc=
X-Received: by 2002:a02:4550:: with SMTP id y77-v6mr8124210jaa.12.1530872308631;
 Fri, 06 Jul 2018 03:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com> <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
In-Reply-To: <1530699470-29808-13-git-send-email-morten.rasmussen@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 6 Jul 2018 12:18:17 +0200
Message-ID: <CAKfTPtDUa7nARKxT+hR_ci3J_exE85sZFT1oEM84akZ+i_-UgA@mail.gmail.com>
Subject: Re: [PATCHv4 12/12] sched/core: Disable SD_PREFER_SIBLING on
 asymmetric cpu capacity domains
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 at 12:18, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> The 'prefer sibling' sched_domain flag is intended to encourage
> spreading tasks to sibling sched_domain to take advantage of more caches
> and core for SMT systems. It has recently been changed to be on all
> non-NUMA topology level. However, spreading across domains with cpu
> capacity asymmetry isn't desirable, e.g. spreading from high capacity to
> low capacity cpus even if high capacity cpus aren't overutilized might
> give access to more cache but the cpu will be slower and possibly lead
> to worse overall throughput.
>
> To prevent this, we need to remove SD_PREFER_SIBLING on the sched_domain
> level immediately below SD_ASYM_CPUCAPACITY.

This makes sense. Nevertheless, this patch also raises a scheduling
problem and break the 1 task per CPU policy that is enforced by
SD_PREFER_SIBLING. When running the tests of your cover letter, 1 long
running task is often co scheduled on a big core whereas short pinned
tasks are still running and a little core is idle which is not an
optimal scheduling decision

>
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
>
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  kernel/sched/topology.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 29c186961345..00c7a08c7f77 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1140,7 +1140,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                                         | 0*SD_SHARE_CPUCAPACITY
>                                         | 0*SD_SHARE_PKG_RESOURCES
>                                         | 0*SD_SERIALIZE
> -                                       | 0*SD_PREFER_SIBLING
> +                                       | 1*SD_PREFER_SIBLING
>                                         | 0*SD_NUMA
>                                         | sd_flags
>                                         ,
> @@ -1186,17 +1186,21 @@ sd_init(struct sched_domain_topology_level *tl,
>         if (sd->flags & SD_ASYM_CPUCAPACITY) {
>                 struct sched_domain *t = sd;
>
> +               /*
> +                * Don't attempt to spread across cpus of different capacities.
> +                */
> +               if (sd->child)
> +                       sd->child->flags &= ~SD_PREFER_SIBLING;
> +
>                 for_each_lower_domain(t)
>                         t->flags |= SD_BALANCE_WAKE;
>         }
>
>         if (sd->flags & SD_SHARE_CPUCAPACITY) {
> -               sd->flags |= SD_PREFER_SIBLING;
>                 sd->imbalance_pct = 110;
>                 sd->smt_gain = 1178; /* ~15% */
>
>         } else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
> -               sd->flags |= SD_PREFER_SIBLING;
>                 sd->imbalance_pct = 117;
>                 sd->cache_nice_tries = 1;
>                 sd->busy_idx = 2;
> @@ -1207,6 +1211,7 @@ sd_init(struct sched_domain_topology_level *tl,
>                 sd->busy_idx = 3;
>                 sd->idle_idx = 2;
>
> +               sd->flags &= ~SD_PREFER_SIBLING;
>                 sd->flags |= SD_SERIALIZE;
>                 if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
>                         sd->flags &= ~(SD_BALANCE_EXEC |
> @@ -1216,7 +1221,6 @@ sd_init(struct sched_domain_topology_level *tl,
>
>  #endif
>         } else {
> -               sd->flags |= SD_PREFER_SIBLING;
>                 sd->cache_nice_tries = 1;
>                 sd->busy_idx = 2;
>                 sd->idle_idx = 1;
> --
> 2.7.4
>
