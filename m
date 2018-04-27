Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524856134; cv=none;
        d=google.com; s=arc-20160816;
        b=p9bAjLJ7NSWY9TGs22kVyGkYB8RLP/WXRViuUMf6U4dN6qaMs2C6+1+W9ael7FfQx1
         66g5lb+bVO/Bg8HSnBWZBRDT5yoyXP+qJJ0wJFiLOm78CZ97OsqPeLyQAvz7pVUkqj1U
         848wtDElwqc6ecMY4ugT1WWxv1EH3ZvzAsVeZdxg99Ux2HVIYlyr5edw6B/Z3KfYHdNF
         WfzZvgaClzm3xFRsDvtmItGZDFOH4BZgPd4MgRyQem89QKFfA8rWNwrW+N3dtWsciNIn
         IkIZpboR8Y/FxE6G/4vWbC1RQ3AOrxgsCPrO2ryQOvRJsJ+LCwiUtrQbLfhs3WD7HDgp
         UApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PnrzaKIGLJAKnE+8crZA1Ez0JRu7eiK8Kvow6RfhS+k=;
        b=ayRNyUJShvOMM1x/VQ6yfYM3YD0kDp6J9sa11sVisT8dEW04OtSYbZB4iEOhYH51Ue
         wQpwj2/XIPSzzzpbGECjHQwyc7Eas4j8iKjHgXUhkHS9Pv0P/xbI4hmRJ2kV9trqSV5g
         4qI6SCq0kW7HSUEkVdyDGGZrv3VKu+rtnZ1HDjJaCVAN7k98VHpfGK1UPMgy/IMA/7pd
         fJcByQBGzPpcG7ul+KohoTL0N77gT4B1beya9fy3rbMrob16eWGQTkCCK6a5bOoL3CVg
         mIZ2c0vsGGQEG8JdNDz5nvNjIr5FemYDQ/8QrUAwO3nVn/uUfwqXkG8orCLC5aKtrBFQ
         efrg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rDnrcL9z;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rDnrcL9z;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZqumDckC/efRU4DZBqvdQcnPQUSbf1BpPLLGyJqsVVwTaE5gkiEiPNxft21U9v7wYVUuMAC8MS84UlatBf70+E=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAMpxmJUovyhsiHByA3MZX5H6AcU4k9shX45Z60NpDkOFTxg_eQ@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl> <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com> <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
 <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
 <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com>
 <CAK8P3a22DKpqMGdjYoBzKfNHc2GvAbvaZowZpz=SFeQHVSWjsg@mail.gmail.com> <CAMpxmJUovyhsiHByA3MZX5H6AcU4k9shX45Z60NpDkOFTxg_eQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 21:08:53 +0200
X-Google-Sender-Auth: 9ANiWA44--KN7taU2CHi5eNeMNY
Message-ID: <CAK8P3a17xU5m+_X-qWQK+LZq-bt3NnuVCgwzg+C2yYsVrdFhWw@mail.gmail.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>, Rich Felker <dalias@libc.org>,
	Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin <peda@axentia.se>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598927546466128002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 6:05 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> 2018-04-27 16:48 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> On Fri, Apr 27, 2018 at 4:05 PM, Bartosz Golaszewski
>
> So speaking in pseudo-C we basically have two ways for an imaginary
> future timer driver:
>
> int foo_probe(struct platform_device *pdev)
> {
>     struct clk *clk;
>
>     if (probing_early(pdev)) {
>         clk = devm_clk_get(dev, "earlyclock");
>
>        /* Do early stuff. */
>         return 0;
>     }
>
>     /* Do late stuff. */
>
>     return 0;
> }
>
>     --- vs ---
>
> int foo_probe(struct platform_device *pdev)
> {
>     /* Do late stuff. */
>
>     return 0;
> }
>
> static int foo_init(struct device_node *np)
> {
>     struct clk *clk;
>     struct device *dev = device_from_device_node(np);
>
>     /* Do early stuff. */
>     clk = devm_clk_get(dev, "earlyclock");
>
>     return 0;
> }
>
> TIMER_OF_DECLARE(foo, "bar,foo", foo_init);
>
> I still believe the first approach is easier to implement and has the
> added benefit of supporting board files.

Right. I still like the second approach better, since it avoids
multiplexing two very different code paths into a single
function, and because it's closer to what everyone is used
to at the moment.

Prototyping both is probably helpful to get a better idea
of the actual complexity this introduces.

> I'll give it a thought and will be back at it next week.

Ok. I'll be on vacation for three weeks so I wont' be able
to reply on the new patches.

       Arnd
