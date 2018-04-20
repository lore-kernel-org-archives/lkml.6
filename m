Return-Path: <ukl@pengutronix.de>
X-Google-Smtp-Source: AIpwx49cNv0gPWxocwUnpfZZPZ76TK3blUb4HxIo2/4kafwBiiv3ApTUKlDPJi+ezXGEDyn/wXhQ
ARC-Seal: i=1; a=rsa-sha256; t=1524204199; cv=none;
        d=google.com; s=arc-20160816;
        b=Io58eO2RVetWVRonCqOGsya93Cclhq/S7nbhwfeb/0xrX661hl3zfEeqCI0N+ufQMl
         NWSEKd1eAo9WIdUnMMq8UVsQkT0xGDkHaqMbrDk6Wh9iSjGmRvL/1bQJ9yDNryxqRTTy
         xo4j8RTBWK9uQTAgKlaZHvK4XBH2GNfGoEdbeZsUQdu6QYoiBy/IvcAmHfSYAin7YHWU
         coFJACBJvV4FTNbtzGLq2LTjne/Y945l9oLwRRcN1zS0H7g1mfnNwFu0Lp85P38YD2jw
         tw6744rSgzMYuynK+inscxBHe+6N1038VobWNgad65fK/TYcvuuSwGzWR/ZZVki/T1qj
         Z8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=yxtsdL29EdlW6eV0VyxgVS4OoWz5N4Unp8/ty6GkVzA=;
        b=cbFZOs86Lw7VcqReaD++sZVd2bBugFO8nToAmqA/D6SvFg9pJjHr9ghvXe5mCfXHcU
         D/iVoqHQZHjfYRcMOKs0wdk356kkjmKBw7WvxHpu89O5Gv7lP08opBqhTz5jQ7Ck/xuQ
         0UvCVKg0+dfWJWd4Ysi5VuEn4dWmTL8ZCfz6UsLfzQBpAX4+dQhLR1ayzwod60LLZ/A8
         Ow20ve5yH9Qw52evacpYIpLEDD7QdCoUVWzJfWIbMo5rHVY/IV73ooc80uRlGtOjHN68
         put4WDzr2poG8Zrhr0eNA5n87+WjRHuJO30RtjZa/BDzGiCBGlzqjq7H7K+djqahLux9
         xrxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Date: Fri, 20 Apr 2018 08:03:15 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: fix cached UCR2 read on software reset
Message-ID: <20180420060315.ob6eygfcibwq7f24@pengutronix.de>
References: <20180416153502.11814-1-stefan@agner.ch>
 <581f0f26d7191aa3355a6c63b531f876@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <581f0f26d7191aa3355a6c63b531f876@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597917613675943799?=
X-GMAIL-MSGID: =?utf-8?q?1598243942704456369?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Stefan,

On Thu, Apr 19, 2018 at 11:37:23PM +0200, Stefan Agner wrote:
> On 16.04.2018 17:35, Stefan Agner wrote:
> > To reset the UART the SRST needs be cleared (low active). According
> > to the documentation the bit will remain active for 4 module clocks
> > until it is cleared (set to 1).
> > 
> > Hence the real register need to be read in case the cached register
> > indcates that the SRST bit is zero.
> > 
> > This bug lead to wrong baudrate because the baud rate register got
> > restored before reset completed in imx_flush_buffer.
> 
> Given that you reviewed my other patch rather quickly, you might have
> overlooked this one?

no I didn't, still the ping was justified. I didn't look into it at once
because I didn't feel like opening the refman.
 
> Since it is a regression, this should go into v4.17 still...

That's right,

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I wonder what is different on your side that made it break. I didn't see
any breakage and tested that on a handful of different machines.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
