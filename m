Return-Path: <ukl@pengutronix.de>
X-Google-Smtp-Source: AB8JxZrYxegoSS4Gt0njpkE6Dyv9aeWesK40/lcYt3TQgAVaUlkoKLi24DiGsdPpZT/IAvkBPlya
ARC-Seal: i=1; a=rsa-sha256; t=1526151574; cv=none;
        d=google.com; s=arc-20160816;
        b=L4VsFaCCfdt63WIJW7UuxRFLBZC8LXJ+9TuI9tg+vom64bYsEfLpU7in+m+SXe5ST7
         4OMvlJ2180bMDZXp4iK1qlf1gTMfK4rdlUkmfZBsBD9NsItWVgJf20tWRUXkEkHkT1oU
         MHunqdAhBDAyEXad+XNDUYWxD50u/Z7zTxkr9oHwzKgmLPxlKnkTnms0wZSeVPsGFLS9
         px7wiQHp7rRJrE+BL2dYcllAI39+A7eFdwELIvqNQtO1qR77AhF6IHcpN9zJflBVbE7F
         YtLvVdIiCnmTecYuoIVbn/46rlzDK4kvg16y4si3Xj0zf2ng5TMOWmbec6JsPwG8JHx2
         v2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=M7+3vj9em1WXhoYZc31GsYvR4tqZN0nOBIIEiyt0Qcw=;
        b=WAArFKYlgOskyWigzy08NBwk7ksYj7StRbg29ZhahuEecGIiSnc5jFdD77tmO88dRc
         vfu3/xNFWbnR8VeUbWfR+JqHDxXVAoo7sNNK6S6jzkAn9zfRIeSbpzcD3H6UIPYbSwZl
         PzgGXecGdqcg+AooOTQ1o0K9mC7te6CdrGOv31p0ZHBAyHBif3lY4tmtc6Xzz5zupZOd
         WTqn7rFbondGdKxokC1O+3q4dDFgoUNVNfxJ6flZ6b+R8CuGAkSQYnlUlOtwZdoAlb+O
         ilyqCWxjXO92wN7t7cpSgUSA7JTfeqqG6Br+NJ0OWTsP2g3EWMWbSPvT1K+C+OFhprT3
         q0Og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Date: Sat, 12 May 2018 20:59:28 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>, linux-can@vger.kernel.org,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
Message-ID: <20180512185928.nzeyvxqnvfefqnzj@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
 <20180510112101.GD6977@amd>
 <20180510112229.GE6977@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180510112229.GE6977@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599889945768146525?=
X-GMAIL-MSGID: =?utf-8?q?1600285913615245051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 01:22:29PM +0200, Pavel Machek wrote:
> On Thu 2018-05-10 13:21:01, Pavel Machek wrote:
> > Hi!
> > 
> > > This allows one to simplify drivers that provide a trigger with a
> > > non-constant name (e.g. one trigger per device with the trigger name
> > > depending on the device's name).
> > > 
> > > Internally the memory the name member of struct led_trigger points to
> > > now always allocated dynamically instead of just taken from the caller.
> > > 
> > > The function led_trigger_rename_static() must be changed accordingly and
> > > was renamed to led_trigger_rename() for consistency, with the only user
> > > adapted.
> > 
> > Well, I'm not sure if we want to have _that_ many trigger. Trigger
> > interface is going to become.. "interesting".
> > 
> > We have 4K limit on total number of triggers. We use rather strange
> > interface to select trigger.
> > 
> > > @@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
> > >  
> > >  	if (msg == NETDEV_CHANGENAME) {
> > >  		snprintf(name, sizeof(name), "%s-tx", netdev->name);
> > > -		led_trigger_rename_static(name, priv->tx_led_trig);
> > > +		led_trigger_rename(priv->tx_led_trig, name);
> > >  
> > >  		snprintf(name, sizeof(name), "%s-rx", netdev->name);
> > > -		led_trigger_rename_static(name, priv->rx_led_trig);
> > > +		led_trigger_rename(priv->rx_led_trig, name);
> > >  
> > >  		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
> > > -		led_trigger_rename_static(name, priv->rxtx_led_trig);
> > > +		led_trigger_rename(priv->rxtx_led_trig, name);
> > >  	}
> > >  
> > 
> > I know this is not your fault, but if you have a space or "[]" in
> > netdev names, confusing things will happen.
> 
> Hmm. If we are doing this we really should check trigger names for
> forbidden characters. At least "[] " should be forbidden.

I think you don't expect me to change the patch, but to make this
explicit: My patch doesn't make this problem worse, so this would be an
orthogonal change and doesn't affect this one.

Spaces don't seem to be allowed in netdev names:

uwe@taurus:~$ sudo ip link set wlp3s0 name 'la la'
Error: argument "la la" is wrong: "name" not a valid ifname

(Didn't check if only ip forbids that, of if that is a kernel policy.) I
could rename my device to "lala[]" though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
