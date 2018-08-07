Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2D2172B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F29OfaCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C2D2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeHGWP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:15:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53612 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hbVhEbmD45C064qO5uvO92lHaztlKbY3+8ZwBOHlnrM=; b=F29OfaCfVJrAzm2a8LZL2mZQY
        3K4dtHKUeXuaSx72H5bIXvugT27zsRu7zgJQRlqf0FZqbfbMbyuUEzGEfDstBC8wCjp344+UoRZFO
        Ewt4vcUJFHpIwHedf0G2KUclA/A93LbfKErELyyafKEMbKyxeR96klLOapP74fEldAhDR2tX3PPqZ
        BVUdO7pd1cK0qJU3j9sMuDH5YB4outhCs0P+97lOlfL0pH6ZqeodebpOOJg04AD2234kvBUSkVbvj
        05KPhFM+hQp99Ydt6yFjK8bqOdF9PyPIt20E1vRrvrrq6+dvvGlLnNbIRrSHhbadpVZH3iyOLxpGx
        YOh1VcUXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn890-0002uC-2e; Tue, 07 Aug 2018 19:59:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFB3820163EC2; Tue,  7 Aug 2018 21:59:45 +0200 (CEST)
Date:   Tue, 7 Aug 2018 21:59:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180807195945.GK2494@hirez.programming.kicks-ass.net>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
 <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
 <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
 <20180807183736.GR4238@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807183736.GR4238@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:37:36AM -0700, Andi Kleen wrote:
> On Tue, Aug 07, 2018 at 07:48:51PM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 07, 2018 at 10:35:42AM -0700, Dave Hansen wrote:
> > > On 08/07/2018 10:17 AM, kan.liang@linux.intel.com wrote:
> > > > Denverton and Gemini Lake are platform names and should not be used for
> > > > Processor Family stuff. The microarchitecture codename should be used.
> > > 
> > > Why?
> > > 
> > > Denverton is the platform.  "Goldmont" is literally the
> > > microarchitecture, and you are suggesting moving *to* the
> > > microarchitecture name, which contradicts the description.
> > 
> > All the other (big core) are uarch names. Atom is weird in that it mixes
> > uarch with platform names.
> 
> On most big core the platform/SOC just happens to have the same name as the 
> uarch. But the identifiers really have to be per SOC because that 
> is how Intel model numbers work.

I'm sure that is how we ended up with two SKX parts with identical model
numbers but different crystal frequencies :-(

Let's just keep consistency and use MICROARCH_TYPE things for
everything.
