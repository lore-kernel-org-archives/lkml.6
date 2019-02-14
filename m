Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651EDC10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3391320835
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G6hNv/iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392806AbfBNK20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:28:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54098 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBNK20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zLuFSdW+UO5nFqX/uI/BxHZUhCEVOW/ZxSRSMf803YA=; b=G6hNv/iz31k6CxW5vusw4X8O9
        hOa0g7gMM4ZNXwH2sZC4MU7X9wkwbcK/CAmaD9PifD2i3M5DyYjEToZc9MW/NkiHBCX61FxGDYqcU
        DJyEknAkX/WomN8w7Vy27QNx/8o8W+I2yaEe2x0v4OKkm+n7CcAMn9MEn+pM9xXXezhxv8HxqemvL
        SQc7GA2ayXqgmX3Pm65oK4305cNQhQvSJ0LEaPRDXM8RBm2XANDAfEn6GTo812V3xY5ZuAjzjteRf
        jwPphrMP7zqwtq1YAoVe8vwTrVtdsLtUrS1GbaGvTK2QcA5SnggKdKjsBKiflPV69mUymEdpHSu6O
        M6wZv+C2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guEFd-0000rM-RX; Thu, 14 Feb 2019 10:28:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D015920298375; Thu, 14 Feb 2019 11:28:15 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:28:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Message-ID: <20190214102815.GF32494@hirez.programming.kicks-ass.net>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
 <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
 <4881796E12491D4BB15146FE0209CE64681DB01F@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4881796E12491D4BB15146FE0209CE64681DB01F@DE02WEMBXB.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:50:43AM +0000, Alexey Brodkin wrote:

> But that's pretty much the same for other 32-bit arches that have 64-bit atomics
> like ARM etc. From what I may see from ARM's documentation for LDREXD/SRREXD they
> require double-word alignment of data as well.
> 
> That said if for some reason atomic64_t variable is unaligned execution on
> any (or at least most) 32-bit architectures will lead to run-time failure,
> i.e. we'll know about it and this will be fixed.

On x86_32 we have cmpxchg8b that 'likes' 8b alignment, our atomic64_32
implementation has the explicit alignment in, however there
__alignof__(unsigned long long) is actually 8, so it all works.

Even though the hardware (obviously) never really requires alignment,
even for atomic ops (although that's coming, yay!).
