Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E7EC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC292085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC292085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJLDij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:38:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48432 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeJLDij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:38:39 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gAhHI-0001MF-I4; Thu, 11 Oct 2018 22:09:48 +0200
Date:   Thu, 11 Oct 2018 22:09:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
cc:     kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: -next20181010,1011 regression: thinkpad x60 (32 bit) dies during
 boot.
In-Reply-To: <20181011180328.GA6740@amd>
Message-ID: <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
References: <20181010195920.GA13860@amd> <20181010200331.GA13975@amd> <20181011180328.GA6740@amd>
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

On Thu, 11 Oct 2018, Pavel Machek wrote:

> On Wed 2018-10-10 22:03:32, Pavel Machek wrote:
> > Hi!
> > 
> > > I updated to todays next... and boot crashes with
> > > 
> > > ..
> > > Call Trace:
> > > kick_ilb
> > > trigger_load_balance
> > > ? active_load..
> > > scheduler_tick
> > > update_process_times
> > > tick_nohz_handler
> > > 
> > > -next20181005 worked ok.
> 
> Problem is still there in today's next.

So what came in between -next20181005 and the first bad one? kernel/sched/*
being the first place to look at.

Thanks,

	tglx
