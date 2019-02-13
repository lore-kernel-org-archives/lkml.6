Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E842C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B169222E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qdFbMKZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392577AbfBMPyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:54:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44764 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391483AbfBMPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4B8f5u24tEnVCYdkrdbMlfH9CFGYs99uoc8FQpeWr3E=; b=qdFbMKZ6VZnn5UM/5xNJjJLAr
        aiHy/+s3SBfe70HSxj2ZP6nVqgIeYoN7TJQax/kaedCpBkAJOQRtcAJlWlB6rF4G0So8Xm3m0Nt4W
        zkCYH/yeSjki56IQbRdIzp7XxdFz/MnW68dig1YtLVDPZ26WOo03qtbXgwdS3j5yzUbo9bx4Lz+dL
        5EBFPwXCopQdLW0sf4/P2vAzD3ycXGyyJbp4PzgJrxQwX/nxzeIoUnLHWq1Nl8u83iI0W0BeSwMhA
        DaVkGgzbjYlyEc5f2lqcv0Xue53EKErndCDXSEY84NZIFYAlEDGg14SV3MXER8R3O6DiTl7LS0pcv
        AACW1cZMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtwrh-0002NB-8P; Wed, 13 Feb 2019 15:54:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 064D8202CEF99; Wed, 13 Feb 2019 16:54:24 +0100 (CET)
Date:   Wed, 13 Feb 2019 16:54:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 03/10] locking/rwsem: Rename kernel/locking/rwsem.h
Message-ID: <20190213155423.GZ32494@hirez.programming.kicks-ass.net>
References: <1550017627-14504-1-git-send-email-longman@redhat.com>
 <1550017627-14504-4-git-send-email-longman@redhat.com>
 <20190213091918.GL32494@hirez.programming.kicks-ass.net>
 <31e47c29-fdb4-6fcb-64a9-36ce70226af5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e47c29-fdb4-6fcb-64a9-36ce70226af5@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:47:11AM -0500, Waiman Long wrote:
> On 02/13/2019 04:19 AM, Peter Zijlstra wrote:
> > On Tue, Feb 12, 2019 at 07:27:00PM -0500, Waiman Long wrote:
> >> The content of kernel/locking/rwsem.h is now specific to rwsem-xadd only.
> >> Rename it to rwsem-xadd.h to indicate that it is specific to rwsem-xadd
> >> and include it only when CONFIG_RWSEM_XCHGADD_ALGORITHM is set. As a result,
> >> the CONFIG_RWSEM_XCHGADD_ALGORITHM conditional compilation directives can
> >> be removed. There is no functional change.
> > Since all of rwsem-xadd is now generic code; how about we delete the
> > spinlock thing and keep everything rwsem ?
> >
> > We don't carry a special spinlock mutex implementation either. And
> > arguably any arch that uses spinlock based atomics (afaict the only case
> > where rwsem-spinlock makes any sense anyway) suck anyway.
> 
> I don't mind removing the rwsem-spinlock code and have just one
> implementation for all as long as there is no objection from others. I
> don't know the history of why we have 2 implementations of rwsem and so
> I didn't plan to do that.

It is from before my time too; but I think rwsem-spinlock is generic and
didn't require arch asm helpers, where rwsem-xadd did, but we just fixed
that :-)
