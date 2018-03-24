Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3936627-1521898338-2-8582568011696049927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521898337; b=b0frvS2cbtz10PobsUt1Y84D483cIfFaEpmn92ZBgX+pv/h
    YH7Uvf6RtILzN2MXTMx+EkuwKGQnG4ALHKoCbQGQ4KYv/AiaZ0Bz8Ekva3NMWYYo
    5m1DwE17xv9x87T/tmjkRCwDXA0e3Wn7JwQgkwSPEu7VLJzhuUPpeEzjmt+e9tDl
    wqkxK8qI8KbRl+rgwn6wO31r5r1+MBXjuSEDeu5JZILhEV6PWpGQUeqYWHf2vIeo
    +mlbXTrzhDmZfzyLSm2X/cUVn8yg4Vd9i2q4CoqzkuxOJGDvwc+9FZXNpGsKzJH0
    rz3LUNSrU1aMj20UBArqiZ6FQda7zbDzdT/KwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521898337; bh=9
    65xy0e2GxRphtaVgnrmGzYK4fv4pt4v2T7uvgjN6g4=; b=sBmhHzH+RN9EnZwyu
    taQgcqJuN/iFdHwmPR7iErqoK1EJi8pTHzrvCb6jGqBwSTMTlefT6meXy+1Jj179
    cdXQhTvJlQAUhsPTyM4Z5xaQA95AiV9cWGvQS2MJLwFCj3Hts/st9/wK8LtR6sY+
    j8F7kutwcG8P9MHmX7IJbKpzYnMPvJuflNfXkTiKUUNif3+3+dcVbXLKwpPdc2D4
    9WsOz45A1g99LmRT78jiilbywz9liF90KtqSZQCmGmCgxXvzLu0Tr1puTy7nxN9Z
    gBJNGjOcKQNBjpdUHgYTuHMNCp3nvC61E0L1/vTX6omMIdEYCieYeVsgBNEnPjX1
    aiZgQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2952F21772
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:32:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 01/11] staging: iio: tsl2x7x: remove unnecessary code
Message-ID: <20180324133206.4ab7c8a0@archlinux>
In-Reply-To: <20180321102912.5130-2-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-2-masneyb@onstation.org>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Mar 2018 06:29:02 -0400
Brian Masney <masneyb@onstation.org> wrote:

> As a follow up to the work in commit a0722d05a195 ("staging: iio:
> tsl2x7x: convert mutex_trylock() to mutex_lock()"), this patch removes
> the unnecessary calls to tsl2x7x_get_prox() and tsl2x7x_get_lux() in
> tsl2x7x_event_handler(). Previously, these functions were locked with
> mutex_trylock(), but that is no longer the case. This patch also removes
> a comment that is no longer relevant about returning the last sample.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 82681300e106..82cf9d853b18 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1430,7 +1430,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  
>  	/* What type of interrupt do we need to process */
>  	if (ret & TSL2X7X_STA_PRX_INTR) {
> -		tsl2x7x_get_prox(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
>  						    0,
> @@ -1440,7 +1439,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  	}
>  
>  	if (ret & TSL2X7X_STA_ALS_INTR) {
> -		tsl2x7x_get_lux(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
>  						    0,
> @@ -1745,10 +1743,6 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		return ret;
>  	}
>  
> -	/*
> -	 * ALS and PROX functions can be invoked via user space poll
> -	 * or H/W interrupt. If busy return last sample.
> -	 */
>  	mutex_init(&chip->als_mutex);
>  	mutex_init(&chip->prox_mutex);
>  

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
