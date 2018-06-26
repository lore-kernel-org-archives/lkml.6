Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D519426993
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D519426993
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934448AbeFZLCz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:02:55 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:50114 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933444AbeFZLCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:02:53 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w5QB2M5O029834;
        Tue, 26 Jun 2018 12:02:22 +0100
Date:   Tue, 26 Jun 2018 12:02:21 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Cox <alan@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 06/16] x86/split_lock: Save #AC setting for split
 lock in firmware in boot time and restore the setting in reboot
Message-ID: <20180626120221.7fbd0eff@alans-desktop>
In-Reply-To: <20180626090521.GF2494@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
        <1527435965-202085-7-git-send-email-fenghua.yu@intel.com>
        <20180621195823.GD13636@worktop.programming.kicks-ass.net>
        <1529680267.4364.50.camel@linux.intel.com>
        <20180626090521.GF2494@hirez.programming.kicks-ass.net>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 11:05:21 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jun 22, 2018 at 04:11:07PM +0100, Alan Cox wrote:
> > On Thu, 2018-06-21 at 21:58 +0200, Peter Zijlstra wrote:  
> > > On Sun, May 27, 2018 at 08:45:55AM -0700, Fenghua Yu wrote:  
> > > > Firmware may contain split locked instructions.  
> > > 
> > > I think that's the wrong attitude. You should mandate in your BIOS
> > > development guide that Firmware _MUST_NOT_ contain unaligned LOCK
> > > prefixed instructions.
> > >   
> > 
> > In the longer term I would agree entirely with that sentiment.  
> 
> But then how do we deal with SMIs ?

On a system doing that level of real time you don't do SMIs.

I think Thomas comment that this shouldn't be in a production kernel
because the firmware people need to have their house in order before that
is a fair one.

(and I've already been poking people to make sure this is documented
properly as a requirement)

Alan
