Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525682509-2-1936899806040917330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682509; b=cDTaUjFgwlakiE2dBMClMKznG85VSTNL70YK2DINVgZa98shKz
    uDo9gxEMbq5HdYBzldCK/Vivq4m5iZQ3eJPYvYujRVpoU04OWATWmcW0Wwd67FTy
    DEFz2lFnuGOHuNfG1ChybfmT9ybofOAZJqcUQLkYsd6KYIaXxwl4tk2TFSbYbgQF
    yRx7hNHTnghTSlS6Ox6G5O3pLkr25hrAxMuN5FysIKrAScJ3OZHmbi4I1vsrbmb1
    dEeTdl1QH1125pakJ0Lo6Rqo2aRlE7lOpZbQfWOCuiL4egtXpsafEIVwaz3DfMTU
    eAAKehHG8ApaMVd1rP6R0T4t2zCsKZmHyUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525682509; bh=vOSd9tJlNZ0
    Tj/6ah/N2GtPSpmPMmgZvl5mDp6BPPlE=; b=bFTkqd6KsP9kAZ475T1Im/nwzrH
    xHfZZ9TYVjPbPxuICOoS3Sy63xZW3YRo6MIIAVNgQHSgSfT31DWJtoqOnAKZ/GjN
    iq0D7EdNBq3ZK5/B+z0FGArt0UxBPk2ugB9DZiZmgWcBt9VG3wTxF5QV0ZEajiXW
    omAC/1/Dl9bGPhb6vb/rW8NSinWKHBv8C3P4zWCQiiD8fjie5rJVMqB3f85Lcsvx
    WmqF9RZktRuJBmT262CbbNEbfBSN9qY+gEpi7grCQPb1MdMDPhrFCddcW2OeguoW
    6hLfMaS5Mnj6sYZxxNiyJR2F3n64ddsj9HfKKbcyEybzzbTQvMdkMfWAKjQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfGX3/BnNmbGHScq3iN3bEcu1IOwJKt4hFEmpCUAm9/sg+f+KEw4SpRIOCqAqy1konDlVTS/aKYmt0QTlnzkEK+QrXUfbtfCrQtrp6cg9NILJoyS6mBz5
    jq93+jWnXEGMhHo1FWoClZ37uOAg+lO4XlPxife7ddRxz0y+v6JhjYnER/DTcJCbr4DDHwf0ve6U8nYQ22vNPNV+pjprvRWfoghorIWwakvMwenuntF4RsB4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=nUTvMOi8PXEK7IDn4w0A:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeEGIlf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 04:41:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55727 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbeEGIld (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 04:41:33 -0400
Date: Mon, 7 May 2018 10:41:27 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: linux-serial@vger.kernel.org,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] tty: implement led triggers
Message-ID: <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180507080252.GO2285@localhost>
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

Hello Johan,

thanks for your feedback.

On Mon, May 07, 2018 at 10:02:52AM +0200, Johan Hovold wrote:
> On Thu, May 03, 2018 at 10:19:52PM +0200, Uwe Kleine-König wrote:
> > The rx trigger fires when data is pushed to the ldisc. This is a bit later
> > than the actual receiving of data but has the nice benefit that it
> > doesn't need adaption for each driver and isn't in the hot path.
> > 
> > Similarily the tx trigger fires when data taken from the ldisc.
> 
> You meant copied from user space, or written to the ldisc, here.

ack.

> Note that the rx-path is shared with serdev, but the write path is not.
> So with this series, serdev devices would only trigger the rx-led.

Where would be the right place to put the tx trigger to catch serdev,
too?

> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Changes since v1, sent with Message-Id: 
> > 20180503100448.1350-1-u.kleine-koenig@pengutronix.de:
> > 
> >  - implement tx trigger;
> >  - introduce Kconfig symbol for conditional compilation;
> >  - set trigger to NULL if allocating the name failed to not free random
> >    pointers in case the port struct wasn't zeroed;
> >  - use if/else instead of goto
> 
> > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> >  		struct tty_buffer *head = buf->head;
> >  		struct tty_buffer *next;
> >  		int count;
> > +		unsigned long delay = 50 /* ms */;
> 
> Comment after the semicolon?

Given that this comment is about the 50 and not the delay member, I
prefer it before the ;.

> >  
> >  		/* Ldisc or user is trying to gain exclusive access */
> >  		if (atomic_read(&buf->priority))
> 
> > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > index 25d736880013..f042879a597c 100644
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
> > @@ -157,6 +158,30 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
> >  
> >  	tty_port_link_device(port, driver, index);
> >  
> > +#ifdef CONFIG_TTY_LEDS_TRIGGER
> > +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> > +					      driver->name, index);
> > +	if (port->led_trigger_rx_name) {
> > +		led_trigger_register_simple(port->led_trigger_rx_name,
> > +					    &port->led_trigger_rx);
> > +	} else {
> > +		port->led_trigger_rx = NULL;
> > +		pr_err("Failed to allocate trigger name for %s%d\n",
> > +		       driver->name, index);
> > +	}
> > +
> > +	port->led_trigger_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
> > +					      driver->name, index);
> > +	if (port->led_trigger_tx_name) {
> > +		led_trigger_register_simple(port->led_trigger_tx_name,
> > +					    &port->led_trigger_tx);
> > +	} else {
> > +		port->led_trigger_tx = NULL;
> > +		pr_err("Failed to allocate trigger name for %s%d\n",
> > +		       driver->name, index);
> > +	}
> > +#endif
> 
> Besides the ugly ifdefs here, you're leaking the above LED resources in
> the error paths below (e.g. on probe deferrals).

ack, the ifdevs are ugly. I'm working on an idea to get rid of them.
 
Will think about how to plug the leak.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
