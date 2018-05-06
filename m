Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3584689-1525630080-2-8531324274317002089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525630080; b=OMVaQfrpUKDIqtyEs8UHKrGSQQMVGVrOF9TGriTkNkuf0THXsB
    ZkdV99Ht9HC3l7rpdb/EL6knVKYsLJHgBBwCtXJKoPLac7aO/5SGQNJkpg1d8lPm
    XqL3xUGIRBa/l4YUSxr2wi7WgsAEmHZJOa5oqcDz1z0Ch34DwZKG2crP35dilOo6
    m7S6LlUvRbUFiAoIr/HojswnQUMaZmpmBqL0YvByf8IO9TUvAIOT2MyIGty/PrVJ
    bbB8GbyH5F3MwRuVmHh0QQ+G6iqrrdlfTuaL+PzPwn44lrzF8lip6SnyO1BJsVb+
    ADvFutKl4AT9yyEfqUDC5u48GZxzphJ9yAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525630080; bh=WrxC1
    ph2okP//rVAbUyhG29gQwYueqzQOnSdsoVofSg=; b=FR2p8LM3eWoJMjc9SUQjb
    ZyjPqb7OWFgvARIgbAMtg7SeuT8arH3sBLeh5/wFcXMaWMoJBcE4B4VE30Ec3KFG
    p7uxN2SPOEvJwBG/Pb2UfHJVglK9+XYe6cQzQgcgDvhzWwV547qv8YtvztEVXA6s
    /mE5+v4TK6sYBhrUd0r5lZejOKmgxoQnl1zj/zDDUePEVQ/r+iSqn6zDR9Xrcggk
    XJpkK+P89SRE43Qv5MmjsGus9KTgrnVQlTW/nHOBO1L0klb4aJQOo9EivBcRIIGC
    iHz/mzs3eZI1QyTMNRCjMESLkc+hk5IWHx/TEXO670nexZuceg7TS1Q07PPZezCY
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=FXz8Gtj/ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=FXz8Gtj/ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFQaE+/Kaej6X0gUzJUiB+98fnXlX3gyc9COISxX1yoTbWQhLbZ0UXTF6Is4KQJ6uTLzikzINhBU6THKR4uXWP8leQXiv8aUOcYXqnHv654kAoWPXmcv
    loV8KsZCt8I/qKNwONGb6uNA7B4zOWVqqqjg1LMYy3nbsqFMbWOnkFKUnPU2qhSYnfeUUq3xu639wTcPUzbGvfTnyd8uMN8NE/yaap0woXASVbUHZvN15zRn
    nUQvhqNHjENpfhXMvaEWhg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=fGO5CdyT4VWP04LonWoA:9 a=I3RYOidHBGVaMKTy:21 a=tv3i1UxE7dBwBBOn:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 19:07:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 05/11] staging: iio: tsl2x7x: use IIO_CONST_ATTR for
 calibscale_available
Message-ID: <20180506190736.7c2d0ac7@archlinux>
In-Reply-To: <20180504025319.28953-6-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-6-masneyb@onstation.org>
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

On Thu,  3 May 2018 22:53:13 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The in_intensity0_calibscale_available sysfs attribute has code that
> checks the device type to determine which calibration scales are
> available. This check is not necessary since all of the supported
> ALS device types use the scales 1 8 16 120. This patch converts the
> sysfs attribute to use IIO_CONST_ATTR. The following device datasheets
> were checked: tsl2571, tsl2771, tmd2771, tsl2572, tsl2772, tmd2772.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 46 ++++---------------------------------
>  1 file changed, 4 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 9aee04fb4168..cf582a2e3633 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -776,24 +776,7 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static ssize_t
> -in_intensity0_calibscale_available_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> -
> -	switch (chip->id) {
> -	case tsl2571:
> -	case tsl2671:
> -	case tmd2671:
> -	case tsl2771:
> -	case tmd2771:
> -		return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
> -	}
> -
> -	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
> -}
> +static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
>  
>  static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
>  
> @@ -1190,25 +1173,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  				chip->settings.als_gain = 2;
>  				break;
>  			case 120:
> -				switch (chip->id) {
> -				case tsl2572:
> -				case tsl2672:
> -				case tmd2672:
> -				case tsl2772:
> -				case tmd2772:
> -					return -EINVAL;
> -				}
> -				chip->settings.als_gain = 3;
> -				break;
> -			case 128:
> -				switch (chip->id) {
> -				case tsl2571:
> -				case tsl2671:
> -				case tmd2671:
> -				case tsl2771:
> -				case tmd2771:
> -					return -EINVAL;
> -				}
>  				chip->settings.als_gain = 3;
>  				break;
>  			default:
> @@ -1247,8 +1211,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static DEVICE_ATTR_RO(in_intensity0_calibscale_available);
> -
>  static DEVICE_ATTR_RW(in_illuminance0_target_input);
>  
>  static DEVICE_ATTR_WO(in_illuminance0_calibrate);
> @@ -1321,7 +1283,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  }
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> -	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
> @@ -1335,7 +1297,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> -	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
> @@ -1350,7 +1312,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> -	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
