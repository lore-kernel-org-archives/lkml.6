Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022A620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022A620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757163AbeFSKUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:20:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46898 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756608AbeFSKUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:20:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C7461435;
        Tue, 19 Jun 2018 03:20:14 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D63E3F25D;
        Tue, 19 Jun 2018 03:20:14 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DF66B1AE5412; Tue, 19 Jun 2018 11:20:49 +0100 (BST)
Date:   Tue, 19 Jun 2018 11:20:49 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, mingo@kernel.org, albert@sifive.com,
        arnd@arndb.de, benh@kernel.crashing.org, geert@linux-m68k.org,
        ink@jurassic.park.msu.ru, linux@armlinux.org.uk,
        mattst88@gmail.com, mpe@ellerman.id.au, palmer@sifive.com,
        paulus@samba.org, rth@twiddle.net, vgupta@synopsys.com
Subject: Re: [PATCHv3 00/18] atomics: API cleanups
Message-ID: <20180619102049.GF13984@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
 <20180618163805.GE11612@arm.com>
 <20180618192126.l7qyuthsc6eqkigb@salmiak>
 <20180619101800.kyue73me67pqktme@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619101800.kyue73me67pqktme@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:18:01AM +0100, Mark Rutland wrote:
> On Mon, Jun 18, 2018 at 08:21:27PM +0100, Mark Rutland wrote:
> > On Mon, Jun 18, 2018 at 05:38:06PM +0100, Will Deacon wrote:
> > > On Mon, Jun 18, 2018 at 11:19:01AM +0100, Mark Rutland wrote:
> > > > This series contains a few cleanups of the atomic API, fixing
> > > > inconsistencies between atomic_* and atomic64_*, and minimizing
> > > > repetition in arch code. This is nicer for arch code, and the improved
> > > > regularity will help when generating the atomic headers in future.
> > > 
> > > Apart from the Alpha patch:
> > > 
> > > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > 
> > Cheers! I assume that also holds with patch 7 fixes up to use s64.
> 
> I've pushed out the series with those fixes and your Reviewed-by tags.
> 
> Given the whole series has your Reviewed-By and Peter's Acked-by, I
> assume that you're both happy for this to be queued?
> 
> What's your prefered way for that to happen? Should I send a v4 with
> those fixes, a pull request, or are you happy to fetch that in a little
> while regardless?

Probably best to send a v4, then Ingo can take it all via -tip. Before you
do that, can you also spell-check your commit messages please? I spotted a
bunch of silly typos, and it will save Ingo from having to fix them up if
you do it first.

Will
