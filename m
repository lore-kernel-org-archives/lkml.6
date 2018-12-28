Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA07C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCC321741
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbeL1AqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:46:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39773 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbeL1AqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:46:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1045C20A02; Fri, 28 Dec 2018 01:46:06 +0100 (CET)
Received: from localhost (sar95-h02-176-184-10-235.dsl.sta.abo.bbox.fr [176.184.10.235])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8E30320729;
        Fri, 28 Dec 2018 01:46:05 +0100 (CET)
Date:   Fri, 28 Dec 2018 01:46:04 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rv8803: Check return value of rv8803_write_reg
Message-ID: <20181228004604.GX2188@piout.net>
References: <20181227202856.27408-1-pakki001@umn.edu>
 <ab4c081a-82d7-4a50-5c2a-4dbb4ba79223@gmail.com>
 <CAK8KejrntOUb7Q2MrPR6mYDKyHKc=pzO5hOYv=ZfLaP_xg0Zsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8KejrntOUb7Q2MrPR6mYDKyHKc=pzO5hOYv=ZfLaP_xg0Zsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2018 17:28:33-0600, Kangjie Lu wrote:
> On Thu, Dec 27, 2018 at 4:31 PM Heiner Kallweit <hkallweit1@gmail.com>
> wrote:
> 
> > On 27.12.2018 21:28, Aditya Pakki wrote:
> > > In rv8803_handle_irq, rv8803_write_reg can return a failed return
> > > value when attempting to write to the bus. The fix checks the output
> > > and throws a dev_warn notifying of the failure.
> > >
> > > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > > ---
> > >  drivers/rtc/rtc-rv8803.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > You seem to submit the same type of changes throughout very
> > different subsystems. And you do it w/o thinking and testing.
> > If you would have looked at rv8803_write_reg() you would have
> > seen that it prints an error in case of failure. So your
> > patch achieves nothing.
> > You got David Miller upset already and it looks like you
> > want to achieve the same with other maintainers too.
> > I'd strongly suggest that you stop sending patches until
> > you better understand the kernel code.
> >
> 
> Hello Heiner,
> 
> Thanks for your suggestion. Sure, we will try to better understand
> how the kernel works when we are preparing other patches. We recently
> found a lot of potential bugs; due to the significant workload but
> limited labor force, we may make some mistakes, but yes, we will try
> to avoid them.
> 
> One main reason we submit the patches is to seek feedback from Linux
> maintainers who know how the kernel works best.  We hope to get: (1)
> confirmation: if this is indeed a bug;

Come on, this is your job, not the maintainer job to check whether there
is indeed a bug. Else, the maintainer may as well just remove your
authorship because he did all the real work.

> (2) improvement feedback: if
> it is a bug and our fix is problematic, how can we improve it?
> 
> Taking the case in this email as an example, rv8803_write_reg could
> fail, so returning IRQ_HANDLED even when it failed doesn't seem to be
> a good practice. Would "returning IRQ_NONE upon failure" be a better
> fix?
> 
> Thanks again for your suggestion.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
