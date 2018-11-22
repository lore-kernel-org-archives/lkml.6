Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9B4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F1320645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKKDW6vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F1320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391616AbeKVMak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:30:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37515 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbeKVMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:30:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so8043686plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WGEtHpnrScXJx5gr14hKwGC9UCALXbnL9Aj5oAqLDfY=;
        b=QKKDW6vRA+RsGDcM+5chD/p+jt74BwT7Ub3F6FVGTED4JxCdZeoy+xQCRwe/JlfL0F
         mt7e6nfDZY/3/3IufbJqIvlmFTIaEiRNJ+qQT9Jn0tcITYA2xpG6uVG0TeBpQeVhysXQ
         GuIQNBIRllQpSlVq9m7sBANbA8ivwhYVLScRnwe06NPfBfZHNHchUn7yZumFfzhZCUOH
         TMbsR2qIffhnoxGgsIqaMOWEgJiqEdwqOtayqPD6DqwOqHnBNf3xmqiwne/nU4QSL0ba
         ZFtQQka4Lwa4kRgp1fB4pdpOweDNs6V6D85cvSGw03OXYMG9SL+zrxTwcrOd08ye7pnk
         Pedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WGEtHpnrScXJx5gr14hKwGC9UCALXbnL9Aj5oAqLDfY=;
        b=SSZRZy6X1omeaGtXy8kDhPPJlTQrp8e4ekNIM0LTLpgBCjq8sMJXl+d9soas2iY2bs
         XAQ//Y6peLEpsrrooV8NJf8zl0uptnR33BC4MCI2LID+kU/EpP0P5phxSScgDbCFNZYl
         yTc/hcByMixxpBmBb5pRM7Bwy3YaVP1vXtPd/Cr5ojOkBUh6Mp/zmBHM3WyueUhhKecB
         XH0qRezMLcjbA0z8whO6o1c/UALivsNlc3q1wcINWJ1a64E1ZRNAIGP9oSOwgDSZE+f6
         iUIf03K36TLFl5SdDdVEiMQna+pRK3Trehs4R7IP5vtJFqBpUC4hzXsApLLDcw1AqmUp
         dQ1A==
X-Gm-Message-State: AA+aEWbO6eBV8PJq9yIKnr/YDsXERI0JwS2UI8p4txUZu+aLNcpTZEh9
        PhMHbmK7D7y1XCD0MWCy+hKXBA==
X-Google-Smtp-Source: AFSGD/WvNUO0809BnwPXDtXC+Bl1k3ijkduNjrczvYehSYTRweNKTdD+duJqEPBMhUgamXFk4+/kSA==
X-Received: by 2002:a17:902:b903:: with SMTP id bf3mr9054242plb.289.1542851615861;
        Wed, 21 Nov 2018 17:53:35 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id e188sm36891581pfg.130.2018.11.21.17.53.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 17:53:35 -0800 (PST)
Date:   Wed, 21 Nov 2018 17:53:33 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Memory hotplug softlock issue
In-Reply-To: <20181121173123.GS12932@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.1811211726080.5557@eggly.anvils>
References: <20181116091409.GD14706@dhcp22.suse.cz> <20181119105202.GE18471@MiWiFi-R3L-srv> <20181119124033.GJ22247@dhcp22.suse.cz> <20181119125121.GK22247@dhcp22.suse.cz> <20181119141016.GO22247@dhcp22.suse.cz> <20181119173312.GV22247@dhcp22.suse.cz>
 <alpine.LSU.2.11.1811191215290.15640@eggly.anvils> <20181119205907.GW22247@dhcp22.suse.cz> <20181120015644.GA5727@MiWiFi-R3L-srv> <alpine.LSU.2.11.1811192127130.2848@eggly.anvils> <20181121173123.GS12932@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Michal Hocko wrote:
