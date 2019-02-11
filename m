Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01858C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C132229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="KSmBfVOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfBKSzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:55:39 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46153 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbfBKSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:55:39 -0500
Received: by mail-yb1-f196.google.com with SMTP id 7so4579439ybp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fwPQA3qU7Aku9UVL4Xj6OeW7KvutLJujKV6PtXhaFY=;
        b=KSmBfVOt//tembuNf6qv9MiwaTLSt+/d0XxrB6YxhFnrNj7Jqys5VcAp3OPQumEVZ/
         MqNLDSVZYNG1PxLrbZZsbpJcxOkt9kXzOTjxqhq2+IImeP4X2Y3sSeX/0PmGithDGw0F
         uMHmyy7dkXFRies/O/3nElxwMqp5pI5QaiAimssP6jMzVS5oq8XEHNa/fV0whvCn3yoG
         hX02Fy688V5oZdTAGvqfw7ARKSHPmaVRYE46nvOxhHfp1AMiewmMN+7RRMU5WlkLHTvj
         10aFXwRq0vbyIvETLdDorc5HSbf9fgvWlID477XFlspaTWkVLjUt97ImjVTjHCJpeZ6j
         mrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fwPQA3qU7Aku9UVL4Xj6OeW7KvutLJujKV6PtXhaFY=;
        b=M9v6JYm+UKn3NrPlC0enYEPlRWTtOnsp1BCJEyIyVyuhY3LEuBYjpNowyVif34mk4o
         mEh451IiohlpTuslIIh3VHgr2OnFgA+VdzVMu9C2MQWslbIqGpvUkWe45d6awg2HI8+c
         P6AxKlauxFxyabMx89ACSIe8zeGKSFu7WfMpjJuymwt7iP4yKWqvBKNaSVssf8pfjtAp
         uo08CDSYXy63Ru/DYiaxlolGsM+FRU23NpnaUv2nwRKV8LWD61x97EV6EjBOi0esqkav
         WcWfghGbZTGh04WB3HHugSZxn9rGxy2Gj7bPoTDwx6iQqdWuhqMxNR3LslbBHRqFh9Mx
         GU4A==
X-Gm-Message-State: AHQUAuby73vyAwToPvL5u6ULy3ALavVXt+1hnei5uSimKqteupCADnRF
        hxmL+MZd8qbI6byZuhhab63Maw==
X-Google-Smtp-Source: AHgI3IaMY21YYwpqjIFAOQ6KEJBW67d3KzImvcjP2lWzxm0+49GO/cYAkDaX1p9rA643uL+lN7i1lA==
X-Received: by 2002:a25:8e0c:: with SMTP id p12mr30114498ybl.3.1549911337759;
        Mon, 11 Feb 2019 10:55:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6e5])
        by smtp.gmail.com with ESMTPSA id 77sm4071530ywr.19.2019.02.11.10.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 10:55:36 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:55:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] mm: Rename ambiguously named memory.stat counters
 and functions
Message-ID: <20190211185535.GB13953@cmpxchg.org>
References: <20190123223144.GA10798@chrisdown.name>
 <20190208224319.GA23801@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208224319.GA23801@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:43:19PM +0000, Chris Down wrote:
> I spent literally an hour trying to work out why an earlier version of
> my memory.events aggregation code doesn't work properly, only to find
> out I was calling memcg->events instead of memcg->memory_events, which
> is fairly confusing.
> 
> This naming seems in need of reworking, so make it harder to do the
> wrong thing by using vmevents instead of events, which makes it more
> clear that these are vm counters rather than memcg-specific counters.
> 
> There are also a few other inconsistent names in both the percpu and
> aggregated structs, so these are all cleaned up to be more coherent and
> easy to understand.
> 
> This commit contains code cleanup only: there are no logic changes.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
