Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEC82087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="z+Z8PesT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEC82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJHQdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:33:00 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41983 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:33:00 -0400
Received: by mail-yw1-f66.google.com with SMTP id 135-v6so964005ywo.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8ce6qwlR7ZgNdRvowCzs1yAJcRG7bHhm9H9XCXD5tg=;
        b=z+Z8PesTOxMOdL6wGaeDSrlwXKMODDyOT4gN3Hks3NNyxdFYGadceBff3lYuoDV+kg
         MITVodt1uWylixgIIDwgIiCHA+7BEfYfSr2UY3W+8Jdy1zM9nkKmOi9838A22cVrqp0b
         WB6vNkvd4PqY+ijtJ/CCg52Gvp0r/tT1/wyNyMDIVr1uRgaTSgtBjO6I5piALetY6ow1
         0ujXXQvh7vQTPfJ2d1fiq6Sn9Yp3c91S1FoUNABN5E6vnuveGf6Iy/7dEDhHc11GVMS/
         RN8ytqnqgBKG9TBEuNNt7H123lCEEBW1MNk28/yYP4WXUHm7FY7Knts2sv0BOZ5RIo7v
         4Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8ce6qwlR7ZgNdRvowCzs1yAJcRG7bHhm9H9XCXD5tg=;
        b=IK746CPq3UhmqDmZrarauPokm0DaETn8YXQFcd8h/O3PTG7HYae70PvgNW+Hd5EhHX
         jm+EetoI35Yk0+mfQY2lZaY7vCUToi9pVe8rVDq6RzgNadsxdOM2mpeIDRwjuhqgfB8K
         +zJIDEhEAiibUHOfDiVj7Km64ZRUAHqjJGC/FZYtBL7UqmDhbSbWd0mFqHyoEVZHOYi8
         gVhktk+hZqA6RkvCMRNSRwI3vziYI8RdGPa11CUuxbELXt/A8/6rXvLfhpJtsiy7UAZG
         ijnnONj2iByCdPPk/Yno5cDnaf52tWZLm1U6qRhTziIq+3FUPsm+BqfjymZpNEvKX0rL
         aG0w==
X-Gm-Message-State: ABuFfoiYKv8GWKBM5q5KXfbeBjaYc10S8R2S/+gyKnfD/nvWCSY+vbNP
        NS//wl0dFPlR6/C8EFK+k03HPg==
X-Google-Smtp-Source: ACcGV63hF9AL4+HL/Btk8VGWh2BCOrQPGt+aiOFYPa1xZ/vBUivoR9n25IDGlBWiUrJQNMBhZ/c5Kg==
X-Received: by 2002:a0d:ed82:: with SMTP id w124-v6mr10081729ywe.447.1538990534371;
        Mon, 08 Oct 2018 02:22:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7d10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm6269930ywv.34.2018.10.08.02.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 02:22:13 -0700 (PDT)
Date:   Mon, 8 Oct 2018 05:22:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20181008092211.GA7515@cmpxchg.org>
References: <20181004214050.7417-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004214050.7417-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:41:09PM +0000, Roman Gushchin wrote:
> I was reported that on some of our machines containers were restarted
> with OOM symptoms without an obvious reason. Despite there were almost
> no memory pressure and plenty of page cache, MEMCG_OOM event was
> raised occasionally, causing the container management software to
> think, that OOM has happened. However, no tasks have been killed.
> 
> The following investigation showed that the problem is caused by
> a failing attempt to charge a high-order page. In such case, the
> OOM killer is never invoked. As shown below, it can happen under
> conditions, which are very far from a real OOM: e.g. there is plenty
> of clean page cache and no memory pressure.
> 
> There is no sense in raising an OOM event in this case, as it might
> confuse a user and lead to wrong and excessive actions (e.g. restart
> the workload, as in my case).
> 
> Let's look at the charging path in try_charge(). If the memory usage
> is about memory.max, which is absolutely natural for most memory cgroups,
> we try to reclaim some pages. Even if we were able to reclaim
> enough memory for the allocation, the following check can fail due to
> a race with another concurrent allocation:
> 
>     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
>         goto retry;
> 
> For regular pages the following condition will save us from triggering
> the OOM:
> 
>    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
>        goto retry;
> 
> But for high-order allocation this condition will intentionally fail.
> The reason behind is that we'll likely fall to regular pages anyway,
> so it's ok and even preferred to return ENOMEM.
> 
> In this case the idea of raising MEMCG_OOM looks dubious.
> 
> Fix this by moving MEMCG_OOM raising to mem_cgroup_oom() after
> allocation order check, so that the event won't be raised for high
> order allocations. This change doesn't affect regular pages allocation
> and charging.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
