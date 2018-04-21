Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460864-1524331366-2-11284427853905412131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524331365; b=jjIQzg2PSSwNSFmegp5qwDR3o6QmfCuw5J7pZi3Foz7y/8zrgH
    Y5cz5/BFzeX/U7BM8f4o2fI7uekjjuS7SV3IvoF3PdF7nrX+kG7jBfwJIAVWzntP
    LA1FrSccKfA+N9zmnWB8OhKUT6kHLugkq36sDcWCMmpf3WyGzBambHjIjmauBMYT
    41Gx0fUMeyFi5JIFfUUz0VsVULUm2lBiLvNPqksRV7X/iu86AIZYeTTVCIRAbohH
    LhznYUvMlrZ6HfpqMJwhqPUtEqJb6VN+2X5GCsvmSSUBopkF93QvwKAGpuIu+X1z
    d96Vb3c4jnWDfUn992WUyvBTdbznCyTseiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524331365; bh=yQ2H/
    IdMb97odnGiMe7NIiF79wCmSG0gFCCmpFWnAyE=; b=MfRS2yroDpn0c48lGjzWL
    bZA55GvEyU1xf19koJv3TYSueSuRcP2TU2pj1Ge1t+ztUz5MpKepblA37FA4ftET
    rdFIIOxuWeKB9Uk3OFtkDDgABwMWZH70dZeg0gCwgWVf4X2DvnOaAYBOqtMR6Wb4
    kI/yWWCo6FyYdZVRl2NWSy6cyOuOyUCRbOulSwobaJoSRifIpuNvgqN7bAjdVvQO
    CLAs3cW7Q8vP1KamSe6EfIMHC5XjMbdE8yhgmf6qa8RUmIEY5zApKCDZ01ZM1xVT
    KL4d+HU1G9XbA2h2jcpKjKME5dk5NM2h6NbaRxDbAJOx3i2usOBabpAeq4uo9DvC
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEWy67QTPCAfjMUlHzQflyV8fHXI9YkrmRRVacwB5UfBmUounFUiUNLZMwcXysVht18XHxHwWAe0dLrC/MBN37rdD8y8C65GCNd+Z7729BAB+JYh2wX3
    3EZ6MfwJ9JfXyF5kH9JHrrc4zt7YpE1L+we9Z4jfeoQhTKrx7VK5e3mvF7sOobZyD5/e0sCWUkE3/Dw22ssZyF4ZlMU6YVw7IwqxgKVvoevdqfe5ef5ZgK6e
    e+O+0RIJjOWgWmvy2RnOOw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=ORlXwjuaMQ1Fe7YkGKwA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
    a=Xaum8mCUkNcp2hE7:21 a=K2TRLrT_iLvPe9NH:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065F321104
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 18:22:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 2/3] stagging:iio:meter: Add ade7854_read_raw function
Message-ID: <20180421182232.7a573a40@archlinux>
In-Reply-To: <9900ff3d492dbca4dc39cdd8ca6490af05a4f09a.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <9900ff3d492dbca4dc39cdd8ca6490af05a4f09a.1524311298.git.rodrigosiqueiramelo@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 21 Apr 2018 08:55:52 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch adds the ade7854_read_raw() function which is responsible for
> handling the read operation for registers: AIGAIN, BIGAIN, CIGAIN,
> NIGAIN, AVGAIN, BVGAIN, and CVGAIN. For the sake of simplicity, this
> patch only adds basic manipulation for current and voltage channels.
> Finally, this patch disables the old approach for reading data.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Other than the previous mentioned issue with the way the channels are
defined, this is nearly fine.

See inline.

> ---
>  drivers/staging/iio/meter/ade7854.c | 41 ++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 2fbb2570ba54..242ecde75900 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -229,31 +229,31 @@ static int ade7854_reset(struct device *dev)
>  }
>  
>  static IIO_DEV_ATTR_AIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_AIGAIN);
>  static IIO_DEV_ATTR_BIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_BIGAIN);
>  static IIO_DEV_ATTR_CIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_CIGAIN);
>  static IIO_DEV_ATTR_NIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_NIGAIN);
>  static IIO_DEV_ATTR_AVGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_AVGAIN);
>  static IIO_DEV_ATTR_BVGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_BVGAIN);
>  static IIO_DEV_ATTR_CVGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_CVGAIN);
>  static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
> @@ -471,6 +471,32 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	return st->write_reg(dev, ADE7854_MASK0, irqen, 32);
>  }
>  
> +static int ade7854_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ade7854_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
Given you specified sampling frequency for the channels in the previous
patch this is a little odd!

> +
> +	switch (chan->type) {
> +	case IIO_CURRENT:
> +	case IIO_VOLTAGE:
> +		ret = st->read_reg(&indio_dev->dev, chan->address, val, 24);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int ade7854_initial_setup(struct iio_dev *indio_dev)
>  {
>  	int ret;
> @@ -572,6 +598,7 @@ static const struct attribute_group ade7854_attribute_group = {
>  
>  static const struct iio_info ade7854_info = {
>  	.attrs = &ade7854_attribute_group,
> +	.read_raw = &ade7854_read_raw,
>  };
>  
>  int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
