Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030738AbeBNUx1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:53:27 -0500
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:33136 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030206AbeBNUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:53:25 -0500
Date: Wed, 14 Feb 2018 13:53:23 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com
Subject: Re: [PATCH v2 06/11] watchdog/hpwdt: Modify to use watchdog core.
Message-ID: <20180214205323.GA28235@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
 <20180212052111.12010-7-jerry.hoemann@hpe.com>
 <20180212090621.GA4513@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212090621.GA4513@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 10:06:21AM +0100, Marcus Folkesson wrote:
> Hi Jerry,
> 
> On Sun, Feb 11, 2018 at 10:21:06PM -0700, Jerry Hoemann wrote:
> > Follow Documentation/watchdog/convert_drivers_to_kernel_api.txt to
> > convert hpwdt from legacy watchdog driver to use the watchdog core.
> > 
> > Removed functions: hpwdt_open, hpwdt_release, hpwdt_write, hpwdt_ioctl
> > Removed data structures: hpwdt_fops, hpwdt_miscdev, watchdog_device
> > Modified functions: hpwdt_start, hpwdt_stop, hpwdt_ping, hpwdt_gettimeleft
> > Added functions: hpwdt_settimeout
> > Added structures: watchdog_device
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> 
> I think it would be better to use
>     dev_emerg()
>     dev_crit()
>     dev_alert()
>     dev_err()
>     dev_warn()
>     dev_notice()
> 
> instead of pr_* functions now when we have a device to use.



> >  }
> > @@ -128,8 +126,10 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >  	if ((ulReason == NMI_UNKNOWN) && !mynmi)
> >  		return NMI_DONE;
> >  
> > +	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
> 
> dev_dbg()
> 

Sorry, wasn't clear on my earlier response.  As hpwdt_pretiemout isn't
being passed a device, this instance will still be a pr_debug.  I have
converted the others to dev_.* in the next version of the series.




-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
