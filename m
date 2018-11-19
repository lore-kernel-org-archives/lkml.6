Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ABEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0898420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYtZAiDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0898420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbeKTG7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:59:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43771 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbeKTG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:59:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so6071230pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 12:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4VwhEQdIzWoKm8DG6qtHibOe+ZGbPSDLqSmQgH3C0pk=;
        b=bYtZAiDOQDc3xDCGzox9W4zcbHNCtx4x/bmgoEhc3Q7DD1mo8UhDPyf7hXhAuJB8XV
         hmtWHfx/nd7yAtNcaW7rQDVbn+lThtgCe7EoZk4+JisFNmNJFH65+7nqhA1GgRQMqyWL
         bFMWUTEN1zXQUq+GY4n6c+AEPv7VixAqwXTGh0KQhd9DWEwRFPwu7p/PtTtY+OdyNffK
         YUO43IVmCXzYJo3Fl306CJW3TbYww/rt56SCagslqcLSR9VH14xAkag7xrchbg5maOPf
         v+OU77ql1m75NsfAa41x0ZPaVcMOlaNflyJC0+bTljYMx2uZaKtHCi9qdBFPORgWy1ye
         pUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4VwhEQdIzWoKm8DG6qtHibOe+ZGbPSDLqSmQgH3C0pk=;
        b=H0uwsiyxwNSDYCwWbMFH7q4Ok93hEMG9wbcCvZLCXQi/i4n0dk6ki9KTHrRrqDaaxy
         vIBRW7NLfBn47FlvWg/UrBacLqKf8APHEEm8uOdLh1x0ejbT70a2pAqalhKtwsKD7rHs
         grc0zGKkJYZvUdq1nA+3ZBntDyRHkZTbVNUPek3LGj6k6Aevmo3ECozu5+S+/qCpmJTu
         vKnd4VhIaj71JAM4Xy85tQCjqk4ReA1Q/jTUP2ocrW3SghPe+d5US4Be8WcFvNVDbfZS
         jaUmZvVJZVcwpGEm9ke5P2zWaoNIjwKmvmAkZ6C+0YTGS5le2sKXgMqZiMq3R/WV8Sy0
         3ZXw==
X-Gm-Message-State: AGRZ1gKGf3Ev7FRUo1gR/7KRGcjFDb0C9uvnWFrNNxVs8uQlDD5G8YZY
        YobZ89g0KZltqkst61BmzbFVQO1LVEA=
X-Google-Smtp-Source: AJdET5fqzXManRba/k9rDP+kZcNFZfR9Voj+tI/VEMd9rVaH0Zs4DsWDLYqKt6kzwnA5hiMPhWivaQ==
X-Received: by 2002:a62:4886:: with SMTP id q6mr20358624pfi.182.1542659658341;
        Mon, 19 Nov 2018 12:34:18 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id 186sm41772986pga.36.2018.11.19.12.34.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 12:34:17 -0800 (PST)
Date:   Mon, 19 Nov 2018 12:34:09 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@kernel.org>
cc:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, pifang@redhat.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Memory hotplug softlock issue
In-Reply-To: <20181119173312.GV22247@dhcp22.suse.cz>
Message-ID: <alpine.LSU.2.11.1811191215290.15640@eggly.anvils>
References: <20181115131211.GP2653@MiWiFi-R3L-srv> <20181115131927.GT23831@dhcp22.suse.cz> <20181115133840.GR2653@MiWiFi-R3L-srv> <20181115143204.GV23831@dhcp22.suse.cz> <20181116012433.GU2653@MiWiFi-R3L-srv> <20181116091409.GD14706@dhcp22.suse.cz>
 <20181119105202.GE18471@MiWiFi-R3L-srv> <20181119124033.GJ22247@dhcp22.suse.cz> <20181119125121.GK22247@dhcp22.suse.cz> <20181119141016.GO22247@dhcp22.suse.cz> <20181119173312.GV22247@dhcp22.suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Michal Hocko wrote:
> On Mon 19-11-18 15:10:16, Michal Hocko wrote:
> [...]
> > In other words. Why cannot we do the following?
> 
> Baoquan, this is certainly not the right fix but I would be really
> curious whether it makes the problem go away.
> 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index f7e4bfdc13b7..7ccab29bcf9a 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -324,19 +324,9 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> >  		goto out;
> >  
> >  	page = migration_entry_to_page(entry);
> > -
> > -	/*
> > -	 * Once page cache replacement of page migration started, page_count
> > -	 * *must* be zero. And, we don't want to call wait_on_page_locked()
> > -	 * against a page without get_page().
> > -	 * So, we use get_page_unless_zero(), here. Even failed, page fault
> > -	 * will occur again.
> > -	 */
> > -	if (!get_page_unless_zero(page))
> > -		goto out;
> >  	pte_unmap_unlock(ptep, ptl);
> > -	wait_on_page_locked(page);
> > -	put_page(page);
> > +	page_lock(page);
> > +	page_unlock(page);
> >  	return;
> >  out:
> >  	pte_unmap_unlock(ptep, ptl);

Thanks for Cc'ing me. I did mention precisely this issue two or three
times at LSF/MM this year, and claimed then that I would post the fix.

I'm glad that I delayed, what I had then (migration_waitqueue instead
of using page_waitqueue) was not wrong, but what I've been using the
last couple of months is rather better (and can be put to use to solve
similar problems in collapsing pages on huge tmpfs. but we don't need
to get into that at this time): put_and_wait_on_page_locked().

What I have not yet done is verify it on latest kernel, and research
the interested Cc list (Linus and Tim Chen come immediately to mind),
and write the commit comment. I have some testing to do on the latest
kernel today, so I'll throw put_and_wait_on_page_locked() in too,
and post tomorrow I hope.

Hugh
