Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85709ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A8B2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vM6+58LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A8B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeGMXYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:24:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34065 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeGMXYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:24:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so5442403pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3nT8/OaJFbIBKu9R5rivmEY5NIymfud7kC1ewr2xxfg=;
        b=vM6+58LE0Yyi6Z/CpK7NMee3AyULAQg99idjRTBl8opQqoZkSkwSJYx0qBwAjNp9Vm
         9gnLFkaSstMwz3uLrp/81VtsKWQpOU/JXix/gwDWO9lZ0JZo2XMTopBbwCHvWfJ817bU
         XenjR7uj50JB9H+kSvhmACPwZfv892LfGAIS+0jxd/5H4ThF7158kpOkYpTs8bPhJWkk
         bLGxjZKukSfkpQ9ZWYC5pbPQ+XjvZeeIb6ZrANvxHgDx4tu5FsemENN8S3d0CV8c7Ba8
         GVWQ8NtrvNF3Vk9LYocF5jG7tUa7JOoOzOd9DJoDH1q72dH2IpWyb+0ArzuuQgt26SLg
         bUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3nT8/OaJFbIBKu9R5rivmEY5NIymfud7kC1ewr2xxfg=;
        b=Eo54YmeUbw1NhQXZ9+HYdQSEw3A08HuoZfoiEKuiEjpLRGL1CSyqi7gu7aGNRHl8vx
         Bsgvxv+zI9USPSdt6vweCWYzv63dGbg33/47q7XZhWwYdTlRlQbe4164/jXmzz7gVjDA
         0DhJ9/G2B42ZvdPpVzTVRvqZD4QZIbWq/mxxGRspKcOYVqAVuVfdz67D07kX6S4MKIhS
         fAVbeiJi7lderelXSFHp8MKrUtVj4+i1vOiaAxSSP95RSW65144Y1b3sOzVqeaYIeK8+
         koS9xRe/ZB77YTq91Z/2XA+qIc2FM/RSu/Q87d506dtkPjVOjf+1i2I/6wyq2B5SyIQH
         B+nA==
X-Gm-Message-State: AOUpUlF1zAQgb2XBZCEC56chdKivMUeuMAC/z+MaILfciST0zkIfCNQr
        t0o8Shu9eE5LoksNy/TS543rSQ==
X-Google-Smtp-Source: AAOMgpdgJxIuZywAGY+3P2xSh1Q0sWhaoJqvZTX7sFYHQSAy2wQ20aB4hbdaTSOBkFYp6o1Tbv1mAw==
X-Received: by 2002:a63:647:: with SMTP id 68-v6mr7768984pgg.205.1531523244241;
        Fri, 13 Jul 2018 16:07:24 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j129-v6sm45841288pfb.113.2018.07.13.16.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 16:07:23 -0700 (PDT)
Date:   Fri, 13 Jul 2018 16:07:23 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch v3 -mm 0/6] rewrite cgroup aware oom killer for general use
In-Reply-To: <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com> <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com> <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three significant concerns about the cgroup aware oom killer as
it is implemented in -mm:

 (1) allows users to evade the oom killer by creating subcontainers or
     using other controllers since scoring is done per cgroup and not
     hierarchically,

 (2) unfairly compares the root mem cgroup using completely different
     criteria than leaf mem cgroups and allows wildly inaccurate results
     if oom_score_adj is used, and

 (3) does not allow the user to influence the decisionmaking, such that
     important subtrees cannot be preferred or biased.

This patchset fixes (1) and (2) completely and, by doing so, introduces a
completely extensible user interface that can be expanded in the future.

Concern (3) could subsequently be addressed either before or after the
cgroup-aware oom killer feature is merged.

It preserves all functionality that currently exists in -mm and extends
it to be generally useful outside of very specialized usecases.

It eliminates the mount option for the cgroup aware oom killer entirely
since it is now enabled through the root mem cgroup's oom policy.
---
v3:
 - Rebased to next-20180713

v2:
 - Rebased to next-20180322
 - Fixed get_nr_swap_pages() build bug found by kbuild test robot

 Documentation/admin-guide/cgroup-v2.rst | 100 ++++++-----
 include/linux/cgroup-defs.h             |   5 -
 include/linux/memcontrol.h              |  21 +++
 kernel/cgroup/cgroup.c                  |  13 +-
 mm/memcontrol.c                         | 221 ++++++++++++++----------
 5 files changed, 204 insertions(+), 156 deletions(-)
