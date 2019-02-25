Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEEFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B922620842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBYMMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:12:41 -0500
Received: from foss.arm.com ([217.140.101.70]:59830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfBYMMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:12:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5F001596;
        Mon, 25 Feb 2019 04:12:40 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D874E3F575;
        Mon, 25 Feb 2019 04:12:39 -0800 (PST)
Date:   Mon, 25 Feb 2019 12:12:34 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-tip] locking/qspinlock: Remove unnecessary BUG_ON() call
Message-ID: <20190225121234.GA17076@fuggles.cambridge.arm.com>
References: <1551057253-3231-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551057253-3231-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 08:14:13PM -0500, Waiman Long wrote:
> With the > 4 nesting levels case handled by the commit d682b596d993
> ("locking/qspinlock: Handle > 4 slowpath nesting levels"), the BUG_ON()
> call in encode_tail() will never be triggered. Remove it.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 21ee51b..5e9247d 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -124,9 +124,6 @@ static inline __pure u32 encode_tail(int cpu, int idx)
>  {
>  	u32 tail;
>  
> -#ifdef CONFIG_DEBUG_SPINLOCK
> -	BUG_ON(idx > 3);
> -#endif
>  	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
>  	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */

Acked-by: Will Deacon <will.deacon@arm.com>

Will
