Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2629652-1520931824-2-15851472225756643140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520931823; b=QYYhRW9OV8mtqpLrfOuV3xzzbaB4m2gps+LNbokIrGoDviT
    apea4hmz8Dn3FEOmI2xQq7cG2fSwS7epOZA7KOn5WooLRbOTSOG3mm/BksdNfI6B
    bJlJQIiXWAgR4ArwKfWP4UO/ITGaobb9PsqDv9Z5CqfFMR2oNUsLUGlaK5jqtRkB
    aKXOzvVIQ9vN1Zqz0La3cuFR2D8DSO8u6TMOMEW3cKOQGnmufYAGQGi3epgRvQNe
    +rElurjqa3VRTiJHXI6Ou+Q9ykqdt2Vnbg0d4DIBPoYKCJb+B85fFGvSo9hARArv
    W2fIMQvarWOVOgqJRdmRD/Q9Db/gs7bw0wlxZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520931823; bh=4
    TilJTZ8HDGU7CcnJlkGyjLA0pf23Qzi6v4n375u+cg=; b=jcvEWO/9Z9zg8A3XG
    wvuggVtaDmNodfkv1bLGEy+d/5U/fDred0uG6qcY9j5b8R0VpyhURlwmUI7jrx5T
    di1ODri+BuPT/m4duuhgfOpBZZvGzRdUvU21WWffr6bN2XMBh7Mvvfs6slfWZ/+n
    pgS7WUILQ2XYEaUmWtO+BuM0OFLSoGvmF2LST6FlWxt2XVpJe0KvvHm0yUyezasQ
    3+JujQxoS2naYgxAGZOwBR4q1C8R1hp8bbvyxpVDkPLc7of1XpGuCwCG+nZW1NBE
    YbPc8vQB5URrEzXVsiEA3BA6MkQBtc5sOcbV1FhIDMMwdvmepLy5ZnHWEGDsFw+P
    GSlBQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hbxumvnu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=hbxumvnu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 13 Mar 2018 12:02:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH 3/3] staging:iio:ad2s1210: Add write_raw to handle
 frequency
Message-ID: <20180313090249.cdurikolfwc5qyol@mwanda>
References: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <ae60ca5cf37d1678cb6b498450f75f93f3d498d2.1520878492.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ae60ca5cf37d1678cb6b498450f75f93f3d498d2.1520878492.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830
 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=898
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130110
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
Cc: devel@driverdev.osuosl.org, Graff Yang <graff.yang@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 03:21:52PM -0300, Rodrigo Siqueira wrote:
> The write interface of AD2S1210 utilizes IIO_DEVICE_ATTR, which violate
> the official IIO ABI. This patch, add the write_raw function responsible
> for handling the fclkin and fexcit channel; also it removes the use of
> IIO_DEVICE_ATTR for fclkin and fexcit.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 117 +++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 27a42ed10fcd..ea6ade4e563c 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -60,6 +60,8 @@
>  
>  #define AD2S1210_DEF_EXCIT	10000
>  
> +#define ERROR_MESSAGE "ad2s1210: %s out of range\n"
> +

Don't make this a define.  That's horrible.  It's a pointless layer of
abstraction.


>  enum ad2s1210_mode {
>  	MOD_POS = 0,
>  	MOD_VEL,
> @@ -210,64 +212,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
>  	return ad2s1210_config_write(st, 0x0);
>  }
>  
> -static ssize_t ad2s1210_store_fclkin(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t len)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned int fclkin;
> -	int ret;
> -
> -	ret = kstrtouint(buf, 10, &fclkin);
> -	if (ret)
> -		return ret;
> -	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
> -		dev_err(dev, "ad2s1210: fclkin out of range\n");
> -		return -EINVAL;
> -	}
> -
> -	mutex_lock(&st->lock);
> -	st->fclkin = fclkin;
> -
> -	ret = ad2s1210_update_frequency_control_word(st);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_soft_reset(st);
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret < 0 ? ret : len;
> -}
> -
> -static ssize_t ad2s1210_store_fexcit(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned int fexcit;
> -	int ret;
> -
> -	ret = kstrtouint(buf, 10, &fexcit);
> -	if (ret < 0)
> -		return ret;
> -	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
> -		dev_err(dev,
> -			"ad2s1210: excitation frequency out of range\n");
> -		return -EINVAL;
> -	}
> -	mutex_lock(&st->lock);
> -	st->fexcit = fexcit;
> -	ret = ad2s1210_update_frequency_control_word(st);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_soft_reset(st);
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret < 0 ? ret : len;
> -}
> -
>  static ssize_t ad2s1210_show_control(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> @@ -545,8 +489,58 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static IIO_DEVICE_ATTR(fclkin, 0644, NULL, ad2s1210_store_fclkin, 0);
> -static IIO_DEVICE_ATTR(fexcit, 0644, NULL, ad2s1210_store_fexcit, 0);
> +static int ad2s1210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	unsigned int clk = val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->channel) {

This is a switch statement with only one case.  Make it an if statement
and chop out some indenting.

	if (mask != IIO_CHAN_INFO_FREQUENCY)
		return -EINVAL;

> +		case FCLKIN:
> +			if (clk < AD2S1210_MIN_CLKIN ||
> +			    clk > AD2S1210_MAX_CLKIN) {
> +				dev_err(&indio_dev->dev, ERROR_MESSAGE,

Ah...  I see why you did the ERROR_MESSAGE define, to get around the 80
character limit.  Don't do that.  Just go over 80 characters if you need
to.


> +					"fclkin");
> +				ret = -EINVAL;
> +				goto error_ret;

Direct returns are better.  Less chance of bugs statistically.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
