Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3584689-1525629720-2-6115697826364567940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525629719; b=ejAJ2M0Vg1DAvNgZTdjrTS7qgOkuVrJDPByP0BUj5pI291ScNW
    edMI0ai1GUnZtJPV5PkooKV2WHwj3Xm2bRjwdCBU12OwYrPl295f9j1kjFf5Ql1k
    Z1fQFAVNSwdbsetXZsbrXElcJQz3HBIYj+C13JNPi/9bYF/5vzCk+i+JnoeWjaeP
    gsTFTGcQRjeLnUBHChBfghM0IVklZB+lfRotU3LkYOY8rVtYDMjaRijMqkwWmx8X
    P6VrqGuIRk+6WuNb4o1Rw8crFkL+L9tTPWITRkAz+S3YteAJsDemRc2DiZehIPJV
    qGvayv/BoMqrsmdEfRhvPd55C376FIdOkGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525629719; bh=gvBny
    q99a8E8bOUPonk+7A2ZE0Z89jh/pxpd0lXcdUo=; b=dNGQFNZH4AcsJv8P5IMeW
    kRXmaGTQBiIi4LiJBJ37E4q47UHRI1yhg1hLWoQN37TklbiUAIc0eBoFTpYL/FDY
    wLPXET/uVc5nGNiDaSTw/5Q2dEfRJf1SgsWwafaMuIIA81FzZ61TnuftL2Yjmvw9
    VIXKY2qz40oibw/DVVsGil3TwZ0bwmGb0PlCe89JS7BTH694Po1CvLLU8Y+oiaPD
    HXOBHbWGJj5NscCekDK2g61X6RwaadYmEJECWGcVzXkGk1RIpjL8zybfGUGbdEbB
    SU4FzO13g1Miiluqc6r9QIa5QvXoQbkreWhnsizRYs8KtK/cKfO9Mw1a50Rr3Iqs
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=Z9E3wRum x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=Z9E3wRum x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIEIS3UoDe6LyInsZ6BER+84sa807EeuhZU+AH20Cf9ZdIEe1IOG0ZjolOehV2vorKAka1yNetY28hfm6qbdMB2jpIzlCiJnH5q8+FZ/waaZX614tXcO
    STO8vJB5T2utNHKON6pYA1co+fC1UDPugt7VCCQWcHHnsc6x7+S8OqPrqsOaeE7MH+vR/tELkoEA7hNULbGereeUo/pRTTB+2xcqFQScVUUBG6pmczwd+47i
    khwmhj77bEpGNnuSEf44pA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=LFXnIVYEelBOnfSsvc0A:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 19:01:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 02/11] staging: iio: tsl2x7x: add range checking to
 three sysfs attributes
Message-ID: <20180506190146.5317da10@archlinux>
In-Reply-To: <20180504025319.28953-3-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-3-masneyb@onstation.org>
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

On Thu,  3 May 2018 22:53:10 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The sysfs attributes in_illuminance0_target_input,
> in_illuminance0_calibrate, and in_proximity0_calibrate did not have
> proper range checking in place so this patch adds the correct range
> checks.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 01bff4593640..b4d77f65ca12 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -814,15 +814,13 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	unsigned long value;
> +	u16 value;
>  	int ret;
>  
> -	if (kstrtoul(buf, 0, &value))
> +	if (kstrtou16(buf, 0, &value))
>  		return -EINVAL;
>  
> -	if (value)
> -		chip->settings.als_cal_target = value;
> -
> +	chip->settings.als_cal_target = value;
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
> @@ -838,14 +836,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>  	bool value;
>  	int ret;
>  
> -	if (strtobool(buf, &value))
> +	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	if (value) {
> -		ret = tsl2x7x_als_calibrate(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = tsl2x7x_als_calibrate(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
> @@ -932,14 +928,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
>  	bool value;
>  	int ret;
>  
> -	if (strtobool(buf, &value))
> +	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	if (value) {
> -		ret = tsl2x7x_prox_cal(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = tsl2x7x_prox_cal(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
