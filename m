Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C11EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168372146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtGcOjSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168372146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeKULkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:40:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38042 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKULkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:40:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so2875817plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CBeYW30Z0HB62m1uZkWJvu1sgDpq1cWZindpCQ/lqxk=;
        b=FtGcOjSu6q3lEVOo15vmYdTTwAlc+7ReZszZCGNPpaSI4CnzwtsekoTuFjigqgk5t1
         Ni1CuHqig60CxZK0fNSXmt2Gsn8Ffc59nuD8rBmacGpno67LFPsCeiGd1q5+gSzMMDDh
         UeIJnDjziPn6VyI7I2oXrtOM5YCGzjdP80MlW9/cg/1k1ZYUZn2uJ9n7NKyPqBJcXZx2
         dnM0ZBNoUxAMJSnOxPLeSKxwgTaid7wf6GZ4hTxYvP6bnYqjv94LxLeuSxwsyKtp7lnW
         EmAZnpnxl3ES26jdNUADP02VI+iI+Q6dkPRocnvH0YX4Ee/IgXPH6VyZATJNSkTg9wsk
         JZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CBeYW30Z0HB62m1uZkWJvu1sgDpq1cWZindpCQ/lqxk=;
        b=b6n11nHzKWE4Q7wAP2iAgZIV6L+KdT1saPP00TJ/RLGk3ZXpERVroAc8YjS+H1yBrO
         Wz7Sy1RX35B74O+V3ImcJU9o61+kQJi/TlIb5DfJIFq8ESNozRe91jujS4X/nPAhIA36
         QYwUSoBqToIl8ner8AqL+9PN3iBPv3bAu6sWCNPS6CwL6mf0WWWFFT88PhtUmAbRtl5D
         cdnDBz1pK00df2LMKrfdzle7BT8DAX2ti5zBodQTGHuqs9DRaoodJhOwAkIDJsyWcpNs
         g3kn53VdwJLjc5fyH3l3V1t3DXF85sHZv66kH1IvedLvROv4rx7k8GpybE3tCg5/1/Bb
         Lghg==
X-Gm-Message-State: AA+aEWbVClaQOnOwzJotuCnzK1MSc0yz353NcQYNXt9jPsG9K66dXLaB
        qsSpyFbV36tst/Td/mn0HctuDw==
X-Google-Smtp-Source: AFSGD/XM9VCB0EfvPDzx7aMwzbiw6NO897sXYTFVjZhMyYyYWHolaHJz55yERdX42VxiSpA4ZzD9mw==
X-Received: by 2002:a17:902:74c1:: with SMTP id f1mr4513636plt.273.1542762528042;
        Tue, 20 Nov 2018 17:08:48 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id t90sm35800294pfj.23.2018.11.20.17.08.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 17:08:46 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:08:39 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Memory hotplug softlock issue
In-Reply-To: <3f1a82a8-f2aa-ac5e-e6a8-057256162321@suse.cz>
Message-ID: <alpine.LSU.2.11.1811201630360.2061@eggly.anvils>
References: <20181115143204.GV23831@dhcp22.suse.cz> <20181116012433.GU2653@MiWiFi-R3L-srv> <20181116091409.GD14706@dhcp22.suse.cz> <20181119105202.GE18471@MiWiFi-R3L-srv> <20181119124033.GJ22247@dhcp22.suse.cz> <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz> <20181119173312.GV22247@dhcp22.suse.cz> <alpine.LSU.2.11.1811191215290.15640@eggly.anvils> <20181119205907.GW22247@dhcp22.suse.cz> <20181120015644.GA5727@MiWiFi-R3L-srv> <alpine.LSU.2.11.1811192127130.2848@eggly.anvils>
 <3f1a82a8-f2aa-ac5e-e6a8-057256162321@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Vlastimil Babka wrote:
> On 11/20/18 6:44 AM, Hugh Dickins wrote:
> > [PATCH] mm: put_and_wait_on_page_locked() while page is migrated
> > 
> > We have all assumed that it is essential to hold a page reference while
> > waiting on a page lock: partly to guarantee that there is still a struct
> > page when MEMORY_HOTREMOVE is configured, but also to protect against
> > reuse of the struct page going to someone who then holds the page locked
> > indefinitely, when the waiter can reasonably expect timely unlocking.
> > 
> > But in fact, so long as wait_on_page_bit_common() does the put_page(),
> > and is careful not to rely on struct page contents thereafter, there is
> > no need to hold a reference to the page while waiting on it.  That does
> 
> So there's still a moment where refcount is elevated, but hopefully
> short enough, right?

Correct: and given page migration's 10 passes, it would have to be very
unlucky to hit one of those transiently elevated refcounts every time:
so I don't think it's a grave drawback at all - certainly much less
grave than how it's done at present.

I admit that doing a get_page_unless_zero() immediately before the
put_and_wait_on_page_locked() looks rather silly, but I think we do
have to hold a reference in order to set PG_waiters. Then for other
future uses (e.g. in find_get_entry() or lock_page_or_retry()),
the reference to be dropped has been taken earlier anyway.

> Let's see if it survives Baoquan's stress testing.
> 
> > mean that this case cannot go back through the loop: but that's fine for
> > the page migration case, and even if used more widely, is limited by the
> > "Stop walking if it's locked" optimization in wake_page_function().
> > 
> > Add interface put_and_wait_on_page_locked() to do this, using negative
> > value of the lock arg to wait_on_page_bit_common() to implement it.
> > No interruptible or killable variant needed yet, but they might follow:
> > I have a vague notion that reporting -EINTR should take precedence over
> > return from wait_on_page_bit_common() without knowing the page state,
> > so arrange it accordingly - but that may be nothing but pedantic.
> > 
> > shrink_page_list()'s __ClearPageLocked(): that was a surprise! this
> > survived a lot of testing before that showed up.  It does raise the
> > question: should is_page_cache_freeable() and __remove_mapping() now
> > treat a PG_waiters page as if an extra reference were held?  Perhaps,
> > but I don't think it matters much, since shrink_page_list() already
> > had to win its trylock_page(), so waiters are not very common there: I
> > noticed no difference when trying the bigger change, and it's surely not
> > needed while put_and_wait_on_page_locked() is only for page migration.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> 
> ...
> 
> > @@ -1100,6 +1111,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
> >  			ret = -EINTR;
> >  			break;
> >  		}
> > +
> > +		if (lock < 0) {
> > +			/*
> > +			 * We can no longer safely access page->flags:
> 
> Hmm...
> 
> > +			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
> > +			 * there is a risk of waiting forever on a page reused
> > +			 * for something that keeps it locked indefinitely.
> > +			 * But best check for -EINTR above before breaking.
> > +			 */
> > +			break;
> > +		}
> >  	}
> >  
> >  	finish_wait(q, wait);
> 
> ... the code continues by:
> 
>         if (thrashing) {
>                 if (!PageSwapBacked(page))
> 
> So maybe we should not set 'thrashing' true when lock < 0?

Very good catch, thank you Vlastimil: as you might have guessed, the
patch from a pre-PSI kernel applied cleanly, and I just hadn't reviewed
the surrounding context properly before sending out.

I cannot say immediately what the right answer is, I'll have to do some
research first: maybe not enter the block that sets thrashing true when
lock < 0, as you suggest, or maybe force lock < 0 to 0 and put_page()
afterwards, or... 

Hugh
