Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2FEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509B25844
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drGLuWhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C509B25844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeGBQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:32:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37462 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752554AbeGBQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:32:28 -0400
Received: by mail-yb0-f196.google.com with SMTP id r3-v6so5308833ybo.4;
        Mon, 02 Jul 2018 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aP337yMUwjNxwESmqz63nB2IfmzYkv0fwTzPmlQUTIQ=;
        b=drGLuWhUq4aurFCSnVKzj98WS3+4Y6rlKp6TuzYIjbcp08d/nl/udzQ0zkONrVT2ZE
         yklCdGVYF6ccURz1O/qaaCDVlgMV6T6r8SLOlCmfEfMlusdsbl+A9zFiu3b6rZ6WT4oW
         M52CJO/0714RDtezb9EIYc85awFBDikA7DYvADC7T8a2KqS1Yoc3mHarv213DeVSUdsw
         7XNIuzqIM/ohPE80sne39nTIdnqipFchy1v95A+TN9yZnMpOiEiuzCRQOBKdpamhdhei
         3hEEUGxdn/w76+bifw2/l0lEn6xJ8Nb2mYsAP+hUbc+pphcJW+fzIl2HsDhCUi/2KWd/
         KcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aP337yMUwjNxwESmqz63nB2IfmzYkv0fwTzPmlQUTIQ=;
        b=ps+dltC81HnWgY7zM+5dtlG6Obgw1vOddsiWY8kbD75LNevCEJFHYvm5QfzGlZEmQc
         TEPhtbEzsfGsZotpkS2HcHX85wjvfH7j9KsIPcqI+pxNVAnuaLn7J0a1oGLCBEP4xwul
         stOTe+UMCi4UUH+hjm80c98zidNSmrRH9ZWjUCA4HEsT48UeqD6H8G8faoKNPnPqM+LD
         9jlNNIfwUGetcCe5+B/w2jo2EtT6wBoG2mdmpjkD6W1Myu26VT29DZvZIB0CDSmmafkF
         44m0DgW+5DXRYqCVqRWo4uwaiXvL3nbC+afrt05nHIrKfj7YnJDm9QriSOhACl/Y15kR
         1R8w==
X-Gm-Message-State: APt69E1JjKRJMkmJRSX3sIn++qAo4Pak8lOb9kvlVsvpydAzOuowvnZp
        sFH5IJTEHTX5mg0DtZAeQfM=
X-Google-Smtp-Source: ADUXVKJr6wmmISfbOtlG/hJON0AXJTXBQu23ThkFCwFxu4HhqI4lb3NglUjLeOuc3M5hKuIhOj39yg==
X-Received: by 2002:a25:7ac3:: with SMTP id v186-v6mr13425072ybc.374.1530549147900;
        Mon, 02 Jul 2018 09:32:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id k10-v6sm6482275ywk.101.2018.07.02.09.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 09:32:27 -0700 (PDT)
Date:   Mon, 2 Jul 2018 09:32:25 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v10 2/9] cpuset: Add new v2 cpuset.sched.domain_root flag
Message-ID: <20180702163225.GH533219@devbig577.frc2.facebook.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-3-git-send-email-longman@redhat.com>
 <20180620142735.GM2494@hirez.programming.kicks-ass.net>
 <b44b0748-9fec-6bb0-7665-435487e5d8b3@redhat.com>
 <20180621092013.GU2494@hirez.programming.kicks-ass.net>
 <1eb82b46-aa97-2ada-5196-5d7fc1cda87d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb82b46-aa97-2ada-5196-5d7fc1cda87d@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 22, 2018 at 11:00:03AM +0800, Waiman Long wrote:
> On 06/21/2018 05:20 PM, Peter Zijlstra wrote:
> >> As for the inconsistency between the real root and the container root,
> >> this is true for almost all the controllers. So it is a generic problem.
> >> One possible solution is to create a kind a pseudo root cgroup for the
> >> container that looks and feels like a real root. But is there really a
> >> need to do that?
> > I don't really know. I thought the idea was to make containers
> > indistinguishable from a real system. Now I know we're really rather far
> > away from that in reality, and I really have no clue how important all
> > that is.
> 
> That will certainly be the ideal.

Sure, ideal in theoretical sense; however, the practical cost-benefit
ratio of trying to make containers indistinguishible from system
doesn't seem enough to justify the effort.  Not yet anyway.  It'd be
nice to not paint ourselves into a corner where we can't get the
equivalence without major interface changes later but I think that's
about the extent we should go for now.

> > It all depends on how exactly this works; is it like I assumed, that
> > this file is owned by the parent instead of the current directory? And
> > that if you namespace this, you have an effective read-only file?
> 
> Yes, that is right.
> 
> > Then fixing the inconsistency is trivial; simply provide a read-only
> > file for the actual root cgroup too.
> >
> > And if the solution is trivial, I don't see a good reason not to do it.
> 
> Do you mean providing a flag like READONLY_AT_ROOT so that it will be
> read-only at the real root? That is an cgroup architectural decision
> that needs input from Tejun. Anyway, this issue is not specific to this
> patchset and I would like to break it out as a separate discussion
> independent of this patchset.

Yeah, it's a larger problem than cpuset and different controllers
trying it in different ways isn't a good idea anyway.  Let's shelve
this topic for now.

Thanks.

-- 
tejun
