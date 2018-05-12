Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1356340-1526123826-2-10093664122681456416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526123825; b=NIXwwbD8OpHZ1iLmkbLtOMUKJfQnayeS2C12o606V5NnTHOofa
    htTyB6WZqDM8JxxmbYv8mV/qdRffyTGW8BM/17Gb9HtAsEQwULwzZIE00sTIBy52
    +a/kQLk5gYwoxuk9IRXVnHtBbHpR/u6szn4wYZbmTMHHy5c2bfZWcfZeGy+0iGWB
    +fsbeheypwDrRieQFLOhdXMuaFyAOr6YVrrDo0R1K9Otgp29zVBdoWeo4P6q+b+B
    1TMovzEeGFR7SfwPIzF853Mwz3t2OgxJQkA/dCYYPKV8CJN6c/eCWx71OSGIUP6s
    0gRoBn/EoF07NrQ8KOR8BXPH77NH3UBYmk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526123825; bh=qon3Q
    zf3x4SLQC8CVPCpg1+PlOam+293Z3jBGdIUsEc=; b=H0vC3zYwWNGJCkBWmQ+Eu
    0UyGY8f9ismj/bz+8kjcy4puwmhn7jvYAIzIIUBePBssgf6rstsxyDx/HbrdZ4F6
    4473s6HKTqViuljES66bPm1CLn9A5VIXg3FJq7PwqqqBqrvgKNwcrPVVEe6RwyFU
    6WJaNgckxKAFh6k0sMsKudvYHAowz09u4zePAX3Q+CQbcfFLmCNilYlRltJ2OdGU
    j2y8Z8+h3Cn6e+n74yUboaEEOhwDdzTD7lmYJM00e8IyCXgDDG4sXDwKTZ2e/nPh
    OLXCWkg2CGxmhgggYmF+ZjczT6aZyQCSbf4d5+Tiddx+h75Xp0rwKw8jfWQHxz2o
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=JuAv1eLD x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=JuAv1eLD x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOxQ2TL0H0KXrFLdWWDyDUnIiYzK/FJ6+saGeExdreK0wJgF6YpYHQ77U+TcYH3IAUd7LbkOrqw1JBKJ3cTjVSpnEOfUNLClW9yktL1pZfPsTZRBmVcn
    SbJfuaCq/bXjzvfyVT993qSQDCORPgvHDfK3IpVkicMjIk0O2rW1dFBr0tGZl9s2U8AVjFIawr0toOeLEI3gk0G6m8Z+bJWiq9sG0JcsXNizXZWUdWjeON8o
    Kq/C26Rv5tLltck/5wWC6Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=6iI3cF5RZ0IlayrIxgoA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 12:16:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 3/9] staging: iio: tsl2x7x: turn chip off if IIO
 device registration fails
Message-ID: <20180512121653.06469001@archlinux>
In-Reply-To: <20180511001223.12378-4-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-4-masneyb@onstation.org>
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

On Thu, 10 May 2018 20:12:17 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch turns the chip off if IIO device registration fails so that
> the error handling mirrors the device remove to make review easier in
> preparation for moving this driver out of staging.
> 
> This patch also adds a missing error check in the call to
> tsl2x7x_chip_on() in tsl2x7x_probe().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index c1e726fc87b7..f5ca5ada0358 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1657,10 +1657,13 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	}
>  
>  	tsl2x7x_defaults(chip);
> -	tsl2x7x_chip_on(indio_dev);
> +	ret = tsl2x7x_chip_on(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> +		tsl2x7x_chip_off(indio_dev);
>  		dev_err(&clientp->dev,
>  			"%s: iio registration failed\n", __func__);
>  		return ret;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
