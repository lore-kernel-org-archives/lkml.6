Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC71720675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbfAPNkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:40:14 -0500
Received: from foss.arm.com ([217.140.101.70]:48450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbfAPNkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:40:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A5780D;
        Wed, 16 Jan 2019 05:40:13 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443C43F70D;
        Wed, 16 Jan 2019 05:40:12 -0800 (PST)
Date:   Wed, 16 Jan 2019 13:40:07 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 0/4] arm64: kprobes: Update blacklist checking on arm64
Message-ID: <20190116134007.GA15255@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154753341900.31541.8135985235882849464.stgit@devbox>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, Jan 15, 2019 at 03:23:39PM +0900, Masami Hiramatsu wrote:
> Hello,
> 
> Here is the v2 series of update of the kprobe blacklist
> checking on arm64.
> 
> I found that some blacklist checking code were mis-placed in
> arch_prepare_kprobe() and arch_within_kprobe_blacklist().
> Since the blacklist just filters by symbol, smaller than the
> symbol, like extable must be checked in arch_prepare_kprobe().
> Also, all function (symbol) level check must be done by blacklist.
> 
> For arm64, it checks the extable entry address in blacklist
> and exception/irqentry function in arch_prepare_kprobe().
> And, RODATA check is unneeded since kernel/kprobes.c
> already ensures the probe address is in kernel-text area.
> 
> In v2, I updated [1/4]'s description and added James'
> Reviewed-by. Also, in this version, I added a patch which
> uses arch_populate_kprobe_blacklist() instead of
> arch_within_kprobe_blacklist() so that user can see the full
> list of blacklisted symbols under the debugfs.

Assuming these are targetting the arm64 tree, are you intending to get them
merged for 5.0?

Will
