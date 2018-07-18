Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1DFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BDE20858
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="GHKwgm6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BDE20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbeGRRWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:22:55 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40461 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbeGRRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:22:54 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so2091831ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hn8PNeEVeBiPcjbyroz+adMVtPsNaYaDnRKKaOIrY5E=;
        b=GHKwgm6DdSmOCkFrFrv42QUK9fk3virG1dzvW1E0Vvo+r6PE5no+K+qKo4JPp9vcuH
         i657zfRdZ5fOXA2Y4EUZu1+7/5nfBwcl+qYfJ6xBcFDmRB0tNUiN4dCNubEo6owXF9FB
         HRR2DlNCF4yYaaV4NE+SKFemGf8af0346shmAk+YrT0t+n/Vvg+ZxcJqCJxnOA10a/pQ
         b+ktdoLgIv6lp4FAsq/B7yJyoJ5JiHVNraYZDivJTaJzosmYeik3Q3T6qUl0qdRar73b
         28WCVoSExhX6o9VrIC4FYAkJqT3rhzUarHbsG6KtuHsBBJ8bi+oXHMELe+wVlgfv+6I0
         nTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hn8PNeEVeBiPcjbyroz+adMVtPsNaYaDnRKKaOIrY5E=;
        b=sBmkm48RW20b+hnAg2DGDRvrYw7RMBJ2QDeRBUIIz/YfhsRV0VzmsAAzf/vQR5iKmy
         6zosk2vwiy6u/Qblpm+QxiOUGX772+DINQmCp7WkUNBA/f1/8UOLt39XKatZWMqMX/rZ
         FWl4GneRiZkJlfWx50XCkD8EkiFYwmYUUdItaMXHJJZ4u4P7cmZ2zYL5pPxIAwAHo7pf
         7/e5eh7y5c+FAA0Q5mYHXUNXa2vzzSWAHdkSnaIfoXFnaeYw4BVXwgie1zAbvGlM7J+v
         fUKgnpyLhCE1uJizanBc4r0DjKSuPuqRQBiF/D4gXuMz6c2eoWMErmNnWcvVR/WND4DW
         xldQ==
X-Gm-Message-State: AOUpUlHzgk2BGXuDllsyaVUNv7xDZSIRmCpYR23fhHoB1NFRIEsji6xq
        D8hBevt5J4knfdSM+iSfqwItAg==
X-Google-Smtp-Source: AAOMgpdWTP0Oqonmq74etKjrA9Wd+lG+jsvyYo0O9Gw759K5XDaQ1Ck5K8Y/twPjpPpgNDhTWuyPnw==
X-Received: by 2002:a25:588a:: with SMTP id m132-v6mr3582201ybb.464.1531932249992;
        Wed, 18 Jul 2018 09:44:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id f137-v6sm4276121ywb.52.2018.07.18.09.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 09:44:08 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:46:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180718164656.GA2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718124627.GD2476@hirez.programming.kicks-ass.net>
 <20180718135633.GA5161@cmpxchg.org>
 <20180718163115.GV2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718163115.GV2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:31:15PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 18, 2018 at 09:56:33AM -0400, Johannes Weiner wrote:
> > On Wed, Jul 18, 2018 at 02:46:27PM +0200, Peter Zijlstra wrote:
> 
> > > I'm confused by this whole MEMSTALL thing... I thought the idea was to
> > > account the time we were _blocked_ because of memstall, but you seem to
> > > count the time we're _running_ with PF_MEMSTALL.
> > 
> > Under heavy memory pressure, a lot of active CPU time is spent
> > scanning and rotating through the LRU lists, which we do want to
> > capture in the pressure metric. What we really want to know is the
> > time in which CPU potential goes to waste due to a lack of
> > resources. That's the CPU going idle due to a memstall, but it's also
> > a CPU doing *work* which only occurs due to a lack of memory. We want
> > to know about both to judge how productive system and workload are.
> 
> Then maybe memstall (esp. the 'stall' part of it) is a bit of a
> misnomer.

I'm not tied to that name, but I can't really think of a better
one. It was called PF_MEMDELAY in the past, but "delay" also has
busy-spinning connotations in the kernel. "wait" also implies that
it's a passive state.

> > > And esp. the wait_on_page_bit_common caller seems performance sensitive,
> > > and the above function is quite expensive.
> > 
> > Right, but we don't call it on every invocation, only when waiting for
> > the IO to read back a page that was recently deactivated and evicted:
> > 
> > 	if (bit_nr == PG_locked &&
> > 	    !PageUptodate(page) && PageWorkingset(page)) {
> > 		if (!PageSwapBacked(page))
> > 			delayacct_thrashing_start();
> > 		psi_memstall_enter(&pflags);
> > 		thrashing = true;
> > 	}
> > 
> > That means the page cache workingset/file active list is thrashing, in
> > which case the IO itself is our biggest concern, not necessarily a few
> > additional cycles before going to sleep to wait on its completion.
> 
> Ah, right. PageWorkingset() is only true if we (recently) evicted that
> page before, right?

Yep, but not all of those, only the ones who were on the active list
in their previous incarnation, aka refaulting *hot* pages, aka there
is little chance this is healthy behavior.
