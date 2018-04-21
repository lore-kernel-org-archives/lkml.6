Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524328730-2-14470828504367314475
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524328730; b=pskYAoBuY7tmGpAZkUMAkik3i28GeLBVPX8vnppu9XXMiIMRK/
    S5lGjTVn6l2ue1MV8i6qWfMKe0t/nPV1ohtmiumqOvBCWHETMF8Hd72JCBSWkD7z
    TYdH73pzwKWn+OZ5TUFknOksQnnBAB059vmqZ4TvZv6bo7NoYkTxlpVo1Z+hUj5w
    qam0RIh04nhIxFPcyL0t9Le+55YyU68kX2F/N4FVliTWYgwk4a2tTD/YHuzERPDj
    i3yC5KoTcuXNWsLcCy5dS6meoJSZbd1qdUAS37pHjKdB950VWN8SUEa84svGQe6U
    69OABD5LleplHM/HW4WzkQ3iSokX/VF0zUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524328730; bh=uMUe9
    UJ+ZSE7Lcj9PSb5i2XCOTEmpPKkf8j54Y8cJ8s=; b=pI9AUTlDDm0cTgY35ZwaA
    XdobsC/ohqvodhqAmiC/Qu9zIQl9h1O2NZxC85ipRkmDZ56CkvJRPYAVrhHm/6/d
    p+NR8gkHssdWooPNnFxJ50afazV+AmQdZG8mCNO3c8g7CufUQwoHFhFoe7tS5IB7
    +sIagWNhxMOCn2GZ2Owo7P/umx5ypG1tVR1qYuMIZX9ZKh/fMCbbVF3NIjqbSNMU
    JmBC0Vhu9vQvbEHr2xqiDdy9cailFmo3zeAiwTgH3JDOBb/L5GXeI+BHIPVv5LkF
    q3+oHvflyWYupaPgIZiGnSdwzqtCqb7wvdQ+fxUspA5oNQpAExx2zO6vZTafQTHV
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCbGiz47y/eCVJi5RvmhZX6BivR4L0LKjeB4JueTrDh1hQmkr8jPEMDgQj2UGDCrmoOUmzExfnkFSMNhLB6BekZawf519x0ilXdFu5u4zSqfPZuO5D6C
    EleEqKgfGTQbqPm/F1Zua6e5B2y3USAa+7OF+goHq0M9s2K/oOseUPnMTHgyFfK2sDoIjFhibdXpf5g1SfP3wGJzlXd3vgEXWEA5221elh3sK2sdhqyVHwqH
    NsX6x44sXQmSp7MskNhrsQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=VTY2ZL07wa-Y4oPuNygA:9 a=9i3Vk-mzYcM4bPqO:21 a=WsHZ_d9K88n73qSp:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD8021742
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:38:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 13/13] staging: iio: tsl2x7x: rename prox_config to
 als_prox_config
Message-ID: <20180421173838.5e842be7@archlinux>
In-Reply-To: <20180421004153.19073-14-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-14-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:53 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The configuration register on the device is represented with the
> prox_config member on the tsl2x7x_settings structure. According to the
> TSL2772 data sheet, this register can hold: 1) the proximity drive
> level, 2) ALS/Proximity long wait, and 3) the ALS gain level. This
> patch renames prox_config to als_prox_config since ALS settings can
> be stored here as well.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git.

So I think I picked up all but 2 where there were minor suggestions.

Looking forward to the final set!

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 7 ++++---
>  drivers/staging/iio/light/tsl2x7x.h | 5 +++--
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 05c0f3d5fac0..708b2c6bdf4b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -56,7 +56,7 @@
>  #define TSL2X7X_PRX_MAXTHRESHLO		0X0A
>  #define TSL2X7X_PRX_MAXTHRESHHI		0X0B
>  #define TSL2X7X_PERSISTENCE		0x0C
> -#define TSL2X7X_PRX_CONFIG		0x0D
> +#define TSL2X7X_ALS_PRX_CONFIG		0x0D
>  #define TSL2X7X_PRX_COUNT		0x0E
>  #define TSL2X7X_GAIN			0x0F
>  #define TSL2X7X_NOTUSED			0x10
> @@ -207,7 +207,7 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
>  	.prox_time = 255, /* 2.73 ms */
>  	.prox_gain = 0,
>  	.wait_time = 255,
> -	.prox_config = 0,
> +	.als_prox_config = 0,
>  	.als_gain_trim = 1000,
>  	.als_cal_target = 150,
>  	.als_persistence = 1,
> @@ -594,7 +594,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	/* Non calculated parameters */
>  	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prox_time;
>  	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
> -	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] = chip->settings.prox_config;
> +	chip->tsl2x7x_config[TSL2X7X_ALS_PRX_CONFIG] =
> +		chip->settings.als_prox_config;
>  
>  	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHLO] =
>  		(chip->settings.als_thresh_low) & 0xFF;
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 85d8fe7a94c8..6e30e71a2127 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -48,7 +48,8 @@ struct tsl2x7x_lux {
>   *                          increments. Total integration time is
>   *                          (256 - prx_time) * 2.73.
>   *  @prox_gain:             Index into the tsl2x7x_prx_gain array.
> - *  @prox_config:           Prox configuration filters.
> + *  @als_prox_config:       The value of the ALS / Proximity configuration
> + *                          register.
>   *  @als_cal_target:        Known external ALS reading for calibration.
>   *  @als_persistence:       H/W Filters, Number of 'out of limits' ALS readings.
>   *  @als_interrupt_en:      Enable/Disable ALS interrupts
> @@ -73,7 +74,7 @@ struct tsl2x7x_settings {
>  	int wait_time;
>  	int prox_time;
>  	int prox_gain;
> -	int prox_config;
> +	int als_prox_config;
>  	int als_cal_target;
>  	u8 als_persistence;
>  	bool als_interrupt_en;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
