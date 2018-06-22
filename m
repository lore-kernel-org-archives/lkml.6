Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6DAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5EB24911
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5EB24911
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbeFVV2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:28:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42820 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeFVV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:28:12 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWTbH-00049G-2k; Fri, 22 Jun 2018 23:28:11 +0200
Date:   Fri, 22 Jun 2018 23:28:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Stultz <john.stultz@linaro.org>
cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCHv2] timekeeping: Update multiplier when NTP frequency is
 set directly
In-Reply-To: <CALAqxLUh+A1nJF1n2G_pRPrUQPMD6b-9fAdojPmAOkmnUM+-Nw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806222327341.1589@nanos.tec.linutronix.de>
References: <20180604133421.19559-1-mlichvar@redhat.com> <alpine.DEB.2.21.1806222308560.1589@nanos.tec.linutronix.de> <CALAqxLUh+A1nJF1n2G_pRPrUQPMD6b-9fAdojPmAOkmnUM+-Nw@mail.gmail.com>
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

On Fri, 22 Jun 2018, John Stultz wrote:
> On Fri, Jun 22, 2018 at 2:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Mon, 4 Jun 2018, Miroslav Lichvar wrote:
> >
> >> When the NTP frequency is set directly from userspace using the
> >> ADJ_FREQUENCY or ADJ_TICK timex mode, immediately update the
> >> timekeeper's multiplier instead of waiting for the next tick.
> >>
> >> This removes a hidden non-deterministic delay in setting of the
> >> frequency and allows an extremely tight control of the system clock
> >> with update rates close to or even exceeding the kernel HZ.
> >>
> >> The update is limited to archs using modern timekeeping
> >> (!ARCH_USES_GETTIMEOFFSET).
> >
> > John ?????
> 
> Yea. I've got this in my toqueue list.  I'm going to take another pass
> at testing and hopefully send it your way.

No hurry. I just wanted to make sure that it didn't fall through the
cracks.

Thanks,

	tglx
