Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB30C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E66720865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCXZBe1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E66720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeKZOWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:22:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33494 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeKZOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:22:00 -0500
Received: by mail-oi1-f193.google.com with SMTP id c206so14572181oib.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 19:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3tDKGL4UxnGD+fU8NJPD/QcNWt/1qaHGuZR5ac1DIXI=;
        b=CCXZBe1L7+ULmWTT4WYTvtR6FMiYWAPh7mmC/YQ1edQj6xb+p8Amr/Fe+GmFZgNjxA
         sl6WzcX753pwjgrxOnwNnw7wAAZOq4g+OVjhxu4Goi53qPyAM3YPY4gJz9wzNnFL1QD4
         q7QzMBqKqlTLVZLTq+98q+bgxth4KBL+Y7sohL/fXY+diu6bMaMwGcKq7w9ROfHkFClQ
         JGb1J4vtJ3OODXLQ9A+70QQTRHd6v9WysCz5Eg/B70qN5HWYL5jzCd6Oe7N/VRbDnpom
         dQfQplmmeX7b3P8ol5SCWBpnBNcTZl4MRCvH1xDV8jF2ocyviDZK3W9IXr8iqZyIFFC1
         b3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3tDKGL4UxnGD+fU8NJPD/QcNWt/1qaHGuZR5ac1DIXI=;
        b=nqmF261fBPMF7sF48oTlvavOptzu+89DCFo5zRuZwaPMPrgG35iH5hhFt0RnnkcjaY
         b9YYXC0ySeFBZmNyY/WrhaS4XEzhSfu36dgh65flHCswy+IkU2sF9kH7+onu8BdgHaN5
         FwI1NHz/czv13N6XbDCCDB8Fh1MSIx6fI0fJs+e2cF47hdomN8cA6+O8WrhogiJaDXdN
         jP76RvZ0kmXfS3uhytZC5oFsM67sfNIPnjetn+pUcyXhlw2i0w8MlAiYKoZx1LFxiqK+
         HCTB0XKt7msrhMpDyEyCw3HjZEseKZdezgSzkOa31yv6jRISxIdZDz11mkHCWkaqBB5W
         qjMg==
X-Gm-Message-State: AA+aEWaHEuDzS2+QvgGjviNs3J0S/ODKqasXDVhiADjX9P1ydDQrD+Zy
        lz5DLJJ2M/azyjxJvJ2JMbf7IQ==
X-Google-Smtp-Source: AFSGD/UEpAsi8VCCwseuiUlDjFcycy/97L5jVEXPIjh/UXGTKSdHqZGH6EvyrwEuqIpGkCClQj5lYQ==
X-Received: by 2002:aca:3a55:: with SMTP id h82mr12385505oia.86.1543202956380;
        Sun, 25 Nov 2018 19:29:16 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c9sm19221094otb.38.2018.11.25.19.29.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 19:29:15 -0800 (PST)
Date:   Sun, 25 Nov 2018 19:29:07 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, david@redhat.com,
        mgorman@techsingularity.net, dh.herrmann@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, kan.liang@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: put_and_wait_on_page_locked() while page is
 migrated
In-Reply-To: <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1811251900300.1278@eggly.anvils>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils> <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018, Linus Torvalds wrote:
> On Sat, Nov 24, 2018 at 7:21 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Linus, I'm addressing this patch to you because I see from Tim Chen's
> > thread that it would interest you, and you were disappointed not to
> > root cause the issue back then.  I'm not pushing for you to fast-track
> > this into 4.20-rc, but I expect Andrew will pick it up for mmotm, and
> > thence linux-next.  Or you may spot a terrible defect, but I hope not.
> 
> The only terrible defect I spot is that I wish the change to the
> 'lock' argument in wait_on_page_bit_common() came with a comment
> explaining the new semantics.o

Thanks a lot for looking through it.

> 
> The old semantics were somewhat obvious (even if not documented): if
> 'lock' was set,  we'd make the wait exclusive, and we'd lock the page
> before returning. That kind of matches the intuitive meaning for the
> function prototype, and it's pretty obvious in the callers too.
> 
> The new semantics don't have the same kind of really intuitive
> meaning, I feel. That "-1" doesn't mean "unlock", it means "drop page
> reference", so there is no longer a fairly intuitive and direct
> mapping between the argument name and type and the behavior of the
> function.
> 
> So I don't hate the concept of the patch at all, but I do ask to:
> 
>  - better documentation.
> 
>    This might not be "documentation" at all, maybe that "lock"
> variable should just be renamed (because it's not about just locking
> any more), and would be better off as a tristate enum called
> "behavior" that has "LOCK, DROP, WAIT" values?

Agreed, an enum should be best. I'll try it out now, and see what
naming fits - I'm not all that keen on "LOCK", since (like many of the
existing comments) it forgets that PG_locked is only one of the flags
that comes here.  Admittedly, the only other is PG_writeback, and
nobody wants exclusive behavior on that one, but...

> 
>  - while it sounds likely that this is indeed the same issue that
> plagues us with the insanely long wait-queues, it would be *really*
> nice to have that actually confirmed.

I echo your words: it would be *really* nice.  We do already know
that this patch is good for many problem loads, but it would be very
satisfying if it could also wrap that discussion from last year.

> 
>    Does somebody still have access to the customer load that triggered
> the horrible scaling issues before?

Kan? Tim?

> 
> In particular, on that second issue: the "fixes" that went in for the
> wait-queues didn't really fix any real scalability problem, it really
> just fixed the excessive irq latency issues due to the long traversal
> holding a lock.
> 
> If this really fixes the fundamental issue, that should show up as an
> actual performance difference, I'd expect..

I guess so, though it might be more convincing to add a hack to suppress
the bookmarking (e.g. #define WAITQUEUE_WALK_BREAK_CNT (INT_MAX - 1))
when trying out the put_and_wait patch - if they can persuade the
customer to go back in time on this, which is asking a lot.

Not that I have any ambitions to do away with the bookmarking myself;
though I do have several reservations about the way it works out (that
I'd rather go into some other time).

> 
> End result: I like and approve of the patch, but I'd like it a lot
> more if the code behavior was clarified a bit, and I'd really like to
> close the loop on that old nasty page wait queue issue...

Thanks!
Hugh
