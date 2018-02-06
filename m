Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBFA5n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:57:43 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:45429 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeBFA5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:57:36 -0500
Date: Mon, 5 Feb 2018 16:57:33 -0800
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: andy.shevchenko@gmail.com, pali.rohar@gmail.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Message-ID: <20180206005733.GA11119@fury>
References: <1517420855-19374-1-git-send-email-mario.limonciello@dell.com>
 <20180204120922.fds52i22griw2h6e@pali>
 <CAHp75VcnDKP=kNPh7pU1v_f0+oP64ByKAOmkZzXNUVaXg=wDSg@mail.gmail.com>
 <9b01161fb81043b79cf9ade8ec348fff@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b01161fb81043b79cf9ade8ec348fff@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 04:49:35PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> > Sent: Sunday, February 4, 2018 8:28 AM
> > To: Pali Rohár <pali.rohar@gmail.com>
> > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Darren Hart
> > <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Platform Driver
> > <platform-driver-x86@vger.kernel.org>
> > Subject: Re: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap rather
> > than globally
> > 
> > On Sun, Feb 4, 2018 at 2:09 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > > On Wednesday 31 January 2018 11:47:35 Mario Limonciello wrote:
> > >> There is no longer a need for the buffer to be defined in
> > >> first 4GB physical address space.
> > >>
> > >> Furthermore there may be race conditions with multiple different functions
> > >> working on a module wide buffer causing incorrect results.
> > >>
> > >> Fixes: 549b4930f057658dc50d8010e66219233119a4d8
> > 
> > He-h, I had to notice this earlier...
> > 
> > > Ok, you can add my:
> > > Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> > 
> > Thanks and sorry, Pali, it's in for-next already, can't rebase.
> 
> Andy,
> Since it's already in for-next it's probably too late to add the stable CC too right?
> 
> So what's the proper time now to send this to @stable?  And should I just forward existing
> patch?

As a general rule, Andy and I should be adding Cc stable to most anything that
includes a Fixes tag that isn't from this review cycle. I've forgotten in the
past as well - sorry about that. Something we should add some tooling around I
think, so we don't miss it when checking things in to our review branches.

As to timing. As soon as this is merged to Linus' master, it can go to stable.
Instructions for doing this are in Documentation/process/stable-kernel-rules.rst

-- 
Darren Hart
VMware Open Source Technology Center
