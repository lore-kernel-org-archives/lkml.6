Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBF7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D412189B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="h3ii49Dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D412189B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeHMTy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:54:27 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42639 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeHMTy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:54:27 -0400
Received: by mail-yw1-f67.google.com with SMTP id y203-v6so14084804ywd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d7YjYfmhzgSP6FwYdHeRdy7ygate4wqD0+xYgcOY848=;
        b=h3ii49DkXCYBxMWjDOjLkNUHcRkxvzX7g8v8B1vR5ncGMn4rx39oY5UI1yGt7q643L
         KqrAyfgs1dFJpyzwdax15D/unLLJs3CiFfQRXJmYa3c93oAkM1JrPOK2yoLNDlINuKGU
         na86chzgMKukDlUPQs29PdIE7HcJY5k4cZlyz1MEeTf8TsqnTciOP5kWNdTY0iljAFPd
         o3BT2Da4lCFEkcdaQyshsf3VTLuVoydqNwQomrnqm3lPjB3PYcIHz53huWekqXDoNwvd
         328P9w/zlMpiLumwUZfvsk/Nuqpbeyp9maJj+W4nOTrq8BH27QiUOv8TgdWrwmQCvBk3
         HIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d7YjYfmhzgSP6FwYdHeRdy7ygate4wqD0+xYgcOY848=;
        b=TmA+0qYFI1w//ZgHLud2gX789mePpHKGL8WzwKkwIGLoHpPg6rVwqMxL1Le94qimrz
         s2+ieVeOXNYMAmsApTh7BBzvzZhA9OX212SuJqUtsGw1sEyrO4Dfrudy+8w2cQfL+pWQ
         KutaspbtVhJV1eJM3pJYaiGJkitI9spbFxl6IEJHCYfUBwFYWOGXJ+7Bbo21OGx/IyxV
         WwHFXSmOn3sOvP37wDuO0cEgvEwhRUNnkR56dINKt1KtBDQOmX8M6ubXbU8rf+itVpy9
         a3O+syfUcalI9M7ktjfo1DpgQdGyk7zEanJGpjkN9o1RrlWA8pbwqNLgEAWnGL54Rrm0
         45wA==
X-Gm-Message-State: AOUpUlHc8D9pj8GOe5ItfNLWIF2qzFZ/rtuku0Mry76xnMusgCAC33V3
        mupk+U1DnkRYeqGThupI0jLtQw==
X-Google-Smtp-Source: AA+uWPx+jIn9KwZMzp44xRXlmyueo4pusE0x8fwJ6bcGhDFK48mI/zvyy+gbySSv45gtxdB0dt9zVA==
X-Received: by 2002:a0d:fec2:: with SMTP id o185-v6mr10480546ywf.195.1534180281077;
        Mon, 13 Aug 2018 10:11:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:b26f])
        by smtp.gmail.com with ESMTPSA id b135-v6sm16319888ywh.24.2018.08.13.10.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:11:20 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:11:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH RFC 1/3] cgroup: list all subsystem states in debugfs
 files
Message-ID: <20180813171119.GA24658@cmpxchg.org>
References: <153414348591.737150.14229960913953276515.stgit@buzz>
 <20180813134842.GF3978217@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813134842.GF3978217@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 06:48:42AM -0700, Tejun Heo wrote:
> Hello, Konstantin.
> 
> On Mon, Aug 13, 2018 at 09:58:05AM +0300, Konstantin Khlebnikov wrote:
> > After removing cgroup subsystem state could leak or live in background
> > forever because it is pinned by some reference. For example memory cgroup
> > could be pinned by pages in cache or tmpfs.
> > 
> > This patch adds common debugfs interface for listing basic state for each
> > controller. Controller could define callback for dumping own attributes.
> > 
> > In file /sys/kernel/debug/cgroup/<controller> each line shows state in
> > format: <common_attr>=<value>... [-- <controller_attr>=<value>... ]
> 
> Seems pretty useful to me.  Roman, Johannes, what do you guys think?

Generally I like the idea of having more introspection into offlined
cgroups, but I wonder if having only memory= and swap= could be a
little too terse to track down what exactly is pinning the groups.

Roman has more experience debugging these pileups, but it seems to me
that unless we add a breakdown off memory, and maybe make slabinfo
available for these groups, that in practice this might not provide
that much more insight than per-cgroup stat counters of dead children.
