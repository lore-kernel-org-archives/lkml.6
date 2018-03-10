Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343216-1520692957-2-13973673122419104227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520692956; b=KSBY8nlSyD3AWRHYNWA1J2216EbH1ybTqagp6F3DXZK6Y43
    SaSg7gmqp10WRH9Vcql0+Dag3CzM/nF6kWPFFZoPWqJN5oXIOxgFSEYZpersnGOq
    HJHz2WG+AMHPcTFUStTEtCna1D+PzkHfGDjJMxFO2ENsa8Bl4vEJ773Ikk8g4ooB
    G2WftLPxHImSxor3JJxM/jTY2CRsNPCe8tAsmRPAkferYbGUQS9pVoWTEXgfks8P
    Pz3yu0LrtYEzFKOdTmy5yzW/b95TaMz+DDhZ+ZbNr7CESi0UQKwBViKtIchpI96k
    GcSBVyWc+lh+X68rSGsMBSTVqaBPzl6hmDpTBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520692956; bh=p
    hA/O6ZCS+gusJBKvNRUOE1uMqy/BTfyBHbdSt7unZw=; b=WGBvKUio6j1WJHg97
    VORuqaK5X1YXsRg2Ua86VVVEh7Lts8y3tEFccxNZbfe42Idp/7rXuR0/J4OnBOB0
    c9pQSUaGj5ViIwc3qt24R3XDmBa87n9AuRMq+BFkhb2FQrCRXS7e5LvBR0nGE7eB
    dP1bbRUZMTOOz3s0Mz4tF4Vz1MjplknObsJmjrfHl1kQ6sWstjiikd81BJghJmRu
    QNQ9izjstINuRPWd6u+TLztS2zcV3w2KbIvwXqGtA3r2qSqzKI0u5Fshdg4JuxSZ
    85+dETfuK/Wzex1Vtq8eflLyM/K2DrQyrVHo/i5aNN4N61e7WVYE1gjqyxzxfPdQ
    1dIZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7B22178C
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:42:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 06/12] staging: iio: tsl2x7x: correctly return errors in
 tsl2x7x_get_prox()
Message-ID: <20180310144225.547f4ec3@archlinux>
In-Reply-To: <20180304014942.18727-7-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-7-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:36 -0500
Brian Masney <masneyb@onstation.org> wrote:

> Not all errors that occurred in tsl2x7x_get_prox() were correctly
> reported in the return value. This patch changes the error handling
> so that errors are now returned properly.
> 
> Note that the ret variable is from the call to tsl2x7x_read_status(),
> and it already has the correct error check. The -EINVAL error code is
> for an unexpected value in the register.
> 
> This patch also corrects an unnecessary word wrap in the call to
> le16_to_cpup() while changes are being made to this code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Good cleanup.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to work their magic.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 5c611250127f..cc209b64ed5a 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -489,16 +489,20 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  	case tmd2671:
>  	case tsl2771:
>  	case tmd2771:
> -		if (!(ret & TSL2X7X_STA_ADC_VALID))
> +		if (!(ret & TSL2X7X_STA_ADC_VALID)) {
> +			ret = -EINVAL;
>  			goto prox_poll_err;
> +		}
>  		break;
>  	case tsl2572:
>  	case tsl2672:
>  	case tmd2672:
>  	case tsl2772:
>  	case tmd2772:
> -		if (!(ret & TSL2X7X_STA_PRX_VALID))
> +		if (!(ret & TSL2X7X_STA_PRX_VALID)) {
> +			ret = -EINVAL;
>  			goto prox_poll_err;
> +		}
>  		break;
>  	}
>  
> @@ -512,14 +516,13 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  		chdata[i] = ret;
>  	}
>  
> -	chip->prox_data =
> -			le16_to_cpup((const __le16 *)&chdata[0]);
> +	chip->prox_data = le16_to_cpup((const __le16 *)&chdata[0]);
> +	ret = chip->prox_data;
>  
>  prox_poll_err:
> -
>  	mutex_unlock(&chip->prox_mutex);
>  
> -	return chip->prox_data;
> +	return ret;
>  }
>  
>  /**

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
