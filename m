Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELsoDx2vpSCCxLh/jOt14Ko6JsNGo36654HmKWg8h4gODCzLkPqbIgaIbIQe2lMKhwxPgPfj
ARC-Seal: i=1; a=rsa-sha256; t=1520452803; cv=none;
        d=google.com; s=arc-20160816;
        b=GGVBgSBWdikotsAKYUtgI2v1iyYxCWslIhRhQ7hUYOoxLFyFM3QLgGxfOdjUJGjJrQ
         AsUrLHqTJRjtjt5aS4yfleBQObbsrKQWr+0+AAgmblSR67Eu/pPaGeQ6HGLgYJPbaaqy
         qzTETgZCyqxdMqHVQMyOVSgC49u4WSbJ9AZn9+rM5FWhctB+u5jME4ba3xC7yt6+Nato
         XguqXEFhGDgfQllhn8vzYHd0w2OvNsyykaKmsvhQ/8UtKamncBP5iCvHuUsw/hPSjrt1
         XBAG5sTLWUKb2TS1nga8+fimloXmxSyPLpidsoqcKWcV0OPMIS2XDMTRcXyioy15GDXG
         6MYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=y9vy8Wt/xN9UORlVNAeX4cEydkzu0FD8OiWM5KCcLn8=;
        b=iAH4kkGaSUL9gJo8+osznUqEkEcR28sjLnrUIwtZix4morUDZt13NO288EamERdqVz
         UKbncAesFokXC4wIPSy16SfP2zSq+ciDUPup2P8X6cf+mgdouS9RqXzEO1n4WYrUpbR+
         7pzY3gfoZWnhOaGRwYxZFXsqWsvfSU7BHZygGelyfboM5JmSO24F5K9VRiBeGhaHjNZM
         eKwfFbPhSY4sergt2eUh2rqIBzmsOWZpbOQ21GULEYJfjvuHeVJJwhRQKOFaPf7ZCK5K
         CVbgc8JDq6BQkdBMWHimZEn2qzGe90JcUinvek6o/meKgrtyVQiNgMXeX4UcOD9VGpxW
         bQQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A2820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 19:59:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: hariprasath.elango@gmail.com
Cc: lars@metafoo.de, Michael Hennerich <Michael.Hennerich@analog.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: meter: Remove reduntant __func__ from
 debug print
Message-ID: <20180307195957.436c4c74@archlinux>
In-Reply-To: <20180307053804.13730-1-hariprasath.elango@gmail.com>
References: <20180307053804.13730-1-hariprasath.elango@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594256112698574000?=
X-GMAIL-MSGID: =?utf-8?q?1594310318838535246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed,  7 Mar 2018 11:08:04 +0530
hariprasath.elango@gmail.com wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> dev_dbg includes the function name & line number by default when dynamic
> debugging is enabled. Hence__func__ is reduntant here and removed.
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Please note that, after discussions with Michael, I'm planning to send
out an email stating these meter drivers will be dropped next cycle
unless we have someone come forward who can test them.

We can't realistically do the work needed to move them out of testing
without a high risk of breaking them and they are 'not suitable
for new designs'.

Ah well, we'll see - someone might care and be able to help

Thanks

Jonathan

> ---
>  drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> index 1f0d1a0..da489ae 100644
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
> @@ -34,7 +34,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  
> -	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
> +	dev_dbg(&indio_dev->dev, "(%d)\n", state);
>  	return ade7758_set_irq(&indio_dev->dev, state);
>  }
>  
