Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE92A2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="RUnN8r6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfBVQTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:19:50 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36897 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:19:50 -0500
Received: by mail-yb1-f193.google.com with SMTP id i205so1056609yba.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/eSOvpEPOdnBZfZTBhWwFR1RxWxC5GEtCoFlgWry3E=;
        b=RUnN8r6qzpBx09mG1/K52QKdmWaNXQKvvE84vAqjXIG/ZVaVcq+f95dgkj4qB8ww1O
         inRD9jCX/m2epxKCQbp3T9kd7YA+hm1MLH0waZGi9Ah2KVreVUs9Vt0o1nGGZu6S0eNE
         2uoUMjRjeDl7cf86+GgxER3fdSGS8eW4jheYlCKyRL/MSnFjGKsQCBXhz33N1cl0NkF0
         OYPlWuIvyhdjuYjdcmrXhFKHzi0idXa5EkaWv0sDKA0bgXep1vJbWRyMVAvDZbmOpk+n
         JP/CHme3+owY86MfPRvgpB5sR9EPLLhEk/58YkhjOfPcfe+QWiHYI6GX5JMMfqaqQQ3e
         TDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/eSOvpEPOdnBZfZTBhWwFR1RxWxC5GEtCoFlgWry3E=;
        b=CBghQnkcqyiol5pJvSfI6Ms7E63qfeeKEKLnpyTsKfg+6IlEH+wYGHSTlhtqu/Ge5b
         9pvV3EuPJ62VruLRvrbme4008Xg1UTpUC2GOROA31A1bxcnYf28y0thPxKgQ8QycDwhO
         nEZahsCV+fHKme9hRksa0nOKOxvH6qucJcz5ULeGuJ2dGTXmhRZPY884ITA8YSdiEisk
         SYsuseoArBFMApRZ/la03WOTYE4EJe0sSpm0/2lIJ+TjqIBEsdsW3/Z+a8pQyJbtJ1ke
         lJivbNRXn3Wh01xb9+wlhdPQoHphjd+/PmTUXsPIPB9y7T26t6o98n9VbalCfbWeFH9f
         0Lmw==
X-Gm-Message-State: AHQUAuZy2giKB+OcDCnL58vnsPPci+M1ZPGjuf80b5p4idjbhnSrknsD
        EAh6rpTHKudcpd14TYYufasodw==
X-Google-Smtp-Source: AHgI3Iaiq/NJn/9xzBub2fgaaUyU2LJQjR9GHmHHPQnoJWWBd+CAnW5eiv/igAntO8Mk8UxSIjD2wQ==
X-Received: by 2002:a25:1907:: with SMTP id 7mr4077408ybz.14.1550852384186;
        Fri, 22 Feb 2019 08:19:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1:cd3d])
        by smtp.gmail.com with ESMTPSA id o4sm557182ywe.102.2019.02.22.08.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 08:19:43 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:19:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Junil Lee <junil0814.lee@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, pasha.tatashin@oracle.com,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com,
        andreyknvl@google.com, arunks@codeaurora.org,
        keith.busch@intel.com, guro@fb.com, rientjes@google.com,
        penguin-kernel@i-love.sakura.ne.jp, shakeelb@google.com,
        yuzhoujian@didichuxing.com
Subject: Re: [PATCH] mm, oom: OOM killer use rss size without shmem
Message-ID: <20190222161942.GA12288@cmpxchg.org>
References: <1550810253-152925-1-git-send-email-junil0814.lee@lge.com>
 <20190222071001.GA10588@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222071001.GA10588@dhcp22.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:10:01AM +0100, Michal Hocko wrote:
> On Fri 22-02-19 13:37:33, Junil Lee wrote:
> > The oom killer use get_mm_rss() function to estimate how free memory
> > will be reclaimed when the oom killer select victim task.
> > 
> > However, the returned rss size by get_mm_rss() function was changed from
> > "mm, shmem: add internal shmem resident memory accounting" commit.
> > This commit makes the get_mm_rss() return size including SHMEM pages.
> 
> This was actually the case even before eca56ff906bdd because SHMEM was
> just accounted to MM_FILEPAGES so this commit hasn't changed much
> really.
> 
> Besides that we cannot really rule out SHMEM pages simply. They are
> backing MAP_ANON|MAP_SHARED which might be unmapped and freed during the
> oom victim exit. Moreover this is essentially the same as file backed
> pages or even MAP_PRIVATE|MAP_ANON pages. Bothe can be pinned by other
> processes e.g. via private pages via CoW mappings and file pages by
> filesystem or simply mlocked by another process. So this really gross
> evaluation will never be perfect. We would basically have to do exact
> calculation of the freeable memory of each process and that is just not
> feasible.
> 
> That being said, I do not think the patch is an improvement in that
> direction. It just turnes one fuzzy evaluation by another that even
> misses a lot of memory potentially.

You make good points.

I think it's also worth noting that while the OOM killer is ultimately
about freeing memory, the victim algorithm is not about finding the
*optimal* amount of memory to free, but to kill the thing that is most
likely to have put the system into trouble. We're not going for
killing the smallest tasks until we're barely back over the line and
operational again, but instead we're finding the biggest offender to
stop the most likely source of unsustainable allocations. That's why
our metric is called "badness score", and not "freeable" or similar.

So even if a good chunk of the biggest task are tmpfs pages that
aren't necessarily freed upon kill, from a heuristics POV it's still
the best candidate to kill.
