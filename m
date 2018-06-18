Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D80AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DCF20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DCF20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755300AbeFRQJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:09:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754561AbeFRQJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:09:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 825E61529;
        Mon, 18 Jun 2018 09:09:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AD7C3F557;
        Mon, 18 Jun 2018 09:09:17 -0700 (PDT)
Date:   Mon, 18 Jun 2018 17:08:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mingo@kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCHv3 09/18] atomics/alpha: define atomic64_fetch_add_unless()
Message-ID: <20180618160829.5jrscmfkorjxdvod@lakrids.cambridge.arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
 <20180618101919.51973-10-mark.rutland@arm.com>
 <20180618155439.GD11612@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618155439.GD11612@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:54:40PM +0100, Will Deacon wrote:
> On Mon, Jun 18, 2018 at 11:19:10AM +0100, Mark Rutland wrote:
> >  /**
> > - * atomic64_add_unless - add unless the number is a given value
> > + * atomic64_fetch_add_unless - add unless the number is a given value
> >   * @v: pointer of type atomic64_t
> >   * @a: the amount to add to v...
> >   * @u: ...unless v is equal to u.
> >   *
> >   * Atomically adds @a to @v, so long as it was not @u.
> > - * Returns true iff @v was not @u.
> > + * Returns the old value of @v.
> >   */
> > -static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> > +static __inline__ int atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
> 

Whoops; yes.

From a scan of the series, I messed that up in the instrumentation, too,
but the rest sems fine.

I'll fix those up and push out an updated branch.

Thanks,
Mark.
