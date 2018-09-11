Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90947C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBD720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FX5Ujg+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBD720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeIKFg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:36:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33016 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeIKFg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:36:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so11318933pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6fsiMTK8GBLceRgG5LCpstljI/UyOX3t1B3JZxYZiRI=;
        b=FX5Ujg+A+3oDAZjZCq0vcG0/78iEuHazAyozQKV2Ohysqru4pSyCrgJ86ND1PfqfNe
         dSE+BPbNfxwhb7K0RjLhDwxsMZA2+WPni98KsqPZ7EJYVYhZNTRDlPoFOgCnzUVw99A3
         zxtFyqq1+qgxIrPJGkMts4RqE9dOBgy55OvrGuAb5yV+Oz+GbpyskW9nZtcUxseuhyX+
         mH/TmNwA/rsqv+s53AaqCmZZ5DQqfKWkBqZlIraRmU7AusprfNXI7LuUH8VKc8c4TSVC
         D9KjW8KTGAk1UliWMsbummGVVqOu9wAgME282C6o4G1KyULY52fQUo5Fn6WcrNTi1lA/
         kj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6fsiMTK8GBLceRgG5LCpstljI/UyOX3t1B3JZxYZiRI=;
        b=oL7o8Uplgb8hQ//BANsdRs7zHx3JnjxKx9OFL3KQWOJ7ivV1ZJiyd2JUsK/kJZ8rdf
         nq3Y3zN96/taoom248RmeQlZ38+/cRoZPFULssSrDRfolSuc5zmB77Ua5znNgimK893y
         sNyyG3e6sDA8uUwEuhKu0xi1D7tku79nZmhD3gIqh7eKuO7Jbf+9/EZfqv6BBhZHILo2
         r6kKJiQ9ycKxDgfL2z8ghEQqariKxHWbVfCO5oaDwhOKH7LLtAq+jsad7k1SEk4HZxBN
         yiUdr82/Oercs4svdh6fKjkklPg+XN7ntr+Ta4lJJRVGb8o9d6qhQJnKJpBo2vq1iQKL
         GHqw==
X-Gm-Message-State: APzg51DYKungIzsrzua8RJxZAcikb2L7aftw+T6zB3VA3SrzGTgJ0VuY
        V3L4wDPGoEDgZqB/OZWCxvjsSA==
X-Google-Smtp-Source: ANB0VdYKLxbrTF4IUooeh/8jTQJxT+yrku3Wx/E1WIQh11ZJtTfV/bsLpNP69KgwEGEq9Ra+UHxlVw==
X-Received: by 2002:a63:3cc:: with SMTP id 195-v6mr24696881pgd.229.1536626421590;
        Mon, 10 Sep 2018 17:40:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q25-v6sm22899340pfh.113.2018.09.10.17.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 17:40:20 -0700 (PDT)
Date:   Mon, 10 Sep 2018 17:40:20 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
In-Reply-To: <20180910215622.4428-1-guro@fb.com>
Message-ID: <alpine.DEB.2.21.1809101740080.256423@chino.kir.corp.google.com>
References: <20180910215622.4428-1-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Roman Gushchin wrote:

> The memcg OOM killer is never invoked due to a failed high-order
> allocation, however the MEMCG_OOM event can be easily raised.
> 
> Under some memory pressure it can happen easily because of a
> concurrent allocation. Let's look at try_charge(). Even if we were
> able to reclaim enough memory, this check can fail due to a race
> with another allocation:
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
> In this case the idea of raising the MEMCG_OOM event looks dubious.
> 
> Fix this by moving MEMCG_OOM raising to  mem_cgroup_oom() after
> allocation order check, so that the event won't be raised for high
> order allocations.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
