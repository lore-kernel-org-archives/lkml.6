Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B067C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2EC208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2QjseIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2EC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeK2KNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:13:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37209 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeK2KNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:13:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so1137plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C/c3G5BmD83tfVWE2NJBrIu3QAeN/dWlRBSxFybPWAU=;
        b=H2QjseIxovCEEMN9C2MSV7HY1gJ8aO4I5A0DVk3hL4VJGs6XifQAcspu1uncB5xDaK
         RGxLCjFV9Xis8nepNBS48v+meMXM90MBKvZX+NVALiPH4R2fLJHUwtkz+ZA1F/ARQsU1
         WInGaBWZMvzz5MbBYaIAj1b3G8JNkE+p8b0lA9rtjEuzdFFteqdTJWhetNiUwxR6nDKV
         A+wI158BC1u+HlYVOpHs4JHQVRrSEk3Bmk3l0KCBiQvuTkHx/VJ259cPo1fW2MlKws7l
         IfJbq8NI9msgySBccb1UmLjIMO4gH3ztafmTTBIjS4tU20BtAe4ByUDXkgK0vShoPwU4
         Wumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C/c3G5BmD83tfVWE2NJBrIu3QAeN/dWlRBSxFybPWAU=;
        b=jGZ4sCZ+TrCFX09YViIoaOo00zylav5p3IrXxHIPdedJUsluF0MnZy0b+flB6L7wVv
         5CxG7GagskxoeucdkS3qW/LNrfMOA8AVDzpuoeO4ZxJbpXbbh52X8WPCG6pKf75EnS65
         9iTzLpTw/OytzT4XjERugytdt47CWdizBBH/7TV/wkgSCeSfRXTyo0DTn/UEi5wORH3Y
         6SI8hYeEmg7u9s1LhwWBbItSoUbPus+4OJOAZlxbC2SEW6d5PVCzris5TJo6Z3/KdVnB
         bKDJI7i38ASBXtXbdRYx2Mj3VrESYVnP5Wepc3C1Q1unv6v0OU8UnJV2Bn6fMJ0as+4c
         6rzw==
X-Gm-Message-State: AA+aEWZu3BUESKx23K6V1olJQDG54K4EyKy1I40TRP1QE1GzRrIlC2rl
        Nvh5CHBKfA372DpwVsEveSCiNQ==
X-Google-Smtp-Source: AFSGD/X9yYgXggHNpBTfxvpCxd/HR0DNDlnMhcagOGZSqPp9gWklrwVBXXy51HSWGqp901EYvQ/Hiw==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr19778631plb.223.1543446608265;
        Wed, 28 Nov 2018 15:10:08 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c12-v6sm10913721pfb.174.2018.11.28.15.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 15:10:05 -0800 (PST)
Date:   Wed, 28 Nov 2018 15:10:04 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811281504030.231719@chino.kir.corp.google.com>
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com> <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018, Linus Torvalds wrote:

> On Tue, Nov 27, 2018 at 7:20 PM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > From the above data, for the parent commit 3 processes exited within
> > 14s, another 3 exited within 100s.  For this commit, the first process
> > exited at 203s.  That is, this commit makes memory allocation more fair
> > among processes, so that processes proceeded at more similar speed.  But
> > this raises system memory footprint too, so triggered much more swap,
> > thus lower benchmark score.
> >
> > In general, memory allocation fairness among processes should be a good
> > thing.  So I think the report should have been a "performance
> > improvement" instead of "performance regression".
> 
> Hey, when you put it that way...
> 
> Let's ignore this issue for now, and see if it shows up in some real
> workload and people complain.
> 

Well, I originally complained[*] when the change was first proposed and 
when the stable backports were proposed[**].  On a fragmented host, the 
change itself showed a 13.9% access latency regression on Haswell and up 
to 40% allocation latency regression.  This is more substantial on Naples 
and Rome.  I also measured similar numbers to this for Haswell.

We are particularly hit hard by this because we have libraries that remap 
the text segment of binaries to hugepages; hugetlbfs is not widely used so 
this normally falls back to transparent hugepages.  We mmap(), 
madvise(MADV_HUGEPAGE), memcpy(), mremap().  We fully accept the latency 
to do this when the binary starts because the access latency at runtime is 
so much better.

With this change, however, we have no userspace workaround other than 
mbind() to prefer the local node.  On all of our platforms, native sized 
pages are always a win over remote hugepages and it leaves open the 
opportunity that we collapse memory into hugepages later by khugepaged if 
fragmentation is the issue.  mbind() is not viable if the local node is 
saturated, we are ok with falling back to remote pages of the native page 
size when the local node is oom; this would result in an oom kill if we 
used it to retain the old behavior.

Given this severe access and allocation latency regression, we must revert 
this patch in our own kernel, there is simply no path forward without 
doing so.

[*] https://marc.info/?l=linux-kernel&m=153868420126775
[**] https://marc.info/?l=linux-kernel&m=154269994800842
