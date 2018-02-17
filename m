Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeBQTcL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:32:11 -0500
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:51164 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeBQTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:32:10 -0500
Date: Sat, 17 Feb 2018 12:32:08 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, rwright@hpe.com,
        maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com
Subject: Re: [v3,04/11] watchdog/hpwdt: white space changes
Message-ID: <20180217193208.GA27788@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180215234400.5022-5-jerry.hoemann@hpe.com>
 <20180217161734.GA671@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217161734.GA671@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 08:17:34AM -0800, Guenter Roeck wrote:
> On Thu, Feb 15, 2018 at 04:43:53PM -0700, Jerry Hoemann wrote:
> > Minor white space changes and some name clean up.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> > ---
> >  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
> >  
> > @@ -102,7 +100,7 @@ static int hpwdt_time_left(void)
> >  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
> >  }
> >  
> > -#ifdef CONFIG_HPWDT_NMI_DECODING
> > +#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
> >  static int hpwdt_my_nmi(void)
> >  {
> >  	return ioread8(hpwdt_nmistat) & 0x6;
> > @@ -133,7 +131,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >  
> >  	return NMI_HANDLED;
> >  }
> > -#endif /* CONFIG_HPWDT_NMI_DECODING */
> > +#endif					/* } */
> 
> I disagree with those changes. While I don't object to adding the '{'
> per se, I find it very useful to have the 'CONFIG_HPWDT_NMI_DECODING'
> with an endif to be able to associate it with the matching #ifdef.

The matching /* { */ and /* } */ allow for quickly the finding of the
matching ifdef/endif.

In the "vim" editor, the command '%' will take one from one curly paren to its
matching curly paren...

There is a similar sequence for emacs.

> 
> Deferring to Wim.
> 
> Guenter
> 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
