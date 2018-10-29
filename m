Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFBC2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFBC2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbeJ3IDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:03:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52891 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbeJ3IDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:03:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gHGiD-0005Ij-Tv; Tue, 30 Oct 2018 00:12:46 +0100
Date:   Tue, 30 Oct 2018 00:12:45 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT 1/2] x86/kconfig: Fall back to ticket spinlocks
Message-ID: <20181029231244.xfj42ucddp7xnoae@linutronix.de>
References: <20181029201617.24733-1-wagi@monom.org>
 <20181029201617.24733-2-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029201617.24733-2-wagi@monom.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-29 21:16:16 [+0100], Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@siemens.com>
> 
> v4.4.162-rt176-rc1 stable review patch.
> If anyone has any objections, please let me know.

I though that we are going to route this via Greg/stable for v4.4?

> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -42,7 +42,6 @@ config X86
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF		if X86_64
>  	select ARCH_USE_QUEUED_RWLOCKS
> -	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_WANT_FRAME_POINTERS
> -- 
> 2.14.4
