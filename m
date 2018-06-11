Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +nvVLFOKHlteVgAAmS7hNA
	; Mon, 11 Jun 2018 15:30:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2ECA4607E7; Mon, 11 Jun 2018 15:30:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1rr+eii"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B7B0560791;
	Mon, 11 Jun 2018 15:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7B0560791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeFKPax (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:30:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbeFKPaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=65q1rIUoU8C8TS301eoTVy0KhNZFqxeRF/+6lOxBotw=; b=P1rr+eii0EdcKpVtsCYbgjNE8
        BKoQwWlZ630TJ/SxeYIodfyX5u5MZ8UE6B30z4oMPy69hxliXzsawPPCttREryCBvXLTqtEXATt6u
        m0yiZ+pbX4im3nxE5nrRPhccnvKf2as1jnM26cMvB4Ml1g9kfzcEdTyYHVe3aOQDNDYbiHDy5g4vD
        2+RA1PJBa53wH20Xy4J7fseqkL8T86N9hMDOpeY3CwxL9EMIxQ6NgmC0ee09gdafLsDgNQzKx0wA1
        O0eKJf3BF/CtgXVzFPQct9gEUGmeP0BD6DRQOyz5MHhTr5AL34SRFl9Hhv7L3cP6qhyfc7dAQUe2j
        6bM3Agcvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSOmK-0005F7-Jq; Mon, 11 Jun 2018 15:30:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E018F201EA7A1; Mon, 11 Jun 2018 17:30:42 +0200 (CEST)
Date: Mon, 11 Jun 2018 17:30:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, len.brown@intel.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        Diego Viola <diego.viola@gmail.com>
Subject: Re: Regression: x86/tsc: Fix mark_tsc_unstable()
Message-ID: <20180611153042.GI12235@hirez.programming.kicks-ass.net>
References: <01000163ef24c875-daa2c00e-611e-4383-99a6-c8c72ef04a14-000000@email.amazonses.com>
 <20180611141742.GP12198@hirez.programming.kicks-ass.net>
 <20180611143801.GH12235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611143801.GH12235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 04:38:01PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 11, 2018 at 04:17:42PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 11, 2018 at 01:59:15PM +0000, Jeremy Cline wrote:
> > > A user has bisected the problem to the v4.16 commit 1ab4ca7c59d4
> > > ("x86/tsc: Fix mark_tsc_unstable()"). According to the reporter,
> > > explicitly setting "tsc=" on the kernel command line causes the boot to
> > > always succeed. All the users have Thinkpad T500s or T400s (Core 2 Duos)
> > 
> > Weird. So Core2 typically triggers mark_tsc_unstable() in either
> > intel_idle or processor_idle. ISTR testing that when I did the patches.
> > 
> > When I make that mark_tsc_unstable() in the idle drivers unconditional
> > and boot my ivb with that, it doesn't want to fail. I've booted the
> > machine 5 consequctive times without issue.
> > 
> > Let me try and checkout -stable, maybe something's up with that.
> 
> Nope -stable seems to be working as well on the IVB (with modification).
> I just dug up my T500 and that's actually still running the test kernel.
> Let me try and build the -stable kernel for that.

4.16.8 works without issue on my T500 with a debian/ubuntu like distro
config.
