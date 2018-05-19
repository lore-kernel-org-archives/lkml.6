Return-Path: <alexandre.belloni@bootlin.com>
X-Google-Smtp-Source: AB8JxZrnRzVycd5P2mx4AGsTl1sVkMvG8CXAcyewigx+N8y6H/s1ZEMNR0kiJOf/yK4DuZiBri9K
ARC-Seal: i=1; a=rsa-sha256; t=1526713700; cv=none;
        d=google.com; s=arc-20160816;
        b=L+N50TNDJgQwg/V1Et/mHu4SThqWr98MUAe6Tf6IGsS79EdjDcb0mQboH8ImpJKu+k
         +JUDGuNw9DbpLQLxc85O8MmS0PBwPZJpKKg6GO0nIxZou9Hw+isp4DR1DvsBJWu4LAPH
         Oseae1HLMd5maBaKxOuMFOI5KxjvIKUV22jMJHkaYe8jvYnMMYQbmxC8oMg4mixWp0Z+
         N93N7OgBheXKgwPtgm+MdwrQyQ7HIJPkei9gU9kcI23ld0seddWW1LEXRS8YHeBDrIxB
         yFtgs/ZctXNGtbMwOpvVpyw7yBzhWo5YpGh4QWq784ArSz9hN/eXqofW9IXv5uww+4P5
         oPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Q+1FskWEfVP2qkS2u0xMa13LiikyungGOF9oLaYHH58=;
        b=Q2RwNwPjtIZJKYuJ/D2HjRF3Ao6aZVhxFXqdYiR+2VouygWLRykaHI4tnxvLeSloW8
         85GeNeG2vFiP0CMFl5vO+dKVRrFn2WKBexwExH+aeU6o1Wvw6715GyzeXLGmH4KtnQUY
         /vDkWf8U03Vq4CL/KoZMSKMGSIU50FPGCHI7AO7yv3Vq8ZIpFcNnSX2CthL6f5A9Smph
         7j0QloVsMH9FOwVMvh6wtygTYWgB2aOqWPFfrkIW1vhxW34nXHLUHqMK0ynNGBNVbhU2
         qiHr5NxLk73JkMf7v+Qprb2SQIiCRgQGkaz5/fIVwSy7upNcZsX8qvina6aeHa6PQUBa
         EX5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.belloni@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=alexandre.belloni@bootlin.com
Date: Sat, 19 May 2018 09:08:09 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Radu Pirea <radu.pirea@microchip.com>, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	mark.rutland@arm.com, lee.jones@linaro.org,
	gregkh@linuxfoundation.org, jslaby@suse.com,
	richard.genoud@gmail.com, nicolas.ferre@microchip.com,
	broonie@kernel.org
Subject: Re: [PATCH v3 2/6] mfd: at91-usart: added mfd driver for usart
Message-ID: <20180519070809.GB23730@piout.net>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-3-radu.pirea@microchip.com>
 <20180518221949.GA13443@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518221949.GA13443@rob-hp-laptop>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163722809709607?=
X-GMAIL-MSGID: =?utf-8?q?1600875344867232740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/05/2018 17:19:49-0500, Rob Herring wrote:
> On Fri, May 11, 2018 at 01:38:18PM +0300, Radu Pirea wrote:
> > This mfd driver is just a wrapper over atmel_serial driver and
> > spi-at91-usart driver. Selection of one of the drivers is based on a
> > property from device tree. If the property is not specified, the default
> > driver is atmel_serial.
> > 
> > Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> > ---
> >  drivers/mfd/Kconfig                  | 10 ++++
> >  drivers/mfd/Makefile                 |  1 +
> >  drivers/mfd/at91-usart.c             | 75 ++++++++++++++++++++++++++++
> >  include/dt-bindings/mfd/at91-usart.h | 17 +++++++
> >  4 files changed, 103 insertions(+)
> >  create mode 100644 drivers/mfd/at91-usart.c
> >  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> > 
> 
> > +#ifndef __DT_BINDINGS_AT91_USART_H__
> > +#define __DT_BINDINGS_AT91_USART_H__
> > +
> > +#define AT91_USART_MODE_SERIAL	1
> > +#define AT91_USART_MODE_SPI	2
> 
> Won't this require a DT update for serial mode to add the mode property? 
> That breaks compatibility.
> 

If the mode property is not present, it defaults to serial to keep
compatibility.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
