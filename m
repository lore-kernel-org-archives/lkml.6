Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbeDBKZ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:25:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34046 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754394AbeDBKZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:25:53 -0400
X-Google-Smtp-Source: AIpwx4/hhBUaCPVjp590LYaQB6pxnaZjFONcJ3e420XD1+vpK96X/+rlVG1RwqxkAyjIUlJoQBBbsw==
Date: Mon, 2 Apr 2018 15:55:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        edubezval@gmail.com
Subject: Re: [PATCH] time: export nsec_to_clock_t
Message-ID: <20180402102550.GE3572@vireshk-i7>
References: <20180328141205.2954245-1-arnd@arndb.de>
 <1522335490.2964.2.camel@intel.com>
 <alpine.DEB.2.21.1803292108350.1486@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1803292108350.1486@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-03-18, 21:11, Thomas Gleixner wrote:
> On Thu, 29 Mar 2018, Zhang Rui wrote:
> > On 三, 2018-03-28 at 16:11 +0200, Arnd Bergmann wrote:
> > > nsec_to_clock_t was traditionally used only in the core kernel, now
> > > we
> > > have a sysfs file that needs it from a loadable module, causing a
> > > link-time error:
> > > 
> > > ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!
> > > 
> > > This exports the function the same way that we do for related
> > > interfaces.
> > > 
> > > Fixes: 96cea33badc5 ("thermal: Add cooling device's statistics in
> > > sysfs")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Thanks for the fix.
> > can I take this patch through thermal tree?
> 
> Well, the question is what's the point of that?
> 
> Why does a new interface expose time in state in clock_t instead in normal
> time units, e.g. nsec/usec/msec ?

The initial patch was displaying the values in msec, but eduardo asked the units
to be consistent with how cpufreq shows it, i.e. clock_t.

https://lkml.kernel.org/r/20180112174606.GA11076@localhost.localdomain 

Anyway I will resend the patch and move back to msec. Thanks.

-- 
viresh
