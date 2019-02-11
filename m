Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A985C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642532229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfBKR2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:28:06 -0500
Received: from foss.arm.com ([217.140.101.70]:54478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfBKR2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:28:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 129DC80D;
        Mon, 11 Feb 2019 09:28:06 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032793F675;
        Mon, 11 Feb 2019 09:28:04 -0800 (PST)
Date:   Mon, 11 Feb 2019 17:28:00 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/atomic_t: Clarify signed vs unsigned
Message-ID: <20190211172800.GA2994@fuggles.cambridge.arm.com>
References: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 06:09:43PM +0100, Peter Zijlstra wrote:
> 
> Clarify the whole signed vs unsigned issue for atomic_t.
> 
> There has been enough confusion on this topic to warrant a few explicit
> words I feel.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/atomic_t.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index 913396ac5824..dca3fb0554db 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -56,6 +56,23 @@ The 'full' API consists of (atomic64_ and atomic_long_ prefixes omitted for
>    smp_mb__{before,after}_atomic()
>  
>  
> +TYPES (signed vs unsigned)
> +-----
> +
> +While atomic_t, atomic_long_t and atomic64_t use int, long and s64
> +respectively (for hysterical raisins), the kernel uses -fno-strict-overflow
> +(which implies -fwrapv) and defines signed overflow to behave like
> +2s-complement.
> +
> +Therefore, an explicitly unsigned variant of the atomic ops is strictly
> +unnecessary and we can simply cast, there is no UB.
> +
> +There was a bug in UBSAN prior to GCC-8 that would generate UB warnings for
> +signed types.
> +
> +With this we also conform to the C/C++ _Atomic behaviour and things like
> +P1236R1.
> +

Acked-by: Will Deacon <will.deacon@arm.com>

Will
