Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF17C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD52921780
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD52921780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbeKPNCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:02:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeKPNCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:02:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD20880D;
        Thu, 15 Nov 2018 18:51:30 -0800 (PST)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380CE3F5A0;
        Thu, 15 Nov 2018 18:51:30 -0800 (PST)
Date:   Fri, 16 Nov 2018 02:51:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mingo@kernel.org, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linuxdrivers@attotech.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3 1/6] atomics: add common header generation files
Message-ID: <20181116025112.xhbfei677awm77ji@blommer>
References: <20180904104830.2975-1-mark.rutland@arm.com>
 <20180904104830.2975-2-mark.rutland@arm.com>
 <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Nov 15, 2018 at 03:10:48PM -0800, Andrew Morton wrote:
> On Tue,  4 Sep 2018 11:48:25 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > To minimize repetition, to allow for future rework, and to ensure
> > regularity of the various atomic APIs, we'd like to automatically
> > generate (the bulk of) a number of headers related to atomics.
> > 
> > This patch adds the infrastructure to do so, leaving actual conversion
> > of headers to subsequent patches.
> 
> This thing is appallingly slow.  `sh scripts/atomic/check-atomics.sh'
> takes 8 seconds on a machine which builds an allnoconfig kernel in 30
> seconds.

Hmm... on my laptop it's less than half that, and allnoconfig takes ~35s, so
clearly there's a major difference between our setups.

For reference, which distro are you using, and what is /bin/sh on your box?
 
> Um, no.  Just no.  Please find a way to make this overhead go away.

Will do.

Trivially, switching to diff -q halves the check runtime for me, and I'm sure
there are other parts of the scripting which can be optimized.

Thanks,
Mark.
