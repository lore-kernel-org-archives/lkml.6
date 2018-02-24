Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AH8x225pTvqn2VTX16vU5v9+sza9KOHQC11nMk4XqMy9P49d2PjhnOoBhLuNkOvSeW26HIPIChFC
ARC-Seal: i=1; a=rsa-sha256; t=1519479754; cv=none;
        d=google.com; s=arc-20160816;
        b=Wk49IgMSOV2SOCPhxhxEB42S6wa+qN93rF3k20YDnl6qElJCo+m/k2WClP3euI5+Bx
         AHIUxzDdhIokF1qfuP+q+bs3Wky2XrDwGIU6omFMdLYFb7XsjqMeJuQvlSOahIpr12oi
         eKyWexWTK4J1LzFJr2UveKoXE/f+472cPt6RrTkIjj2ZB3z9J9kWUyAsxz6Fa/9Evxgi
         kb+HoWITQx930dQ0NU4eiPzw1GO34eUPl7TNHIs+tmg46b38ZCRzdWkRgEbaC++ozjOI
         XDVNF9VIWtqeaL11zsdApjvCXazB3W2GQ6syUVkodFWJG4WTV/wxS3b979wbaDEbDUz0
         Sgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=0n73P8KNoQS+UuxOS93g6q+tp5oa4lkqA5mxtG58Oo8=;
        b=KgssttPwcSUM1CdHMT+0TxNhVAq0tyXPTe4U/vzYuVOtdHNgiddZpIz09E58ckpihH
         cNjaXM/wbg09s2zSM6MXukx6o+mCuIagaC4Q9F769H6ExtNmSn+LbVKH5wmSuzDxA6/p
         zlkhck0gHUMyRA9s8gUenu8qFHbonSbYbG5gxEs6kQB/vNOWE8N4ajweDO4xK2fftz5o
         aaT9ehPjTZVXSn6NbnMVpkJWABDcLiDcm7pAsgaWdr5Fp3Wcz8lFh/KT+9tN2gti6fLb
         VTOXaZ4yN9Arl/4aUMLpTJpV5BJM/1113bP8L9Mo0k9LT6GqPkWtQivN/pbQhkSeLQ3m
         Ytbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C89E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Feb 2018 13:42:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, daniel.baluta@nxp.com,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging:iio:meter: Add name to function definition
 arguments
Message-ID: <20180224134229.297acded@archlinux>
In-Reply-To: <20180221195435.bycvg26n6sm45lx5@smtp.gmail.com>
References: <20180221195435.bycvg26n6sm45lx5@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593041622332624434?=
X-GMAIL-MSGID: =?utf-8?q?1593290002710157641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Feb 2018 16:54:35 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch fixes the checkpatch.pl warning:
> 
> drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
> argument 'struct device *' should also have an identifier name...
> 
> This commit adds arguments names to the signature declared in the
> ade7854_state struct. For consistency reason, It also renames all
> arguments in function definitions.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