> On Mon 19-11-18 21:44:41, Hugh Dickins wrote:
> [...]
> > [PATCH] mm: put_and_wait_on_page_locked() while page is migrated
> > 
> > We have all assumed that it is essential to hold a page reference while
> > waiting on a page lock: partly to guarantee that there is still a struct
> > page when MEMORY_HOTREMOVE is configured, but also to protect against
> > reuse of the struct page going to someone who then holds the page locked
> > indefinitely, when the waiter can reasonably expect timely unlocking.
> 
> I would add the following for the "problem statement". Feel free to
> reuse per your preference:
> "
> An elevated reference count, however, stands in the way of migration and
> forces it to fail with a bad timing. This is especially a problem for
> memory offlining which retries for ever (or until the operation is
> terminated from userspace) because a heavy refault workload can trigger
> essentially an endless loop of migration failures. Therefore
> __migration_entry_wait is essentially harmful for the even it is waiting
> for.
> "

Okay, I do have a lot written from way back when I prepared the
now-abandoned migration_waitqueue patch internally, but I'll factor in
what you say above when I get there - in particular, you highlight the
memory offlining aspect, as in this mailthread: which is very helpful,
because it's outside my experience so I won't have mentioned it - thanks.

I just know that there's some important linkage to do, to the August 2017
WQ_FLAG_BOOKMARK discussion: so it's a research and editing job I have to
work myself up to at the right moment.

> 
> > But in fact, so long as wait_on_page_bit_common() does the put_page(),
> > and is careful not to rely on struct page contents thereafter, there is
> > no need to hold a reference to the page while waiting on it.  That does
> > mean that this case cannot go back through the loop: but that's fine for
> > the page migration case, and even if used more widely, is limited by the
> > "Stop walking if it's locked" optimization in wake_page_function().
> 
> I would appreciate this would be more explicit about the existence of
> the elevated-ref-count problem but it reduces it to a tiny time window
> compared to the whole time the waiter is blocked. So a great
> improvement.

Fair enough, I'll do so. (But that's a bit like when we say we've attached
something and then forget to do so: please check that I've been honest
when I do post.)

> 
> > Add interface put_and_wait_on_page_locked() to do this, using negative
> > value of the lock arg to wait_on_page_bit_common() to implement it.
> > No interruptible or killable variant needed yet, but they might follow:
> > I have a vague notion that reporting -EINTR should take precedence over
> > return from wait_on_page_bit_common() without knowing the page state,
> > so arrange it accordingly - but that may be nothing but pedantic.
> > 
> > shrink_page_list()'s __ClearPageLocked(): that was a surprise!
> 
> and I can imagine a bad one. Do we really have to be so clever here?
> The unlock_page went away in the name of performance (a978d6f521063)
> and I would argue that this is a slow path where this is just not worth
> it.

Do we really have to be so clever here? That's a good question: now we
have PG_waiters, we probably do not need to bother with this cleverness,
and it would save me from having to expand on that comment as I was asked.
I'll try going back to a simple unlock_page() there: and can always restore
the __ClearPageLocked if a reviewer demands, or 0-day notices regression,

> 
> > this
> > survived a lot of testing before that showed up.  It does raise the
> > question: should is_page_cache_freeable() and __remove_mapping() now
> > treat a PG_waiters page as if an extra reference were held?  Perhaps,
> > but I don't think it matters much, since shrink_page_list() already
> > had to win its trylock_page(), so waiters are not very common there: I
> > noticed no difference when trying the bigger change, and it's surely not
> > needed while put_and_wait_on_page_locked() is only for page migration.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> The patch looks good to me - quite ugly but it doesn't make the existing
> code much worse.
> 
> With the problem described Vlastimil fixed, feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> 
> And thanks for a prompt patch. This is something I've been chasing for
> quite some time. __migration_entry_wait came to my radar only recently
> because this is an extremely volatile area.

You are very gracious to describe a patch promised six months ago as
"prompt".  But it does help me a lot to have it fixing a real problem
for someone (thank you Baoquan) - well, it fixed a real problem for us
internally too, but very nice to gather more backing for it like this.

Hugh
