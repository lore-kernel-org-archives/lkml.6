Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3936627-1521899060-2-5403883436393753775
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enrofr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521899060; b=FRBKZX8vl0TAb3yZNCgBPrzsXPN/Pl7+x60pKA/D/Vb1HVQ
    IEpmvrK8DP2wpfGcXpJPfkJ6FBPbWMQjU7l77sXGnmfHYw24rZZgGVC5csJkSJJY
    XhfT+iOF89Eb5Gm7DvrqZOi/3rin4zbqfSn2Sec+jn6UmRDc1NLSArfJuF6xngNF
    3sDHiYYoKhUM/VGpPtQjUFKiK9jTadmmfXNVSlIreexmx4PnG44Q1pSaPFko/b85
    u24KCnUlrQWkjr609Uq4Dm/QT3BFUimtws54yTs5FvVARoMd3tA6ZJuYmoa0JJKC
    vsqWpgXOUnhriLXFAQAUoH7/RHET74aj0reXL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521899060; bh=b
    Atw4UsK0d0GWI4us37rntf5EpSJdmPAIXyE6+66Ep0=; b=Fkb0YC5iMbRciaDcI
    6Rr5yXF+fpPx5ww1EREQkZfJ3asnEktGYWKltMIsO/+8G2rmqKittIaLtnGyJrHX
    bTSdLAlcK8uJpVDEtNw363NaoWDdicZJ7tW697/MxtVjHKZAcTA8ysB5O/ZWt4/H
    5+vmHjpQNYhuXkh8Wr1SoeyHm9QseePALxEv1zOygQ52K7b1PtXAP6XiUWvEWUf3
    /JrFmxhLVQnzIKlgddRSF+HZyL+gFMurzaFHO97N5US0AhFR0T8k10sQ/30GdV9+
    pNYXKkzqzU4trx1GdkcuNCwq6m1l1ZkjD2R0+WapMMU57KtAHvnhDfK6hOUVs4TP
    I/apw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4796721772
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 13:44:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 10/11] staging: iio: tsl2x7x: put local variables in
 reverse Christmas tree order
Message-ID: <20180324134410.142b622e@archlinux>
In-Reply-To: <20180321102912.5130-11-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
 <20180321102912.5130-11-masneyb@onstation.org>
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

On Wed, 21 Mar 2018 06:29:11 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch ensures that all of the local variable declarations are in
> reverse Christmas tree order where possible to increase code
> readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied. As ever it's a minor improvement but I suppose worth doing
whilst we are there!

Thanks,

Jonathan.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 65b7fbca8c5d..5f78664d2b0e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -336,13 +336,12 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
>   */
>  static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  {
> -	u32 lux; /* raw lux calculated from device data */
> -	u64 lux64;
> -	u32 ratio;
> -	u8 buf[4];
> -	struct tsl2x7x_lux *p;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	struct tsl2x7x_lux *p;
> +	u32 lux, ratio;
>  	int i, ret;
> +	u64 lux64;
> +	u8 buf[4];
>  
>  	mutex_lock(&chip->als_mutex);
>  
> @@ -589,13 +588,9 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  
>  static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  {
> -	int i;
> -	int ret = 0;
> -	u8 *dev_reg;
> -	int als_count;
> -	int als_time;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	u8 reg_val = 0;
> +	int ret, i, als_count, als_time;
> +	u8 *dev_reg, reg_val;
>  
>  	/* Non calculated parameters */
>  	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
> @@ -1121,8 +1116,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			    int *val2,
>  			    long mask)
>  {
> -	int ret = -EINVAL;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -1583,9 +1578,9 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  static int tsl2x7x_probe(struct i2c_client *clientp,
>  			 const struct i2c_device_id *id)
>  {
> -	int ret;
>  	struct iio_dev *indio_dev;
>  	struct tsl2X7X_chip *chip;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
>  	if (!indio_dev)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
