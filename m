Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA9DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAFA208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCB0Fh4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAFA208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeJCDOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:14:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38608 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeJCDOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:14:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so481515pgr.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5gSLG4lyA5oa9/o65FQ1egmY4ijkLaRYn17Ah1lMl4U=;
        b=PCB0Fh4X00kG3gvk7iwNNKeP7hr3SIwWLOnEA0k/OBmJRcjKTCDLiPvBnLzmDSQNEW
         OU1U6tS8OJ+8gkwmPWSUYGKZxk4iscyFD6BvWR2E4rOul91MqOmwZJqN8P1RnbIZdOL5
         ecY4QaWThD7wH2sNLR/lOQ4V4CPUd947oywD5KlHdj1vda/+io3DxBnBWMvUIB2rdywh
         8k1FLtvvPl2MGA+/Yrt7h++0GuaOUqTZp+vr/OkQ2ajPkHs2cj/0GvlX3Vv2e2CGJwtT
         if+y3x5As9TniPrsamc4KWVVOLYsMMb7AB7h9M2EyEH1S0bW/9RbiOShRe7f+rAIl/gQ
         9Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5gSLG4lyA5oa9/o65FQ1egmY4ijkLaRYn17Ah1lMl4U=;
        b=Qf3UGWw8+i0Erp3w8RFA54ZiO/bqwEpr4ZyitNA7wbGfCcysEUzPdvaWlTQXIxt5Qb
         vkaiaMsHc8OXZdOwa2mD6TmmNE4NPyEruOnhCx1Q4vm1USqGca+xMZsN01tDKvNJrol/
         z8cwAHUx3IqODBnhhn/0NMsccqrBi84hEpPo7afEWUIl55LsCR6ILnji6H4oGOXGl5KS
         5wNPqeWqkNdssBLzNOyRLUyl+YsbouzIHjlQuc3+M8PiYeggmjUjCWG5dKTYqYronH1x
         fDsI/X0j7yPjg+zqkHnh+DoxqyU0QPILNvM45EWklnMlTugUb68a6wdw4+LP6qeJhCg1
         Gzig==
X-Gm-Message-State: ABuFfohiEz+PzWgZzfIEqLjPtlkJbyBX8HMZfkVCqUBXAhwz/Sx11evm
        svESJ+jOyWKmyif+BGz2RJgKKg==
X-Google-Smtp-Source: ACcGV60g7aq4CZ22aabstsUQgO9BQwg5ccPjhlagypSy0W9QIYh7ss9IeGOHxB/F87Af5nN83HvF3A==
X-Received: by 2002:a63:184a:: with SMTP id 10-v6mr15755174pgy.81.1538512184337;
        Tue, 02 Oct 2018 13:29:44 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1129740pfi.4.2018.10.02.13.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 13:29:43 -0700 (PDT)
Date:   Tue, 2 Oct 2018 13:29:42 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
In-Reply-To: <20181002112851.GP18290@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com> <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com> <20180924195603.GJ18685@dhcp22.suse.cz> <20180924200258.GK18685@dhcp22.suse.cz> <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
 <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com> <20180925202959.GY18685@dhcp22.suse.cz> <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com> <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org> <20180926060624.GA18685@dhcp22.suse.cz>
 <20181002112851.GP18290@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Michal Hocko wrote:

> On Wed 26-09-18 08:06:24, Michal Hocko wrote:
> > On Tue 25-09-18 15:04:06, Andrew Morton wrote:
> > > On Tue, 25 Sep 2018 14:45:19 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> > > 
> > > > > > It is also used in 
> > > > > > automated testing to ensure that vmas get disabled for thp appropriately 
> > > > > > and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
> > > > > > this, and those tests now break.
> > > > > 
> > > > > This sounds like a bit of an abuse to me. It shows how an internal
> > > > > implementation detail leaks out to the userspace which is something we
> > > > > should try to avoid.
> > > > > 
> > > > 
> > > > Well, it's already how this has worked for years before commit 
> > > > 1860033237d4 broke it.  Changing the implementation in the kernel is fine 
> > > > as long as you don't break userspace who relies on what is exported to it 
> > > > and is the only way to determine if MADV_NOHUGEPAGE is preventing it from 
> > > > being backed by hugepages.
> > > 
> > > 1860033237d4 was over a year ago so perhaps we don't need to be
> > > too worried about restoring the old interface.  In which case
> > > we have an opportunity to make improvements such as that suggested
> > > by Michal?
> > 
> > Yeah, can we add a way to export PR_SET_THP_DISABLE to userspace
> > somehow? E.g. /proc/<pid>/status. It is a process wide thing so
> > reporting it per VMA sounds strange at best.
> 
> So how about this? (not tested yet but it should be pretty
> straightforward)

Umm, prctl(PR_GET_THP_DISABLE)?
