Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9B5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5790820857
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5790820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbeGKNiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732469AbeGKNiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:38:11 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E57820846;
        Wed, 11 Jul 2018 13:33:48 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:33:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180711093346.782af07a@gandalf.local.home>
In-Reply-To: <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
        <20180522131004.3012953c@gandalf.local.home>
        <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
        <20180522132429.6f1dcf92@gandalf.local.home>
        <20180522173333.aawadhkcekzvrswp@linutronix.de>
        <20180711092555.268adf7f@gandalf.local.home>
        <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 15:31:57 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-07-11 09:25:55 [-0400], Steven Rostedt wrote:
> > Did you decide to create a local_lock_bh(lock) function? I don't see it.
> > 
> > And should this be backported to 4.14-rt too? You state you saw this in
> > 4.16-rt, but did you start doing something different then, or did the
> > kernel change?  
> 
> I wanted to re-evaluate the whole situation here but didn't get to it
> yet.

Thanks, I wont add this then.

-- Steve
