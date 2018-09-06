Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CFE20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJ5l310/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CFE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIFL4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:56:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeIFL4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NqAbaFN92D4G3+p51ZzLNslymfO2UQnKyKaP0bcNla0=; b=gJ5l310/94vKEQc2SdsDmoOOC
        c7oaczOaE4boY9L4MHEnqPOTCaMZq+EdKPdMzkZh2I6jwlaXlQPJ91kB+lsQyTOcQ9cENptsOmc7L
        SmA/8w+8ceXoZYKcU3oVceHpPcbaEebyJZxiNzeScALuWV1ioEiRgLZM/EYShDnY+fjjAaBE/1C+6
        bQucWYv38HjiMYRx0O3sSKHBV2ik57oI0vLC7OpF8T7LFlYGpCd/bQ9SaxwakByVZOQ8Nrix/9slz
        cKBM/JF8IW5IOQ7X4hbQx5YUR7Yo67MmVVF7Xr/v30t2tyVCQF2JkFCyz2aUExfLTLyoqazQ6fz8D
        KRmkye8KQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxobw-0004Ow-4T; Thu, 06 Sep 2018 07:21:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9CE520210301; Thu,  6 Sep 2018 09:21:49 +0200 (CEST)
Date:   Thu, 6 Sep 2018 09:21:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Eduardo Valentin <eduval@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180906072149.GE24082@hirez.programming.kicks-ass.net>
References: <20180823150732.11249-1-eduval@amazon.com>
 <20180905085212.GS24124@hirez.programming.kicks-ass.net>
 <20180905155317.GA20320@u40b0340c692b58f6553c.ant.amazon.com>
 <20180905214707.GM27886@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905214707.GM27886@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:47:07PM -0700, Andi Kleen wrote:
> On Wed, Sep 05, 2018 at 08:53:17AM -0700, Eduardo Valentin wrote:
> > On Wed, Sep 05, 2018 at 10:52:12AM +0200, Peter Zijlstra wrote:
> > > On Thu, Aug 23, 2018 at 08:07:32AM -0700, Eduardo Valentin wrote:
> > > > On a system with X86_FEATURE_ARCH_PERFMON disabled
> > > > and with a model not known by family PMU drivers,
> > > > user gets a kernel message log like the following:
> > > > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> > > > 
> > > > The "unsupported .. CPU" part may be confusing for some
> > > > users leading to wrong understanding that the kernel
> > > > does not support the CPU model.
> > > 
> > > Send them back to first grade, such that they might learn to read?
> > > 
> > 
> > :-)
> 
> I think it's a valid concern, I guess Eduardo actually has real people
> who got confused.

But it is really easy to confuse real people; as real people are mostly
clueless.  There is only so much you can do for the semi illiterate
masses. Should we dumb down everything to baby talk just to cater to
them?

The string is clearly prefixed by the subsystem, if you get confused by
that your reading comprehension really is rock bottom.

  [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.

Heck, it even mentions "no PMU driver", how much clues do you need?
Also, the proposed alternative:

  [ 0.667154] Performance Events: CPU does not support PMU: no PMU driver, software events only.

Looses out information on which CPU family we failed on. Nor does it
mention the most likely reason for this error: virt crap.

I'd not mind a warning like:

  [] Performance Events: Your crappy virt solution is lying about it's CPU model, it doesn't have a (matching) PMU.


