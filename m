Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeC2TL7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:11:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeC2TL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:11:58 -0400
Date: Thu, 29 Mar 2018 21:11:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Zhang Rui <rui.zhang@intel.com>
cc: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time: export nsec_to_clock_t
In-Reply-To: <1522335490.2964.2.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1803292108350.1486@nanos.tec.linutronix.de>
References: <20180328141205.2954245-1-arnd@arndb.de> <1522335490.2964.2.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1923257923-1522350708=:1486"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1923257923-1522350708=:1486
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 29 Mar 2018, Zhang Rui wrote:
> On 三, 2018-03-28 at 16:11 +0200, Arnd Bergmann wrote:
> > nsec_to_clock_t was traditionally used only in the core kernel, now
> > we
> > have a sysfs file that needs it from a loadable module, causing a
> > link-time error:
> > 
> > ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!
> > 
> > This exports the function the same way that we do for related
> > interfaces.
> > 
> > Fixes: 96cea33badc5 ("thermal: Add cooling device's statistics in
> > sysfs")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for the fix.
> can I take this patch through thermal tree?

Well, the question is what's the point of that?

Why does a new interface expose time in state in clock_t instead in normal
time units, e.g. nsec/usec/msec ?

That makes no sense whatsoever.

Thanks,

	tglx
--8323329-1923257923-1522350708=:1486--
