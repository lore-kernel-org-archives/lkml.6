Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELtiZeuqC/dCORwtgcUBqBrh8ZUfGokTTjXBsnb0459HgION0T6VExaVzeQ5jtrSTyl5wzkD
ARC-Seal: i=1; a=rsa-sha256; t=1521913661; cv=none;
        d=google.com; s=arc-20160816;
        b=ffQacj1TlW5XXhmUh6Az/0q2P00BSDOb9FQslTY5XR5XiscVxeBpi0WkJTJOeaMYbs
         juWs4AbTkE1dcCM1V/2AfxyXB/AeMc4D/3Avhw+cujmohy1Na1edxdcMrFmqHlMf3MmQ
         QZ3+obI8+cw//yHe0+OAxSCVo20UDHmZVXXISeeXkNBuFhSoOUatxUDZrfK2Y0gfswTO
         rHbqd9Y2OwPQDW+ZCfNielniLsQ5J42NW/uvo3/QiuKJhkgQYpgWSV5otIw/drZNQEn7
         KRnIR6mzdeXZBqcmWtmdoa9qOa9jeha1DNUtBtjSJUJq7w6O0DXb3j8+Cbbmf/k78jd+
         EVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=vZKvCO7N+++OWLM8nFndIDAYy+sLxu4W1GqemX469Jo=;
        b=omUGRgN1U1qCeNFvOyZzUyFwtNblQAFN45S7SLInv+MQYrr+J70WLdfmElOzg98LBc
         O6AMEylg9aGV+StXKTfwqiyUM3cfV9cFzaFGBWzJHft5KylMAlDPm6fXy3yRIC4a9lkf
         OS3/MPb22OajZokFQngQuOfg5VXB0/ISA/fsxcIWwbzoI3ie58USCDmV4tDn6rx/9yLD
         YhL2Ar1rY2T+8zAKV8U6djcMCpoEvr/ZysD8D1KqWQu4hWBmx1Uhxux5ZYlBUjQ8RwOq
         oQhvmi6/edMRePoXbaxwWHHurM93PGvts9K5h3uqSZg2GjwPgnoL2p7FDnvCg7ramncG
         KNjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D412177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:47:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-iio@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>
Subject: Re: [PATCH 0/3] iio: add unit converter
Message-ID: <20180324174734.1ac1706f@archlinux>
In-Reply-To: <CACRpkdYPayHqYdFMmts20yLRdMEy6SW-qqnC+BsYip-RdN2HSQ@mail.gmail.com>
References: <20180319170246.26830-1-peda@axentia.se>
	<20180323141401.000031cc@huawei.com>
	<0863dfa7-c1da-7691-a896-9b414e2fddfa@axentia.se>
	<20180324134801.0e6254ee@archlinux>
	<CACRpkdYPayHqYdFMmts20yLRdMEy6SW-qqnC+BsYip-RdN2HSQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386339632135527?=
X-GMAIL-MSGID: =?utf-8?q?1595842139445797766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018 17:34:17 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Mar 24, 2018 at 2:48 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 23 Mar 2018 14:59:41 +0100
> > Peter Rosin <peda@axentia.se> wrote:  
> 
> >> So, not super-happy about that either. And maybe leave the mux
> >> where it is? It's just that I have the feeling that the iio-mux
> >> is never going to get any friends in its category, and the mux
> >> and the unit-converter are kind of related in that they operate
> >> on other channels. But maybe that's only logical it you know how
> >> they are implemented...  
> >
> > Perhaps Analog Front ends?
> > We could move the amplifier driver into the same directory as well,
> > though right now that driver is not passing the channels through
> > (it's often used without there being an IIO ADC behind it I think...)  
> 
> (passive) linear scaler?
> analog linear scaler?
> But maybe these supersets are not broad enough.
> 
> Or just invent another acronym akin to "PHY" such as
> "AIF" (analog interface)?
AFE (analog front end) is commonly used, but I'm not sure if implies
more than we want here.  Lars, Michael this is more your area than
mine - what do you think?

We could call it an amplifier and be done with it but that wouldn't
really encompass the fact we are also changing it's apparent measurement
from voltage to current because we know enough about the circuit to do
so...

Jonathan




> 
> Yours,
> Linus Walleij
