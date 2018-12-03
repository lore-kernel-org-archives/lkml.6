Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF555C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B327C20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lClfeSoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B327C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeLCKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:31:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32988 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLCKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CexawC3nyzeCnZ2zl9Hy5QxR2DmGyi6qNmeB9w3ERnw=; b=lClfeSoyPB21V4WHBiBCsa1JY
        EjWg3smFWPdXyDb9RMHjuIuVKQLxdAZClBsGtwmyxUycrOu8zgym5HbNJadsUQMewpXMJITPpJRHW
        ZNiaAYtEhCptKG/MgpdGPDtImBXRsF0HUjpdIjYbsRsWUAoQFdku4FvYW8xaz5wUljiWiMInz/xDX
        g3jRsZf5iD6fH4fK2vSnoVUq6ITdrybqjfjl+1sH+OcMTEB0CvdJMpzS+KdNoFBjtoGDHInkQR2Xn
        xkK41UNOkd7DtzkrTlj6ZFQaGEENkJPLvvkDyQ0yiZLTXj8ZfWBXDFv8Vs4tMHEROzGgAVGESarrV
        QjzTwTruw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTlVO-0006ly-9F; Mon, 03 Dec 2018 10:31:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D3462029F87F; Mon,  3 Dec 2018 11:31:07 +0100 (CET)
Date:   Mon, 3 Dec 2018 11:31:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] tools: Fix diverse typos
Message-ID: <20181203103107.GC11573@hirez.programming.kicks-ass.net>
References: <20181203102200.GA104797@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203102200.GA104797@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:22:00AM +0100, Ingo Molnar wrote:
> Go over the tools/ files that are maintained in Arnaldo's tree and
> fix common typos: half of them were in comments, the other half
> in JSON files.
> 
> ( Care should be taken not to re-import these typos in the future,
>   if the JSON files get updated by the vendor without fixing the typos. )

>  .../perf/pmu-events/arch/x86/broadwell/cache.json  |  4 +--
>  .../pmu-events/arch/x86/broadwell/pipeline.json    |  2 +-
>  .../pmu-events/arch/x86/broadwellde/cache.json     |  4 +--
>  .../pmu-events/arch/x86/broadwellde/pipeline.json  |  2 +-
>  .../perf/pmu-events/arch/x86/broadwellx/cache.json |  4 +--
>  .../pmu-events/arch/x86/broadwellx/pipeline.json   |  2 +-
>  tools/perf/pmu-events/arch/x86/jaketown/cache.json |  4 +--
>  .../pmu-events/arch/x86/jaketown/pipeline.json     |  2 +-
>  .../pmu-events/arch/x86/knightslanding/cache.json  | 30 +++++++++++-----------
>  .../pmu-events/arch/x86/sandybridge/cache.json     |  4 +--
>  .../pmu-events/arch/x86/sandybridge/pipeline.json  |  2 +-
>  .../pmu-events/arch/x86/skylakex/uncore-other.json | 12 ++++-----

Yeah, so I think those are generated from somewhere, fixing them here
isn't going to nessecarily help much.

Andi, how do we get the source for that fixed?
