Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97102C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACD0217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAzi4Km5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfBEURz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:17:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38357 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBEURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:17:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so1876441pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/asjwI2h3R4dB1KhUJqTPMjf/nV/o0Zi8H3tJeSh7VI=;
        b=KAzi4Km5jRdAkGHd8bF9cYNW+h3If+L5zZL9wXe8rlZwk2X9UWvGIWw9I/vNP7Ded0
         eHc2JjtT4+muoLZ5IWpv/CpBbNDvyMWZpA7We2nd7HHvbNEPgHz9I6qtuvF309UvIm4Z
         TPtLp5ZlmhpbJ/PENU681DVQGwzC3ZYFm5X3rVrgrW7HtPWGWohKXY9CSa/H9u22shzU
         9N1iGG7Lt78dbVsBTqG/gzQ7k9avihm5xuQiy/ENFH92r9xyLYqcgFiIeAJocprDnPV2
         Oa1Ed2PGwzMHZrUAsO+/SbO8o6jzdX58TDEPUTdTWcTxXfFczNH2ydRuPtZVheCX6vrL
         bIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/asjwI2h3R4dB1KhUJqTPMjf/nV/o0Zi8H3tJeSh7VI=;
        b=uWX2SdvDVOFw4Loup7HWLUieU6qV5UKFek8rChIz0VmbHWyzYG50LpHcPSbt5wq858
         HYtJGMDjMmaQhf1WOjG1XxFIDKUYUgMe/7fyewgu10wUtL4vyp2bOkCjyrrwR5SKPiaR
         Orr0VF5P0Wi1rpnQJ5J615D+t7zZHPoDqDHfFXeM3vYwDpm+gTHvVbFspKwmGBpHxIH6
         BScCiuPeunf0bDNPs7aTPWN5JrFYncOLheg5NBFYZqJMRdjvS9cqvW9S6cxGxjCXSsHt
         xsbdg5E5OK0HfluS4xFZWoLmxfkfmazDa7p0qDRfbr94CCukfB23jjbjYgSVIAwsD9t5
         hqbA==
X-Gm-Message-State: AHQUAuaN+S0U7j4ns2A+GIDuBzfnErkXeIR5/ilhl8m0LBU25qz5YxXb
        ZIFhOt5Bu7/HyMZDg37D26k++g==
X-Google-Smtp-Source: AHgI3IaxNujIIMGLSxIBhRN36McCLaK/t8qyuhWae1Pe1AbArdzO/lDa9w0pCkuUIZ50wuLA5kt+Hw==
X-Received: by 2002:a62:ae04:: with SMTP id q4mr6864882pff.126.1549397872974;
        Tue, 05 Feb 2019 12:17:52 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id 24sm6722800pfr.75.2019.02.05.12.17.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 12:17:51 -0800 (PST)
Date:   Tue, 5 Feb 2019 12:17:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Artem Savkov <asavkov@redhat.com>,
        Baoquan He <bhe@redhat.com>, Qian Cai <cai@lca.pw>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: mm: race in put_and_wait_on_page_locked()
In-Reply-To: <CAHk-=wjXP6dnbdeLryqrMCG8+-yk1G7gcSKiopDKDEj0AdzdAA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1902051109120.9007@eggly.anvils>
References: <20190204091300.GB13536@shodan.usersys.redhat.com> <alpine.LSU.2.11.1902041201280.4441@eggly.anvils> <CAHk-=wjXP6dnbdeLryqrMCG8+-yk1G7gcSKiopDKDEj0AdzdAA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019, Linus Torvalds wrote:
> On Mon, Feb 4, 2019 at 8:43 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Something I shall not be doing, is verifying the correctness of the
> > low-level get_page_unless_zero() versus page_ref_freeze() protocol
> > on arm64 and power - nobody has reported on x86, and I do wonder if
> > there's a barrier missing somewhere, that could manifest in this way -
> > but I'm unlikely to be the one to find that (and also think that any
> > weakness there should have shown up long before now).
> 
> Remind me what the page_ref_freeze() rules even _are_?
> 
> It's a very special thing, setting the page count down to zero if it
> matches the "expected" count.
> 
> Now, if another CPU does a put_page() at that point, that certainly
> will hit the "oops, we dropped the ref to something that was zero".
> 
> So the "expected" count had better be only references we have and own
> 100%, but some of those references aren't really necessarily private
> to our thread.
> 
> For example, what happens if
> 
>  (a) one CPU is doing migration_entry_wait() (counting expected page
> refs etc, before doing page_ref_freeze)

s/migration_entry_wait/migrate_page_move_mapping/

> 
>  (b) another CPU is dirtying a page that was in the swap cache and
> takes a reference to it, but drops it from the swap cache

This is reuse_swap_page() called from do_wp_page(), I presume.

> 
> Note how (b) does not change the refcount on the page at all, because
> it just moves the ref-count from "swap cache entry" to "I own the page
> in my page tables". Which means that when (a) does the "count expected
> count, and match it", it happily matches, and the page_ref_freeze()
> succeeds and makes the page count be zero.
> 
> But now (b) has a private reference to that page, and can drop it, so
> the "freeze" isn't a freeze at all.
> 
> Ok, so clearly the above cannot happen, and there's something I'm
> missing with the freezing. I think we hold the page lock while this is
> going on, which means those two things cannot happen at the same time.
> But maybe there is something else that does the above kind of "move
> page ref from one owner to another"?

You're right that the page lock prevents even getting there (and is
essential whenever mucking around with PageSwapCache), but more to
the point is that the expected_count passed to page_ref_freeze()
does not include any user mapping references (mapcount).

All user mappings (known of at that instant) have been unmapped before
migrate_page_move_mapping() is called, and if any got added since
(difficult without page lock, but I wouldn't assume impossible),
their associated page references are sure to make the page_ref_freeze()
fail (so long as the page refcounting has not been broken).

reuse_swap_page() is called while holding the page table lock: so
although do_wp_page() cannot quite be said to own the page, it is
making sure that it cannot be racily unmapped at that point.  So
until the pte_unmap_unlock() (by which time it has done its own
get_page()) it can treat the page reference associated with the
user mapping as safe, as if it were its own.  And no racing
page_ref_freeze() could succeed while it's there, page lock or not.

Page lock is more important at the "outer" level of the page
migration protocol: holding together the "atomic" switch from old
to new page with the copying of data and flags from old to new.
And more important with anon (swapless) pages, for which there's no
shared visible cache, so migrate_page_move_mapping() does not even
bother with a page_ref_freeze() (though sometimes I want it to).

> 
> The page_ref_freeze() rules don't seem to be documented anywhere.

I would not enjoy documenting what has to be done at what stage
in the page migration sequence: it has evolved, it is subtle,
and we're grateful just to have working code.

At the inner level (where I worried we might have some barrier problem),
the relation between page_ref_freeze() and get_page_unless_zero():
the best documentation I can think of on page_ref_freeze() indeed does
not mention it as such at all (I think it has gone through renamings):
the big comment Nick wrote above page_cache_get_speculative() in
include/linux/pagemap.h.  And there's a helpful little comment in
include/linux/mm.h get_page() too.

(Ah, those innocent days, when the word "speculative" filled us
with delight and hope, instead of horror and dread.)

By the way, I won't put this bug out of my mind, until I've done
an audit of PagePrivate: I've a feeling that fs/iomap.c is not the
first place to forget that PagePrivate must be associated with a
page reference (which is not a special demand of page migration:
page reclaim won't work without it either); and put_and_wait_blah
may now expose such incorrectness as crashes.

Hugh
