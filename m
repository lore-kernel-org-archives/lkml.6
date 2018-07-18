Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9267ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A20620850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A20620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeGRLeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:34:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbeGRLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:34:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffk93-0004yw-JS; Wed, 18 Jul 2018 12:57:21 +0200
Date:   Wed, 18 Jul 2018 12:57:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Shaohua Li <shli@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 1/6] drivers/md/raid5: Use irqsave variant of
 atomic_dec_and_lock()
Message-ID: <20180718105721.rcd6l7s6l4yfbahg@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
 <20180703200141.28415-2-bigeasy@linutronix.de>
 <20180716122740.q7oim7te5bybcniz@linutronix.de>
 <20180717003727.GA128433@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717003727.GA128433@kernel.org>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-16 17:37:27 [-0700], Shaohua Li wrote:
> On Mon, Jul 16, 2018 at 02:27:40PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2018-07-03 22:01:36 [+0200], To linux-kernel@vger.kernel.org wrote:
> > > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > > 
> > > The irqsave variant of atomic_dec_and_lock handles irqsave/restore when
> > > taking/releasing the spin lock. With this variant the call of
> > > local_irq_save is no longer required.
> > 
> > Shaohua, are you with this?
> 
> Acked-by: Shaohua Li <shli@kernel.org> 

Thank you. 
Is there a reason why you did not apply it or are you too busy now and
do it later (and just signal the ack that you are fine with it)?

Sebastian
