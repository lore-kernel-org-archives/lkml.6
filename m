Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B122C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D336F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeICL5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:57:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54474 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeICL5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:57:30 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwjR9-0003UN-IT; Mon, 03 Sep 2018 09:38:15 +0200
Date:   Mon, 3 Sep 2018 09:38:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Kevin Shanahan <kevin@shanahan.id.au>,
        Siegfried Metz <frame@mailbox.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
In-Reply-To: <20180903072506.GS24124@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org> <20180830130439.GM24082@hirez.programming.kicks-ass.net> <20180901022125.GO4941@tuon.disenchant.local> <20180903072506.GS24124@hirez.programming.kicks-ass.net>
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

On Mon, 3 Sep 2018, Peter Zijlstra wrote:
> On Sat, Sep 01, 2018 at 11:51:26AM +0930, Kevin Shanahan wrote:
> > commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
> > Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Date:   Tue Aug 18 17:09:42 2009 +0200
> > 
> >     clocksource: Avoid clocksource watchdog circular locking dependency
> > 
> >     stop_machine from a multithreaded workqueue is not allowed because
> >     of a circular locking dependency between cpu_down and the workqueue
> >     execution. Use a kernel thread to do the clocksource downgrade.
> 
> I cannot find stop_machine usage there; either it went away or I need to
> like wake up.

timekeeping_notify() which is involved in switching clock source uses stomp
machine.

Thanks,

	tglx

