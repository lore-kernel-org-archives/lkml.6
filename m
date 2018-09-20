Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D4921522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D4921522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbeIUDu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:50:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55792 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeIUDu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:50:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 67E6280749; Fri, 21 Sep 2018 00:05:17 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:05:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, "Chen, Yu C" <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, kookoo.gu@intel.com
Subject: Re: [PATCH 04/12][RFC v3] x86, hibernate: Extract the common code of
 64/32 bit system
Message-ID: <20180920220516.GF27468@xo-6d-61-c0.localdomain>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <020db877db6a8d39808dfaef2a5162f541f0853b.1537275915.git.yu.c.chen@intel.com>
 <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
 <20180919103405.GA19621@gmail.com>
 <CAJZ5v0hq_qawFjpCsYvkOF=OotY+a2AuNc7eTR8RhaLyNPMd-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hq_qawFjpCsYvkOF=OotY+a2AuNc7eTR8RhaLyNPMd-w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-19 12:36:40, Rafael J. Wysocki wrote:
> On Wed, Sep 19, 2018 at 12:34 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > > > index 000000000000..fbde8f0e8fe0
> > > > --- /dev/null
> > > > +++ b/arch/x86/power/hibernate.c
> > > > @@ -0,0 +1,249 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Hibernation support for x86
> > > > + *
> > > > + * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
> > > > + * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
> > > > + * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
> > >
> > > I don't think this "copyright" information has any legal bearing any
> > > more at this point.
> >
> > I think that's wrong in general, and it's routine for corporate legal
> > departments to insist on specific boilerplate copyright notices when
> > OSS code is contributed.
> >
> > Copying code and then removing copyright notices is frowned upon
> > independently as well.
> >
> > While you can probably talk for your own copyright notice, I'm not sure
> > it's true of the two other historic copyright notices that were copied.
> >
> > So I think it's best practice to preserve all copyright notices as-is.
> 
> OK, let's retain them, then.

Thank you, I was about to make same comment as Ingo.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
