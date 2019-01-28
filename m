Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C52D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695905;
	bh=CpGGdcnwrJd3FP0zZD+UImDx7jURHf0H/1MruVeOXVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lRMY373AzVBwrpc3GNaiGFm1tLHUw+6vTx5yTGBDo5WxRKI5Kob2nVZg0qefJrkdO
	 4UA0+lWiHBpLuEeuq4oekykX+rhoNtjRRbPxgKwGxG1HkMbn+XDGfuae2TPPypChmu
	 xdvrpMP+kg4RWjz7ggX6yeMiNKSEArdME0N9c0i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfA1QFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:19 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46380 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfA1QFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:16 -0500
Received: by mail-yw1-f67.google.com with SMTP id t13so6894630ywe.13;
        Mon, 28 Jan 2019 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D0XIA/6Qh8GnZZaGo5cB5eBgXybV2IxRZOPzdvJrX0c=;
        b=l+K36/RDCfBLXWyfwDofaL0N6kncsH8J9nemOl65EBSWfBsCNapxwp3eNjnoplOTEg
         5K6WRkAL0/ukREfK8WDnsPdxifoTXD0UigcTjP4F8EqcZ6Prk6QeaR6FSyVSmh1LCQuR
         wbq/fKfQRplDMddZCczhcb2GLUV6Y5PmhcFFPM4CBO/CjzJ5rlOb+Jz/AOPBigxYRaOf
         zfGSfdkMTqAVYZvMk1U9ZwSf9VJ+yMd3aGmeTjyA+GkmgO8wjEzamAYjwk8OMjpEgg/D
         AzJtY400kLlnBy6R0JGDR5ehBi+hS47pxRDGQjoam2KKUhP3Uw93irXgqvzxYQ/q6fFW
         zlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D0XIA/6Qh8GnZZaGo5cB5eBgXybV2IxRZOPzdvJrX0c=;
        b=ePXufY2SuwDWCWwQ7XtDP/WjhuSEsz/GPd3bcqJX3Ngneo6sqWDltA5SP8pBJhWu7y
         K8XuV1bNWEy/y7fN6P/gSkDF8Ikfc4c3z34EHstkZLFd49x772hhqaWoPbKFGSMJDWx1
         Jh/8I9jsVZVBWGYpSCBUh4itjKVf4Q6Am52dajAN8zmR92ipRrVESq1h/wNKpqLeXuxu
         zg88p/Jw1i8SKWJ3bxPf5VC9LJPFBO9siCoYVnAI4zuqWcJFWNzUsFx5aMsM3nmvWfzW
         sSBWpxPYZx5R/Zj/X9CXHjMg3GCJQ5eH18qkYbMQMVB4J/aO7ZugppkUlhE484PnkCjC
         Ymyw==
X-Gm-Message-State: AJcUukdwMbTCsuhQiNzxjTuSPSAV5GugUfr9lmeWACr9s+ZQuzjR/wqR
        cjAx2L0ikiJFmyyhTbZidpk=
X-Google-Smtp-Source: ALg8bN7bUpeHV836lzz3aJ6Sgr6OtwzyPs6fkMCKJBakdwydEIqxML/o9OUDhLodzTvZNikuzUjKAA==
X-Received: by 2002:a81:2cc4:: with SMTP id s187mr21940591yws.67.1548691515076;
        Mon, 28 Jan 2019 08:05:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:a62a])
        by smtp.gmail.com with ESMTPSA id d3sm18681834ywh.58.2019.01.28.08.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:05:13 -0800 (PST)
Date:   Mon, 28 Jan 2019 08:05:12 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190128160512.GR50184@devbig004.ftw2.facebook.com>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
 <20190124160009.GA12436@cmpxchg.org>
 <20190124170117.GS4087@dhcp22.suse.cz>
 <20190124182328.GA10820@cmpxchg.org>
 <20190125074824.GD3560@dhcp22.suse.cz>
 <20190125165152.GK50184@devbig004.ftw2.facebook.com>
 <20190125173713.GD20411@dhcp22.suse.cz>
 <20190125182808.GL50184@devbig004.ftw2.facebook.com>
 <CALvZod6LFY+FYfBcAX0kLxV5KKB1-TX2cU5EDyyyjvHOtuWWbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6LFY+FYfBcAX0kLxV5KKB1-TX2cU5EDyyyjvHOtuWWbA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Shakeel.

On Mon, Jan 28, 2019 at 07:59:33AM -0800, Shakeel Butt wrote:
> Why not make this configurable at the delegation boundary? As you
> mentioned, there are jobs who want centralized workload manager to
> watch over their subtrees while there can be jobs which want to
> monitor their subtree themselves. For example I can have a job which
> know how to act when one of the children cgroup goes OOM. However if
> the root of that job goes OOM then the centralized workload manager
> should do something about it. With this change, how to implement this
> scenario? How will the central manager differentiates between that a
> subtree of a job goes OOM or the root of that job? I guess from the
> discussion it seems like the centralized manager has to traverse that
> job's subtree to find the source of OOM.
> 
> Why can't we let the implementation of centralized manager easier by
> allowing to configure the propagation of these notifications across
> delegation boundary.

I think the right way to achieve the above would be having separate
recursive and local counters.

Thanks.

-- 
tejun
