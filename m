Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2438926-1525348367-2-2605638209237930616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525348367; b=f4RvcsKait+tFCaDIjGLtTAwRhl/WT80RPsvR6Yc9wIhuYvV5g
    cofl9gklmdy7PlA2EGnPu768k2DOSmbEugKLUYIlV1z1JH3ed7BAroE0ffeoT9s5
    g3KjLar8OzLwPppMA8x+Z7ITqPXYn3SGtx6UQkz3Cy9KXpoGk9R3RB5uQqygKjI5
    0/85fJyrSyUH/QE476fu6LZ/24TSYs0L/mwq63tAcrweIWoTvusT6zFVIAe/pePb
    u9+r9nTdPcutTZesClcNmTloAhCj6qGWBtzRd1Ht8wTgOP5k3Loq1xjY3pgETZ0B
    wHQFxqGEsAtzrUK86TA+6ATZsepPgNI90Wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525348367; bh=DT29R5Jv7/c
    tyZPAk+I71qKelbs9Sv+LU/V0Q4iOTuI=; b=B9pva2IvINLxrILKAZl/uzzMbOS
    pufDm3CxdDm2PmKDMEXD3x1WGZfYpGXkur7dqltV7q1mgJw5ySl0Eiy7bzZCKc+C
    DUyEkm2EJRDomMEy/WGaSMlRcqGQVd+peFjJ5vk0uSvd91tuLcwlgxzNdvHRny55
    POcPffNF06l5szELts9vEzWv/TIYrHGsvR6SB8/tc2J7hgu+hpzsImdTHpL0cePS
    bix9xgD3BdzeKzMK4IyfuA13LYm+cIDpWUeDeAahox3/u6QdpSH185tn9Uamt2Kk
    RpYTaUN95obAY8tSYr3fwd64545GBvGXhgGLbUGP9ZgEMB+nsAu8xztjzTA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIlIUtabOlNkeDX/5eFpls+X1T1jDGDn5hEDAemiAw0X19U4oV6lE7/BSe9amG43wlzTTeeNkv+n2Qi+OpOoT2CT1s542xfCKHbIY0uzp++KzMeDt7Ae
    yEIbJpldx2nCKcmVNPGEBlh+y5PMNoBwG5KZ0z4esAqfN1wC0S/ni6MBwmoGGPLdYoQpo1I9nNPFGmoRBZ1z3IEBvcCy9n73vl8t7IwnSgclpVbsakWZLO5Z
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=kMeOZ7sdGS2vkW5sB7oA:9
    a=HFkPjQK4fOao-DIG:21 a=D-qzHcMTX2D0UQ-i:21 a=wPNLvfGTeEIA:10
    a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbeECLwd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 07:52:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60271 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeECLwb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 07:52:31 -0400
Date: Thu, 3 May 2018 13:52:27 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: implement a rx led trigger
Message-ID: <20180503115227.gogvknx5sbuyrcey@pengutronix.de>
References: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
 <20180503101047.GF32180@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180503101047.GF32180@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 12:10:47PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The trigger fires when data is pushed to the ldisc. This is a bit later
> > than the actual receiving of data but has the nice benefit that it
> > doesn't need adaption for each driver and isn't in the hot path.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Well, why not, but there certainly should be config option? Because I
> really don't see many people wanting to use this trigger.

Yeah, can be done. I'll implement this for v2.

> > diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> > index c996b6859c5e..4d364b77b1a7 100644
> > --- a/drivers/tty/tty_buffer.c
> > +++ b/drivers/tty/tty_buffer.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/leds.h>
> >  
> >  
> >  #define MIN_TTYB_SIZE	256
> > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> >  		struct tty_buffer *head = buf->head;
> >  		struct tty_buffer *next;
> >  		int count;
> > +		unsigned long delay = 50 /* ms */;
> >  
> >  		/* Ldisc or user is trying to gain exclusive access */
> >  		if (atomic_read(&buf->priority))
> > @@ -521,6 +523,8 @@ static void flush_to_ldisc(struct work_struct *work)
> >  			continue;
> >  		}
> >  
> > +		led_trigger_blink_oneshot(port->led_trigger_rx, &delay, &delay, 0);
> > +
> >  		count = receive_buf(port, head, count);
> >  		if (!count)
> >  			break;
> > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > index 25d736880013..51b78a585417 100644
> > --- a/drivers/tty/tty_port.c
> > +++ b/drivers/tty/tty_port.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/bitops.h>
> >  #include <linux/delay.h>
> > +#include <linux/leds.h>
> >  #include <linux/module.h>
> >  #include <linux/serdev.h>
> >  
> > @@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
> >  
> >  	tty_port_link_device(port, driver, index);
> >  
> > +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> > +					      driver->name, index);
> > +	if (!port->led_trigger_rx_name) {
> > +		pr_err("Failed to allocate trigger name for %s%d\n",
> > +		       driver->name, index);
> > +		goto skip_trigger;
> > +	}
> > +
> > +	led_trigger_register_simple(port->led_trigger_rx_name,
> > +				    &port->led_trigger_rx);
> > +
> > +skip_trigger:
> >  	dev = serdev_tty_port_register(port, device, driver, index);
> >  	if (PTR_ERR(dev) != -ENODEV) {
> >  		/* Skip creating cdev if we registered a serdev device */
> > @@ -206,6 +219,9 @@ void tty_port_unregister_device(struct tty_port *port,
> >  	if (ret == 0)
> >  		return;
> >  
> > +	led_trigger_unregister_simple(port->led_trigger_rx);
> 
> Is it ok to unregister if it was not registered in the first place?

led_trigger_unregister_simple() looks as follows:

	if (trig)
		led_trigger_unregister(trig);
	kfree(trig);

So yes, it does the right thing when it wasn't registered. Assuming it
is NULL then, which doesn't seem to be guaranteed. Probably I'd need

	port->led_trigger_rx = NULL
	
if kasprintf failed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
