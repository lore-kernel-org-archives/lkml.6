Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33680ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAF4208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAF4208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeGMPVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:21:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbeGMPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:21:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5206715AD;
        Fri, 13 Jul 2018 08:06:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 601AA3F627;
        Fri, 13 Jul 2018 08:06:10 -0700 (PDT)
Date:   Fri, 13 Jul 2018 16:06:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        mingo@kernel.org
Cc:     Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, aryabinin@virtuozzo.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        hpa@zytor.com, linuxdrivers@attotech.com, parri.andrea@gmail.com,
        peter@hurleysoftware.com, tglx@linutronix.de
Subject: Re: [PATCHv3 00/12] atomics: generate atomic headers / instrument
 arm64
Message-ID: <20180713150607.rf6hkwsxpe4gsxqt@lakrids.cambridge.arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180706131603.GA11172@arm.com>
 <20180706132124.GN2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706132124.GN2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:21:24PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 02:16:04PM +0100, Will Deacon wrote:
> > On Thu, Jul 05, 2018 at 05:40:41PM +0100, Mark Rutland wrote:
> > > This series scripts the generation of the various atomic headers, to ensure
> > > that the various atomic APIs remain consistent, reducing the risk of human
> > > error, and simplifying future rework. This fleshes out the instrumented atomics
> > > such that arm64 can be migrated over to them.
> > 
> > Thanks! For the series apart from the shell scripts:
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Awesome, Ingo can you stuff these here patches into locking/core
> someplace?

Looks like Ingo was only Cc'd for the above.

Ingo, are you happy to pick these up?

I've pushed out a branch [1] with Will's acks and a trivial commit
message change for patches 8-10 which I don't think is too important. I
can post that as v4 if you'd prefer to pick that.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/generated 
