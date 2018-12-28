Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEEEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626B320879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="c5KdxtdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EE1E1t7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbeL1KuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:50:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50117 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731657AbeL1KuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:50:12 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 23521231E0;
        Fri, 28 Dec 2018 05:50:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 28 Dec 2018 05:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=lVUmVluNZd1NM2JBPvZpUPEHJfv
        t7kD4SJciWQCcuTc=; b=c5KdxtdADM7yAaP8FT/fgcHueR3GK3uiD8Jbov+Eqwx
        mypAICO+me55UXbQGx4iNKaL2SfkMVEj0erAWod7Bhq6fV9cpNDWMRFa2gxYgtjj
        9dCTh9J4ugja+2HAhkmv/LEWPGe+2+bRIRUNR3Jy4pOSrEVFSE2gjRJ3wTfuHqA7
        49gWotVqDO12edAiQeo5U54QV7n/a+lJ5xj3iD8x6ULKqiaq5yaqhqtmAW7kb6aO
        lugOZp4cg7g6BIBFfTOdStwlTMmuRe3MZkpfDd3vuIwqRBEUOKRon4cM//vE0ozW
        hgGLFRj/6JBYF/Lf2XOGS/PGWpEBHXreN2zb15hwUXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lVUmVl
        uNZd1NM2JBPvZpUPEHJfvt7kD4SJciWQCcuTc=; b=EE1E1t7d4Qok2zLXiFeaEv
        Q8TvSMwdjgUiEDn3I9oTqXDeAB27p/PJJpyU/vIZoucB5K0iwxnanko8AsPYaRq4
        VSGLXjAJzmZfq8a0hWZelRbf3+9qCg2A0Ds1VTpbmFxPJwCR6IaGpqnrfe5NnRIY
        k2IQnAiNvLfNHjy9mzkBgI9sU/w2WFlqIGyz80TjrWKX0NtVHhnMzWn1knSOmglo
        wL/BclIGmuP73P7OawJPpNyI0Gs3l5/zpYzZ/rnPO0MkXilCcwyBKhSh5RG9ZLQY
        scRTbTYRtuFpR3a8kx/Ikx2XDjFJxL4HacQqcrMGNd0IH3g6mwIq3pyCGX1DfR5A
        ==
X-ME-Sender: <xms:4v8lXIGLe-3Uj8xvH0JPIxf1ktpaH7O69GIdGPojYUiyznUepexaew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrtdehgddvudculddtuddrgedtkedrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:4v8lXCC6iyRGHg13vsRL3FDtm0OZcgD-yWN_v6XO6u7M9g6uo_-ECA>
    <xmx:4v8lXAXU67WKhx0OEv8wLceuJDr5bXSjqMcDZlL52uDVSv-ktWt__g>
    <xmx:4v8lXOojz3Jt-fsR09ZUls-Zax1gFkQ7RvHAVtPFlxY1nrB7CLethw>
    <xmx:4_8lXEBAYksLGD9IAXYZlbfoRF05Ak-_-6eOQ74Gwg-fVR1C5wI57Q>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7BB97E4597;
        Fri, 28 Dec 2018 05:50:09 -0500 (EST)
Date:   Fri, 28 Dec 2018 11:50:08 +0100
From:   Greg KH <greg@kroah.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Message-ID: <20181228105008.GB15967@kroah.com>
References: <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102073009.GP23921@dhcp22.suse.cz>
 <20181102154844.GA17619@tower.DHCP.thefacebook.com>
 <20181102161314.GF28039@dhcp22.suse.cz>
 <20181102162237.GB17619@tower.DHCP.thefacebook.com>
 <20181102165147.GG28039@dhcp22.suse.cz>
 <20181102172547.GA19042@tower.DHCP.thefacebook.com>
 <20181102174823.GI28039@dhcp22.suse.cz>
 <20181102193827.GA18024@castle.DHCP.thefacebook.com>
 <20181105092053.GC4361@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105092053.GC4361@dhcp22.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:21:23AM +0100, Michal Hocko wrote:
> On Fri 02-11-18 19:38:35, Roman Gushchin wrote:
> > On Fri, Nov 02, 2018 at 06:48:23PM +0100, Michal Hocko wrote:
> > > On Fri 02-11-18 17:25:58, Roman Gushchin wrote:
> > > > On Fri, Nov 02, 2018 at 05:51:47PM +0100, Michal Hocko wrote:
> > > > > On Fri 02-11-18 16:22:41, Roman Gushchin wrote:
> > > [...]
> > > > > > 2) We do forget to scan the last page in the LRU list. So if we ended up with
> > > > > > 1-page long LRU, it can stay there basically forever.
> > > > > 
> > > > > Why 
> > > > > 		/*
> > > > > 		 * If the cgroup's already been deleted, make sure to
> > > > > 		 * scrape out the remaining cache.
> > > > > 		 */
> > > > > 		if (!scan && !mem_cgroup_online(memcg))
> > > > > 			scan = min(size, SWAP_CLUSTER_MAX);
> > > > > 
> > > > > in get_scan_count doesn't work for that case?
> > > > 
> > > > No, it doesn't. Let's look at the whole picture:
> > > > 
> > > > 		size = lruvec_lru_size(lruvec, lru, sc->reclaim_idx);
> > > > 		scan = size >> sc->priority;
> > > > 		/*
> > > > 		 * If the cgroup's already been deleted, make sure to
> > > > 		 * scrape out the remaining cache.
> > > > 		 */
> > > > 		if (!scan && !mem_cgroup_online(memcg))
> > > > 			scan = min(size, SWAP_CLUSTER_MAX);
> > > > 
> > > > If size == 1, scan == 0 => scan = min(1, 32) == 1.
> > > > And after proportional adjustment we'll have 0.
> > > 
> > > My friday brain hurst when looking at this but if it doesn't work as
> > > advertized then it should be fixed. I do not see any of your patches to
> > > touch this logic so how come it would work after them applied?
> > 
> > This part works as expected. But the following
> > 	scan = div64_u64(scan * fraction[file], denominator);
> > reliable turns 1 page to scan to 0 pages to scan.
> 
> OK, 68600f623d69 ("mm: don't miss the last page because of round-off
> error") sounds like a good and safe stable backport material.

Thanks for this, now queued up.

greg k-h
