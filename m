Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967162AbeBNK1z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:27:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35544 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966996AbeBNK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:27:53 -0500
Date: Wed, 14 Feb 2018 11:27:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: pali.rohar@gmail.com, sre@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org,
        aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com,
        patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com,
        clayton@craftyguy.net, martijn@brixit.nl,
        Filip Matijevi? <filip.matijevic.pz@gmail.com>
Subject: Re: v4.13 on nokia n900: oops during tethering
Message-ID: <20180214102752.GA18007@atrey.karlin.mff.cuni.cz>
References: <20180212201000.GA25608@amd>
 <20180213222412.GA1116@mara.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213222412.GA1116@mara.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > During tethering, I got oops in ssi_stop_tx(), followed by failure of
> > GPRS. I used GPRS tethering a lot with some older kernel, and it was
> > stable for hours.
> > 
> > It seems v4.12 has the same problem. In v4.15 usb networking does not
> > work at all, so I can't test... v4.10 seems to have similar problem. (Testing is
> > slighlty tricky, as my internet connection is ... tethering using
> > N900.)
> 
> Based on a quick look ssi_stop_tx() is called too many times (i.e. once
> more than ssi_start_tx()). This would appear to be an interal problem
> with the SSI codebase (or whatever lies there; I don't know the current
> codebase).

If you had ideas for debugging patch or maybe a workaround, that would
be nice...

> Did this work in the past? When? There appear to have been changes in IRQ
> handling some time in 2016...

I could not find working version. It looks like it really depends on
workload... tethering over USB triggers it quickly, but apparently
only if I generate "right" ammount of network load.

There were also some power management changes....

GPRS traffic generated from N900 does not seem to trigger the problem,
or not easily.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
