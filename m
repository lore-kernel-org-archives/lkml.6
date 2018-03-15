Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521104984; cv=none;
        d=google.com; s=arc-20160816;
        b=K35pNiRA/2nomATde9P0niec4EdJ0VHcB/fpOdBAclnCifYy0zZ4UfqQQ0c37760mS
         qfQJ1pM6SeEYN1h8MAk+u0nXs4vVdfsASLd9kLM6bjDFxgfYL7CD2RURRvLBIlOgxho2
         9WdAndKLiYIfQucgl03abkoKeIvMavbltnYXx0YIEQaOV26EEUv6UhqBUJirBKQih6PZ
         9Z+h/cJ8s7AMAYM1viNKnVk7jjk4O4KqWadFQ5bwoQxQ/Da3AunElra3VkRRvviq3ejF
         bShKqwj+Nunl6s180P6WyacDzYPeE6MoKcCXhH7M1lUgEcQ8W2QMlJIITba5ZtUHPct3
         CY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3vH19icGt60cUWf0Uwc73FuYPkh4s1WU6fG3lDEzI08=;
        b=jtGPb9+5bqH40SM7Vl5zxf6loe7+HBFlVYSjZFa1R8scv9l/oBagjk77HyauvMFcHx
         +LBDsAzhn/VRvR5oOdOKR3IG6fbCfoz8PGDp+5a6QBVSCw6HLgk61OPs7+xxyjo1g/rQ
         fOI48iik1dq6bylBrB5mZfKdEejMFvLpl6FVZSRRQ8TTj0WfpmVB13I+HLgcTLZIkDRi
         XMWXLCYXPnZ/OOJRRYNaZ8c+ijG30b/Jht3vhH6myDJ8WQKZltUsp2L1Z3rYBezktEgl
         9NZl3sex3TtBY/FC+/uLBuOqk7q9qcXNN4ZlkJeZPqa7i3AO9fvj5JL1uf5Gp+QiXe8i
         Y0DA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UhEu+zZe;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UhEu+zZe;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELu+COPt4lzTXrU5W4GEOEjm/qwRxGQxRt7dEKJfOBHNwMefcQ7b6ds9yoF7hKIhtHbDYT5fwJ0Wds7oBU9+J1k=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180315063238.3303b8d1@bbrezillon>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180315063238.3303b8d1@bbrezillon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 10:09:43 +0100
X-Google-Sender-Auth: S50j4r2Q48shEJdNkpSM6mRCjes
Message-ID: <CAK8P3a151M35ywHyABt2KFypPaiZROYuL10ztChwjSwqS9haHg@mail.gmail.com>
Subject: Re: [PATCH 00/47] arch-removal: device drivers
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>,
	Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, wg@grandegger.com, mkl@pengutronix.de,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jiri Slaby <jslaby@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shaohua Li <shli@kernel.org>,
	linux-watchdog@vger.kernel.org,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>,
	linux-pm@vger.kernel.org,
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-edac@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	Linux Media Mailing List <linux-media@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>, Networking <netdev@vger.kernel.org>,
	linux-can@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	"open list:SOFTWARE RAID (Multiple Disks) SUPPORT" <linux-raid@vger.kernel.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594927909252349454?=
X-GMAIL-MSGID: =?utf-8?q?1594994179732956481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 6:32 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Arnd,
>
> On Wed, 14 Mar 2018 16:35:13 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Hi driver maintainers,
>>
>> I just posted one series with the removal of eight architectures,
>> see https://lkml.org/lkml/2018/3/14/505 for details, or
>> https://lwn.net/Articles/748074/ for more background.
>>
>> These are the device drivers that go along with them. I have already
>> picked up the drivers for arch/metag/ into my tree, they were reviewed
>> earlier.
>>
>> Please let me know if you have any concerns with the patch, or if you
>> prefer to pick up the patches in your respective trees.  I created
>> the patches with 'git format-patch -D', so they will not apply without
>> manually removing those files.
>>
>> For anything else, I'd keep the removal patches in my asm-generic tree
>> and will send a pull request for 4.17 along with the actual arch removal.
>>

>
> If you don't mind, I'd like to take the mtd patches through the MTD
> tree. As you've probably noticed, nand code has been moved around and
> it's easier for me to carry those 2 simple changes in my tree than
> creating an immutable branch.
>
> Let me know if this is a problem.

Sounds good, I've removed the two patches from my tree now.
I've already sent a version of those that is based on your latest tree to
you for inclusion.

      Arnd
