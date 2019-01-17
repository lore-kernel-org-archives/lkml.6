Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD499C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8053720856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfAQMOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:14:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46862 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:14:23 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gk6Yu-0005xY-89; Thu, 17 Jan 2019 13:14:20 +0100
Date:   Thu, 17 Jan 2019 13:14:20 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] x86/traps: Have read_cr0() only once in the #NM handler
Message-ID: <20190117121420.wsjyynxnznwkcew2@linutronix.de>
References: <20190117120728.3811-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117120728.3811-1-bp@alien8.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-17 13:07:28 [+0100], Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... instead of twice in the code. In any case, CR0 ends up being read
> once anyway:
> 
> 1. The CONFIG_MATH_EMULATION case does so and exits.
> 2. The normal case does it once too.
> 
> However, read it on function entry instead to make the code even simpler
> to follow.

makes sense.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
