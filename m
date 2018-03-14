Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AG47ELtgoCvGs5zDfQUcYoQGJqzflxBNC5DCeA4KyJTfIfREn0Ylu114EAUervyminhHtySH+rqj
ARC-Seal: i=1; a=rsa-sha256; t=1521047217; cv=none;
        d=google.com; s=arc-20160816;
        b=VZDLtzf6ObSoEEriiAvxChYgIBFRSTDTd2TEztjfuZYip184HDN8Un2qMaf5uviAI1
         KeTVSgDegXPj2SZyYWeRRsVGS9yXzFxdtPr01RKXJqQ3h4El8R+jdBgz4KAu1pbi+y0/
         Xa7aBEoRym5j0pk/n+5XXdBt9E++hjXUb5rpg19certD294jooFJ3RABSVP27CGnp6lu
         2dAhld6lFFaLDnwpE4c68YsxvxnLSjxSubo3RtJf2tVDVnx42kMT2OXVEFepSeacqAjx
         Ej5JHuPhIHLD9hnLB6i7glyA6eyo+ym2LQXjORPdeu8QEXHZRYzB4E3nN2jBcqtDvPLJ
         Iqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/yPWT2FPsC+TiJgfGPucZzEK8RQMHG57cK1G9pZFkvA=;
        b=r3zRL4Lz1Unk37BYlgLadlZpdMXvJq9tGt4m56tjhIfpBcUKJqpBHzxG7GyWyqQudf
         pwU+9ugCRUPmv1B+4ecS4rke4ohI2DfvIfE8gUGjH7k1ttPe9VCpHXuA9lctRHj9gdHc
         gzZjR47PtuEGLNeubj058T07jy9jYrY7BA7RBRaf5OCx+dEDWYrnYQJlHNgZtiLE9F6R
         umnZopsD3Lq9iUc7j7Wv5g0pUK8UppOnscRdbtTaSCGJ1Hd1Sbs0jQGRgdx6P8zyGrDn
         bUU//RKJF8OQ+uVtj7DhKeS4M9WVsXK2cHdKw3/UKzsKt3D2jIlHCVbeNALwF0EIAbBu
         mkEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Wed, 14 Mar 2018 17:06:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
	<devel@driverdev.osuosl.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
Message-ID: <20180314180633.000067dd@huawei.com>
In-Reply-To: <20180314163207.GA4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
	<20180314153603.3127932-48-arnd@arndb.de>
	<20180314163207.GA4279@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594929157432161227?=
X-GMAIL-MSGID: =?utf-8?q?1594933606762066087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Mar 2018 17:32:07 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Mar 14, 2018 at 04:36:00PM +0100, Arnd Bergmann wrote:
> > The blackfin architecture is getting removed, so the timer trigger
> > driver is now obsolete. Since this is the last remaining iio trigger
> > driver in staging, I'm removing the entire directory.
Great.

> > 
> > I'm not sure about the other staging iio drivers though: almost
> > all of them are for Analog Devices devices like this one. They
> > are likely used along with blackfin SoCs, but could easily be
> > used on any others as well.
> > 
> > It might be time to consider whether they should be removed, but
> > it doesn't feel like a decision that I should be making.  
> 
> The IIO driver maintainer/developers are talking about that currently, I
> think they have a plan for those other drivers.

Some of the drivers are under consideration for removal (particularly most
of the meter drivers) but it is unconnected to the blackfin removal.
They are simply other obsolete parts that we don't have test hardware
for and need sufficient 'surgery' that we wouldn't feel comfortable
cleaning them up without.  One has been reprieved as a user, who was
happy to test, came forward when I announced the intent to remove them.

> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
