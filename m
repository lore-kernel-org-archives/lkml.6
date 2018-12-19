Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F55EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEB3218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeLSPXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:23:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbeLSPXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:23:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A8FFEBD;
        Wed, 19 Dec 2018 07:23:36 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5E83F675;
        Wed, 19 Dec 2018 07:23:34 -0800 (PST)
Date:   Wed, 19 Dec 2018 15:23:32 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Alan Hayward <Alan.Hayward@arm.com>, nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64/sve: Disentangle <uapi/asm/ptrace.h> from
 <uapi/asm/sigcontext.h>
Message-ID: <20181219152332.GC22067@e103592.cambridge.arm.com>
References: <1544556407-19897-4-git-send-email-Dave.Martin@arm.com>
 <201812151729.IIgleZIH%fengguang.wu@intel.com>
 <20181218121307.GA22067@e103592.cambridge.arm.com>
 <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c409567-1beb-e0cb-3efd-589a869ac7c8@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 03:11:52PM +0000, Szabolcs Nagy wrote:
> On 18/12/2018 12:14, Dave Martin wrote:
> > On Sat, Dec 15, 2018 at 05:20:29PM +0800, kbuild test robot wrote:

[...]

> >>>> ./usr/include/asm/sve_context.h:30: found __[us]{8,16,32,64} type without #include <linux/types.h>
> > 
> > Since the new header is not meant to be included directly (and has a
> > guard to that effect), we don't strictly need to do anything here.
> > 
> > The way to include <asm/sve_context.h> in userspace is via
> > <asm/sigcontext.h> or <asm/ptrace.h>, both of which include
> > <linux/types.h> first.
> > 
> 
> i think there is no need to explicitly prevent the inclusion of
> the header.
> 
> it is enough to have a comment that it's not supposed to be
> included by user code (so the header can be later refactored).
> 
> and then such automated header checks (or whatever other hacks
> ppl do temporarily) can continue to work.

The guard is in linux-next now AFAIK.

Are you saying that it's likely to break something and needs to be
removed, or it is unnecessary but harmless?

Cheers
---Dave
