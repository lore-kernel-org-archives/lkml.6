Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BD2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BFE21582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1XpjElI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BFE21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeI0VQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:16:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeI0VQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vZWoBKe497po3/yYhDt0zH8YNeRRaIxnHXpzkxUc2gs=; b=I1XpjElIpcanGzUyItPr3/CfB
        +zPAv09NnaREiJFy2TT+yQRc4nl+oyOsgNs8bJ3IKiK4PBz9R5VvVfOeXyNIou1DNnVXlBDw2vzb+
        pweNLp/hxECImwOx0NMwlk8ztA+i8bUb35dDFqIyJ9WG7h6D0/EvEciI50Wx5tY/vcC/93P26j6Kw
        p0RmGKdhvWYxXhao7dEZ6laYnUk1cL6YRgIAVO8+uOSy1G/xo+V2gFTaHtgnzyrVSDbC/x/bw2btE
        Q44PQgkyHU98y4EaSKQ4FESQ94mEXdIbmDY87ZApDwhJSSjeVS7EyYOVzMxjb0KJWeSRFAgeGsasP
        BtaLSeZSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5Xjg-0000Nd-Ht; Thu, 27 Sep 2018 14:58:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 794EE203C2F8D; Thu, 27 Sep 2018 16:57:45 +0200 (CEST)
Date:   Thu, 27 Sep 2018 16:57:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180927145745.GD3439@hirez.programming.kicks-ass.net>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
 <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
 <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
 <20180807183736.GR4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de>
 <20180807221725.GU4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
 <20180927142519.GB3439@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809271648210.8118@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809271648210.8118@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:49:18PM +0200, Thomas Gleixner wrote:
> > Subject: x86/cpu: Sanitize FAM6_ATOM naming
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Tue, 7 Aug 2018 10:17:27 -0700
> > 
> > Going primarily by:
> > 
> >   https://en.wikipedia.org/wiki/List_of_Intel_Atom_microprocessors#Silvermont_microarchitecture
> > 
> > with additional information gleaned from other related pages; notably:
> > 
> >  - Bonnell shrink was called Saltwell
> >  - Moorefield is the Merriefield refresh which makes it Airmont
> > 
> > The general naming scheme is: FAM6_ATOM_UARCH_SOCTYPE
> > 
> > Cc: x86@kernel.org
> > Cc: mingo@redhat.com
> > Cc: ak@linux.intel.com
> > Cc: tglx@linutronix.de
> > Cc: dave.hansen@linux.intel.com
> > Cc: len.brown@intel.com
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Which way do we route that?

I have it stuck in with some perf patches, does that work?
