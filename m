Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F8C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9F120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9F120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeKASYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:24:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeKASYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:24:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC27341;
        Thu,  1 Nov 2018 02:22:22 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A20E3F557;
        Thu,  1 Nov 2018 02:22:21 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:22:18 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: arch/x86/include/asm/rmwcc.h:23:17: error: jump into statement
 expression
Message-ID: <20181101092217.GB1565@brain-police>
References: <201811010946.KVmoo2CH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811010946.KVmoo2CH%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thu, Nov 01, 2018 at 09:11:52AM +0800, kbuild test robot wrote:
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5b7449810ae6d652629c550d3974c8453836d229
> commit: 7aa54be2976550f17c11a1c3e3630002dea39303 locking/qspinlock, x86: Provide liveness guarantee
> date:   2 weeks ago
> config: x86_64-randconfig-j0-10290909 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         git checkout 7aa54be2976550f17c11a1c3e3630002dea39303
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/atomic.h:5:0,
>                     from include/linux/atomic.h:7,
>                     from include/linux/crypto.h:20,
>                     from arch/x86/kernel/asm-offsets.c:9:
>    arch/x86/include/asm/qspinlock.h: In function 'queued_fetch_set_pending_acquire':
> >> arch/x86/include/asm/rmwcc.h:23:17: error: jump into statement expression
>        : clobbers : cc_label);    \

You wrote a fix for this last week, right? Do we need to get it queued
someplace for -rc1?

Will
