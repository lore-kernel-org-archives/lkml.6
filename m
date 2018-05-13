Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526222083; cv=none;
        d=google.com; s=arc-20160816;
        b=jrwj44JULccS9syVK31M5lcPFGgdBnaeKCue6ozxs3wv4Uai6tpBzPgflYxypvlVg8
         j24ndIOjTCWYx1CXsL/tUSDn7dOSwpN0icEqgt2rIt2xsBGXVkIY4ceuN3/6ol7G/NPv
         PV4kX1dxM0oplNBfnQIChMjsQTad5vnx6q7v3dsG6FjIWawUwibztghg6jaguq2ey1lN
         CiqFtkF9gssCgH6M9hFye3+idwrrVp9aMH7oqrVelkg0MeIAARhMLtHqtA3HXg0mIt+s
         /oVQdW5yCeRGclGEmyneNKhVRgza7Wh67hMVj7tmqTG72XBVCleDwCJiuCAaXjqNHFyx
         4B9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AozWz5xWVE2LadIGHxkfroCdZUNZIW1P9RA56JGj0GA=;
        b=QNaogYHF+VyCVqAul0sMcVneyZQ0OAtoDshKsQNQCGIcQyfFa//6+x0r8ur0xJWDSc
         gS0hu0vIWKzOnilfZIdJeH4z1dPZUmgfH5KkpV6Q3wZuWbMk93jDXIce9ljOlsgwdTRt
         UDMrtuaYobDlefZH9/lZfZ4hANwKSMSvbG0wHNkBUQxSSGatySnhl4e8vTFrPc3UPfrR
         5JvDYNHA6Y9jJ7XybiuVp2BvHG9V3t5QFyW15mt46LYZa8qMSpOv04DflF/Le8GYj507
         dFXghua+0V27Drz9q9tjBhEwBnnahUgEUuwQCebp4SMlLfU0zhN0y9AFuOHjDct3Q8p8
         7DXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s0Y0+Yf4;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=s0Y0+Yf4;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr8Cl1FRV7DoIRaBIZWaR+WeIO7/3+SQdQrXlgeadOM0rDadyhF5X6x2BfHnpSCYbpWTZj29H0yI6n4Wr9lZdg=
MIME-Version: 1.0
In-Reply-To: <20180510112229.GE6977@amd>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de> <20180510112101.GD6977@amd>
 <20180510112229.GE6977@amd>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 17:34:42 +0300
Message-ID: <CAHp75VeWsbT+XuacdrKM6drzcxwx0inAUjtyU0WBX_SUTg6Lbg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] leds: triggers: provide led_trigger_register_format()
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
	Linux LED Subsystem <linux-leds@vger.kernel.org>, linux-can@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599889945768146525?=
X-GMAIL-MSGID: =?utf-8?q?1600359847296801508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 2:22 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2018-05-10 13:21:01, Pavel Machek wrote:

>> I know this is not your fault, but if you have a space or "[]" in
>> netdev names, confusing things will happen.
>
> Hmm. If we are doing this we really should check trigger names for
> forbidden characters. At least "[] " should be forbidden.

So, string_escape_mem() is your helper here.

-- 
With Best Regards,
Andy Shevchenko
