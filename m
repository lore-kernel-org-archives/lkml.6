Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-460864-1524331580-5-13950748553503985844
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
    1524331579; b=pLQ6cEdb1vP86pKJpOp281WzuUzPxd1/olcXWy3BQKkWilqSSk
    CY5YdJYGwLjON/Q7J3kkyBg89L1rfXS1cL0uU/sIITfcRiV9xdB70ee9dXFzxGAC
    N7E5ABIruo90/bhj0UXrF/dRmAFxHF3XWWhyXWG2IblAoGSW9ZyKAce6fdM+HjXG
    ImVpTlarTbnGv8/eIe0ZcOr2wy5GORKzYq45QArqNZqw3cGsVMBIRsXJrO9pg4xy
    qImIYrohCTB9D/SWQpL763xEO9TApgfPuwKzIJAzZSnevKg3VcJyyqpkUpEpByW4
    pfhafDf8qUhgIov6AuRlkKm8JgxDRNuNjdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524331579; bh=XAySv
    3+qkzV6K0+G6RDHiAg9dsAHe5/p7Z+JO3JcMjo=; b=VU/PzK2Oj26qe27cJZXvG
    3gtK14CieEYVu3AKLopMbjb82tdpEsKUK3Nj2Hh57oDs9OuQr4mfnp0efoU8gmEx
    G070I4bCA78T/S8QiZYzXKZDVAKqE2O9yurWZdwt4EVAJSwOSPvwb38KZg/g/jg2
    sIc/9ysamkAT69VDI5z/oeJcBi0hOieqG7UFMPpBkUudf82lpztg/5ku//oK81ce
    txCcwzz2yP4npRxOsXImOzoQFBx429pLPgp3SqLyMLpnNOCd8+dNsodJnkw8cmaR
    3pp/P4qGbRumn1jsdX7lucfBcXzj8e/cZYRk1K475wSkl47f/qOw3YAXcYaR7Qd6
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
X-CM-Envelope: MS4wfMl7g5j/nwGVCmAVFBRT8B7UbGvOmEz2UvJdy0qo05I32o2pHJh1MEWRMpz2Whfwkn8VVSpuDvBhLzAB7a+MnatAbIk1PqCqvd6Zj2sV+zjlMW7b1tIo
    0jE6LouiweZQan5P3IuvXucY9scSNnpP47DuKEeHkGj10mBfntotZ02sUP1s9i5faQmg9Lvd7uVJjS7vfu6F7y+VbUazjjX9RCYjSqSIoMKttlPymaIKI+pP
    GrWkclIoJg2NJ1nZssXhnw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=x8MYKJAVCqi3D4_BGVYA:9 a=8tSJy2skGzhcg8gH:21 a=1aisqjzt9sTemgLs:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6553E21104
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 18:26:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 3/3] stagging:iio:meter: Add ade7854_write_raw function
Message-ID: <20180421182608.3371a50b@archlinux>
In-Reply-To: <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
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

On Sat, 21 Apr 2018 08:56:19 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch adds the ade7854_write_raw() function which is responsible
> for handling the write operation for registers: AIGAIN, BIGAIN, CIGAIN,
> NIGAIN, AVGAIN, BVGAIN, and CVGAIN. Finally, this patch completely
> removes the old ABI used for handling the registers mentioned above.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
The baby steps approach here is good, but with all 3 patches as one it
would have been a lot easier to follow.

This is almost fine except for the issue I had with how the channels
were defined in the first place.

Also a question about scales inline...

> ---
>  drivers/staging/iio/meter/ade7854.c | 60 ++++++++++++-----------------
>  1 file changed, 25 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 242ecde75900..df19c8b4b5d7 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -228,34 +228,6 @@ static int ade7854_reset(struct device *dev)
>  	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
>  }
>  
> -static IIO_DEV_ATTR_AIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_AIGAIN);
> -static IIO_DEV_ATTR_BIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_BIGAIN);
> -static IIO_DEV_ATTR_CIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_CIGAIN);
> -static IIO_DEV_ATTR_NIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_NIGAIN);
> -static IIO_DEV_ATTR_AVGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_AVGAIN);
> -static IIO_DEV_ATTR_BVGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_BVGAIN);
> -static IIO_DEV_ATTR_CVGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_CVGAIN);
>  static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
>  		ade7854_read_24bit,
>  		ade7854_write_24bit,
> @@ -497,6 +469,30 @@ static int ade7854_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int ade7854_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ade7854_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_CURRENT:
> +	case IIO_VOLTAGE:
Probably need some range checking to make sure we have a sane value.

Also, I'm curious about units here.

you are using CHAN_INFO_SCALE which would mean this is linked to
the _RAW value (the actual reading of the channel) by _RAW*_SCALE = value in
defined base units for the channel type.  So I'd expect to see some
code here doing a conversion to the internal format for the device.

I wouldn't expect to see a value from userspace written unconverted
into the register.

(I missed this in the previous patch - sorry).

Jonathan

> +		ret = st->write_reg(&indio_dev->dev, chan->address, val, 24);
> +		if (ret < 0)
> +			return ret;
> +		return 0;
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
> @@ -521,13 +517,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
>  static IIO_CONST_ATTR(name, "ade7854");
>  
>  static struct attribute *ade7854_attributes[] = {
> -	&iio_dev_attr_aigain.dev_attr.attr,
> -	&iio_dev_attr_bigain.dev_attr.attr,
> -	&iio_dev_attr_cigain.dev_attr.attr,
> -	&iio_dev_attr_nigain.dev_attr.attr,
> -	&iio_dev_attr_avgain.dev_attr.attr,
> -	&iio_dev_attr_bvgain.dev_attr.attr,
> -	&iio_dev_attr_cvgain.dev_attr.attr,
>  	&iio_dev_attr_linecyc.dev_attr.attr,
>  	&iio_dev_attr_sagcyc.dev_attr.attr,
>  	&iio_dev_attr_cfcyc.dev_attr.attr,
> @@ -599,6 +588,7 @@ static const struct attribute_group ade7854_attribute_group = {
>  static const struct iio_info ade7854_info = {
>  	.attrs = &ade7854_attribute_group,
>  	.read_raw = &ade7854_read_raw,
> +	.write_raw = &ade7854_write_raw,
>  };
>  
>  int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
