Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+4Dn7ByQ89c2nnpur7/VyW/Hb5oHGHr72p+DVZogM6soivUzsBSKsD54VNBFZnribC/+Ub
ARC-Seal: i=1; a=rsa-sha256; t=1522401890; cv=none;
        d=google.com; s=arc-20160816;
        b=ezSxSQ5sJIbATDUJ3pvhIwcCGbqY+rHAbiuUH2fm56EZS2GVa8yb+EgoNaAkXFrqAH
         DF+hhmvgFKz731GmEMlEr9aRIfbkAAX8FmQe7TonhiUaBO7226Je4FQ3nMg8cP9uzfYd
         foHYOay3konalA3cy8Er84H+t5K3FWpUaL/bE5bdssHfjqS/k+3lXDxGL9OssC1z2voj
         gWVQrHtzpw3DGNwuZITU6Q2MDU4Pi8Vgy/4vA+2wc8MaB1LIKWhSI6LI1hDR6bj5bX/O
         PhurHZEcRucaCIrkbZBm97tlBY0tvhVudI13V6VuilEMk5vrZFCL4VwN1XkTn8iBseJG
         mIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=1F0MPFzYJm4Joy52n5JvK3LUOWj4i8fvimxgEGXRE90=;
        b=IhrI/PfD5/jZF5VDuRT31UZ+OI8Oon0+Ryztrp4+o/dXmkUN0+RKp7GilY0oiXOA2/
         HZ8i4Dgjn+um5AMuX6q0cFayDIr+tW7MyL+hihvo8C8r11dO4aQpk0y5QUFUSomQYlVz
         d4BmXYZqpgzs7czQoVTjpagL0DpH69QMi3YSP50dg7XD3kM98CxGUBIvN6hwo4TEXHxz
         tpw4yV2E3YlmlHSPMRRWPgXLHmbbTMGuzzKJfSQZgRPVc2CE4Mb8f/x+ARA8enYOyo5D
         rSoXLD+I2KZTQ5piOEQpAm34yVCvJD8tbeNbQql2SLLSBTCUkWg+Wl5cV17PIB5mpb7a
         Q88A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65BB20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 10:24:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "David
 S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: wrapper: unit-converter: new driver
Message-ID: <20180330102443.187496bd@archlinux>
In-Reply-To: <0c9e6fbe-cc05-1a2e-0437-dcde134e6eba@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
	<20180319170246.26830-4-peda@axentia.se>
	<20180324140339.4ec66792@archlinux>
	<1e950fde-d3d9-ca9c-1055-7ab8fc57fc4a@axentia.se>
	<20180327142256.00003056@huawei.com>
	<0c9e6fbe-cc05-1a2e-0437-dcde134e6eba@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386357743794195?=
X-GMAIL-MSGID: =?utf-8?q?1596354084036249905?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Mar 2018 15:32:13 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-03-27 15:22, Jonathan Cameron wrote:
> > On Tue, 27 Mar 2018 09:42:40 +0200
> > Peter Rosin <peda@axentia.se> wrote:  
> >> On 2018-03-24 15:03, Jonathan Cameron wrote:  
> >>> On Mon, 19 Mar 2018 18:02:46 +0100
> >>> Peter Rosin <peda@axentia.se> wrote:  
> >>>> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> >>>> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);    
> >>> if the parent doesn't support RAW, is there a lot of point in carrying on?    
> >>
> >> Nope, better to error out I suppose. But I'm not familiar with channels
> >> without RAW, what alternatives are there anyway?  
> > 
> > Potentially _PROCESSED though that will need somewhat different handling.
> > A nasty trick for that might be to map it to RAW and then have the SCALE
> > reflect the divider circuit scale only.  
> 
> Hmm, I think a lot of things might assume RAW to be a pure integer, and
> maybe they are even correct to do so? So yes, that seems nasty indeed...
Seems unlikely to occur often as ADCs are mostly linear, but you never
know...  We'll figure it out when it happens.

> 
> > It's perfectly possible to have channels with neither _RAW or _PROCESSED
> > but I suspect we don't care about them here.
> > 
> > There might be an application that needs to do buffered data flows in the
> > long run, but we can figure out how to do that when one exists.
> > 
> > It won't be a huge amount more than you have here, though we might need
> > a trigger pass through as well to allow you to set the trigger for
> > the front end and having it automatically applied to the backend.  
> 
> Yes, this is the same for the iio-mux. I don't need it, I in fact need
> very little bandwidth for these things. Someone with an itch will have
> to fill in the buffer/trigger handling...
Absolutely!

> 
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
