Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460864-1524331269-2-12346791745203759196
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524331268; b=ub19MoQEkFpqfxEBK7+tEOrMBLZ/GsJxwJ3ZO+rB1dSwwSz24u
    6W3lvrC+Kph0OyUrUQZl8bgwzJdOq9UwC2C7yaxoQw6f3NrH54aZT+vgLRi6MR6P
    L2GLQRCnN2e9pPhzTdugm9E6IxbGMmE3RImuWnZiYNNaFuM4xFjw3pqNBdYt7ecK
    QPx+TU5myjuO8aKatnUgiOh6L/7/m+mUUAzlsUoZoMF6zNqYP/UOWGriXnPnQ9nZ
    c26CsOCT524Crfb+I0wVx1zzH0HtjQfHshPZvBHBbhQP0fxKrZYje/iQIshsmwIH
    a/EhR3k2gDJYTKlvZHjaF3ydYA0DLJcb6OWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524331268; bh=YcI+F
    6vyvpUdf1IJGqxqXb74ycei52Yrlvvy1SUbwHc=; b=GFS4YZZlry7xoy6h/TRm/
    KF5MGP4ns5ziirGn1s5Vmp12jizYA1Hrkjb/bw/W4BQZTI65BbrPZoARqGYQ9iTL
    uaqJGXUvl3MrXvhn9Cv+9mlD5BUgR1QaqRgRAjSDa+Fwf0VkOPrP35SUlzX+h2ZZ
    We312vVfueTrQFdboAdiVMPkQuG9Xcqj+cU/MErHZtc85jvZWB+Ps3mUKY+H0Qwh
    vcoRC8y3wyqIMOBWaIQt15Ygw2mF+LDy2erUiwRDqU7CGjYA0zhTPLF0bw1TMHxL
    r9I642HE++PUlLgrMSxGQS8exLUc+446oMlj3J4v0iMReyJuahiSCz2BUV5LpQJs
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJx4XZHfO/YKjC+Lvw7uWERJojC0lEisylQwrCL6WLZx4xZoIXQSBvdQJL8xyHcEqh0NXBSopO7sj9LRXigEaIiLlXXR+lcMu4dk+Yg1Uf6J7H/BHc60
    MLuSAEL3F0K1peLo/Hp2ZJcSlPvExwO8/QHVb3/FYvye16xtZXhS0R3TlVhfHJpzaNorMHXE463X/p8LXqOJHaUPGAnNVr/7sk/agYNXizY+CW7wqXmcfAft
    gPw0QR8doO4j9YidY0qzPw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=33S3vzJ8itXcAb-oOnwA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB87121104
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 18:20:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 1/3] stagging:iio:meter: Add iio_chan_spec
Message-ID: <20180421182056.4bb119ad@archlinux>
In-Reply-To: <957b06793a65e0209dc794489b0ae815071b0992.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <957b06793a65e0209dc794489b0ae815071b0992.1524311298.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 21 Apr 2018 08:55:08 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch adds iio_chan_spec struct. Additionally, the channel adds the
> support for handling AIGAIN, BIGAIN, CIGAIN, NIGAIN, AVGAIN, BVGAIN, and
> CVGAIN.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854.c | 42 +++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 029c3bf42d4d..2fbb2570ba54 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -22,6 +22,48 @@
>  #include "meter.h"
>  #include "ade7854.h"
>  
> +#define PHASEA "phaseA"
> +#define PHASEB "phaseB"
> +#define PHASEC "phaseC"
> +#define NEUTRAL "neutral"
> +
> +#define ADE7854_CHANNEL(_type, _name, _mask, _reg) {			\
> +	.type = _type,							\
> +	.indexed = 1,							\
> +	.channel = 0,							\
> +	.extend_name = _name,						\
> +	.info_mask_separate = _mask,					\
> +	.address = _reg,						\
> +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
This is odd. It defines the sampling frequency.  whilst providing now
such read_raw functionality.  So you will get a sampling frequency attribute
that doesn't work.
> +	.scan_index = -1,						\
There is no buffered support so this isn't needed.

> +}
> +
> +static const struct iio_chan_spec ade7854_channels[] = {
> +	/* Current */
> +	ADE7854_CHANNEL(IIO_CURRENT, PHASEA,
> +			BIT(IIO_CHAN_INFO_SCALE),
Each patch needs to stand on it's own (I might no apply them
all).  This adds the scale attributes, but the support for
them to actually work is in the next patch.

It isn't sensible to break this up into 3 patches and it actually
makes it harder to review (as they only make sense together).

Jonathan

> +			ADE7854_AIGAIN),
> +	ADE7854_CHANNEL(IIO_CURRENT, PHASEB,
> +			BIT(IIO_CHAN_INFO_SCALE),
> +			ADE7854_BIGAIN),
> +	ADE7854_CHANNEL(IIO_CURRENT, PHASEC,
> +			BIT(IIO_CHAN_INFO_SCALE),
> +			ADE7854_CIGAIN),
> +	ADE7854_CHANNEL(IIO_CURRENT, NEUTRAL,
> +			BIT(IIO_CHAN_INFO_SCALE),
> +			ADE7854_NIGAIN),
> +	/* Voltage */
> +	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEA,
> +			BIT(IIO_CHAN_INFO_SCALE),
> +			ADE7854_AVGAIN),
> +	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEB,
> +			BIT(IIO_CHAN_INFO_SCALE),
> +			ADE7854_BVGAIN),
> +	ADE7854_CHANNEL(IIO_VOLTAGE, PHASEC,
> +			BIT(IIO_CHAN_INFO_SCALE),
> +			ADE7854_CVGAIN),
> +};
> +
>  static ssize_t ade7854_read_8bit(struct device *dev,
>  				 struct device_attribute *attr,
>  				 char *buf)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
