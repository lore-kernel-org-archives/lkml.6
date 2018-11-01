Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B32C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3484E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3484E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeKASTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:19:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57101 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKASTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:19:54 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gI96j-0001G1-Do; Thu, 01 Nov 2018 10:17:41 +0100
Date:   Thu, 1 Nov 2018 10:17:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4.4] x86/kconfig: Fall back to ticket spinlocks
In-Reply-To: <20181031081458.13996-1-wagi@monom.org>
Message-ID: <alpine.DEB.2.21.1811011016420.1642@nanos.tec.linutronix.de>
References: <20181031081458.13996-1-wagi@monom.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, Daniel Wagner wrote:
> Backporting all qspinlock related patches is very likely to introduce
> regressions on v4.4. Therefore, the recommended solution by Peter and
> Thomas is to drop back to ticket spinlocks for v4.4.
> 
> Link :https://lkml.kernel.org/r/20180921120226.6xjgr4oiho22ex75@linutronix.de
> Link: https://lkml.kernel.org/r/20180926110117.405325143@infradead.org
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
> ---
> 
> Thomas suggest following plan for fixing the issues on the varous
> stable trees:
> 
>    4.4:  Trivial by switching back to ticket locks.
> 
>    4.9:  Decide whether bringing back ticket locks or backporting all qrlock
>    	 fixes. Sebastian has done the latter already and it's probably the
>    	 right solution
> 
>    4.14:
>    4.18: Backporting the qrlock fixes
> 
>    4.19: Either the fix ends up in 4.19 final or it needs to be backported

Looks about right. Sebastian, can you please provide the 4.9 backport as a
patch series?

Thanks,

	tglx
