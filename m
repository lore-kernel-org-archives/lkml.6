Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3678177-1521366356-2-7761481166043863215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521366355; b=u23eapSZeJLmVBMS9gSC5VHRlqh55hRMDFUCiywXYovgLcF
    8zQ8paMSrRed5pxhkJHIt9kCAY8oKj+Vd0wc3OmuGhYFSh1IQ2las9E1VYqPfsXS
    mWLsdyw5eL1vmmqmLWsFsnp+EcWnieGaeFdfRTGZbvDrq2jHN5Q4JeF5cxzCkHcz
    sYKaC+dN/AZgCr+b8g3Gmdb2Wk9Aysi59yUrPDwfXRYYGd6jKWXwp68ZSZ5oT9I1
    LcczkrLlGIclvKC5wmxwjm5bRSkOW29h+n0YuHVvBnubkEw64t5YF+m6HvLI8NOT
    UAntibKsuJY7TCnNxM9IfTbl8hQ8EtBHD10STqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521366355; bh=U
    LKHwUBlRlegIrkegCvNp2egw0z8V27/2Xvgh4884pM=; b=wx/h9DxUdZ1bSPZQF
    Z9icjG/3BwkDhgu3zHTsPQ5+nrSTd7hEWU8ZxLc6eVyxiJBflW/TtZqV4bTmE4nv
    C3bJcSdBHa07zm5HcrPKUgMX0GGPbIciwpTMeQMtjXEo0VTKOUpuOz1zR3R+e+If
    c9DC5knmZDoQlFAM2dfCcyIez10jfu35C9/StFhxbO5IwMYukqbrCE2YrJVOQuTy
    /aW0QMezqY0pWKIMGKfGDvhxGvWUmTx135kbxA6TU6kR2BNXb5XnC48fFNoi4BlR
    hhNW9+AsotAtnojMKGGSdghb+KQjZ6qG3v1vCG9IitSxLJpYojZK8FkgJ9tmvoLm
    EGU5A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E812320838
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 09:45:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 1/8] staging:iio:ade7854: Fix error handling on
 read/write
Message-ID: <20180318094541.24331a00@archlinux>
In-Reply-To: <c6329504bb92726dd1ca45cd5b44e180e86a407e.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <c6329504bb92726dd1ca45cd5b44e180e86a407e.1521239766.git.rodrigosiqueiramelo@gmail.com>
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
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 19:48:33 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The original code does not correctly handle the error related to I2C
> read and write. This patch fixes the error handling related to all
> read/write functions for I2C. This patch is an adaptation of the John
> Syne patches.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
Hi Rodrigo,

I'm not sure what the chain of authorship was here.  If this is fundamentally
John's original patch he should still be the author and his sign off should be
first.  You then sign off afterwards to indicate that you 'handled' the patch
and believe the work to be John's (you are trusting his sign off).  This
is 'fun' legal stuff - read the docs on developers certificate of origin.

If the patch has changed 'enough' (where that is a fuzzy definition)
then you should as you have here take the authorship, but John's sign off is
no longer true (it's a different patch).  If John has reviewed the code
it is fine to have a reviewed-by or acked-by from John there to reflect
that.

Anyhow, please clarify the situation as I shouldn't take a patch where
I'm applying my sign-off without knowing the origins etc.

> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 24 ++++++++++++------------
>  drivers/staging/iio/meter/ade7854.c     | 10 +++++-----
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 317e4f0d8176..4437f1e33261 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -31,7 +31,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 3);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_16(struct device *dev,
> @@ -51,7 +51,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 4);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_24(struct device *dev,
> @@ -72,7 +72,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 5);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_32(struct device *dev,
> @@ -94,7 +94,7 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 6);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
So for write cases you are flattening to 0 for good and < 0 for bad.
good.
>  
>  static int ade7854_i2c_read_reg_8(struct device *dev,
> @@ -110,11 +110,11 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 1);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = st->rx[0];
But in read cases you are returning the number of bytes read...
Given these functions can know the 'right' answer to that why not check
it here and do the same as for writes in return 0 for good and < 0 for
bad?
> @@ -136,11 +136,11 @@ static int ade7854_i2c_read_reg_16(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 8) | st->rx[1];
> @@ -162,11 +162,11 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> @@ -188,11 +188,11 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 90d07cdca4b8..0193ae3aae29 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -33,7 +33,7 @@ static ssize_t ade7854_read_8bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_8(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
If you did as discussed above with the reads then this change would not
be needed and all the changes would be confined to the i2c code.

Thanks,

Jonathan


>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -50,7 +50,7 @@ static ssize_t ade7854_read_16bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_16(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -67,7 +67,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_24(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -84,7 +84,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	ret = st->read_reg_32(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -416,7 +416,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	u32 irqen;
>  
>  	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	if (enable)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
