Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC024C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D37124B71
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D37124B71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeGCLj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:39:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48010 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752414AbeGCLjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:39:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D8B80D;
        Tue,  3 Jul 2018 04:39:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1FFC3F5BA;
        Tue,  3 Jul 2018 04:39:37 -0700 (PDT)
Date:   Tue, 3 Jul 2018 12:39:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] refcount: always allow checked forms
Message-ID: <20180703113934.d2c5grjqwq5kuk4h@lakrids.cambridge.arm.com>
References: <20180703100102.16615-1-mark.rutland@arm.com>
 <20180703103320.GA17809@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703103320.GA17809@andrea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:33:20PM +0200, Andrea Parri wrote:
> Hi Mark,
> 
> a typo below:
> 
> 
> >  /**
> > - * refcount_inc - increment a refcount
> > + * refcount_inc_checked - increment a refcount
> >   * @r: the refcount to increment
> >   *
> >   * Similar to atomic_inc(), but will saturate at UINT_MAX and WARN.
> > @@ -148,14 +146,14 @@ EXPORT_SYMBOL(refcount_inc_not_zero);
> >   * Will WARN if the refcount is 0, as this represents a possible use-after-free
> >   * condition.
> >   */
> > -void refcount_inc(refcount_t *r)
> > +void refcount_inc_chcked(refcount_t *r)
> 
> s/chcked/checked

The kbuild test robot also just spotted this; I've fixed tht up locally
and pushed it out to my atomics/refcount-checked branch.

Thanks for the spot!

Mark.
