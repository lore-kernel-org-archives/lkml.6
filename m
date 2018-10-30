Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A39E20831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A39E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJ3V50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:57:26 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:43698 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727620AbeJ3V50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:57:26 -0400
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1gHTgg-0008Ug-UP; Tue, 30 Oct 2018 09:04:02 -0400
Date:   Tue, 30 Oct 2018 09:04:01 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-scsi@vger.kernel.org,
        Praneeth Bajjuri <praneeth@ti.com>,
        linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
Message-ID: <20181030130401.3ab5gl4fsvpa2fes@cs.cmu.edu>
Mail-Followup-To: Sam Protsenko <semen.protsenko@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-scsi@vger.kernel.org,
        Praneeth Bajjuri <praneeth@ti.com>, linux-kernel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20181029200311.16947-1-semen.protsenko@linaro.org>
 <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
 <20181030063408.GA26627@kroah.com>
 <CAKaJLVtT+pFzOBjybAXmOC0mJyN=BHavsfAYEzgSWn-i7UYEjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaJLVtT+pFzOBjybAXmOC0mJyN=BHavsfAYEzgSWn-i7UYEjA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:01:04PM +0200, Sam Protsenko wrote:
> On Tue, Oct 30, 2018 at 8:34 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Mon, Oct 29, 2018 at 10:05:49PM +0200, Sam Protsenko wrote:
> >> Hi Greg,
> >>
> >> On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
> >> <semen.protsenko@linaro.org> wrote:
> >> > The kernel is self-contained project and can be built with bare-metal
> >> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> >> > this u_quad_t type is not defined when using bare-metal toolchain and
> >> > codafs build fails. This patch fixes it by defining u_quad_t type
> >> > unconditionally.
> >> >
> >> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >> > ---
> >>
> >> Can you please pull this one, if this applicable? I sent it a while
> >> ago, but I guess it got lost in mailing list. It might be also
> >> applicable to stable branch (as it fixes allmodconfig build for ARM
> >> with bare-metal toolchain).
> >
> > Why are you asking me?  I'm not the maintainer of this file :(
> >
> > confused,
> >
> 
> Sorry to bother you. I just thought you might be interested in this
> one, as it fixes build for "allmodconfig" configuration, hence it can
> be related to stable branch. Also, maintainers didn't respond to that
> patch, so I'm kinda dead in the water.
> 
> Anyway, will try to ping maintainers one more time.

I thought I had responded, I didn't see a reason why one would want to
compile non-userspace kernel headers outside of the context of the
kernel and if you do have to do that why not just add -D__linux__.

However, I can also see the point that anything not in uapi/ pretty much
by definition will be compiled with __linux__ defined so it actually
doesn't make a discernable difference to just drop the ifdef and I'm
fine with a patch like this.

These trivial patches typically get picked up through kernel janitors,
or maybe an akpm linux-next patch queue. In fact, I'm not even sure if
there is a designated person I would be passing updates to, I've sent
patches to akpm, viro, hellwig, linus, and gregkh at various times.

Jan
