Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3ADC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67AC217BF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67AC217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeHVCoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 22:44:00 -0400
Received: from muru.com ([72.249.23.125]:54400 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeHVCn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 22:43:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 84A1180B8;
        Tue, 21 Aug 2018 23:25:33 +0000 (UTC)
Date:   Tue, 21 Aug 2018 16:21:44 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Message-ID: <20180821232144.GW94926@atomide.com>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2161372.IsD4PDzmmY@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [691231 23:00]:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the tick has been stopped already, but the governor has not asked to
> stop it (which it can do sometimes), the idle loop should invoke
> tick_nohz_idle_stop_tick(), to let tick_nohz_stop_tick() take care
> of this case properly.
> 
> Fixes: 554c8aa8ecad (sched: idle: Select idle state before stopping the tick)

This patch seems to fix an issue where boot hangs occasionally
on beagleboard-xm with ARM multi_v7_defconfig as reported by
kernelci.org and Mark Brown earlier at [0].

At least so far no boot hangs for me with this fix, so:

Tested-by: Tony Lindgren <tony@atomide.com>

[0] https://www.spinics.net/lists/linux-mmc/msg50480.html
