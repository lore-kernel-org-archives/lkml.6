Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2443EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83BB208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83BB208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966193AbeFORkT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:40:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51309 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966130AbeFORkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:40:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fTshp-0004pT-4q; Fri, 15 Jun 2018 19:40:13 +0200
Date:   Fri, 15 Jun 2018 19:40:13 +0200
From:   Sebastian Sewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: High-priority softirqs [was: [PATCH] usb: don't offload
 isochronous urb completions to ksoftirq]
Message-ID: <20180615174012.m6rqow2sytwgxxrx@linutronix.de>
References: <Pine.LNX.4.44L0.1806151308310.1387-100000@iolanthe.rowland.org>
 <alpine.DEB.2.21.1806151919130.1582@nanos.tec.linutronix.de>
 <20180615133428.20205bae@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615133428.20205bae@gandalf.local.home>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-15 13:34:28 [-0400], Steven Rostedt wrote:
> On Fri, 15 Jun 2018 19:28:34 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > One solution to that is to avoid both tasklets and kworkers and change the
> > USB code to make use of threaded interrupt handlers. I.e. handle the fast
> > stuff in the primary (hardirq) handler and delegate the rest to the irq
> > thread. That thread still can offload disk type stuff to a kworker if
> > needed. But the irq thread allows to bring the stuff under scheduler
> > control and experiments which I did a few years ago worked out pretty good.
> 
> If there's any question about this, drivers can request to have their
> interrupt handlers run as threads. This has been added to mainline
> years ago. And it really should be the default solution before pushing
> off to tasklets or kworkers.

 https://lkml.kernel.org/r/20180216170450.yl5owfphuvltstnt@breakpoint.cc

> -- Steve

Sebastian
