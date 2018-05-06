Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3606268-1525630076-2-10952627734112081576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525630075; b=bsAWMCOv/zaR5uE1vJ4dcTkGP1VTkEtozngFjbCHEFQ1BDmfTE
    dufxur6vn6T8Q5plcbi0vos7NLRlD3JAEaYjiG5atHNvRLwaCnHzYHERkRsLI/xI
    j7izab1/Yy4eUDdMTUnbmhs68CIopg2xb6xOX7lmurCHPwWEvchft4nFnnCmvt2u
    mYE4X17fszmikYhZKgb1yDQEAfTKt46SnvXIWQj0nj3NsUIEtUQ6XpGml6DzCc0J
    KPgWygXJ8qYaWSyzR75mNXzgPNJnqcsWgpJs+EL2jHDVkhVdDWBOuhxv0Ep0tNZZ
    yic1aVNuDNSwLyvG735mMJ4mZFqC2cc98YUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525630075; bh=+AeVp
    F9Brgw7LekLiWhcHWgByz0bv2uE6+xaKOm8Qw0=; b=NpNyW4DBuQvTaPgoLCFZJ
    zJOcS/FS66NedNkzUTRiza9xykDYBl+Da3EHG0f38vSFyIAZ6FFtAojdO4I9fpWt
    HboIFR1e4/EP0kMdiz2QtU9ElGQZX0UqPE64/aTPBQGhSHand6F/HazZ4f3Qq9gJ
    U5slGBrTZ/VS4fBiCauyss6bjP2MbKq0BurvJiiKbHea0C8OBcrz9tOCESj0sOzt
    GoQOXbA5eMvx4vuk/1yF4FAyPbvfRSGaigYzVkmbsMVbt7YbaMX/mI3Zm7eaOw6g
    SawdJEXrWD+8Y3Y365Sw/vOYzI5R9L37q6ZOKSxFLuJahMj2o7kVXTATN18tRMmZ
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=fICo9R9b x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=fICo9R9b x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIw3BJYeqRFo/GRlh454S2AUTRhqvxYKV5luTzNmriSP2YvhGCnmlf86INLSpI8DaI3pniyQhHOCyRH2akez/zsOimLY47pkHQqEupBEPC0H1WrUkreB
    FJL2fqAZloSZumJFU2HMTWvol4jD89I0nxdmHg4CR2rYDSRxbdGsAbZ3fhLXSJj/87U0++xGb182WYV9arcUdoItC7bn2cXpHpzFtyNoG7fEMX7cguBgpxyx
    rbpes5OPuGlomA+EdF1bDg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=OM8EEJsD5EUIPNQWs7oA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 19:06:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 04/11] staging: iio: tsl2x7x: move
 calibscale_available attribute to IIO_INTENSITY channel
Message-ID: <20180506190603.4cafa992@archlinux>
In-Reply-To: <20180504025319.28953-5-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-5-masneyb@onstation.org>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de, drew.paterson@ams.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu,  3 May 2018 22:53:12 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The calibscale_available attribute is currently associated with the
> IIO_LIGHT channel but should be associated with the IIO_INTENSITY
> channel. This patch corrects that association and it also corrects
> lines that were unnecessarily split for the
> in_intensity0_integration_time sysfs attribute.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 7e8db5178a2c..9aee04fb4168 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -777,9 +777,9 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  }
>  
>  static ssize_t
> -in_illuminance0_calibscale_available_show(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf)
> +in_intensity0_calibscale_available_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  
> @@ -1247,7 +1247,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
> +static DEVICE_ATTR_RO(in_intensity0_calibscale_available);
>  
>  static DEVICE_ATTR_RW(in_illuminance0_target_input);
>  
> @@ -1321,9 +1321,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  }
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> -	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available
> -		.dev_attr.attr,
> +	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1336,9 +1335,8 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> -	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available
> -		.dev_attr.attr,
> +	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1352,9 +1350,8 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> -	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available
> -		.dev_attr.attr,
> +	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
