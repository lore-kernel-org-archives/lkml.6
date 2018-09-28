Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6382C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D3D206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEU3XydI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D3D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeI2BoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:44:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI2BoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eJRn+NCJD19OKCs4nx+a2tKYlAg2+VbnS6n2puTD5fM=; b=SEU3XydIp2YjA85OIU6iKX5Ce
        MBrsQryyV4GPNzvJBMBMOxbgS+U7/WAqzDC9Ic1kW7KdKFfyXR2ve9uQ7bP15uzMAFFr+/f/P5TOC
        FmLnsF6ts2ElDAsVfZ3MIo8CzVEWAzmBqEFKgFSW5L/hB06vHe1K0n6EEwCyIAbDQhAV8xccM9jyP
        Lkd/9i8nKFYQsXpvMQR/3kCpeIY6UtqajV+Y9fNLTBpBp/CjiVf6GNhReWierPyLA60EK9DBfAlfw
        7mvzlvFfQ620vrsTfNTGGFHihcqZgHuEWwreCKRvNcXl1gOAJXc2yxxrsA3xeJnWOfNAxWyZvcZKr
        DRv3TKvjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5yHy-00013j-4H; Fri, 28 Sep 2018 19:18:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0274202C1A17; Fri, 28 Sep 2018 21:18:53 +0200 (CEST)
Date:   Fri, 28 Sep 2018 21:18:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, mingo@redhat.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
Message-ID: <20180928191853.GJ3439@hirez.programming.kicks-ass.net>
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
 <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com>
 <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
 <20180807183736.GR4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de>
 <20180807221725.GU4238@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
 <20180927142519.GB3439@hirez.programming.kicks-ass.net>
 <20180928170704.7e428738@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928170704.7e428738@alans-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 05:07:04PM +0100, Alan Cox wrote:
> > > SILVERMONT_CLIENT  	0x37	     Baytrail, Valleyview
> 
> There is no such product as Valleyview. Some things talk about
> Valleyview 2 but shouldn't as that is Baytrail.

I couldn't find it either, but it is all over the linux code.

I'd be happy to remove it from this comment though.

> > /* "Small Core" Processors (Atom) */
> > 
> > #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
> > #define INTEL_FAM6_ATOM_BONNELL_MID	0x26 /* Silverthorne, Lincroft */
> > 
> > #define INTEL_FAM6_ATOM_SALTWELL	0x36 /* Cedarview */
> > #define INTEL_FAM6_ATOM_SALTWELL_MID	0x27 /* Penwell */
> > #define INTEL_FAM6_ATOM_SALTWELL_TABLET	0x35 /* Cloverview */
> > 
> > #define INTEL_FAM6_ATOM_SILVERMONT	0x37 /* Bay Trail, Valleyview */
> > #define INTEL_FAM6_ATOM_SILVERMONT_X	0x4D /* Avaton, Rangely */
> > #define INTEL_FAM6_ATOM_SILVERMONT_MID	0x4A /* Merriefield */
> > 
> > #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
> > #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
> > 
> > #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
> > #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denvertor */
> > #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
> 
> Can you decide if you are going to consistently use the -view or the
> -trail naming ? I think for our use cases you mean Pinetrail, Cedartrail,
> Clovertrail, Cherrytrail as you are talking about platform (at least in
> the Intel sense of the word).

Like I said; I went with whatever is on this here page:

  https://en.wikipedia.org/wiki/List_of_Intel_Atom_microprocessors

There is no Cedar Trail, or Bayview. If you could do me a delta patch
with the names you think are appropriate i'd be happy to fold it in.
Alternatively, I can remove the tail comments entirely.

I spend entirely too much time already trying to come up with sensible
names already.

