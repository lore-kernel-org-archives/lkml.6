Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E95C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8BF222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394137AbfBNQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:27:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387824AbfBNQ1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:27:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AACCAF56;
        Thu, 14 Feb 2019 16:27:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C54271E0900; Thu, 14 Feb 2019 17:27:41 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:27:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214162741.GA23000@quack2.suse.cz>
References: <20190212183454.26062-1-willy@infradead.org>
 <20190213144102.GA18351@quack2.suse.cz>
 <20190213201715.GU12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213201715.GU12668@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 12:17:15, Matthew Wilcox wrote:
> > > -		pages[ret] = page;
> > > +		pages[ret] = find_subpage(page, xas.xa_index);
> > >  		if (++ret == nr_pages) {
> > >  			*start = page->index + 1;
> > >  			goto out;
> > >  		}
> > 
> > So this subtly changes the behavior because now we will be returning in
> > '*start' a different index. So you should rather use 'pages[ret]->index'
> > instead.
> 
> You're right, I made a mistake there.  However, seeing this:
> https://lore.kernel.org/lkml/20190110030838.84446-1-yuzhao@google.com/
> 
> makes me think that I should be using xa_index + 1 there.

Yeah, you're right. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
