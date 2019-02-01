Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1FCC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D7020833
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfBAV7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:59:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfBAV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:59:15 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gpgq5-0007ej-FQ; Fri, 01 Feb 2019 22:59:09 +0100
Date:   Fri, 1 Feb 2019 22:59:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Sebastian Sewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
In-Reply-To: <20190201161227.GG3770@osiris>
Message-ID: <alpine.DEB.2.21.1902012258290.8200@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de> <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de> <20190130233557.GA4240@linux.ibm.com> <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de> <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de> <20190201161227.GG3770@osiris>
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

On Fri, 1 Feb 2019, Heiko Carstens wrote:
> On Thu, Jan 31, 2019 at 06:06:53PM +0100, Sebastian Sewior wrote:
> > On 2019-01-31 17:52:28 [+0100], Heiko Carstens wrote:
> > > ...nevertheless Stefan and I looked through the lovely disassembly of
> > > _pthread_mutex_lock_full() to verify if the compiler barriers are
> > > actually doing what they are supposed to do. The generated code
> > > however does look correct.
> > > So, it must be something different.
> > 
> > would it make sense to use one locking function instead all three (lock,
> > try-lock, timed) in the test case to figure out if this is related to
> > one of the locking function?
> 
> I tried all three variants, but it seems to be close to impossible to
> re-create then. I had a single fail when using only the trylock
> variant, but I wouldn't say that means anything.
> 
> Only if all three variants run in parallel it seems to be quite
> reliably reproducible, even though sometimes it still takes an hour.

Were you able to capture a trace with the last set of additional trace
printks?

Thanks,

	tglx
