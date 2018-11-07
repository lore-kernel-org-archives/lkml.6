Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E101AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A596220862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A596220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeKHFUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:20:47 -0500
Received: from ms.lwn.net ([45.79.88.28]:45270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbeKHFUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:20:47 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E9C912ED;
        Wed,  7 Nov 2018 19:48:56 +0000 (UTC)
Date:   Wed, 7 Nov 2018 12:48:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20181107124855.328133e7@lwn.net>
In-Reply-To: <20181107171010.421878737@linutronix.de>
References: <20181107171010.421878737@linutronix.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Nov 2018 18:10:10 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Mark recently suggested in one of the ksummit discussions to add subsystem
> or tree specific maintainer handbooks to document subsystem/tree specific
> development process information.
> 
> The following series adds the general section and the tip tree specific
> handbook.

So this is an idea that has gone around for a while; developers often get
into trouble when wandering into an unfamiliar part of the kernel, so
documenting the quaint local customs might help.  Assuming people actually
read the documentation, of course.

What's here seems generally good, but I do have an overall worry that we
may want to consider:

  - How much do we want to support and document subsystem-specific quirks
    vs. promoting reasonable and consistent rules kernel-wide?

There is a *lot* of stuff in the new tip manual.  Much of it, regarding
coding style and the writing of changelogs, really seems like it should be
global; if we need better documentation of that stuff, I'd really rather
see that advice folded into the central documents.  Having two (or more)
extensive coding-style documents doesn't seem like it's going to help us.

The stuff that is truly specific to tip seems fairly minimal:

  - what goes into tip
  - the reverse fir tree thing
  - tail comments, or the distaste thereabouts
  - subject-line prefixes

Having a tip-specific document that contains only those (plus whatever
else I forgot to list) would, IMO, make it much more likely that readers
would actually notice (and follow) the stuff that's specific to tip.

See what I'm getting at here?  Am I totally out to lunch on this?

Thanks,

jon

P.S. There is the separate issue of whether having subsystem-specific
     coding-style rules is a good thing overall.  I think we should try to
     be one big kernel project rather than 100 small ones, but perhaps
     that's just me.
