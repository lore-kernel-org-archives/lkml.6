Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeA3K2Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:28:24 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:36721 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeA3K2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:28:23 -0500
Date: Tue, 30 Jan 2018 11:27:40 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Grzeschik <mgr@pengutronix.de>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com, kernel@pengutronix.de,
        Denis.Osterland@diehl.com
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Message-ID: <20180130102740.GD2809@piout.net>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-5-m.grzeschik@pengutronix.de>
 <20180123182254.GA27379@roeck-us.net>
 <20180124090333.r5o2mzpm4q536w4r@pengutronix.de>
 <20180129215919.GA17988@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129215919.GA17988@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2018 at 13:59:19 -0800, Guenter Roeck wrote:
> On Wed, Jan 24, 2018 at 10:03:33AM +0100, Michael Grzeschik wrote:
> [ ... ]
> > > > +
> > > > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > > > index fc337c317c673..a12b3c2b2a18c 100644
> > > > --- a/Documentation/hwmon/sysfs-interface
> > > > +++ b/Documentation/hwmon/sysfs-interface
> > > > @@ -702,6 +702,13 @@ intrusion[0-*]_alarm
> > > >  		the user. This is done by writing 0 to the file. Writing
> > > >  		other values is unsupported.
> > > >  
> > > > +intrusion[0-*]_timestamp
> > > > +		Chassis intrusion detection
> > > > +		YYYY-MM-DD HH:MM:SS UTC (ts.sec): intrusion detected
> > > > +		RO
> > > > +		The corresponding timestamp on which the intrustion
> > > > +		was detected.
> > > > +
> > > 
> > > Sneaky. Nack. You don't just add attributes to the ABI because you want it,
> > > without serious discussion, and much less so hidden in an RTC driver
> > > (and even less as unparseable attribute).
> > 
> > Right; but it was not meant to be sneaky. I should have stick to my first
> > thought and label this patch RFC. Sorry for that.
> > 
> > > In addition to that, I consider the attribute unnecessary. The intrusion
> > > already generates an event which should be sufficient for all practical
> > > purposes.
> > 
> > Would it make sense in between the other sysfs attributes of this driver?
> > 
> I don't understand what you mean with that, sorry.
> 
> From an ABI perspective, the attibute doesn't add value since it is
> highly device specific (or at least it is the only chip I am aware of
> which reports such a time stamp). Feel free to add the attribute to the
> driver and document it, but not as part of the hwmon ABI. In that
> case I would be inclined to accept it. However, keep in mind that
> your version, reporting a human readable date/time, would effectively
> preclude it from ever making it into the ABI.
> 

Actually, there are many RTCs that are able to register one or more
timestamps. My plan was to add support for that soon but I was not
planning to do so in the hwmon ABI as this may be used for something
that is not intrusion detection (interval timers for example).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
