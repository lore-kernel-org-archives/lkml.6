Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AIpwx48O1W/mkoC9NIubZ30GcS8PdPtPjBvqHT0ds9IeGMiH7sXA0kCoA4Z7Pz6Z5WveX+rdqH3z
ARC-Seal: i=1; a=rsa-sha256; t=1524044288; cv=none;
        d=google.com; s=arc-20160816;
        b=IL1aOclmTx6n7pSdOnHQ/xBpCmbnzRYfPeEmeUVaoDlAd3Q37eS/74Q0ALyD/OyGcl
         BxPsiMblavX7pLVp7fMDrLr3eoZj0a22x0QBYuJTPNKpWUGbTFGRK9yKAIzay/l6NGxZ
         ubdJFOOHaFOjHBgZQZw1mE6nPrODVzF3d+rd8c/9/EpeVeASNqypRRmr1Y3MFWyIKdiq
         97AHmGCRTu68kDFrVYBShaxuMcpxZg3EU8/yUQeut9+QPquDaCBqkAeOnvR3IWeHwGJU
         TGlTEU+bFJ+v3Fr3QmU3uUirH26xoHG2OlwP3pJqncWI4QwPsvVV4TVm78MEFGgnerN6
         aewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=g8ciEa6JXyX47GOsLt0d4aEMfTl07VdU/K5AYiL1na0=;
        b=olHN3MbrzvwF1hcXx5nai7OqwT9ETvkLvrKbZ1p1/XeUOKmXFuWeoh1X1tGfYVZqdN
         ZabweZaCoCA7GOR8eBoJ4sV0itVOygfnAZ0Q/SyVJHUAUJdlkXm+evbbV+5L+uXotm3Q
         OERvptZv7DQbuV2wU7P7Fres9rNwbNJunCgIMSbz/JOa5XijNVbN8+LfSV1gMtNXrK+X
         oExNRuiC3pX9QPmlPazUByhLgSXhZb1Ed7lIpYQgkfkcglZFW48/AWwLkX8/9venSBth
         VbocPqOkagHYwBzWjl5mEH+h13W1aLXFHBK1cngRjxuXZKFA7eKmW9fT/UgB9hs2eXvL
         Z5vQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Wed, 18 Apr 2018 10:37:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Rosin <peda@axentia.se>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, "Andrew F . Davis" <afd@ti.com>, Fabio
 Estevam <festevam@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: afe: unit-converter: new driver
Message-ID: <20180418103721.00004171@huawei.com>
In-Reply-To: <81e69701-d49b-6675-010d-99d5d3eaf827@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
	<20180410152802.30958-3-peda@axentia.se>
	<20180415183140.04c39ebe@archlinux>
	<81e69701-d49b-6675-010d-99d5d3eaf827@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373534966690766?=
X-GMAIL-MSGID: =?utf-8?q?1598076264197729426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 09:12:45 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-15 19:31, Jonathan Cameron wrote:
> > On Tue, 10 Apr 2018 17:28:02 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> If an ADC channel measures the midpoint of a voltage divider, the
> >> interesting voltage is often the voltage over the full resistance.
> >> E.g. if the full voltage is too big for the ADC to handle.
> >> Likewise, if an ADC channel measures the voltage across a shunt
> >> resistor, the interesting value is often the current through the
> >> resistor.
> >>
> >> This driver solves both problems by allowing to linearly scale a channel
> >> and by allowing changes to the type of the channel. Or both.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>  
> > So I 'think' the only outstanding question is Andrew's one about the driver
> > name.  We aren't in a hurry at this point in the kernel cycle, so lets
> > wait until that discussion has ended.  Assuming that we do possibly end
> > up with a change, then please roll all the patches up into a single series
> > to avoid me getting confusion.  
> 
> Yeah, sure, sorry for the split series, but the lt6106 that's present in
> one of our newer designs didn't occur to me until just seconds after
> firing the first half of the series. Which is kind of typical...
> 
> Anyway, about the driver naming. The suggestion I like best so far is
> linear-scaler from Linus W, but thinking about it some more I think I
> like iio-rescale even better.
> 
> Any objections to iio-rescale?

Works for me. But then I rarely care 'that much' about naming and am
responsible for plenty of previous confusing choices ;)

Jonathan

> 
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
