Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2390121473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2390121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLCJVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:21:23 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47151
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbeLCJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:21:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,310,1539640800"; 
   d="scan'208";a="287622068"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 10:20:46 +0100
Date:   Mon, 3 Dec 2018 10:20:42 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        mingo@redhat.com, will.deacon@arm.com, Julia.Lawall@lip6.fr
Subject: Re: [PATCH] locktorture: Fix assignment of boolean variables
In-Reply-To: <20181203084605.GC11650@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.20.1812031016330.7942@hadrien>
References: <20181201083149.36972-1-wen.yang99@zte.com.cn> <20181201203700.GW4170@linux.ibm.com> <20181203083500.GH11614@hirez.programming.kicks-ass.net> <20181203084605.GC11650@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Dec 2018, Peter Zijlstra wrote:

> On Mon, Dec 03, 2018 at 09:35:00AM +0100, Peter Zijlstra wrote:
> > On Sat, Dec 01, 2018 at 12:37:01PM -0800, Paul E. McKenney wrote:
> > > On Sat, Dec 01, 2018 at 04:31:49PM +0800, Wen Yang wrote:
> > > > Fix the following warnings reported by coccinelle:
> > > >
> > > > kernel/locking/locktorture.c:703:6-10: WARNING: Assignment of bool to 0/1
>
> Not to mention that WARN is gramatically incorrect. We're not assigning
> 'bool' to 0/1 but the other way around.
>
> What crap..
>
> > So I strongly disagree with this. Anybody that has trouble with 0/1 vs
> > false/true needs to stay the heck away from C.
> >
> > I would suggest we delete that stupid coccinelle scripts that generates
> > these pointless warns.

Personally, I would prefer that assignments involving boolean variables
use true or false.  It seems more readable.  Potentially better for tools
as well.  But if the community really prefers 0 and 1, then the test can
be deleted.

julia
