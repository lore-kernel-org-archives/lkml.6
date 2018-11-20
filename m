Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E59A208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQ22EFOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E59A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeKTL41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:56:27 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35121 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:56:27 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so1148548itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 17:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V3m6gtQ1iRlWcRSMq0w2qWBRsEA6IUH9wDb9KBQbc1w=;
        b=RQ22EFOGMlzy4jAQwMHeVgHN7RcelmsF4D/OEYzl1jUdfCnv/tHR60j/BG//zRs98L
         pd1d+KQNo0EiNOINb1Ilr5Euvl0AQTVgjMu8ERtKiWyVDIYkl/1KWRpbucUnuS10OeH0
         lTHSwR5vWBO2LhvbjarXqFcliL8Yp7elGW9jccCK/TEhCPs2ihu47N6GgwQCHhgaZ7dU
         gdOzR8WcmCs9lhCFAQZIWgZWikJNmf1c1SAKjuO0TI3ntaoAzTnCkHfDfOH+DnBDr+hy
         Fb+2wtvVpEGhCEWTKfQ9iOCwELpsdCvTIcGyklVwIm8H4hSIy5wDVnx09/4IJm5RkueQ
         3Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V3m6gtQ1iRlWcRSMq0w2qWBRsEA6IUH9wDb9KBQbc1w=;
        b=dRfr8/pqmCVOcxz5OUxfD8wwLh26SoqeH0e7bdKNhMHp0vOQgh3OQ2ULt1vg5lClmP
         8i8TSua/ZBv5Lbtri0jqb4jSINQbEKNPJzjtOK8rllARf2sVJdY78O4x/5IMPv0TAQrV
         DlyJ6UM4ftRbpDVzP+6kSH5FQAnMOcuigJoN52sFXyBekJ1fVPRwp5uwpwfCKw/aU6q8
         IX0YQeQPIfguvp/a/2iVlfPuY3Ms9O//jRg8RnFBSWQy4s55+W19XmBfunNH/ZOIwQPl
         AeTScnQ3pRNhQnFeRn4mYBCt89HWpr/NjeN8+Ywz4uz6OmPi49b5NmoIHfhP7E5XMMvj
         1KPg==
X-Gm-Message-State: AA+aEWYQpJln1uw3LlAOu+IxTEvgGMpzJreFMiwwuIk2GSa4uQVmlN8t
        ye/8vNQTY5YL7FwCT/vBnIu11g==
X-Google-Smtp-Source: AFSGD/Vd1Buge1t5VzBEyIJqckAoza8PM0GF/rsFPH080gDstdFlOlDGh45kNTBW1qmskFqvE+yr5w==
X-Received: by 2002:a24:55d4:: with SMTP id e203mr484324itb.36.1542677394424;
        Mon, 19 Nov 2018 17:29:54 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id p10-v6sm13209106ioh.20.2018.11.19.17.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 17:29:53 -0800 (PST)
Date:   Mon, 19 Nov 2018 18:29:50 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix swap offset when replacing shmem page
Message-ID: <20181120012950.GA94981@google.com>
References: <20181119004719.156411-1-yuzhao@google.com>
 <20181119010924.177177-1-yuzhao@google.com>
 <alpine.LSU.2.11.1811191343280.17359@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1811191343280.17359@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:11:27PM -0800, Hugh Dickins wrote:
> On Sun, 18 Nov 2018, Yu Zhao wrote:
> 
> > We used to have a single swap address space with swp_entry_t.val
> > as its radix tree index. This is not the case anymore. Now Each
> > swp_type() has its own address space and should use swp_offset()
> > as radix tree index.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> This fix is a great find, thank you! But completely mis-described!

Yes, now I remember making swap offset as key was done long after per
swap device radix tree.

> And could you do a smaller patch, keeping swap_index, that can go to
> stable without getting into trouble with the recent xarrifications?
> 
> Fixes: bde05d1ccd51 ("shmem: replace page if mapping excludes its zone")
> Cc: stable@vger.kernel.org # 3.5+
> 
> Seems shmem_replace_page() has been wrong since the day I wrote it:
> good enough to work on swap "type" 0, which is all most people ever use
> (especially those few who need shmem_replace_page() at all), but broken
> once there are any non-0 swp_type bits set in the higher order bits.

But you did get it right when you wrote the function, which was before
the per swap device radix tree. so
Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
looks good?

> > ---
> >  mm/shmem.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index d44991ea5ed4..685faa3e0191 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1509,11 +1509,13 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
> >  {
> >  	struct page *oldpage, *newpage;
> >  	struct address_space *swap_mapping;
> > -	pgoff_t swap_index;
> > +	swp_entry_t entry;
> 
> Please keep swap_index as well as adding entry.

Ack.

> >  	int error;
> >  
> > +	VM_BUG_ON(!PageSwapCache(*pagep));
> > +
> 
> I'd prefer you to drop that, it has no bearing on this patch;
> we used to have it, along with lots of other VM_BUG_ONs in here,
> but they outlived their usefulness, and don't need reintroducing -
> they didn't help at all to prevent the actual bug you've found.
> 
> >  	oldpage = *pagep;
> > -	swap_index = page_private(oldpage);
> > +	entry.val = page_private(oldpage);
> 
> entry.val = page_private(oldpage);
> swap_index = swp_offset(entry);
> 
> >  	swap_mapping = page_mapping(oldpage);
> >  
> >  	/*
> > @@ -1532,7 +1534,7 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
> >  	__SetPageLocked(newpage);
> >  	__SetPageSwapBacked(newpage);
> >  	SetPageUptodate(newpage);
> > -	set_page_private(newpage, swap_index);
> > +	set_page_private(newpage, entry.val);
> 
> Yes.
> 
> >  	SetPageSwapCache(newpage);
> >  
> >  	/*
> > @@ -1540,7 +1542,8 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
> >  	 * a nice clean interface for us to replace oldpage by newpage there.
> >  	 */
> >  	xa_lock_irq(&swap_mapping->i_pages);
> > -	error = shmem_replace_entry(swap_mapping, swap_index, oldpage, newpage);
> > +	error = shmem_replace_entry(swap_mapping, swp_offset(entry),
> > +				    oldpage, newpage);
> 
> I'd prefer to omit that hunk, to avoid the xa_lock_irq() in the context;
> the patch is just as good if we keep the swap_index variable.
> 
> >  	if (!error) {
> >  		__inc_node_page_state(newpage, NR_FILE_PAGES);
> >  		__dec_node_page_state(oldpage, NR_FILE_PAGES);
> > -- 
> > 2.19.1.1215.g8438c0b245-goog
> 
> Thanks,
> Hugh
