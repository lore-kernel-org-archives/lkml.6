Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F03C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5174222A8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BQFE2J2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfBLX5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:57:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55152 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbfBLX5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:57:47 -0500
Received: by mail-it1-f194.google.com with SMTP id p11so1230854itf.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 15:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QQqVRIzi2ZKQ1+x3//wGskAucMWO5ZOTt+7fEHwsmFU=;
        b=BQFE2J2GcTdoaR3dWyKYvqUhQ4t/A/HraworagwibSGxHKTkRD64ZPvTAUon4dHuoh
         bjlizUafHQYjZVulL0a9//I1yftb8NaJi5qd3ks4AMtLA2jByOvIwlepINm6q9YVD8og
         1UB7Ui4JFXUcniZmwHGeq/vueLJGWt6qpSqP1xklyDXbS6Y4U92TCwwKXxezi65RRXKg
         FqkRTJaS1yFJVDvXyvoA6RxmNm7c8UJdW7Bv+QVy5Qe0o7SOLkA9huuJ9nCuwku6EqO3
         tVL5V9F5Lj6u7SEkAaz0bFSCuNtJKITHzhC1n2hmxkewN3+0+iX4JILMeaRxLu9D9Lb3
         +uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQqVRIzi2ZKQ1+x3//wGskAucMWO5ZOTt+7fEHwsmFU=;
        b=PlJK7gqO+udiLHcQRSW/TrRs1iO+tcroXp4Da16nMISz5YXgXlgbdLeuGp8NS5+4Mo
         6y8XbZ3TDBWrz4Tc5CtUkqZylo1MPnNnmYo9Pa0Es+jOpHzEgWXoWj7ZyiP0c0JC/Jjn
         7h4GhSagZEvdUHIv+fahr7bOoLb+Fy8Ozt6SKraWqN3qPhrMnlztbdVG/zodTVA5BI7L
         PLhailHgNreGmJ8tJFtTwoLxfOovJMQR49jTyDrKHutmDzOltiGPEwhUb7hzn/YPFOjH
         yIozl5GGI23DIgGCrBEhphFD/y570SUXIhJfTa5D39OVUgdyJ+B3rxV6Hq/fFsa7v2sJ
         qi5w==
X-Gm-Message-State: AHQUAubNgOugqvg4o2cX9xO5Mzma06jMsUhN6iD0Wxbg8dJES93Iw7LE
        wfSmtheCcxjaC+nQ3H39Fm2afw==
X-Google-Smtp-Source: AHgI3IYYB7mTt5TQyA7LpgtC+IlB2ggbcp4h7TnHjxblVDJqs1Js4AK4B8ZLgV1oC5o+3EfHdklVXw==
X-Received: by 2002:a24:9b89:: with SMTP id o131mr706270itd.41.1550015866451;
        Tue, 12 Feb 2019 15:57:46 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id k26sm3462792iol.14.2019.02.12.15.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 15:57:45 -0800 (PST)
Date:   Tue, 12 Feb 2019 16:57:43 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: make find_get_pages_range() work for huge page
Message-ID: <20190212235743.GB95899@google.com>
References: <20190110030838.84446-1-yuzhao@google.com>
 <A7BE64E0-8F88-46AC-A330-E1AB23A50073@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7BE64E0-8F88-46AC-A330-E1AB23A50073@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:43:57AM -0700, William Kucharski wrote:
> 
> 
> > On Jan 9, 2019, at 8:08 PM, Yu Zhao <yuzhao@google.com> wrote:
> > 
> > find_get_pages_range() and find_get_pages_range_tag() already
> > correctly increment reference count on head when seeing compound
> > page, but they may still use page index from tail. Page index
> > from tail is always zero, so these functions don't work on huge
> > shmem. This hasn't been a problem because, AFAIK, nobody calls
> > these functions on (huge) shmem. Fix them anyway just in case.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> > mm/filemap.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 81adec8ee02c..cf5fd773314a 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1704,7 +1704,7 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
> > 
> > 		pages[ret] = page;
> > 		if (++ret == nr_pages) {
> > -			*start = page->index + 1;
> > +			*start = xas.xa_index + 1;
> > 			goto out;
> > 		}
> > 		continue;
> > @@ -1850,7 +1850,7 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
> > 
> > 		pages[ret] = page;
> > 		if (++ret == nr_pages) {
> > -			*index = page->index + 1;
> > +			*index = xas.xa_index + 1;
> > 			goto out;
> > 		}
> > 		continue;
> > -- 
> 
> While this works, it seems like this would be more readable for future maintainers were it to
> instead squirrel away the value for *start/*index when ret was zero on the first iteration through
> the loop.

I'm not sure how this could be more readable, and it sounds
independent from the problem the patch fixes.

> Though xa_index is designed to hold the first index of the entry, it seems inappropriate to have
> these routines deference elements of xas directly; I guess it depends on how opaque we want to keep
> xas and struct xa_state.

It seems to me it's pefectly fine to use fields of xas directly,
and it's being done this way throughout the file.

> Does anyone else have a feeling one way or the other? I could be persuaded either way.
