Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E642DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EC3206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IUckfwCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBUAko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:40:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUAko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bbwz8tRewBIlDfjLCBmDnmJnVrvUjyp2e8OuwZFi5dM=; b=IUckfwCXmEhFa00BWQihzN3eO
        eSDiJWP8hQBdlRp3UaitSDjd5ATsyOcC5TmG33DtgTbaIt9aruTnqmgHMm/yZi41s7Tlssx583cJZ
        oUSSh/sXUgMR7oePFDlNvKHGJeT0SPbgekujj1/3HMLCAFtcA5/L6Qe7EAMFOIc+h7fEecbVrwdad
        8tHKhTooBy7v2CFdSknlu1y/chjdwy2vNdCykUO0PmW5pwat4K9iDfGC98uAR62ZPl6kbtewjonAn
        jr34Jil9aDOKzVqmKNA9/P09h4EXGIEiq3PjVyWBGqJy+vluTfhNUFIL5Y5bTXfmIEZ98j/INjSh5
        ykuNAA1Cg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwcPr-0004Sw-7M; Thu, 21 Feb 2019 00:40:43 +0000
Date:   Wed, 20 Feb 2019 16:40:41 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the drivers-x86 tree
Message-ID: <20190221004041.GA5838@wrath>
References: <20190207095703.564e76b2@canb.auug.org.au>
 <38152c55-c2c1-c89f-2751-0ef0d40fcba9@linux.intel.com>
 <CAHp75Vf6gs1342N16MZHvPmiiv3+xJyMyyJQK677KPZbb_7Vrg@mail.gmail.com>
 <e0c40627-f1a2-254f-14b0-b9df0d62dd34@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c40627-f1a2-254f-14b0-b9df0d62dd34@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:45:56PM +0530, Bhardwaj, Rajneesh wrote:
> 
> On 07-Feb-19 9:25 PM, Andy Shevchenko wrote:
> > On Thu, Feb 7, 2019 at 4:06 AM Bhardwaj, Rajneesh
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> > > On 07-Feb-19 4:27 AM, Stephen Rothwell wrote:
> > > 
> > > Hi all,
> > > 
> > > In commit
> > > 
> > >    4284dc008f43 ("platform/x86: intel_pmc_core: Fix file permissions for ltr_show")
> > > 
> > > Fixes tag
> > > 
> > >    Fixes: 63cde0c16c67 ("platform/x86: intel_pmc_core: Show Latency Tolerance info")
> > > 
> > > has these problem(s):
> > > 
> > >    - Target SHA1 does not exist
> > > 
> > > Did you mean:
> > > 
> > >    2eb150558bb7 ("platform/x86: intel_pmc_core: Show Latency Tolerance info")
> > > 
> > > Yes, upstream commit is 2eb150558bb79ee01c39b64c2868216c0be2904f. For some reason when i do git show on my repo with both these SHA1 i see the same patch.
> > > 
> > > I will fix this in next version.
> > Hmm... this came to our published branch, i.e. for-next, would it be
> > better to update it via rebasing?
> > 
> > Darren, what do you think?
> 
> Hi Andy, I have corrected this in v2 anyway and i sent to upstream today,
> just in case you prefer it over rebasing.
> 
> https://patchwork.kernel.org/patch/10810123/
> 

While we try hard not to rebase, if the choice is to rebase for-next or send a
bad commit to upstream, I will opt for the rebase.

Andy, I would suggest doing the rebase.

-- 
Darren Hart
VMware Open Source Technology Center
