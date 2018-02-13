Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966075AbeBMXKy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:10:54 -0500
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:35377 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeBMXKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:10:53 -0500
Date: Tue, 13 Feb 2018 16:10:51 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 10/11] watchdog/hpwdt: remove allow_kdump module
 parameter.
Message-ID: <20180213231051.GD22295@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-11-jerry.hoemann@hpe.com>
 <20180213182042.GA26558@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213182042.GA26558@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:20:42AM -0800, Guenter Roeck wrote:
> On Sun, Feb 11, 2018 at 10:21:10PM -0700, Jerry Hoemann wrote:
> > The intent of this parameter is unclear and it sets up a
> > race between the reset of the system by ASR and crashdump.
> > 
> > The length of time between receipt of the pretimeout NMI
> > and the ASR reset of the system is fixed by hardware.
> > 
> > Turning the parameter off doesn't necessairly prevent a crash dump.
> > Also, having the ASR reset occur while the system is crash dumping
> > doesn't imply that the dump was hung given the short duration
> > between the NMI and the reset.
> > 
> > This parameter is not a substitute for having a architected watchdog
> > crashdump hang detection paridigm.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  drivers/watchdog/hpwdt.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index e9e54fe20804..bb0dcc8709b8 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -33,7 +33,6 @@
> >  static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
> >  static bool nowayout = WATCHDOG_NOWAYOUT;
> >  #ifdef CONFIG_HPWDT_NMI_DECODING
> > -static unsigned int allow_kdump = 1;
> 
> At the end of hpwdt_init_nmi_decoding(), there used to be a log message
> showing the value of allow_kdump. Maybe that was removed in another patch,
> but it really belongs to this patch, or am I missing something ?
> 
> Guenter

That got pulled into patch 6.  I'll refactor the patches to include the
message change here.



-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
