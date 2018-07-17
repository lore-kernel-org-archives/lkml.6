Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9806ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDC720673
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDC720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGQUQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:16:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56456 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeGQUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:16:22 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ffVrO-0007cK-Rl; Tue, 17 Jul 2018 21:42:10 +0200
Date:   Tue, 17 Jul 2018 21:42:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Julien Thierry <julien.thierry@arm.com>,
        linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, marc.zyngier@arm.com,
        mingo@kernel.org
Subject: Re: [RFC PATCH 1/4] genirq: Provide basic NMI management for interrupt
 lines
In-Reply-To: <20180717155117.GJ2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1807172141150.1817@nanos.tec.linutronix.de>
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com> <1531152846-19374-2-git-send-email-julien.thierry@arm.com> <alpine.DEB.2.21.1807171114280.3238@nanos.tec.linutronix.de> <e0c00482-7125-32e5-faa1-4251c118de5e@arm.com>
 <c4f7e808-d416-63c9-2972-fb90a5c72753@arm.com> <20180717155117.GJ2494@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Peter Zijlstra wrote:

> On Tue, Jul 17, 2018 at 04:48:17PM +0100, Julien Thierry wrote:
> > Supporting desc->affinity_hint for NMIs shouldn't be an issue, right?
> 
> Shouldn't NMIs be strictly per cpu interrupt sources?

Right. They are surely not subject to be fiddled with by irqbalanced or
random admin affinity settings.

Thanks,

	tglx

