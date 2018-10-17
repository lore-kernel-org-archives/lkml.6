Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B856DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E812150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E812150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJQTzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:55:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:55:43 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCkUr-0006vo-Nl; Wed, 17 Oct 2018 14:00:17 +0200
Date:   Wed, 17 Oct 2018 14:00:17 +0200
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Message-ID: <20181017120017.cq5mkcrlwifrz7kn@linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
 <20181017103926.okjwwinlsyegyrhu@linutronix.de>
 <903c4734c77f4fbaba8598bc2effaf78@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <903c4734c77f4fbaba8598bc2effaf78@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-17 11:45:59 [+0000], David Laight wrote:
> Right, so it should be disabled before the CR3 reload and enabled after?

It was before commit decab0888e6e1 ("x86/mm: Remove
preempt_disable/enable() from __native_flush_tlb()") then it was lifted
to the caller.

> 	David

Sebastian
