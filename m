Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A16DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB862086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB862086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeIYW45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:56:57 -0400
Received: from muru.com ([72.249.23.125]:57220 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbeIYW45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:56:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DCE1D80E2;
        Tue, 25 Sep 2018 16:52:56 +0000 (UTC)
Date:   Tue, 25 Sep 2018 09:48:33 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] ARM: dts: gta04: add serial console wakeup irq
Message-ID: <20180925164833.GP5662@atomide.com>
References: <20180923150719.8211-1-andreas@kemnade.info>
 <20180924220345.GG5662@atomide.com>
 <20180925072550.424e82e7@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925072550.424e82e7@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [180925 05:32]:
> Hi Tony,
> 
> On Mon, 24 Sep 2018 15:03:45 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Andreas Kemnade <andreas@kemnade.info> [180923 08:12]:
> > > This enables the possibility to have more aggressive runtime pm
> > > by providing proper wakeup irq for the serial console.  
> > 
> > Thanks applying to omap-for-v4.20/dt.
> > 
> > FYI, you can now grep wake /proc/interrupts and see the
> > wakeirq counts increase when they trigger. Might be handy
> > for debugging PM stuff.
> > 
> thanks for that information, you also had a patch for checking
> pm which was explicitely marked as not-to-merge. Is there
> any up-to-date version of it?

It's still the same so no updates to it.

> Well, for debugging I check first average currents via bq27000
> attached to omap_hdq. omap_hdq gets stuck after first transaction
> after idling uarts which does not happen when CM_AUTOIDLE1_CORE.AUTO_HDQ
> is cleared. Reloading the omap_hdq module to try to fix things
> makes w1 really freak out (patch already sent for that).
> Well, will do some rtfm and hopefully come back with a patch.
> afaicr there was something special...

Hmm sounds like drivers/w1/masters/omap_hdq.c needs to implement
PM runtime calls, it's probably just enabled because of only
needing the interconnect fck that the uart happens to keep
enabled.

> The result are power management problem in /dev/brain ;-)

:)

Tony


