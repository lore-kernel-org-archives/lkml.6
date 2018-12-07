Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF26C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFBD20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmwKln+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFBD20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGXPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:15:40 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:44549 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:15:40 -0500
Received: by mail-pf1-f177.google.com with SMTP id u6so2608694pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 15:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QUkms/DVJEKkHxhV0riKAPj/37mf5Vv4TDTyEJSUMhk=;
        b=mmwKln+sZzjUrKXqKL7+e+5HbPmGyDw9iQ6z65MC+pQo5ex5/XAvvWktIF1bhELfcZ
         dXXtSath4sJ8FCl/xT0b1rdpOqAh/XaU1em8tZ/dahuTg/tNkntq95xkUb1VeqlSWuZP
         jzr0yYeNQPx8seu730Uf46ydZKgLHz/Nzr6mFv6caPCL3uicOE9WcmcsCJxI9rOnroXX
         dNJZXd8ZSjwReI2vlJUKEaX9pmlneLNouvk7Pu8xcGgVRaJeulwSMQACQJ9IYiEfNV7Q
         f1ymI4McAclm1ZoFH4FL39+vVtlgpkXJL85sITtDsj0YPGvLC4ovTH0C6l9uoMeObfbl
         0ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QUkms/DVJEKkHxhV0riKAPj/37mf5Vv4TDTyEJSUMhk=;
        b=sTBoIoJtTiBvxVI8YBks0jRYB9raPBhEvCIgxZH6vwRhSrYxA9z9Pfp2jx/JaNX3y3
         1j50tGFif0wZnxVizN9PZpwt2O4qdd6jWSd9j8kwX5X1xgQDjeTA3t8HROms3fYcw7wp
         FoMd3qp6SQPITdZxPhHp0vQeSAY+t5t43TPmSNCNVnJnuk+QBXWSlP4w3msWyunRqjXk
         du+j8XeZe7v9gMa7wzKNvIujvWFUPBDxwoBv+88Ifm974T8nA4aNaiR/S0JBT1DZZUGq
         tFC8OJry2dFqfGSQ79mHHoN1YR1O9f1XjCtKn41vSS9cVkGiahk3z6SCtGwGqgckfW7V
         ZQrg==
X-Gm-Message-State: AA+aEWbiXPJP3mJNs2TuuOqjTi9khzDv5oFVMRQWf+WSt9HBy5w6xg3n
        X9S0BWvsJtIic7jgd8IP2TyRsA==
X-Google-Smtp-Source: AFSGD/U5nVyydSSZjUt1PDP4uvDnDBvk7pLai5HsYYt94QUcAt2kpB3/LJvsVdX4VSwBI0uL8XMouw==
X-Received: by 2002:aa7:8758:: with SMTP id g24mr4002576pfo.250.1544224539240;
        Fri, 07 Dec 2018 15:15:39 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m76sm6497986pfi.102.2018.12.07.15.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:15:38 -0800 (PST)
Date:   Fri, 7 Dec 2018 15:15:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: MADV_HUGEPAGE vs. NUMA semantic (was: Re: [LKP] [mm] ac5b2c1891:
 vm-scalability.throughput -61.3% regression)
In-Reply-To: <779efc07-cac0-5d36-72fc-11d99060cac7@suse.cz>
Message-ID: <alpine.DEB.2.21.1812071512040.173448@chino.kir.corp.google.com>
References: <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com> <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com> <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com> <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com> <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com> <20181206091405.GD1286@dhcp22.suse.cz> <CAHk-=whCnERJt8bterD5yXABvoSmoJAx004Y76c82bBHCWbgDg@mail.gmail.com>
 <20181207074954.GR1286@dhcp22.suse.cz> <779efc07-cac0-5d36-72fc-11d99060cac7@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018, Vlastimil Babka wrote:

> >> But *that* in turn makes for other possible questions:
> >>
> >>  - if the reason we couldn't get a local hugepage is that we're simply
> >> out of local memory (huge *or* small), then maybe a remote hugepage is
> >> better.
> >>
> >>    Note that this now implies that the choice can be an issue of "did
> >> the hugepage allocation fail due to fragmentation, or due to the node
> >> being low of memory"
> > How exactly do you tell? Many systems are simply low on memory due to
> > caching. A clean pagecache is quite cheap to reclaim but it can be more
> > expensive to fault in. Do we consider it to be a viable target?
> 
> Compaction can report if it failed (more precisely: was skipped) due to
> low memory, or for other reasons. It doesn't distinguish how easily
> reclaimable is the memory, but I don't think we should reclaim anything
> (see below).
> 

Note that just reclaiming when the order-0 watermark in 
__compaction_suitable() fails is unfortunately not always sufficient: it 
needs to be accessible to isolate_freepages().  For order-9 memory, it's 
possible for isolate_migratepages_block() to skip over a top of free pages 
that were just reclaimed if there are unmovable pages preventing the 
entire pageblock from being freed.
