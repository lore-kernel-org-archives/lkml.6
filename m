Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeEUML6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:11:58 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39024 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeEUMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:11:50 -0400
Date: Mon, 21 May 2018 13:11:41 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: ilialin@codeaurora.org
Cc: viresh.kumar@linaro.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Message-ID: <20180521121140.GO17671@n2100.armlinux.org.uk>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526898690-4018-1-git-send-email-ilialin@codeaurora.org>
 <20180521105428.GM17671@n2100.armlinux.org.uk>
 <000b01d3f0f3$aa961cc0$ffc25640$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01d3f0f3$aa961cc0$ffc25640$@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 02:05:41PM +0300, ilialin@codeaurora.org wrote:
> You are right.
> cpu_dev_silver != cpu_dev_gold, and I found this with my tests as well.
> Thank you.
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux <linux@armlinux.org.uk>
> > Sent: Monday, May 21, 2018 13:54
> > To: Ilia Lin <ilialin@codeaurora.org>
> > Cc: viresh.kumar@linaro.org; devicetree@vger.kernel.org; linux-
> > pm@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-soc@vger.kernel.org; linux-
> > clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
> > 
> > On Mon, May 21, 2018 at 01:31:30PM +0300, Ilia Lin wrote:
> > > +#define SILVER_LEAD	0
> > > +#define GOLD_LEAD	2
> > 
> > Okay, two different values here, but "GOLD_LEAD" appears unused.
> > 
> > > +	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> > > +	if (NULL == cpu_dev_silver)
> > > +		return -ENODEV;
> > > +
> > > +	cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> > > +	if (NULL == cpu_dev_gold)
> > > +		return -ENODEV;
> > 
> > get_cpu_device() takes the logical CPU number.  So the above gets CPU 0
> > each time, and so cpu_dev_silver == cpu_dev_gold here.  So what's the
> > point of the second get_cpu_device() ?  If it's supposed to be:
> > 
> > 	cpu_dev_gold = get_cpu_device(GOLD_LEAD);
> > 
> > That would get CPU 2, but in terms of these defines, it doesn't make that
> > much sense.  What exactly does "silver lead" and "gold lead" refer to in
> these
> > definitions?

I think you still need to explain this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
