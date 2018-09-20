Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB513ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206F821522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206F821522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbeIUDuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:50:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55736 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUDuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:50:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E23968074B; Fri, 21 Sep 2018 00:04:30 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:04:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: Trap WFI executed in userspace
Message-ID: <20180920220430.GA27468@xo-6d-61-c0.localdomain>
References: <20180807093326.5090-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807093326.5090-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-08-07 10:33:26, Marc Zyngier wrote:
> It recently came to light that userspace can execute WFI, and that
> the arm64 kernel doesn trap this event. This sounds rather benign,
> but the kernel should decide when it wants to wait for an interrupt,
> and not userspace.
> 
> Let's trap WFI and treat it as a way to yield the CPU to another
> process.

I don't think that's reasonable. Userspace should not be doing that, and we do not want
to encourage it. SIGILL would be reasonable, I'd  say.

(Very old mail, was forgotton in the queue)
