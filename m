Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeDMKII (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:08:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40070 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeDMKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:08:06 -0400
X-Google-Smtp-Source: AIpwx4+WQOoziS1gaZvu1pz4+5AoC6AJL28UOXvMRdONUIi5jeCKAV+WUrMaWk6u+oJzlOQ2AY1K4A==
Date: Fri, 13 Apr 2018 03:08:03 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Message-ID: <20180413100801.GA21913@localhost.localdomain>
References: <1523436077.16235.5.camel@intel.com>
 <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
 <1523509711.16235.25.camel@intel.com>
 <CA+55aFw0C-S0L-cnk0oROG=Khqy9s36O+g3_BxqPfewKGQ9_EQ@mail.gmail.com>
 <20180413040855.GA29826@localhost.localdomain>
 <1523597945.16235.52.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523597945.16235.52.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 01:39:05PM +0800, Zhang Rui wrote:
> Hi, Eduardo,
> 
> On 四, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> > Hello,
> > 
> > On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > > 
> > > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>
> > > wrote:
> > > > 
> > > > 
> > > > could you please illustrate me what the kconfig & warning is?
> > > Just "make allmodconfig" and the warning is about a uninitialized
> > > variable.
> > > 
> > > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> > > history
> > > is to be believed.
> > > 
> > >                 Linus
> > Yeah, this has also passed my local compilation error. Somehow my
> > gcc4.9
> > is not catching it. Using an older gcc (gcc4.6) does catch it.
> > 
> > Anyways, given that the conversion functions are written to cover
> > for unexpected cal_type, the right way of fixing this is to rewrite
> > the conversion functions to allow for returning error codes and
> > adjusting the callers as expected.
> > 
> > Rui, bzolnier, please consider the following fix:
> > 
> as it is late in this merge window, I'd prefer to
> 1. drop all the thermal-soc material in the first pull request which I
> will send out soon.
> 2. you can prepare another pull request containing the thermal-soc
> materials except the exynos fixes
> 3. exynos fixes with the problem solved can be queued for -rc2 or
> later.
> 

Agreed
