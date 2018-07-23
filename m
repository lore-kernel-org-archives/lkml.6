Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E850ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C79520685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxLjg5bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C79520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbeGWVgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:36:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38657 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388069AbeGWVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:36:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so709383pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yGbLnZFJA6I0Ic94Ezv3ensUtPYygDmSuOZCeDVO0mw=;
        b=oxLjg5buWfC5lY0MP4QEexzMyzT7/3auEi6ZXL2vv7Dlk7kWdcE6TMIM9cVmrCVMvw
         BK31MZtGUg/nISgd64gQ5ZnjTuqzhnQqq7gKdcFwfsz/P5/N1SEgLWO502PThbZFYI5t
         C95njTz3xBhxzoKMlTC0pqOoO/pLrl8z/GB7tIvVX8tgzxKK8T+eokHPns6PuIaoIZI7
         cjA3IswRrkH+u0wSYphsn7iaNzsA7Jg7MrB/Gyk6/59Ck15suuL/o6BohMQlmC91IN4B
         nrQT1nh9JrkfitRcrcoRPmaQjzS57XO0HdwXljyXU6Mwecxlp/oBuUTy1X1j2BRoZ5zE
         e2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yGbLnZFJA6I0Ic94Ezv3ensUtPYygDmSuOZCeDVO0mw=;
        b=ExZUbUyVbO9bSJB7Exc+wIuMSLWfijLmHp0Fk/5a8+v4t/iMJKOnjBVXqIWyX4sI9i
         uzEhMnkc+9IvNGIvhTSE+Xn/frsz+ePRSvsjs1Hs36kSa3A1OzuEAjyCwsw2+2iY2LPQ
         kAhH8QfPvZBXNsTv24IoSuXkpg45iVq9QDMoalUfPLcxShnn74l06U26XELjjetO9WQB
         UvHaq57w6BJJKEVdlYIIbIkCakx4GhaYbaxKk1BTpBXBNX7harH3qp22+nw0+TVX50Dv
         EMOukQHA+GS4gtN8OLbMENiIsLhnhCiYb0ipip0TZIL/MoN4xLcTv9jJJ80cpfgR5PS6
         csIw==
X-Gm-Message-State: AOUpUlF1pcQw1gRqGZlCZFNK+CK7MRXoKf5tC24T4qZtlibzT8wjuQwJ
        2AeX1zZbd1SO7WRw+MSUSAHA7A==
X-Google-Smtp-Source: AAOMgpfTxlu9oTIHR62rYXWS8CUpvfT5CAX1lhr1qRK9fQm8/J1X97bLdfhPPQnZm9Vqm/+oiDcsng==
X-Received: by 2002:a17:902:7e43:: with SMTP id a3-v6mr14169721pln.151.1532378001671;
        Mon, 23 Jul 2018 13:33:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v20-v6sm22919829pfk.12.2018.07.23.13.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:33:20 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:33:19 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3 -mm 3/6] mm, memcg: add hierarchical usage oom
 policy
In-Reply-To: <alpine.DEB.2.21.1807162101170.157949@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807231331510.105582@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com> <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com> <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com> <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com> <alpine.DEB.2.21.1807131605590.217600@chino.kir.corp.google.com> <20180716181613.GA28327@castle> <alpine.DEB.2.21.1807162101170.157949@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, David Rientjes wrote:

> > And "tree" is different. It actually changes how the selection algorithm works,
> > and sub-tree settings do matter in this case.
> > 
> 
> "Tree" is considering the entity as a single indivisible memory consumer, 
> it is compared with siblings based on its hierarhical usage.  It has 
> cgroup oom policy.
> 
> It would be possible to separate this out, if you'd prefer, to account 
> an intermediate cgroup as the largest descendant or the sum of all 
> descendants.  I hadn't found a usecase for that, however, but it doesn't 
> mean there isn't one.  If you'd like, I can introduce another tunable.
> 

Roman, I'm trying to make progress so that the cgroup aware oom killer is 
in a state that it can be merged.  Would you prefer a second tunable here 
to specify a cgroup's points includes memory from its subtree?

It would be helpful if you would also review the rest of the patchset.
