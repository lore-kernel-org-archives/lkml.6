Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/+FlUOqqAl7SdDmGYXX5pBSbbwi3hL9ZfeOSTSyaoTzTqqA3sHvYcJbC1bcCe6iUoWZf0+
ARC-Seal: i=1; a=rsa-sha256; t=1523814113; cv=none;
        d=google.com; s=arc-20160816;
        b=zA0EM4l6b+fEqQnxz2Zf3rnmv+qYLKmBsXwSQTMQwLdqyq0N/Q7W8w13IuFkquLDzy
         0IMHhUgNs8ffctKJoq9kVnEn+UcU4Bjw45o7//vERCKPR9by/C6dfvXguHqZ+tNgnMwE
         stDBVOag/dt0RDV7TTy97TOdSHCEZYe9xf7PYLAiFnBd0M/zgZe09vHj8gdxAobo1LIu
         4QlBD1CjR2Lenp62ruTQW7s+Vf6l7me/M/Ms+ccyOZ9wBaMABbCZl679iOiSsO7c40tq
         cEL8HVXOYIkqoUNBXp7HAavTxqX0D+SICBRBQouLD7cwLcz93sIyehVo/RkUfYbrLU+G
         JI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=PYV0LL6R8Vi/qmX5YGJPLm+arGGwwdlZXsJScEL8JVI=;
        b=jdN+PCFpHonMey9sbztsFQwdDVsdHI4J9aDdjRQY4axMzaccqvSQw3RRC+kuOzcFjH
         CQI2EIaKTBqQHZCtCnvF7j/mPmtfE14/MBVIOQnIohomXeuHI56XoCbXXLQ35GMbnn8p
         ObUTk9Yu1P1whXj2dNzJfL5Y2lGLpgGKh1OkuQ/Pu6eZPS8VUkmdwAGaEA1GjfDodlMe
         QxebTpjY48sHBpo8bZZvhfqa0+39Ax/O44s+VNOyK5pnhNGFsD0dGnADNn8sy+uI2s1D
         GqOYx0xzsza0ctyq5Ydh5BvItqPSdf7VTrvFf72RkZVMgLyvWA/kwM6jm2TgPu/j4c+1
         eSCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFF92176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 18:41:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Andrew
 Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 "Andrew F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: add unit converter
Message-ID: <20180415184146.72c1afd3@archlinux>
In-Reply-To: <20180411141555.15044-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
	<20180411141555.15044-1-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373525263580007?=
X-GMAIL-MSGID: =?utf-8?q?1597834907977731753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 11 Apr 2018 16:15:53 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> I'm now following up with one more binding for the unit-converter.
> This time with a real IC, namely LT6106 from Analog Devices. It's
> a current sense amplifier. I was a but unsure if I should have
> the Rin and Rout resistors in the binding or if I instead should
> have used the "gain". In the end I went with the resistors since
> while the normal case is an integer gain, that may not always be
> the case. And when it's not, that could get tricky. But I'm open
> for arguments on that.
> 
> Cheers,
> Peter
Trivial complaint of the day - why the same title for this email
as the previous series?  Had me really confused for a minute ;)

Seems like the whole driver is stabilizing.  If we do a v4 please
pull the whole lot into one series.

Jonathan

> 
> Peter Rosin (2):
>   dt-bindings: iio: afe: add binding for adi,lt6106
>   iio: afe: unit-converter: add support for adi,lt6106
> 
>  .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  drivers/iio/afe/Kconfig                            |  3 +-
>  drivers/iio/afe/iio-unit-converter.c               | 54 ++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
> 
