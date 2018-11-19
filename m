Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F51C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3EB20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3EB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbeKSXvb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:51:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:48361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbeKSXva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:51:30 -0500
Received: from [98.118.28.103] ([98.118.28.103]) by
 msvc-mesg-gmx021.server.lan (via HTTP); Mon, 19 Nov 2018 14:27:37 +0100
MIME-Version: 1.0
Message-ID: <trinity-0de3e85e-8526-4004-b346-3b64dd89bc78-1542634057117@msvc-mesg-gmx021>
From:   "Qian Cai" <cai@gmx.us>
To:     "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "linux kernel" <linux-kernel@vger.kernel.org>, arnd@arndb.de,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Waiman Long" <longman@redhat.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] debugobjects: add a new Kconfig for POOL_SIZE
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 19 Nov 2018 14:27:37 +0100
In-Reply-To: <alpine.DEB.2.21.1811190904450.9459@nanos.tec.linutronix.de>
References: <20181118082255.1275-1-cai@gmx.us>
 <alpine.DEB.2.21.1811181919170.9459@nanos.tec.linutronix.de>
 <5939F7F3-E332-4112-861E-C6C0DF86717E@gmx.us>
 <alpine.DEB.2.21.1811190904450.9459@nanos.tec.linutronix.de>
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ozL6SoKj9pKODCHXYCDjZLvxBFfIcDw6CdAMqQq4J1wmW7Ey7xWCphdfPuiPZEvSxw7EH
 JcezaHgnvMKDfIx5mZo6hdz8WAHicXaF0zkogrvliCX4BZBusBccjlOA2WGAqk2Kg0G7Sv3Nq1Wt
 1Unz2PxzK6lbHzN6i1nP7k2R+pOUZiJuit5CY/6kbEDcYLJQPcBysdEra6zBUsbD390XOKu221Tp
 wJuznQZnnwtn3GmdqG5gr5AnAeV3Xt5ZHjTGrO1A5miJFR5htijkKaOGoUY+tMG88Qal44nDzMsH
 dcWGhYg5vyxIFdxRkeAPLuI
X-UI-Out-Filterresults: notjunk:1;V01:K0:zgTijqUqRNI=:1NOpCFWUqGl6R7GR6JFgcB
 UmcjOq4CpIffht2S9bWT1XsXw5Oln3rncBsS/FLDYHWTTLo/JSPoejpaf+6qzFN10hYL9a9RA
 0ErxEyEgRzgOGEQQCQiYV4JN4WZnI+bg3qk5jVj8cFRwMsgX1QB9CtebFdqwVTsrrJm7RaNvg
 QYYG131q5o1LnspMG1bitip36y+Ysd1PVinc8JwZW6HHerF3trYys5R5QAvTBS9mRAnyWvb0S
 WsxzmzPCzPJ/EunOQR0whCWeHUk7VdNiVH1h4O0UflJvg04SM+4CSO+zN2oAyQvFL1pepE3RE
 aorxS8+UWKaZ5HC//24BoEs7dNInKKoKoqyMJCQOY1T3bqlg5skWyRFinEcQ2xhmLWbBiO+AM
 gJUDV2vUxA+X/8Z4T9y0xZilSsOquR2p2WAwxJbE0eAQViKVFcH8MCaSPXFsHb0Uxma+Ej5OO
 lcA/jUkkzf2KIO/fdZn53Z8hE64qKxa7syJytsilYfJZQtARBc3SaDiQ3yLv99TVHu0oDLYP2
 zm6yFH6ntrxwc0bvo0cXak6i1XAchIcvLg8D63c7/VdIQYXw42x65SubN7/L0Wz/+fmN47mDs
 Cf4XLC79SjXiFSZ0VvvjNGzh/2xkbXnYzW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 at 3:09 AM, Thomas Gleixner wrote:

> Qian,
> 
> On Sun, 18 Nov 2018, Qian Cai wrote:
> > > On Nov 18, 2018, at 1:21 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Sun, 18 Nov 2018, Qian Cai wrote:
> > >> As the results, systems have 60+ CPUs with both timer and workqueue
> > >> objects enabled could trigger "ODEBUG: Out of memory. ODEBUG disabled".
> > >> 
> > >> Hence, add a new Kconfig option so users could adjust ODEBUG_POOL_SIZE
> > >> accordingly if either timer or workqueue objects are selected.
> > > 
> > > why do we need a config option, when the required number can be deduced
> > > already from the active CONFIG_DEBUG_OBJECTS_* and NR_CPUS?
> > > 
> > It because I am worry about the coupling between the implementation details of
> > timers and workqueue objects, and the computation in the code you mentioned
> > here. For example, people could change workqueue.c to have different number
> > of worekqueues initialized during the early boot in the future which is going to
> > affect the required pool size, and I am not sure if people are going to adjust the
> > code in debugobjects.c here as well when they made changes like that.
> > 
> > Also, the computation could become so complex depends on lots of config
> > options like perf, hrtimer, and combinations that I have not tested so far which is
> > difficult to exhausted all the possibilities.
> > 
> > Hence, I feel like the Kconfig option is more flexible and less error-prone.
> 
> Quite the contrary. Config options are a pain and truly error-prone if you
> want to compile general purpose kernels as distributions do.
> 
Ah, I never thought distributions people would
enable those debugging options.
> Its not really a problem to have a larger initial static pool which gets
> freed after init anyway. So we can size it generously depending on the
> config options and be done with it.
> 
That’s a good point. I’ll send out a patch shortly.
