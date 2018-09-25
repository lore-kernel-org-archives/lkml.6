Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F20421480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F20421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeIYUOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:14:10 -0400
Received: from foss.arm.com ([217.140.101.70]:51598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeIYUOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:14:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B491C7A9;
        Tue, 25 Sep 2018 07:06:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA5CF3F5D3;
        Tue, 25 Sep 2018 07:06:27 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:06:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
Message-ID: <20180925140624.7wovo2xtpyihyt3j@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180924171936.q5bfvczzllmm5lpe@lakrids.cambridge.arm.com>
 <20180925095316.GA27420@toy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925095316.GA27420@toy>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 05:53:16PM +0800, Jun Yao wrote:
> On Mon, Sep 24, 2018 at 06:19:36PM +0100, Mark Rutland wrote:
> > I've pushed a branch with the cleanups I requested [1] folded in.
> > 
> > I'm still a bit worried about the pgd lock, but otherwise I think this
> > is sound. I intend to throw some testing at it, just in case.
> > 
> > If you're happy with that branch, I'll ask Will and Catalin to consider
> > picking it up.
> 
> This branch looks great. Thank you for improving my patch.

Thanks for your patches!

> Is there anything I need to do? This is my first time to submit a patch,
> so I am a bit overwhelmed. I think I should wait for other people to
> review my patch. If there is a problem, I need to fix it.

Hopefully Catalin is happy to pick this up from my branch, and neither
of us have to do anything. :)

Catalin, are you happy to pick the patches from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ro-swapper

... that should be based on the arm64 for-next/core branch, and has
James's R-B prior to my commit fixup notes.

I've given this some basic testing with defconfig, 48-bit/4k and
42-bit/64k (with lockdep on in both cases), and things seem fine.

Thanks,
Mark.
