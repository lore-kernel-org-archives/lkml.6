Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2491876-1518088979-2-7371466994842314243
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518088978; b=gTF5CauwEy1/eBsqyvCw33Nx+F7C7bxVCExm+GPXXlPea/t
    D5h9WtIBc9Q5K4Jx8MBEyQViKDIzDKmauWFn8NvVCP+KNbgdN74z2hPsrfdS2UiY
    lakK5+Pw0kpINklnw416L+0wcNmThUyoxUOEQaFzVC/5KkMeP6TDfNtPLjElpIri
    9zek8ZB+27pmc9OFrAElar5HnV+UV1zSJD4cYXC9jXPtsKDwsVNzq/yVmto08HOZ
    Ju8R7vsEBfI/qvW2+zMjQukqF8t43Ah2h1QPnREdIF58HUGyQOMuEXmR8CozbPrG
    ADXt/VnMetS88Ok0EcS5kGZIhsMG3/OwLMzz8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518088978; bh=NqZ1cEB31YPtMRhcUHEUfULSK9
    U2CLgvg2oNHnsG2yo=; b=EQpaIhxHtzxVNJJgjfd22FFygfxuh4t2bm3/aFeZ4T
    iH9G8oFtRl1eNC4nRgNDxBKS53qQsSgHJGWbwXT/klXQXgZjG7pZyQ//QHd1WA5a
    71SAATrq0afGlF/SmEUwklqeWGsfiAVJ55EXKa38G+ET/JjNo/pSbYO32Pisebe/
    3pyup8iIq1u2PtucS0Ac+DPgGtfET1J+PBT+NrTa6PyY1QxF5ZNST9rV4Won5kGM
    stI72wO/aEcM/XyKrEAwAyLyNuny8Bu9MgDvXamtDNSa386DI3psHCtBVVzyj17M
    A8zSV+IR2FPXxwlovF6rkoou/I0HmYO4a0ifpnQ0Am7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bZa2tiEw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SPWWtG4Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bZa2tiEw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SPWWtG4Z;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeBHLW5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 06:22:57 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37904 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHLW4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 06:22:56 -0500
X-Google-Smtp-Source: AH8x226IPqh4X94nS4HfsveYUMm8drLhrIkwuaBEINpwkEHzjf4o++PxFx8GX75UWSnsH5p5hwbckg==
Date: Thu, 8 Feb 2018 20:22:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shaohua Li <shli@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH -mm -v2] mm, swap, frontswap: Fix THP swap if frontswap
 enabled
Message-ID: <20180208112251.GA710@jagdpanzerIV>
References: <20180207070035.30302-1-ying.huang@intel.com>
 <20180207130534.259cd71a595c6275b2da38d3@linux-foundation.org>
 <20180208013635.GA596@jagdpanzerIV>
 <20180208102521.GB74192@eng-minchan1.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208102521.GB74192@eng-minchan1.roam.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (02/08/18 02:25), Minchan Kim wrote:
[..]
> > >  	if (PageTransHuge(page)) {
> > > -		if (IS_ENABLED(CONFIG_THP_SWAP))
> > > -			get_swap_pages(1, true, &entry);
> > > +		/* Frontswap doesn't support THP */
> > > +		if (!frontswap_enabled()) {
> > > +			if (IS_ENABLED(CONFIG_THP_SWAP))
> > > +				get_swap_pages(1, true, &entry);
> > > +		}
> > >  		return entry;
> > >  	}
> > 
> > I have proposed exactly the same thing [1], Minchan commented that
> > it would introduce frontswap dependency to swap_slots.c [2]. Which
> > is true, but I'd still probably prefer to handle it all in
> > get_swap_page. Minchan, any objections?
> 
> I didn't want to spread out frontswap stuff unless it has good value
> because most of frontswap functions are located in mm/swapfile.c
> at this moment.

Sure, your points are perfectly valid. At the same time it might be the
case that we already kind of expose that THP dependency thing to vmscan.
The whole

	if (!add_to_swap()) {
		if (!PageTransHuge(page))
			goto activate_locked;

		split_huge_page_to_list(page);
		add_to_swap(page);
	}

looks a bit suspicious - if add_to_swap() fails and the page is THP then
split it and add_to_swap() again.

	-ss
