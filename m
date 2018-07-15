Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF090ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D5A2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D5A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeGOUFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:05:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeGOUFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:05:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6409CC9A;
        Sun, 15 Jul 2018 19:41:53 +0000 (UTC)
Date:   Sun, 15 Jul 2018 21:41:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        John Joseph <jnjoseph@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Rob Springer <rspringer@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
Message-ID: <20180715194150.GC2288@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-12-toddpoynor@gmail.com>
 <20180715090544.GC23333@kroah.com>
 <CAE_wzQ_YosCJro46uuF1v6TQhVaTaXLdiLVD7gb94BwQx00SuQ@mail.gmail.com>
 <20180715093216.GA16003@kroah.com>
 <CAE_wzQ9rsw14EbFpt4kdt8bRJYyjDVvMrf45u3-y4Dzs4NKwRg@mail.gmail.com>
 <20180715100345.GA17618@kroah.com>
 <CAO3upoZeTGDZsGaYGhmQE_7GaihLYPym6miD9vMWM5Fzi46GMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3upoZeTGDZsGaYGhmQE_7GaihLYPym6miD9vMWM5Fzi46GMA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 11:15:26AM -0700, Todd Poynor wrote:
> On Sun, Jul 15, 2018 at 3:03 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sun, Jul 15, 2018 at 12:53:09PM +0300, Dmitry Torokhov wrote:
> >> > I can't wait for people to just realize this whole "new" subsystem can
> >> > be replaced with UIO, but that's a topic for a different thread...
> >>
> >> Yes, that is true and that is why I am not sure why we are going
> >> through all this staging exercise.
> >>
> >> As far as I understand we'd still need to have quite a bit of kernel
> >> code so that we can safely program DMA controller (it does not look
> >> like uio_dmem_genirq.c is sufficient as is for gasket needs), but that
> >> should be solvable.
> >
> > I agree, it should be solvable, and much smaller and simpler than this
> > whole large chunk of "subsystem+driver" code.  But I'm not the one
> > having to do this work, and it provides a bunch of easy cleanups for
> > people looking to get into kernel development, so I don't mind :)
> >
> > But the "maintainers" should keep this in mind, as it is, this code is
> > _not_ acceptable for the main kernel tree because of the UIO framework
> > already present.
> 
> My own preference is to rewrite the apex driver entirely in-kernel and
> pull in its userspace parts here.  If I don't receive significant
> pushback on that I'll start doing that real soon.

Why would we object to that?

