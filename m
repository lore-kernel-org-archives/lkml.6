Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51294C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161AC20852
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161AC20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbeGKNgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:36:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbeGKNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:36:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fdFDp-0000ku-PW; Wed, 11 Jul 2018 15:31:57 +0200
Date:   Wed, 11 Jul 2018 15:31:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711092555.268adf7f@gandalf.local.home>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-11 09:25:55 [-0400], Steven Rostedt wrote:
> Did you decide to create a local_lock_bh(lock) function? I don't see it.
> 
> And should this be backported to 4.14-rt too? You state you saw this in
> 4.16-rt, but did you start doing something different then, or did the
> kernel change?

I wanted to re-evaluate the whole situation here but didn't get to it
yet.

> Thanks!
> 
> -- Steve

Sebastian
