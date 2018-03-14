Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521067555; cv=none;
        d=google.com; s=arc-20160816;
        b=iNGpd+ADfv34E1mcFrXz6MJzdb2CarJ+Eo1QCuCos10MwJmn3ChXKB9mIJOvU7pMuh
         bXbZ3tHhbo4m5tXno5CMa5Ub9lbEgN/2PMcXC0Q4on4gUkYz506ZQFuxTrNy4drz9Quv
         m90fkv7i8qPBkPKuBiBV8EzulNN5weyjCh+a5LNMjns1TtWa/P/17Tkkg0UdK5h8yOBd
         6jar5GhAdJL16LhPSOPaBDKqFhemJFp2v1NLDV5YGcJsE2L5Q/bXrPlJlkxwFQ/JPNCo
         PLjXQ+hRi1vH9Uoj/HN1xWqXuHjbl/iQbTOVFlhGEv6rJWMFjwreNujNIOX7WWDfA+da
         60Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=21Jha/+gSy4BToWkni7/8bLNW92bAjbIDezZPV4xG1g=;
        b=fJTRe0x3HW/r8N97xSlI6q2HwYjCYYohzi6FIjKJNy/gkkoG2ekE6oGyMXmK633Fgg
         sUrcDi4oJGrrbpnXFPRbznIQ1DvYxklAfpTYxfLjwOH4XixklJvh15XzySOdZmxNGjwC
         b8HREogGXFc0VqdtWLHWMGBtOYMpRHVVxtrWQ3+0vaR839CTF22d2Nxj7xE5qDMtAGFV
         o+NDflcz1MQjXm++0QOIXzsBqcQPI7Y6DlgjBMz6gj8hvzdHePJZlePZyLevhiHfaYPl
         nzrNqcNE5cNARjc21LaGj9Bakvpqk4OfYtTxkyd/6Mvs6IB/J+lxsYq8lvysp1+Xxdvn
         hsVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=j5Y+rvn2;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=j5Y+rvn2;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AG47ELslAkBvsXNXJmN7UmHIU+ZVxw95bSxVU3JFDwp3q+kz4FmU8fGS3t1tfBg5ZuN8mG9JgMNeHTpspFvW4QEfTfM=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Mar 2018 23:45:54 +0100
X-Google-Sender-Auth: do6KEOWTa9xqorsSdrsxZs2rYEc
Message-ID: <CAJZ5v0jsoxWRiwPOCJH6AAz-MiccOuicD8peCevLRMbTfc7LEg@mail.gmail.com>
Subject: Re: [PATCH 00/47] arch-removal: device drivers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>, Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, boris.brezillon@bootlin.com,
	cyrille.pitchen@wedev4u.fr, wg@grandegger.com, mkl@pengutronix.de,
	alexandre.belloni@bootlin.com, Mark Brown <broonie@kernel.org>, jic23@kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Jiri Slaby <jslaby@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, shli@kernel.org, linux-watchdog@vger.kernel.org,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-ide@vger.kernel.org,
	Linux PM <linux-pm@vger.kernel.org>, linux-crypto@vger.kernel.org,
	"open list:EDAC-CORE" <linux-edac@vger.kernel.org>, linux-gpio@vger.kernel.org,
	linux-i2c <linux-i2c@vger.kernel.org>, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, netdev <netdev@vger.kernel.org>,
	linux-can@vger.kernel.org, Linux PWM List <linux-pwm@vger.kernel.org>,
	linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
	"open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, linux-raid@vger.kernel.org,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594927909252349454?=
X-GMAIL-MSGID: =?utf-8?q?1594954932359612095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Hi driver maintainers,
>
> I just posted one series with the removal of eight architectures,
> see https://lkml.org/lkml/2018/3/14/505 for details, or
> https://lwn.net/Articles/748074/ for more background.
>
> These are the device drivers that go along with them. I have already
> picked up the drivers for arch/metag/ into my tree, they were reviewed
> earlier.
>
> Please let me know if you have any concerns with the patch, or if you
> prefer to pick up the patches in your respective trees.  I created
> the patches with 'git format-patch -D', so they will not apply without
> manually removing those files.
>
> For anything else, I'd keep the removal patches in my asm-generic tree
> and will send a pull request for 4.17 along with the actual arch removal.

Please include the cpufreq patches into that and you can add ACKs from
me on them if that helps.

Thanks!
