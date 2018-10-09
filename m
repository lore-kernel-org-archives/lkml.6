Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C16C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79372087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79372087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJISHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:07:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJISHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:07:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g9pbc-0001ft-Hq; Tue, 09 Oct 2018 12:51:12 +0200
Date:   Tue, 9 Oct 2018 12:51:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181009105112.bhqlrabdt5ae5qmm@linutronix.de>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-09 11:24:26 [+0200], Juri Lelli wrote:
> The main concerns I have with the current approach is that, being based
> on mutex.c, it's both
> 
>  - not linked with futexes
>  - not involving "legacy" priority inheritance (rt_mutex.c)
> 
> I believe one of the main reasons Peter started this on mutexes is to
> have better coverage of potential problems (which I can assure everybody
> it had). I'm not yet sure what should we do moving forward, and this is
> exactly what I'd be pleased to hear your opinions on.

wasn't the idea that once it works to get rid of rt_mutex?

Sebastian
