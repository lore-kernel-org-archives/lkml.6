Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03F1C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57422086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HUaXNF7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbfBMSd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:33:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBMSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2+DpYQ1RgGmMz3i+2Oak2qboDEh+xxduT0QJZ3VtomY=; b=HUaXNF7P0vNTbCRTBTt4MZvWi
        oaNnNwx1FlJT43/Jt+uZJOe+ATtf9fqO8yw5rN6azk1+k6CKAPLGk423nL+bQOmXXEFYuQvGojxhE
        e+PRZsoU+NagWzm51En666YIEo4Pk5qMW7Y47AzOHOVpdTi34TUSJaFxjkXsvPlyuuJR123i3KVc8
        +itdTS5Qza6pOBQcKCSwPPyXnhLXnnbHLDPaOpTq8EzPAdnnFcEVUiGgGkdSxNeK9RUTgaUrpEkt/
        0EHm4w6kYGEwCL+J7Dmw/jnERj+THqTC6t1AzE996p2bvPWVb0Pd842XXDmAo2fk+6WtsvTkgrizZ
        KiKVIj7/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzLR-0005jN-1w; Wed, 13 Feb 2019 18:33:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45EF0202CEF76; Wed, 13 Feb 2019 19:33:14 +0100 (CET)
Date:   Wed, 13 Feb 2019 19:33:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190213183314.GB32494@hirez.programming.kicks-ass.net>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:27:09AM -0800, Linus Torvalds wrote:
> Yeah, yeah, there's the SGI "SN" platform that apparently has a bug,
> so because of that platform problem maybe it needs the more complex
> "use a flag" model.  But even the complex model isn't _hugely_
> complex.
> 
> But we *could* first just do the mmiowb() unconditionally in the ia64
> unlocking code, and then see if anybody notices?
> 
> Tony, comments? Are there any SGI SN machines around any more?

I think the last time this came up, it was said that those people still
running Linux on Itanium were running old disto kernels, not upstream.

So yeah, we could probably do whatever and nobody would ever notice,
except maybe Al, who is rumoured to still have an ia64 :-)
