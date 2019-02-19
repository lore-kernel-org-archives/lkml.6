Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4951CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229C82146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfBSMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:48:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44922 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfBSMsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:48:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 240A1EBD;
        Tue, 19 Feb 2019 04:48:03 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F6D03F720;
        Tue, 19 Feb 2019 04:48:00 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:47:58 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v6 13/18] asm-generic/tlb: Introduce
 HAVE_MMU_GATHER_NO_GATHER
Message-ID: <20190219124758.GF8501@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.633310832@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103233.633310832@infradead.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:32:01AM +0100, Peter Zijlstra wrote:
> Add the Kconfig option HAVE_MMU_GATHER_NO_GATHER to the generic
> mmu_gather code. If the option is set the mmu_gather will not
> track individual pages for delayed page free anymore. A platform
> that enables the option needs to provide its own implementation
> of the __tlb_remove_page_size function to free pages.
> 
> Cc: npiggin@gmail.com
> Cc: heiko.carstens@de.ibm.com
> Cc: will.deacon@arm.com
> Cc: aneesh.kumar@linux.vnet.ibm.com
> Cc: akpm@linux-foundation.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux@armlinux.org.uk
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20180918125151.31744-2-schwidefsky@de.ibm.com
> ---
>  arch/Kconfig              |    3 +
>  include/asm-generic/tlb.h |    9 +++
>  mm/mmu_gather.c           |  107 +++++++++++++++++++++++++---------------------
>  3 files changed, 70 insertions(+), 49 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
