Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E777FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5FD20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5FD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeLCOIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:08:22 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:51244 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbeLCOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:08:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,310,1539640800"; 
   d="scan'208";a="358492938"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 15:07:11 +0100
Date:   Mon, 3 Dec 2018 15:07:07 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        mingo@redhat.com, will.deacon@arm.com
Subject: Re: [PATCH] locktorture: Fix assignment of boolean variables
In-Reply-To: <20181203105045.GD11573@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.20.1812031506200.23279@hadrien>
References: <20181201083149.36972-1-wen.yang99@zte.com.cn> <20181201203700.GW4170@linux.ibm.com> <20181203083500.GH11614@hirez.programming.kicks-ass.net> <20181203084605.GC11650@hirez.programming.kicks-ass.net> <alpine.DEB.2.20.1812031016330.7942@hadrien>
 <20181203105045.GD11573@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Dec 2018, Peter Zijlstra wrote:

> On Mon, Dec 03, 2018 at 10:20:42AM +0100, Julia Lawall wrote:
> > Personally, I would prefer that assignments involving boolean variables
> > use true or false.  It seems more readable.  Potentially better for tools
> > as well.
>
> Then those tools are broken per the C spec.
>
> > But if the community really prefers 0 and 1, then the test can
> > be deleted.
>
> The C language spec, specifies _Bool as an integer type wide enough to
> at least store 0 and 1.
>
> IOW, 0 and 1 are perfectly valid valus to assign to a _Bool.
>
> And fundamentally that has to be so. That's how computers work. 0 is
> false, 1 is true.
>
> The kernel is not the place to try and abstract such stuff, C is our
> portable assembler. We muck with hardware, we'd better know how the heck
> it works.

How about it it were suggested only in files that already use true and
false somewhere?

julia
