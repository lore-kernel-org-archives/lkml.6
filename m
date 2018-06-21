Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDBFC4314A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D2A2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D2A2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbeFUUdF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:33:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39777 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeFUUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:33:04 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fW6GI-0004A3-Ba; Thu, 21 Jun 2018 22:32:58 +0200
Date:   Thu, 21 Jun 2018 22:32:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
In-Reply-To: <20180621201851.GC114883@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <20180621193738.GA13636@worktop.programming.kicks-ass.net> <20180621201851.GC114883@romley-ivt3.sc.intel.com>
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

On Thu, 21 Jun 2018, Fenghua Yu wrote:
> On Thu, Jun 21, 2018 at 09:37:38PM +0200, Peter Zijlstra wrote:
> > On Sun, May 27, 2018 at 08:45:49AM -0700, Fenghua Yu wrote:
> > > Currently we can trace split lock event counter for debug purpose. But
> > 
> > How? A while ago I actually tried that, but I could not find a suitable
> > perf event.
> 
> The event name is called sq_misc.split_lock. It's been supported in perf
> already.

So the obvious question is why not simply use that counter and capture the
IP which triggers the event?

I can see that this wont cover the early boot process, but there it's
enough to catch #AC once, yell loudly and then disable the thing. I'm not
seing the value of adding 1000 lines of code with lots of control knobs.

I might be missing something though and am happy to be educated.

Thanks,

	tglx


