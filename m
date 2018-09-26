Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D549C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051D821531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051D821531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeIZXwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:52:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbeIZXwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:52:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0952C7A9;
        Wed, 26 Sep 2018 10:38:46 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.Emea.Arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F07AC3F5B3;
        Wed, 26 Sep 2018 10:38:44 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:38:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [REVIEW][PATCH 00/15] signal/arm64: siginfo cleanups
Message-ID: <20180926173841.GD175719@arrakis.emea.arm.com>
References: <871s9j462u.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s9j462u.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, Sep 24, 2018 at 11:07:05AM +0200, Eric W. Biederman wrote:
> This is the continuation of my work to sort out signaling of exceptions
> with siginfo.  The old signal sending functions by taking a siginfo
> argument resulted in their callers having to deal with the fiddly nature
> of siginfo directly.  In small numbers of callers this is not a problem
> but in the number of callers in the kernel this resulted in cases
> where fields were not initialized or improperly initialized before
> being passed to userspace.
> 
> To avoid having to worry about those issues I have added new signal
> sending functions that each deal wit a different siginfo case.  When
> using these functions there is no room for the fiddly nature of siginfo
> to cause mistakes.
> 
> This is my set of changes to update arm64 to use those functions.
> Along with some refactoring so those functions can be cleanly used.
> 
> Folks please review and double check me.  I think I have kept these
> changes simple and obviously correct but I am human and mess up
> sometimes.

Nice clean-up, thanks. I started reviewing the patches, I should finish
by tomorrow (I also applied them locally to give some testing).

> After these patches have had a chance to be reviewed I plan to merge
> them by my siginfo tree.  If you would rather take them in the arm64
> tree let me know.   All of the prerequisites should have been merged
> through Linus's tree several releases ago.

Either way works for me. There is a trivial conflict in
force_signal_inject() with the arm64 for-next/core tree so I could as
well put them on top of this branch and send them during the 4.20
merging window.

-- 
Catalin
