Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E30C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E022121473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OcAIFZP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E022121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeHVMKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:10:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48378 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeHVMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uv6gyphl0jkOlP3BKc2BS4MJWnnzqfgePwULtmXVxVY=; b=OcAIFZP7vn6HwUuHbVUr2Y1BB
        T0s4auj3yc6Jt6Sbq7wZLF8FVfEm5mteEZQ+0NG6hlA4y7mx37GsF2Xmvt+tD6k23pJQOIwJSa0OL
        NOCAZwjrX/zpam6zhyxGOEq3/5LKIEy81H7Tk+hWDDa6r9SHFryz0iiEVXfX5gBw90VAloPlI1Paj
        f0sf7GyhFYdhnkSwfGL4eAfnzQBKDAApdMd43TnbPSqh3EdNCa0tKDK5Oo6305M59Wnl4bVOGu+bS
        wD6u/pzJGSX1mot9cR4YIboDEWVFEu705j8UBY8YKKyjsOwxHLSc7ChidPQi9GjNGSM+Fnth3JRHB
        VwNGsZltA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsOm9-00078T-5P; Wed, 22 Aug 2018 08:46:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0CAF2025D75D; Wed, 22 Aug 2018 10:45:58 +0200 (CEST)
Date:   Wed, 22 Aug 2018 10:45:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180822084558.GS24124@hirez.programming.kicks-ass.net>
References: <20180821211528.8575-1-eduval@amazon.com>
 <20180821220937.GV12066@tassilo.jf.intel.com>
 <20180821230522.GA10816@u40b0340c692b58f6553c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821230522.GA10816@u40b0340c692b58f6553c.ant.amazon.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:05:22PM -0700, Eduardo Valentin wrote:
> On Tue, Aug 21, 2018 at 03:09:37PM -0700, Andi Kleen wrote:
> > On Tue, Aug 21, 2018 at 02:15:28PM -0700, Eduardo Valentin wrote:

> > > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.

> > Maybe it is confusing (why exactly?), but it doesn't seem to me that your
> > new message is any better.
> 
> Yeah, the part that says "unsupported CPU" is the confusing part,
> I get people thinking that the specific reported CPU model is not
> supported by the kernel :-)

It is prefixed by: "Performance Events:", what is the problem?
