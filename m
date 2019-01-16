Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66886C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3766A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="NNSL/Bd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfAPTRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:17:32 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42847 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfAPTRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:17:32 -0500
Received: by mail-yw1-f66.google.com with SMTP id x2so2834032ywc.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kIFFLkmq7d3xFpRMLDb08Mw1HpNVbvYZHc+n3mgNoj8=;
        b=NNSL/Bd3aNrBfSndV2o1hvQ3nbYDQ3op0STM0igBEdRn8QAeAmSSbGIugQi43fcd5V
         b8FNwOkSMLltBhPH6uzFCikvhmh/KuhWnRObaUw2AkhiHXf7S4hKCiSq61zp4r9PIaA+
         BL2xSSnZJVsoP1r5qg9HlTN1zRpYiRkI5PZEo/ynNddY0l83FBP8pCEgNKFoeeSvY/fD
         5VT6G1MQkskyoTaGsiqJ7pD8/XsObcLDBFxJSMW7RhXnc9ekhDPGw9CSQF0iGSemOPuK
         Bmf9gGjHDicM8qG90ire2HSUPXzunPANhQ8gD90oyUxt+2yv2Oxr+0fVV1ULNUOQ7oyP
         fgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kIFFLkmq7d3xFpRMLDb08Mw1HpNVbvYZHc+n3mgNoj8=;
        b=JHGvm8IM9Smialle1SWHzWJVra/8dRoYhQSk+08HQ9Eg7HLmwGbGq+fIuokj+LoXPO
         BaHF6DUvwJRL1BRrUmB+LqrVhsSbNhZ6hPN6qEurSiDs2fxd9/RmhzfUZw9MVt7ylM8C
         IhFZ9cIK+zBpCFh22NQCUo0azmajqyXpP+LehIGsO3momQpQBXXClbfJ0G+FYfpKOnkh
         fblAWCMFd3ntE7N9peXlV6qhGQ/aGrr0t+breDbtCOnn2amoq9UGl8rSlYq4+SuoICn4
         dQ+U3MsboK38ySRzjk6jStXk660tkWQ8ikYgzboO1J+stUVC1ejrsHpRzY7Ilr3900pf
         5ISQ==
X-Gm-Message-State: AJcUukfeeQ8pHGczlHOCEZLohSmOBY8KvmH4nZuoBIQgUMscSp+TqLc1
        AyQoHqdyQrXnyKitWcza6RWLiQ==
X-Google-Smtp-Source: ALg8bN4vCehI+JLbpJywb7Y3MB6fCIMuKW0bsgB2FbFKyX8r6NstXfM2nImoO9rzNcsi/iaNo+zc3Q==
X-Received: by 2002:a81:c144:: with SMTP id e4mr9203726ywl.409.1547666250524;
        Wed, 16 Jan 2019 11:17:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:ddb4])
        by smtp.gmail.com with ESMTPSA id d85sm3073760ywd.22.2019.01.16.11.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:17:29 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:17:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v2 5/5] psi: introduce psi monitor
Message-ID: <20190116191728.GA1380@cmpxchg.org>
References: <20190110220718.261134-1-surenb@google.com>
 <20190110220718.261134-6-surenb@google.com>
 <20190114102137.GB14054@worktop.programming.kicks-ass.net>
 <CAJuCfpGUWs0E9oPUjPTNm=WhPJcE_DBjZCtCiaVu5WXabKRW6A@mail.gmail.com>
 <20190116132446.GF10803@hirez.programming.kicks-ass.net>
 <CAJuCfpEJW6Uq4GSGEGLKOM4K7ySHUeTGrSUGM1+EJSQ16d8SJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEJW6Uq4GSGEGLKOM4K7ySHUeTGrSUGM1+EJSQ16d8SJg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:39:13AM -0800, Suren Baghdasaryan wrote:
> On Wed, Jan 16, 2019 at 5:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jan 14, 2019 at 11:30:12AM -0800, Suren Baghdasaryan wrote:
> > > For memory ordering (which Johannes also pointed out) the critical point is:
> > >
> > > times[cpu] += delta           | if g->polling:
> > > smp_wmb()                     |   g->polling = polling = 0
> > > cmpxchg(g->polling, 0, 1)     |   smp_rmb()
> > >                               |   delta = times[*] (through goto SLOWPATH)
> > >
> > > So that hotpath writes to times[] then g->polling and slowpath reads
> > > g->polling then times[]. cmpxchg() implies a full barrier, so we can
> > > drop smp_wmb(). Something like this:
> > >
> > > times[cpu] += delta           | if g->polling:
> > > cmpxchg(g->polling, 0, 1)     |   g->polling = polling = 0
> > >                               |   smp_rmb()
> > >                               |   delta = times[*] (through goto SLOWPATH)
> > >
> > > Would that address your concern about ordering?
> >
> > cmpxchg() implies smp_mb() before and after, so the smp_wmb() on the
> > left column is superfluous.
> 
> Should I keep it in the comments to make it obvious and add a note
> about implicit barriers being the reason we don't call smp_mb() in the
> code explicitly?

I'd keep 'em out if they aren't actually in the code. But I'd switch

	delta = times[*]

in this comment to to

	get_recent_times() // implies smp_mb()

or something to make the ordering a bit more visible.

And also add a comment to the actual cmpxchg() in the code directly
that says that we rely on the implied ordering and that it pairs with
the smp_mb() in the slowpath; add a similar comment to the smp_mb().

> > Also, you probably want to use atomic_t for g->polling, because we
> > (sadly) have architectures where regular stores and atomic ops don't
> > work 'right'.
> 
> Oh, I see. Will do. Thanks!

Yikes, that's news to me too. Good to know.
