Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3349553-1525810661-2-18406410743167242389
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
    1525810660; b=YSOyRwqhXxKhlUnP0HgKdhEV3aI+UGyw2cphiDlcOBUORcQJEl
    NN5/Bz1k2KlvJLtVn0Qcgn1olenEgSt8ymle2t8Tzil+e0vg5KAqUnp1EWAfOzhj
    6JHjTj+WJx29CjIL3OyV4medltL/smDNl9Eoc3CFoaDR3exuNJrJ8O6diqTAPTdO
    Dv8FacB3YHNi5RxkvPZHxo0s/+kkB/IWBgUhV8D5jf4J6wOqLf+JvioM9LtDbR1O
    pi6aEZ+XLcv3M8xTioQ3b2nUh5W764fNDtEvBFdEsYGLaey+FGYjWhR8WDLVgAjy
    sxAv4TqajgK1HLKKFo53cUImrC/dt5ykbeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525810660; bh=Cj1fQoYm0Bc
    nExUYIxJbTTfsae+jh1JpVGiwRbO9oSY=; b=H/NiMFz9ZJV1ZRK5iUrfJK3OEau
    Q4cg3lF7qb8K8n89GjVaHJkAAFS92PDegtT/Ktcy+ORxSdwoH15c7G5rJLkfC0xE
    4knUDqpRO0MuloPsSCkXeWkZNT0SSquWjTfTo5WcWVBt7U0lHRjeD3ovUsUwnId2
    2ub3Hf7aGGq1UtJWva4dlC5+ToS6S//86QWimKNSmkdlxs8bEjtRmHlHFEogrnqp
    Ba2X8j5hjRi0BF02sxboUH5MfQGTDIsF2M8ZdY/Y38LnpSUqVvsF0Zsg0clYiUab
    +pNl2f4Lfp3EsntnYMe/FoYqJmf5R7WlZY1UonHPkyR44nqwIWL1YN2tz6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNbUZD9npvE+5OXunvH4aE9RwaVtmQD4Gl3vaBFKzVkl15do76xCnDK+sDPGRVUcVxraAqxrWsu9koYmIktP/7wg5btqAwXlIo+Wq1dL+4raO2FvC3CZ
    zr5hA6OisFHbMcjgdmr2gOIR3/2SxHieZ8+D4Vv8kt8I1VfPfKj5Rj07u+7cVXsMMndDj4mtByB2/ouZXwJ+2DztG/XSgSNLcztsmwOq6v7woJIYKSiUZeyH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=rPz6akS9f96F6Qop2vYA:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755708AbeEHURi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 16:17:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48417 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755702AbeEHURi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 16:17:38 -0400
Date: Tue, 8 May 2018 22:17:25 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Robin Murphy <robin.murphy@arm.com>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
Message-ID: <20180508201725.3alpkcpaxebupzqv@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
 <ea34ce99-d446-03d2-b38d-d40a22480337@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea34ce99-d446-03d2-b38d-d40a22480337@gmail.com>
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

Hello Jacek,

On Tue, May 08, 2018 at 09:33:14PM +0200, Jacek Anaszewski wrote:
> Thank you for the patch. It looks fine, but please split
> the drivers/net/can/led.c related changes into a separate one.

I renamed led_trigger_rename_static() to led_trigger_rename() (and
changed the parameters). The can change just adapts the only user of
led_trigger_rename_static() to use the new one.

It's not impossible to separate this patches, but I wonder if it's worth
the effort.

The first patch would be like the patch under discussion, just without
the can bits and introducing something like:

	/*
	 * compat stuff to be removed once the only caller is converted
	 */
	static inline led_trigger_rename_static(const char *name, struct led_trigger *trig)
	{
		(void)led_trigger_rename(trig, "%s", name);
	}

Then the second patch would just be the 6-line can hunk. And a third
patch would remove the compat function. (Maybe I'd choose to squash the
two can patches together then, but this doesn't reduce the overhead
considerably.) The only upside I can see here is that it increases my
patch count, but it's otherwise not worth the effort for such an easy
change. Further more as there is a strict dependency on these three
patches this either delays the cleanup or (IMHO more likely) the can
change would go in via the led tree anyhow.  (Mark already acked patch 2
of this series and in private confirmed that the agrees to let this
change go in via the led tree, too.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
