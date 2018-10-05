Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F531C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87AC2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87AC2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeJEXqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:46:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38659 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEXqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:46:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g8TFD-0004ml-RS; Fri, 05 Oct 2018 18:46:27 +0200
Date:   Fri, 5 Oct 2018 18:46:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julia Cartwright <julia@ni.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] kthread: convert worker lock to raw spinlock
Message-ID: <20181005164627.m6w5s44s25dhu7ln@linutronix.de>
References: <cover.1538089179.git.julia@ni.com>
 <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da33d7d7aa32d08f9cbf5016fb04426f90645cb0.1538089180.git.julia@ni.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-28 21:03:51 [+0000], Julia Cartwright wrote:
> In order to enable the queuing of kthread work items from hardirq
> context even when PREEMPT_RT_FULL is enabled, convert the worker
> spin_lock to a raw_spin_lock.
> 
> This is only acceptable to do because the work performed under the lock
> is well-bounded and minimal.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reported-by: Tim Sander <tim@krieglstein.org>
> Signed-off-by: Julia Cartwright <julia@ni.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
