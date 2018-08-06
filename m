Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB473C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B42D21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubRCGwUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B42D21A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbeHGAmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:42:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43598 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHGAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:42:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so6210479plv.10;
        Mon, 06 Aug 2018 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNyCCAgKIbbpoFnhRlDV8TTBD+TVOHwxhaZ8yEcIBzY=;
        b=ubRCGwUL6M3Bbt5qFsf0tH0JwsghRpVqkcnnlNgr/lFK0hVuxEDfyGZJ9LI59ufBQH
         jH4AZoTpvlepUfZXv3aj+Y3o8YTIAhwAf3VtwGdidFkK9dWOXbi57lagLgTpR7DyrIoL
         6z4y3oRKu9KX1H2CAWX+Cxvl/G3SU8MB80zeoD9UzqQzTRgave9kG0Q3WYb5eUUPRl02
         iy7jDMBZdKZ9O79YIAk4JkekPl7FrOtUwbN+A3uAaIAv4t5vG9rlCMgn5wAc6LTjMmki
         zjdVmKQIc5ZOq91/tzYZBt03onpv+AdrgUyvfAhPgldkguKcopj9aacnWg5+Pzfz59yW
         /AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNyCCAgKIbbpoFnhRlDV8TTBD+TVOHwxhaZ8yEcIBzY=;
        b=OnKSiZDmCkEEfcwJnSFgwrtxwpyrs+33hiwcqKu5nfriH1E4ozVxgChLiji6OIjzh0
         Hms9kVjah6D3GfwZiKzv52oT1mL/IoTN1sF8G4Gx+u6W6Ro0ay/YGqL12uqpRuFdkoKm
         aPoEMTq8hKo+EI6U98IjPNEzchEFE0q8OmyamedQA+DzdqJrxjFZVSW7YkQpcqLZNG2F
         FtyHDD8nlO8Bdlfkj0AJZ8CEwdOh/z2VqDZB5WdCWaaJWdpaPl8Tz9DXw0OqvWw6UBHG
         mWoz00V2KXSkTsOPzrg33t3vkD9OdERrViPPwEAPgL57pg9c9csdAHflg/HBoD/XK6Fn
         fsUA==
X-Gm-Message-State: AOUpUlHM/TGKYYYgTPmKjRSBXqNk/fkqyxp4/4hNOCPMzV2tQV0wBTYl
        tWvJ5vQqEvxqtwYNzNibqzU=
X-Google-Smtp-Source: AAOMgpcBv8wCQrLDhb2pTCNt7KSZuqefHTRuy9rKdKOEAESvhxPE7V9nQ4n8KHvmxmgXZu4io6RH4Q==
X-Received: by 2002:a17:902:8541:: with SMTP id d1-v6mr15743829plo.81.1533594700161;
        Mon, 06 Aug 2018 15:31:40 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c85-v6sm30081661pfd.110.2018.08.06.15.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 15:31:39 -0700 (PDT)
