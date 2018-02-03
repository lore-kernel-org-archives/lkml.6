Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeBCPMD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:12:03 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:57009 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeBCPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:11:53 -0500
Date: Sat, 3 Feb 2018 15:11:25 +0000
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nicholas Mc Guire <hofrat@osadl.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: i2c: drop unnecessary .owner field in
 examples
Message-ID: <20180203151125.GA17486@osadl.at>
References: <1516018126-16119-1-git-send-email-hofrat@osadl.org>
 <CAHp75VeamZDS=-bwGYn41y0pwKEptRE02W3bRe326Q34i68=yg@mail.gmail.com>
 <20180115202847.77s42fgc2zsdnc6s@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115202847.77s42fgc2zsdnc6s@ninjato>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 09:28:47PM +0100, Wolfram Sang wrote:
> On Mon, Jan 15, 2018 at 10:24:52PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 15, 2018 at 2:08 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > > From: Nicholas Mc Guire <hofrat@osadl.at>
> > >
> > >  Currently there are a few drivers that still set the .owner
> > >  in the i2c_driver structure - all of which are reported by
> > >  coccinelle (scripts/coccinelle/api/platform_no_drv_owner.cocci)
> > >  and there are no cases that set the .onwer and do not call any
> > >  of the functions that set the .owner field anyway in any of the
> > >  drivers (checked by a modified coccinelle script based on the
> > >  above) so it seems that the examples are no longer valid and
> > >  .owner = THIS_MODULE, can be removed here.
> > >
> > >  While at it an obvious typo (new new) was also fixed.
> > 
> > AFAIU It is right only in case when someone does this, e.g.
> > module_i2c_driver() macro. Otherwise the field is pretty valid and
> > must be filled.
> 
> It gets filled with i2c_add_driver. module_i2c_driver uses
> i2c_add_driver. I was about to suggest to keep the field in the old
> driver and describe that it can be removed when using one of
> i2c_add_driver or module_i2c_driver.
> 
> But then I realised that the kernel tree does not have any such old
> drivers anymore and I couldn't even find out-of-tree code via some
> search engines (I tried looking for "I2C_CLIENT_INSMOD").
> 
> I consider this obsolete and irrelevant these days. It might be good to
> simply remove it to not confuse users.
> 
Not sure what the status of this is now - but I would
want to clean up some of the coccinelle findings - as a pre-requisite
it would make sense to either drop the examples inclusion of
.owner = THIS_MODULE or add a note in the documentation making
clear that this is only needed in case where the appropriate
module initialization helpers are not used. Is there any good
reason *not* to use these initialization helpers when upgrading
a driver ? If not (and I could not find one) then it might simply
be the right way to recommend using the initialization helpers and
drop the .owner = THIS_MODULE from the examples.

Anyway - cleaning up coccinelle findings would seem futile if the
documentation may be the cause.

thx!
hofrat