I would have slightly preferred this as two patches - one doing the
renames and one introducing them where they were missing.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Make the commit message clearer.
>   - Use the same arguments name across signatures and definitions.
> Changes in v3:
>   - Fix name in the email header.
> 
>  drivers/staging/iio/meter/ade7754.c     |  6 +++---
>  drivers/staging/iio/meter/ade7854-i2c.c | 28 ++++++++++++++--------------
>  drivers/staging/iio/meter/ade7854-spi.c | 28 ++++++++++++++--------------
>  drivers/staging/iio/meter/ade7854.h     | 28 ++++++++++++++--------------
>  4 files changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 3a1e342d75fb..9aa067736715 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -132,7 +132,7 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
>  }
>  
>  static int ade7754_spi_write_reg_16(struct device *dev,
> -				    u8 reg_address, u16 value)
> +				    u8 reg_address, u16 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -140,8 +140,8 @@ static int ade7754_spi_write_reg_16(struct device *dev,
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7754_WRITE_REG(reg_address);
> -	st->tx[1] = (value >> 8) & 0xFF;
> -	st->tx[2] = value & 0xFF;
> +	st->tx[1] = (val >> 8) & 0xFF;
> +	st->tx[2] = val & 0xFF;
>  	ret = spi_write(st->us, st->tx, 3);
>  	mutex_unlock(&st->buf_lock);
>  
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 8106f8cceeab..317e4f0d8176 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -17,7 +17,7 @@
>  
>  static int ade7854_i2c_write_reg_8(struct device *dev,
>  				   u16 reg_address,
> -				   u8 value)
> +				   u8 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -26,7 +26,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = value;
> +	st->tx[2] = val;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 3);
>  	mutex_unlock(&st->buf_lock);
> @@ -36,7 +36,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
>  
>  static int ade7854_i2c_write_reg_16(struct device *dev,
>  				    u16 reg_address,
> -				    u16 value)
> +				    u16 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -45,8 +45,8 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (value >> 8) & 0xFF;
> -	st->tx[3] = value & 0xFF;
> +	st->tx[2] = (val >> 8) & 0xFF;
> +	st->tx[3] = val & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 4);
>  	mutex_unlock(&st->buf_lock);
> @@ -56,7 +56,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
>  
>  static int ade7854_i2c_write_reg_24(struct device *dev,
>  				    u16 reg_address,
> -				    u32 value)
> +				    u32 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -65,9 +65,9 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (value >> 16) & 0xFF;
> -	st->tx[3] = (value >> 8) & 0xFF;
> -	st->tx[4] = value & 0xFF;
> +	st->tx[2] = (val >> 16) & 0xFF;
> +	st->tx[3] = (val >> 8) & 0xFF;
> +	st->tx[4] = val & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 5);
>  	mutex_unlock(&st->buf_lock);
> @@ -77,7 +77,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
>  
>  static int ade7854_i2c_write_reg_32(struct device *dev,
>  				    u16 reg_address,
> -				    u32 value)
> +				    u32 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -86,10 +86,10 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (value >> 24) & 0xFF;
> -	st->tx[3] = (value >> 16) & 0xFF;
> -	st->tx[4] = (value >> 8) & 0xFF;
> -	st->tx[5] = value & 0xFF;
> +	st->tx[2] = (val >> 24) & 0xFF;
> +	st->tx[3] = (val >> 16) & 0xFF;
> +	st->tx[4] = (val >> 8) & 0xFF;
> +	st->tx[5] = val & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 6);
>  	mutex_unlock(&st->buf_lock);
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 63e200ffd1f2..72eddfec21f7 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -17,7 +17,7 @@
>  
>  static int ade7854_spi_write_reg_8(struct device *dev,
>  		u16 reg_address,
> -		u8 value)
> +		u8 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -32,7 +32,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = value & 0xFF;
> +	st->tx[3] = val & 0xFF;
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
>  	mutex_unlock(&st->buf_lock);
> @@ -42,7 +42,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
>  
>  static int ade7854_spi_write_reg_16(struct device *dev,
>  		u16 reg_address,
> -		u16 value)
> +		u16 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -57,8 +57,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (value >> 8) & 0xFF;
> -	st->tx[4] = value & 0xFF;
> +	st->tx[3] = (val >> 8) & 0xFF;
> +	st->tx[4] = val & 0xFF;
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
>  	mutex_unlock(&st->buf_lock);
> @@ -68,7 +68,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
>  
>  static int ade7854_spi_write_reg_24(struct device *dev,
>  		u16 reg_address,
> -		u32 value)
> +		u32 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -83,9 +83,9 @@ static int ade7854_spi_write_reg_24(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (value >> 16) & 0xFF;
> -	st->tx[4] = (value >> 8) & 0xFF;
> -	st->tx[5] = value & 0xFF;
> +	st->tx[3] = (val >> 16) & 0xFF;
> +	st->tx[4] = (val >> 8) & 0xFF;
> +	st->tx[5] = val & 0xFF;
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
>  	mutex_unlock(&st->buf_lock);
> @@ -95,7 +95,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
>  
>  static int ade7854_spi_write_reg_32(struct device *dev,
>  		u16 reg_address,
> -		u32 value)
> +		u32 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -110,10 +110,10 @@ static int ade7854_spi_write_reg_32(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (value >> 24) & 0xFF;
> -	st->tx[4] = (value >> 16) & 0xFF;
> -	st->tx[5] = (value >> 8) & 0xFF;
> -	st->tx[6] = value & 0xFF;
> +	st->tx[3] = (val >> 24) & 0xFF;
> +	st->tx[4] = (val >> 16) & 0xFF;
> +	st->tx[5] = (val >> 8) & 0xFF;
> +	st->tx[6] = val & 0xFF;
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
>  	mutex_unlock(&st->buf_lock);
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index c27247a7891a..a82d38224cbd 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -152,20 +152,20 @@
>   * @rx:			receive buffer
>   **/
>  struct ade7854_state {
> -	struct spi_device	*spi;
> -	struct i2c_client	*i2c;
> -	int			(*read_reg_8)(struct device *, u16, u8 *);
> -	int			(*read_reg_16)(struct device *, u16, u16 *);
> -	int			(*read_reg_24)(struct device *, u16, u32 *);
> -	int			(*read_reg_32)(struct device *, u16, u32 *);
> -	int			(*write_reg_8)(struct device *, u16, u8);
> -	int			(*write_reg_16)(struct device *, u16, u16);
> -	int			(*write_reg_24)(struct device *, u16, u32);
> -	int			(*write_reg_32)(struct device *, u16, u32);
> -	int			irq;
> -	struct mutex		buf_lock;
> -	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
> -	u8			rx[ADE7854_MAX_RX];
> +	struct spi_device *spi;
> +	struct i2c_client *i2c;
> +	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
> +	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
> +	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
> +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
> +	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
> +	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
> +	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
> +	int irq;
> +	struct mutex buf_lock;
> +	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
> +	u8 rx[ADE7854_MAX_RX];
>  
>  };
>  