Date:   Mon, 6 Aug 2018 15:31:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mark expected switch fall-throughs
Message-ID: <20180806223137.GB141444@dtor-ws>
References: <20180703203544.GA1015@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703203544.GA1015@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:35:44PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used: -Wimplicit-fallthrough=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/joystick/db9.c          | 5 +++++
>  drivers/input/keyboard/adp5589-keys.c | 1 +
>  drivers/input/mouse/appletouch.c      | 1 +
>  drivers/input/mouse/cyapa_gen5.c      | 1 +
>  drivers/input/mouse/cyapa_gen6.c      | 1 +
>  drivers/input/mouse/elantech.c        | 2 +-
>  drivers/input/mouse/sermouse.c        | 4 +++-
>  drivers/input/touchscreen/elo.c       | 1 +
>  8 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index de0dd47..0006da5 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -263,6 +263,7 @@ static unsigned char db9_saturn_read_packet(struct parport *port, unsigned char
>  			db9_saturn_write_sub(port, type, 3, powered, 0);
>  			return data[0] = 0xe3;
>  		}
> +		/* else: fall through */
>  	default:
>  		return data[0];
>  	}
> @@ -282,11 +283,14 @@ static int db9_saturn_report(unsigned char id, unsigned char data[60], struct in
>  		switch (data[j]) {
>  		case 0x16: /* multi controller (analog 4 axis) */
>  			input_report_abs(dev, db9_abs[5], data[j + 6]);
> +			/* fall through */
>  		case 0x15: /* mission stick (analog 3 axis) */
>  			input_report_abs(dev, db9_abs[3], data[j + 4]);
>  			input_report_abs(dev, db9_abs[4], data[j + 5]);
> +			/* fall through */
>  		case 0x13: /* racing controller (analog 1 axis) */
>  			input_report_abs(dev, db9_abs[2], data[j + 3]);
> +			/* fall through */
>  		case 0x34: /* saturn keyboard (udlr ZXC ASD QE Esc) */
>  		case 0x02: /* digital pad (digital 2 axis + buttons) */
>  			input_report_abs(dev, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
> @@ -380,6 +384,7 @@ static void db9_timer(struct timer_list *t)
>  			input_report_abs(dev2, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9_LEFT ? 0 : 1));
>  			input_report_abs(dev2, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9_UP   ? 0 : 1));
>  			input_report_key(dev2, BTN_TRIGGER, ~data & DB9_FIRE1);
> +			/* fall through */
>  
>  		case DB9_MULTI_0802:
>  
> diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
> index 32d94c6..2835fba 100644
> --- a/drivers/input/keyboard/adp5589-keys.c
> +++ b/drivers/input/keyboard/adp5589-keys.c
> @@ -885,6 +885,7 @@ static int adp5589_probe(struct i2c_client *client,
>  	switch (id->driver_data) {
>  	case ADP5585_02:
>  		kpad->support_row5 = true;
> +		/* fall through */
>  	case ADP5585_01:
>  		kpad->is_adp5585 = true;
>  		kpad->var = &const_adp5585;
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index 032d279..0aeed28e8 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -472,6 +472,7 @@ static int atp_status_check(struct urb *urb)
>  				dev->info->datalen, dev->urb->actual_length);
>  			dev->overflow_warned = true;
>  		}
> +		/* fall through */
>  	case -ECONNRESET:
>  	case -ENOENT:
>  	case -ESHUTDOWN:
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index 5775d40..14239fb 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -2554,6 +2554,7 @@ static int cyapa_gen5_do_operational_check(struct cyapa *cyapa)
>  		}
>  
>  		cyapa->state = CYAPA_STATE_GEN5_APP;
> +		/* fall through */
>  
>  	case CYAPA_STATE_GEN5_APP:
>  		/*
> diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
> index 0163978..c1b524a 100644
> --- a/drivers/input/mouse/cyapa_gen6.c
> +++ b/drivers/input/mouse/cyapa_gen6.c
> @@ -680,6 +680,7 @@ static int cyapa_gen6_operational_check(struct cyapa *cyapa)
>  		}
>  
>  		cyapa->state = CYAPA_STATE_GEN6_APP;
> +		/* fall through */
>  
>  	case CYAPA_STATE_GEN6_APP:
>  		/*
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index dd85b16..44f57cf 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -340,7 +340,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>  		 */
>  		if (packet[3] & 0x80)
>  			fingers = 4;
> -		/* pass through... */
> +		/* fall through */
>  	case 1:
>  		/*
>  		 * byte 1:  .   .   .   .  x11 x10 x9  x8
> diff --git a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
> index 8df5266..4431057 100644
> --- a/drivers/input/mouse/sermouse.c
> +++ b/drivers/input/mouse/sermouse.c
> @@ -143,7 +143,8 @@ static void sermouse_process_ms(struct sermouse *sermouse, signed char data)
>  			switch (sermouse->type) {
>  
>  				case SERIO_MS:
> -					 sermouse->type = SERIO_MP;
> +					sermouse->type = SERIO_MP;
> +					/* fall through */
>  
>  				case SERIO_MP:
>  					if ((data >> 2) & 3) break;	/* M++ Wireless Extension packet. */
> @@ -154,6 +155,7 @@ static void sermouse_process_ms(struct sermouse *sermouse, signed char data)
>  				case SERIO_MZP:
>  				case SERIO_MZPP:
>  					input_report_key(dev, BTN_SIDE,   (data >> 5) & 1);
> +					/* fall through */
>  
>  				case SERIO_MZ:
>  					input_report_key(dev, BTN_MIDDLE, (data >> 4) & 1);
> diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
> index 83433e8..7f2942f 100644
> --- a/drivers/input/touchscreen/elo.c
> +++ b/drivers/input/touchscreen/elo.c
> @@ -352,6 +352,7 @@ static int elo_connect(struct serio *serio, struct serio_driver *drv)
>  
>  	case 1: /* 6-byte protocol */
>  		input_set_abs_params(input_dev, ABS_PRESSURE, 0, 15, 0, 0);
> +		/* fall through */
>  
>  	case 2: /* 4-byte protocol */
>  		input_set_abs_params(input_dev, ABS_X, 96, 4000, 0, 0);
> -- 
> 2.7.4
> 

-- 
Dmitry
