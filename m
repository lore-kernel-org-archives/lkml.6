Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F22C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757DB22518
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757DB22518
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeGDWix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:38:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49364 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeGDWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:38:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1faqPp-0001A1-Mk; Wed, 04 Jul 2018 22:38:25 +0000
Date:   Wed, 4 Jul 2018 23:38:25 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe()
 exception handling
Message-ID: <20180704223825.GZ30522@ZenIV.linux.org.uk>
References: <20180702165803.GB19488@linux.intel.com>
 <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180703083040.GB971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703083040.GB971@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:30:40AM +0200, Ingo Molnar wrote:
> 
> * Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Hi Ingo,
> > 
> > Here is an additional copy_to_iter_mcsafe() fix to address the crash
> > reported by Ross. This now passes xfstests:generic/323 on my system.
> 
> The lib/iov_iter fix would need an Acked-by from Al.

I can live with that; I would really like to see some documentation on
the copy_to_iter_mcsafe(), but that's a separate story.  Incidentally,
are there any expectations of other callers appearing, or is that
(and copy_from_iter_flushcache()) YASingleConsumerAPI?
