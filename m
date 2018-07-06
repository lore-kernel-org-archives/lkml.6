Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486F120877
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486F120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934432AbeGFF6f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:58:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58934 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934247AbeGFFvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DE9118A;
        Thu,  5 Jul 2018 22:51:22 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD343F5BA;
        Thu,  5 Jul 2018 22:51:18 -0700 (PDT)
Date:   Fri, 6 Jul 2018 06:51:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        hpa@zytor.com, linuxdrivers@attotech.com, mingo@kernel.org,
        mingo@redhat.com, parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: Re: [PATCHv3 08/12] atomics: switch to generated fallbacks
Message-ID: <20180706055115.we4yegemiiqe4zdm@salmiak>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180705164053.10073-9-mark.rutland@arm.com>
 <20180705172306.GG2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705172306.GG2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:23:06PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 05, 2018 at 05:40:49PM +0100, Mark Rutland wrote:
> 
> > * The fallbacks are not expected to change very often, and are not
> >   affected by machine details or configuration options, so regenerating
> >   them for *every* build is somewhat wasteful.
> 
> Except of course, your last patch in this series now does exactly that
> :-)

Second-last, but agreed. ;)

I'll reword this to:

* The fallbacks are not affected by machine details or configuration options,
  so it is not necessary to regenerate them to take these into account.

Thanks,
Mark.
