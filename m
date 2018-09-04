Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832FC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C4206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0C4206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIDUEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:04:10 -0400
Received: from muru.com ([72.249.23.125]:55244 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbeIDUEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:04:09 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4306C80E1;
        Tue,  4 Sep 2018 15:42:30 +0000 (UTC)
Date:   Tue, 4 Sep 2018 08:38:28 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, Kishon <kishon@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix wakeirq handling on removal
Message-ID: <20180904153828.GC5662@atomide.com>
References: <20180902073058.17053-1-andreas@kemnade.info>
 <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpHPre_turpYtpB+N+LHR+EMW2p2GJ92J1zu8h6p5W=LQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [180904 14:39]:
> On 2 September 2018 at 09:30, Andreas Kemnade <andreas@kemnade.info> wrote:
> > after unbinding mmc I get things like this:
> > [  185.294067] mmc1: card 0001 removed
> > [  185.305206] omap_hsmmc 480b4000.mmc: wake IRQ with no resume: -13
> >
> > The wakeirq stays in /proc-interrupts
> >
> > rebinding shows this:
> > [  289.795959] genirq: Flags mismatch irq 112. 0000200a (480b4000.mmc:wakeup) vs. 0000200a (480b4000.mmc:wakeup)
> > [  289.808959] omap_hsmmc 480b4000.mmc: Unable to request wake IRQ
> > [  289.815338] omap_hsmmc 480b4000.mmc: no SDIO IRQ support, falling back to polling
> >
> > That bug seems to be introduced by switching from devm_request_irq()
> > to generic wakeirq handling.
> >
> > So let us cleanup at removal.
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Fixes: 5b83b2234be6 ("mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq")

Ooops sorry about that.

> Applied for fixes, and added a stable tag, thanks!

OK and thanks for fixing this Andreas!

Regards,

Tony
