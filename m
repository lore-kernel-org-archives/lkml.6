Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3330179-1520692808-2-7194862256472705214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520692808; b=udn5K0g8rUgw6SsTxYZRXoE8a7Sdi+Md/UH9rujkAFGyZWA
    HnZKcQLuZjAjYc9TnHPm8UsO6mTDYVg899kXHhDgHWNOJMjrB/xLyFcfH8GpZmYo
    g2m3Y8KwR5xB5Y7hgc4eDL/0eCyMYUKETszJff3Cm3Sr0V9poZxdr+9eA8xu4aDA
    lf2gC4JZGSjnr2/7+PE/0/osreQDmc07FanXlcaFuWsHvwE8l4VSl/rEfP4kfIBJ
    WfECrOUIn/GZfa2g5Yq5T/XL6VgCbaGz3Oob7y+RLmZVb+oeXjPvRs6QPd7YekQW
    ksfdAoaDn8DRXiN95fDNaSX7KgqMClo/155Zbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520692808; bh=/
    0xY2Xv1KiyNmEJAZ577vWJVqUr9Q4nwzvtD+hL8VSk=; b=L/zJi1jua0jF3lJeb
    mkTTBxeV+1dAf6qZhSrFKQTv1fqbLrrt9Ro95ZU6ur1WL5JK3+gwcXbCs2DiauLZ
    nrW616UD1F/SHNjfEckPQLcIskmtSKmnwGVH0DAkOeT1CiqyKpe4fqqqzaLqceCz
    t5wJyY6t5iGUsXM9epmU4huP2jsOTsoyo2yxvHcOJV1zBp1iOqoo62QJT1YxgA5F
    sqSijDxVOikaGWUPOaBsrAljd0ebrD6NnNuBiQiuIoR7oDYzoXW8Dtvlfs2rpBLP
    JIEVbh12PJzinJwTyRvC/6Pa0hW32h0kbzc2dWQKqEbHrsSKl/D8SQr150iknQiR
    eGfSA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8942178C
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:39:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 05/12] staging: iio: tsl2x7x: convert mutex_trylock() to
 mutex_lock()
Message-ID: <20180310143956.29443f83@archlinux>
In-Reply-To: <20180304014942.18727-6-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-6-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:35 -0500
Brian Masney <masneyb@onstation.org> wrote:

> The driver uses mutex_lock() and mutex_trylock() in several places.
> Convert the mutex_trylock() to mutex_lock() for consistency with other
> IIO light drivers in mainline.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This was a little odd given we don't lock the device for long and all this
will do is slow down userspace access if it tries several at the same time
(a fairy uncommon usecase).

Applied

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index cf16dd206c0b..5c611250127f 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -350,8 +350,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	u32 ch0lux = 0;
>  	u32 ch1lux = 0;
>  
> -	if (mutex_trylock(&chip->als_mutex) == 0)
> -		return chip->als_cur_info.lux; /* busy, so return LAST VALUE */
> +	mutex_lock(&chip->als_mutex);
>  
>  	if (chip->tsl2x7x_chip_status != TSL2X7X_CHIP_WORKING) {
>  		/* device is not enabled */
> @@ -478,11 +477,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  	u8 chdata[2];
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  
> -	if (mutex_trylock(&chip->prox_mutex) == 0) {
> -		dev_err(&chip->client->dev,
> -			"%s: Can't get prox mutex\n", __func__);
> -		return -EBUSY;
> -	}
> +	mutex_lock(&chip->prox_mutex);
>  
>  	ret = tsl2x7x_read_status(chip);
>  	if (ret < 0)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
