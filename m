Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343216-1520693133-2-2536346367660905320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520693132; b=iSDxz3NfaBjPBGhqf9WoDn7thCq/k/CtBIs7xhK8DODgC8J
    6LOFfc1v8TKwxL+DQY+EesJ8sJXy+lySJawIW4Ax+oaWUzsIi3b1BwYN2hYPloKF
    tsg7eUVs1SNxYTphD55O0rhsqcDeVC7YFUi9CD+v0V3vfpCWk0UnLXxQTaKxjd8y
    Vwmpf+AUl7807H3jhGriFXp1zrUAosBmXwVuxQCIkI+JHEuNVYEhd2v2MeT9AnRR
    meNIsfMK9/KVUNkUpNRwE1YjCGh12YElKmm3NfpMvqWuv/uCOG94aJH4nLMA5f4f
    8En0IDtNcQoGvsPafphXAcYtgIqEfbLE49aKFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520693132; bh=c
    i9LOWmuc/GPP4qzVGuQr5aMuN6G/Re/UX/ShcgAJ4o=; b=cyUogz4dUlutvyMq7
    uiU2vbHsyaZZrRNONCDdziSsovVkDtt73jici9vMCvRQMhi307UIhSxgQIh61oAE
    rJugSfAqQ/eOCzz8LY7SHBt7s4Pdp4vcaLVwMCsfN7+T9jNCRafMk+6zu5nhkpFe
    B0eEuNFkh1N4zVlv4dl3/Qa4Sf+iFz7MFOYZTsBPt0Lc5C6ZL20sV5scy7rBMtlj
    zForQ+icTL3C1bo2sjyb2cjutvDqN8VzcMVjuXZaywpYwt7ANV3QCV7FXoNqGMvU
    ozVPkO9rgqIi70w3vO+KYCm7ciepoXDdjZG1ky3WZMnnaKrYPIPI+o8Waqgo2Maz
    LK4ng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591692133D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:45:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 09/12] staging: iio: tsl2x7x: add missing error checks
Message-ID: <20180310144520.7ed3b658@archlinux>
In-Reply-To: <20180304014942.18727-10-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-10-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:39 -0500
Brian Masney <masneyb@onstation.org> wrote:

> The functions in_illuminance0_calibrate_store() and
> in_illuminance0_lux_table_store() did not have complete error handling
> in place. This patch adds the missing error handling.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 8adc6db44790..da7a4e025083 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -940,8 +940,11 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>  	if (strtobool(buf, &value))
>  		return -EINVAL;
>  
> -	if (value)
> -		tsl2x7x_als_calibrate(indio_dev);
> +	if (value) {
> +		ret = tsl2x7x_als_calibrate(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
> @@ -1006,8 +1009,11 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING)
> -		tsl2x7x_chip_off(indio_dev);
> +	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> +		ret = tsl2x7x_chip_off(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	/* Zero out the table */
>  	memset(chip->tsl2x7x_device_lux, 0, sizeof(chip->tsl2x7x_device_lux));

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
