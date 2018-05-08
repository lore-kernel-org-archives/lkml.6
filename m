Return-Path: <schmitzmic@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525766524; cv=none;
        d=google.com; s=arc-20160816;
        b=baz3GNTXK6D/eSVOPaYgTjKlNw91WOxLO/gljB2kQL0QYW+bAvKGx6MGi+kMrTgV93
         B8Ipk6otSSSaZi50jXEb0pSg8YZBjDHeZHTn0OgGXmv1m8JWkeh9TreD7cuwE1AG2Qzk
         VyEs1UpkuBghbokMFoHf+xknFYX0jZPeG3M3BrVW4y6Ezm2GgbYSROXDz3BZ6IvzvlWp
         cAUI150jtEmFZCdXdho6XTATeHd6XN6VsFX2/RPZj0vJSyrucxAF2updE5e7F6J9BSIR
         8+iKxlPjPdj61FxZPkbpqiJWyInmF2tOIuGvjp7rclCRnrafQxWTKoBzRTcH65isXzrc
         hcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=rEf20kFy9YiD1ZevLdQELU8BulRLPEK95SfZZ7X+iIs=;
        b=zZeuTIRtFGLB4yNiLuZW/5SH1+HSViSLlq+DrYk1Yp5QeQ5ft3XTPssSUuHCoXncLS
         LzKXGT8cQO4Lrsu21gDi1pOBoNhB/mNuHWNRX41A3LdZnvGQt9A7WgZKPV71pIozk/gE
         7L18S4Km71aVMh9ADRUwiYASoGFHLggQTCcs4BTtB559Uhl9UqARh5zQzejubl5ir3Ig
         hp/M3lnA8twHc60S/s1mTKl9WXUgmIi0tWbUTwivBidrz1xVlMeOcyCIM6rhvu0nEk6A
         4Z2yBkEdAyP9uMLkGjjXE8RcR7J9WA0v9ubtHag9iqzpm9kdE8uK+jYIkTYG1pCqcEvx
         eQwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a6CTTjAg;
       spf=pass (google.com: domain of schmitzmic@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=schmitzmic@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a6CTTjAg;
       spf=pass (google.com: domain of schmitzmic@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=schmitzmic@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrjJXWPSVxQ7svQKpSNnsYEKVuEbEPmJ4nOfAyE6tBG/fW9xHQgqw9QGamstQF1VX5JH2MCwQ==
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com>
 <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com>
 <CAOmrzk+bY5wUxJhNAwO-pf+O--HiqJ63rB3BmxRsY8qq_PeLmw@mail.gmail.com>
 <20180508070037.GA4792@kroah.com>
 <CAMuHMdUAWfmiaZG7snEQRL1N-w69NuSYzeoQgQosQRf_JTZ5OQ@mail.gmail.com>
 <20180508072522.GA26568@kroah.com>
Cc: Finn Thain <fthain@telegraphics.com.au>,
 Linux/m68k <linux-m68k@lists.linux-m68k.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <53b0fe0b-70c5-a327-57b8-47c02331d2bd@gmail.com>
Date: Tue, 8 May 2018 20:01:56 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180508072522.GA26568@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599882158878052417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Am 08.05.2018 um 19:25 schrieb Greg Kroah-Hartman:
> On Tue, May 08, 2018 at 09:07:27AM +0200, Geert Uytterhoeven wrote:
>> Hi Greg,
>>
>> On Tue, May 8, 2018 at 9:00 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Mon, May 07, 2018 at 09:51:12AM +1200, Michael Schmitz wrote:
>>>> the BUG() was triggered by loading a Mac Nubus network card module on
>>>> a multiplatform kernel running on an Amiga machine. Up to Finn's Nubus
>>>> core rewrite (this February), we've seen no errors. Since then, Nubus
>>>> drivers fail to register because the Nubus bus is only registered on
>>>> Macs.
>>>>
>>>> Can't see link order involved here at all.
>>>
>>> The link order is totally involved here :)
>>>
>>> Link order determines the order in which init calls are run, so you need
>>> to ensure that your bus code comes before any drivers that use that bus
>>> code in link order.  That way, at init time, your bus is created first,
>>> preventing this type of error to happen.
>>
>> The issue here is not due to link ordering, but due to the bus not being
>> registered on a system that doesn't have that particular bus.
> 
> But how can that happen if the bus code is not present in the system at
> that point in time?  Hardware doesn't matter at all here.
> 
>> Akin to booting a kernel on an old PC without PCI, and loading a driver
>> module for a PCI network card. I guess that doesn't crash (because no one
>> has a PC without PCI anymore? ;-)
> 
> No, it should work just fine, try it!  :)
> 
> The driver will not bind to anything, but the bus code should work
> properly, as long as it is initialized before the driver tries to
> register with that specific bus type.

Before Finn's patch, the Nubus init call used to do this:

static int __init nubus_init(void)
{
        int err;

        if (!MACH_IS_MAC)
                return 0;

        nubus_proc_init();
        err = nubus_bus_register();
        if (err)
                return err;
        nubus_scan_bus();
        return 0;
}

subsys_initcall(nubus_init);

MACH_IS_MAC returns false if run on Amiga, Atari, ... anything but Mac.
The Nubus bus driver is only registered on Mac hardware (working on the
assumption it won't be useful anywhere else so should not be needed.
That was a little naive, as we've seen now.).

The initcalls for Nubus hardware drivers attempt to register the driver
with the Nubus bus driver, regardless of what hardware we're running on,
i.e. regardless of whether or not the Nubus bus ever registered with the
core.

Finn's patch sidesteps the issue by registering the Nubus bus with the
core unconditionally (PCI probably does the same). Drivers can then
register successfully but will never see their probe code called because
the Nubus driver only scans the bus for devices if running on a Mac. So
no harm done either way.

An alternative might be to only allow devices to register if the Nubus
bus has successfully registered with the core (which it wouldn't do
unless running on Mac hardware). That would solve link order and wrong
hardware issues at the same time.
(Link order is Nubus before network drivers as far as I could see from
drivers/built-in.a)

Cheers,

	Michael

> 
> thanks,
> 
> greg k-h
> 
