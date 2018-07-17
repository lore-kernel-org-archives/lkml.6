Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5263EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0322B20877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkxQsrXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322B20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeGQEhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:37:04 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35193 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeGQEhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:37:04 -0400
Received: by mail-pf0-f182.google.com with SMTP id q7-v6so26247284pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XXRaf6b1Z7QH2G5n/zGzvWHa4onHyZTEv5o26QMKEGg=;
        b=EkxQsrXEkLQM5BKFqWURcpdb3Z9lLUTS2/Qsm+hIycrLi8KHjDvuD0HqeTUeTOWMks
         3fz+gA6JRLMM+BJUIS0zBULelglH2bL/rEAizZZWm9A9JkcSjENjTCfQOYNl11ir4Zt0
         uGWM2OJExwE5OM5pABnF9DpVumpFCPEOzEvaWJv5URzg8Gp4Cu4XR/cHxEUw1w6f+lK5
         jkOlKmSpd+2JnzI0jWoLUKbF53uiTiglfp365G5DdRq849O5SeLyHZOeKqbB3QlCYvph
         lch2QT4k3nuNidffA3jPtF1Xx20fyZomXEb3v6gL2HxBZ+CRCN2Fe7+Yla2HAJFJM2m4
         H+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XXRaf6b1Z7QH2G5n/zGzvWHa4onHyZTEv5o26QMKEGg=;
        b=Css7J/3lW+PEmE9+9e1eQFgjm6U9zpwlChH2UV65YLvp0dMVE7js0CqNDnYNV6BJaD
         +D5pj4a7YopuraZ34NFIadG9H6oMpLV0YQ2ces+dZSaPAflz8DnJCHfQE7jb4gifHMr+
         l/JPPALMVMoVFYES/oeEt7JVwPCJWoE3Az4xYGNF0m6GUoOfQfK/HeweFpotaI6tNRzo
         IGMerei/sJY5Iyen4W0W8Na/oXK5TLpnDt4inTU5KRk4hGCoBkmvCkMraSbeqaeg7c4u
         pp4jopFV9k+F5vcuPizyYLbXHpzhhxcWyMkVAWzw1NLxGiHQlVL/GAFCgaiF/tl1NLu2
         GTow==
X-Gm-Message-State: AOUpUlFuW/rhUcO0hIoFfdgYF9Ax7PFKTDhHVnOr5lEFvZKn46b95+hJ
        cw4tVA/eTqZdqJWcL3q0X3OAuw==
X-Google-Smtp-Source: AAOMgpfIHlAmeu9QprmQzfm0qdSsU/c5PVdAeYRvgFUG1aiUMdgyLUdcyYaE/XdgwxaigGbGRelPBA==
X-Received: by 2002:a62:d10b:: with SMTP id z11-v6mr20798858pfg.255.1531800391264;
        Mon, 16 Jul 2018 21:06:31 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 65-v6sm46874758pfq.81.2018.07.16.21.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:06:30 -0700 (PDT)
Date:   Mon, 16 Jul 2018 21:06:30 -0700 (PDT)
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
In-Reply-To: <20180716181613.GA28327@castle>
Message-ID: <alpine.DEB.2.21.1807162101170.157949@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com> <alpine.DEB.2.20.1803151351140.55261@chino.kir.corp.google.com> <alpine.DEB.2.20.1803161405410.209509@chino.kir.corp.google.com> <alpine.DEB.2.20.1803221451370.17056@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807131604560.217600@chino.kir.corp.google.com> <alpine.DEB.2.21.1807131605590.217600@chino.kir.corp.google.com> <20180716181613.GA28327@castle>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Roman Gushchin wrote:

> Hello, David!
> 
> I think that there is an inconsistency in the memory.oom_policy definition.
> "none" and "cgroup" policies defining how the OOM scoped to this particular
> memory cgroup (or system, if set on root) is handled. And all sub-tree
> settings do not matter at all, right? Also, if a memory cgroup has no
> memory.max set, there is no meaning in setting memory.oom_policy.
> 

Hi Roman,

The effective oom policy is based on the mem cgroup that is oom.  That can 
occur when memory.max is set, yes.

If a mem cgroup does not become oom itself, its oom policy doesn't do 
anything until, well, it's oom :)

> And "tree" is different. It actually changes how the selection algorithm works,
> and sub-tree settings do matter in this case.
> 

"Tree" is considering the entity as a single indivisible memory consumer, 
it is compared with siblings based on its hierarhical usage.  It has 
cgroup oom policy.

It would be possible to separate this out, if you'd prefer, to account 
an intermediate cgroup as the largest descendant or the sum of all 
descendants.  I hadn't found a usecase for that, however, but it doesn't 
mean there isn't one.  If you'd like, I can introduce another tunable.
