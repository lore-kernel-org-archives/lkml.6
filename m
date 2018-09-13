Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47412FA374A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BC3214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BC3214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeIMVCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:02:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbeIMVCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:02:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709947A9;
        Thu, 13 Sep 2018 08:52:45 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 387503F557;
        Thu, 13 Sep 2018 08:52:45 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5A3501AE3411; Thu, 13 Sep 2018 16:53:02 +0100 (BST)
Date:   Thu, 13 Sep 2018 16:53:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jon Masters <jcm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        benh@au1.ibm.com, torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180913155301.GA20290@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <3dd55e21-7424-071a-0f7e-d24fc2396f2a@redhat.com>
 <20180905122828.GF20186@arm.com>
 <f8ba271b-87c0-29ef-1216-77d5d391d5c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ba271b-87c0-29ef-1216-77d5d391d5c8@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 02:36:08AM -0400, Jon Masters wrote:
> On 09/05/2018 08:28 AM, Will Deacon wrote:
> > On Tue, Sep 04, 2018 at 02:38:02PM -0400, Jon Masters wrote:
> >> On 08/24/2018 11:52 AM, Will Deacon wrote:
> >>
> >>> I hacked up this RFC on the back of the recent changes to the mmu_gather
> >>> stuff in mainline. It's had a bit of testing and it looks pretty good so
> >>> far.
> >>
> >> I will request the server folks go and test this. You'll probably
> >> remember a couple of parts we've seen where aggressive walker caches
> >> ended up (correctly) seeing stale page table entries and we had all
> >> manner of horrifically hard to debug problems. We have some fairly nice
> >> reproducers that were able to find this last time that we can test.
> > 
> > Cheers, Jon, that would be very helpful. You're probably best off using
> > my (rebasing) tlb branch rather than picking the RFC:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tlb
> > 
> > Let me know if you'd prefer something stable (I can tag it with a date).
> 
> That would be useful. I've prodded each of the Arm server SoC vendors I
> work with via our weekly call to have them each specifically check this.
> A tag would be helpful to that effort I expect. They all claim to be
> watching this thread now, so we'll see if they see cabbages here.

This is now all queued up in the (stable) arm64 for-next/core branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core

so that's the best place to grab the patches.

Will
