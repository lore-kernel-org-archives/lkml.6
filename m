Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04066C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC504206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC504206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeIEQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:58:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeIEQ6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A038A7A9;
        Wed,  5 Sep 2018 05:28:14 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 721363F5BC;
        Wed,  5 Sep 2018 05:28:14 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D8B521AE3546; Wed,  5 Sep 2018 13:28:28 +0100 (BST)
Date:   Wed, 5 Sep 2018 13:28:28 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jon Masters <jcm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        benh@au1.ibm.com, torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180905122828.GF20186@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <3dd55e21-7424-071a-0f7e-d24fc2396f2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd55e21-7424-071a-0f7e-d24fc2396f2a@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 02:38:02PM -0400, Jon Masters wrote:
> On 08/24/2018 11:52 AM, Will Deacon wrote:
> 
> > I hacked up this RFC on the back of the recent changes to the mmu_gather
> > stuff in mainline. It's had a bit of testing and it looks pretty good so
> > far.
> 
> I will request the server folks go and test this. You'll probably
> remember a couple of parts we've seen where aggressive walker caches
> ended up (correctly) seeing stale page table entries and we had all
> manner of horrifically hard to debug problems. We have some fairly nice
> reproducers that were able to find this last time that we can test.

Cheers, Jon, that would be very helpful. You're probably best off using
my (rebasing) tlb branch rather than picking the RFC:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tlb

Let me know if you'd prefer something stable (I can tag it with a date).

Will
