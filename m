Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELtCnFlqAai3gVVVhnnfvdwO3m7vv2ofqSg9EEHvtOfdsue0Quhy4qKtVYSwphbcFKIbPY5x
ARC-Seal: i=1; a=rsa-sha256; t=1520089568; cv=none;
        d=google.com; s=arc-20160816;
        b=VYFm9JBajumhMPR3fZReS4zhm/RVThAYVKWYMuYYqGKObyX8P9LtMj0ipzu4eTyCB4
         LF23ltH6hrh9g5W9cBKCYHvGyPRNIAtJZry4KWXEHu+X35NrlhhJr/ecR2QrUgCkI6HY
         2TNBYJU9pH7YAPKqpwlSRjigfmT8H2JSTcx6fdhaiPat5GeigH2J1X1OlvszByr35HDp
         2pC3HIEzi/P5RIxYCN7LxCtLrBL2cNfUNXFYPDDks+JX7inI7xCQaK3L3xDvjPXwRprE
         WZ5Ii2DnmjtcVvabEOU10Kd3r+T1U+KpkfKdplsCd2qpQQvkkiuldRsirCdsooY6vaYo
         GkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=qiMD0sHMFyX0e67/vXhmAkT/AXusU4FmZs8WUstESis=;
        b=nM5LUt0rw0XggFpvWIqcoVR4CqdA4sZfC6crnuLP1SOSnhd0Anw3eQUW452H5Knkow
         vJJtdPL9Zh44LWwokgZrgLpEIOXlG7j8jMAlCeV/yd6ZEvWtQDkTumQYSUHgRtvF+oBf
         Bq3Gc1y4FvWclTHQRQ1YFYXWFjLULwZkPJqfN70CbOVuxed1eB4gy5PaLOtGa0gVcxch
         PNjU7LMDtIn07PW9y53ooqORgH11jWMt+WJJ+bshvJbx9sC5I2Bu7uMUWfxGuyEpuBae
         JF7209x+fqUgofO4urUhSrSFlUDPSkW4lk4t4pw7Aq6AlYgNBKRNJRjbEfh21u5M2u7H
         ompw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDE82133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:06:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, daniel.baluta@nxp.com,
 linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging:iio:meter: Add name to function definition
 arguments
Message-ID: <20180303150603.043df2cf@archlinux>
In-Reply-To: <20180302233847.xwvs6qnpzhyqd6oq@smtp.gmail.com>
References: <20180221195435.bycvg26n6sm45lx5@smtp.gmail.com>
	<20180224134229.297acded@archlinux>
	<20180302233847.xwvs6qnpzhyqd6oq@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593041622332624434?=
X-GMAIL-MSGID: =?utf-8?q?1593929439147086257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018 20:38:47 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> On 02/24, Jonathan Cameron wrote:
> > On Wed, 21 Feb 2018 16:54:35 -0300
> > Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> >   
> > > This patch fixes the checkpatch.pl warning:
> > > 
> > > drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
> > > argument 'struct device *' should also have an identifier name...
> > > 
> > > This commit adds arguments names to the signature declared in the
> > > ade7854_state struct. For consistency reason, It also renames all
> > > arguments in function definitions.
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>  
> > 
> > I would have slightly preferred this as two patches - one doing the
> > renames and one introducing them where they were missing.
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to play with it.  
> 
> Hi Jonathan,
> 
> I looked at 'togreg' and 'testing' branch, and I did not find the patch.
> Is it in another branch?
Sorry, my fault - forgot to push out.  Should be there now.

Jonathan
> 
> Thanks.
> 
>  
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > Changes in v2:
> > >   - Make the commit message clearer.
> > >   - Use the same arguments name across signatures and definitions.
> > > Changes in v3:
> > >   - Fix name in the email header.
> > > 
> > >  drivers/staging/iio/meter/ade7754.c     |  6 +++---
> > >  drivers/staging/iio/meter/ade7854-i2c.c | 28 ++++++++++++++--------------
> > >  drivers/staging/iio/meter/ade7854-spi.c | 28 ++++++++++++++--------------
> > >  drivers/staging/iio/meter/ade7854.h     | 28 ++++++++++++++--------------
> > >  4 files changed, 45 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> > > index 3a1e342d75fb..9aa067736715 100644
> > > --- a/drivers/staging/iio/meter/ade7754.c
> > > +++ b/drivers/staging/iio/meter/ade7754.c
> > > @@ -132,7 +132,7 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> > >  }
> > >  
> > >  static int ade7754_spi_write_reg_16(struct device *dev,
> > > -				    u8 reg_address, u16 value)
> > > +				    u8 reg_address, u16 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -140,8 +140,8 @@ static int ade7754_spi_write_reg_16(struct device *dev,
> > >  
> > >  	mutex_lock(&st->buf_lock);
> > >  	st->tx[0] = ADE7754_WRITE_REG(reg_address);
> > > -	st->tx[1] = (value >> 8) & 0xFF;
> > > -	st->tx[2] = value & 0xFF;
> > > +	st->tx[1] = (val >> 8) & 0xFF;
> > > +	st->tx[2] = val & 0xFF;
> > >  	ret = spi_write(st->us, st->tx, 3);
> > >  	mutex_unlock(&st->buf_lock);
> > >  
> > > diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> > > index 8106f8cceeab..317e4f0d8176 100644
> > > --- a/drivers/staging/iio/meter/ade7854-i2c.c
> > > +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> > > @@ -17,7 +17,7 @@
> > >  
> > >  static int ade7854_i2c_write_reg_8(struct device *dev,
> > >  				   u16 reg_address,
> > > -				   u8 value)
> > > +				   u8 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -26,7 +26,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
> > >  	mutex_lock(&st->buf_lock);
> > >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[1] = reg_address & 0xFF;
> > > -	st->tx[2] = value;
> > > +	st->tx[2] = val;
> > >  
> > >  	ret = i2c_master_send(st->i2c, st->tx, 3);
> > >  	mutex_unlock(&st->buf_lock);
> > > @@ -36,7 +36,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
> > >  
> > >  static int ade7854_i2c_write_reg_16(struct device *dev,
> > >  				    u16 reg_address,
> > > -				    u16 value)
> > > +				    u16 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -45,8 +45,8 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
> > >  	mutex_lock(&st->buf_lock);
> > >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[1] = reg_address & 0xFF;
> > > -	st->tx[2] = (value >> 8) & 0xFF;
> > > -	st->tx[3] = value & 0xFF;
> > > +	st->tx[2] = (val >> 8) & 0xFF;
> > > +	st->tx[3] = val & 0xFF;
> > >  
> > >  	ret = i2c_master_send(st->i2c, st->tx, 4);
> > >  	mutex_unlock(&st->buf_lock);
> > > @@ -56,7 +56,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
> > >  
> > >  static int ade7854_i2c_write_reg_24(struct device *dev,
> > >  				    u16 reg_address,
> > > -				    u32 value)
> > > +				    u32 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -65,9 +65,9 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
> > >  	mutex_lock(&st->buf_lock);
> > >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[1] = reg_address & 0xFF;
> > > -	st->tx[2] = (value >> 16) & 0xFF;
> > > -	st->tx[3] = (value >> 8) & 0xFF;
> > > -	st->tx[4] = value & 0xFF;
> > > +	st->tx[2] = (val >> 16) & 0xFF;
> > > +	st->tx[3] = (val >> 8) & 0xFF;
> > > +	st->tx[4] = val & 0xFF;
> > >  
> > >  	ret = i2c_master_send(st->i2c, st->tx, 5);
> > >  	mutex_unlock(&st->buf_lock);
> > > @@ -77,7 +77,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
> > >  
> > >  static int ade7854_i2c_write_reg_32(struct device *dev,
> > >  				    u16 reg_address,
> > > -				    u32 value)
> > > +				    u32 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -86,10 +86,10 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
> > >  	mutex_lock(&st->buf_lock);
> > >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[1] = reg_address & 0xFF;
> > > -	st->tx[2] = (value >> 24) & 0xFF;
> > > -	st->tx[3] = (value >> 16) & 0xFF;
> > > -	st->tx[4] = (value >> 8) & 0xFF;
> > > -	st->tx[5] = value & 0xFF;
> > > +	st->tx[2] = (val >> 24) & 0xFF;
> > > +	st->tx[3] = (val >> 16) & 0xFF;
> > > +	st->tx[4] = (val >> 8) & 0xFF;
> > > +	st->tx[5] = val & 0xFF;
> > >  
> > >  	ret = i2c_master_send(st->i2c, st->tx, 6);
> > >  	mutex_unlock(&st->buf_lock);
> > > diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> > > index 63e200ffd1f2..72eddfec21f7 100644
> > > --- a/drivers/staging/iio/meter/ade7854-spi.c
> > > +++ b/drivers/staging/iio/meter/ade7854-spi.c
> > > @@ -17,7 +17,7 @@
> > >  
> > >  static int ade7854_spi_write_reg_8(struct device *dev,
> > >  		u16 reg_address,
> > > -		u8 value)
> > > +		u8 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -32,7 +32,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
> > >  	st->tx[0] = ADE7854_WRITE_REG;
> > >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[2] = reg_address & 0xFF;
> > > -	st->tx[3] = value & 0xFF;
> > > +	st->tx[3] = val & 0xFF;
> > >  
> > >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> > >  	mutex_unlock(&st->buf_lock);
> > > @@ -42,7 +42,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
> > >  
> > >  static int ade7854_spi_write_reg_16(struct device *dev,
> > >  		u16 reg_address,
> > > -		u16 value)
> > > +		u16 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -57,8 +57,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
> > >  	st->tx[0] = ADE7854_WRITE_REG;
> > >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[2] = reg_address & 0xFF;
> > > -	st->tx[3] = (value >> 8) & 0xFF;
> > > -	st->tx[4] = value & 0xFF;
> > > +	st->tx[3] = (val >> 8) & 0xFF;
> > > +	st->tx[4] = val & 0xFF;
> > >  
> > >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> > >  	mutex_unlock(&st->buf_lock);
> > > @@ -68,7 +68,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
> > >  
> > >  static int ade7854_spi_write_reg_24(struct device *dev,
> > >  		u16 reg_address,
> > > -		u32 value)
> > > +		u32 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -83,9 +83,9 @@ static int ade7854_spi_write_reg_24(struct device *dev,
> > >  	st->tx[0] = ADE7854_WRITE_REG;
> > >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[2] = reg_address & 0xFF;
> > > -	st->tx[3] = (value >> 16) & 0xFF;
> > > -	st->tx[4] = (value >> 8) & 0xFF;
> > > -	st->tx[5] = value & 0xFF;
> > > +	st->tx[3] = (val >> 16) & 0xFF;
> > > +	st->tx[4] = (val >> 8) & 0xFF;
> > > +	st->tx[5] = val & 0xFF;
> > >  
> > >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> > >  	mutex_unlock(&st->buf_lock);
> > > @@ -95,7 +95,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
> > >  
> > >  static int ade7854_spi_write_reg_32(struct device *dev,
> > >  		u16 reg_address,
> > > -		u32 value)
> > > +		u32 val)
> > >  {
> > >  	int ret;
> > >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > @@ -110,10 +110,10 @@ static int ade7854_spi_write_reg_32(struct device *dev,
> > >  	st->tx[0] = ADE7854_WRITE_REG;
> > >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> > >  	st->tx[2] = reg_address & 0xFF;
> > > -	st->tx[3] = (value >> 24) & 0xFF;
> > > -	st->tx[4] = (value >> 16) & 0xFF;
> > > -	st->tx[5] = (value >> 8) & 0xFF;
> > > -	st->tx[6] = value & 0xFF;
> > > +	st->tx[3] = (val >> 24) & 0xFF;
> > > +	st->tx[4] = (val >> 16) & 0xFF;
> > > +	st->tx[5] = (val >> 8) & 0xFF;
> > > +	st->tx[6] = val & 0xFF;
> > >  
> > >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> > >  	mutex_unlock(&st->buf_lock);
> > > diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> > > index c27247a7891a..a82d38224cbd 100644
> > > --- a/drivers/staging/iio/meter/ade7854.h
> > > +++ b/drivers/staging/iio/meter/ade7854.h
> > > @@ -152,20 +152,20 @@
> > >   * @rx:			receive buffer
> > >   **/
> > >  struct ade7854_state {
> > > -	struct spi_device	*spi;
> > > -	struct i2c_client	*i2c;
> > > -	int			(*read_reg_8)(struct device *, u16, u8 *);
> > > -	int			(*read_reg_16)(struct device *, u16, u16 *);
> > > -	int			(*read_reg_24)(struct device *, u16, u32 *);
> > > -	int			(*read_reg_32)(struct device *, u16, u32 *);
> > > -	int			(*write_reg_8)(struct device *, u16, u8);
> > > -	int			(*write_reg_16)(struct device *, u16, u16);
> > > -	int			(*write_reg_24)(struct device *, u16, u32);
> > > -	int			(*write_reg_32)(struct device *, u16, u32);
> > > -	int			irq;
> > > -	struct mutex		buf_lock;
> > > -	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
> > > -	u8			rx[ADE7854_MAX_RX];
> > > +	struct spi_device *spi;
> > > +	struct i2c_client *i2c;
> > > +	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
> > > +	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
> > > +	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
> > > +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> > > +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
> > > +	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
> > > +	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
> > > +	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
> > > +	int irq;
> > > +	struct mutex buf_lock;
> > > +	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
> > > +	u8 rx[ADE7854_MAX_RX];
> > >  
> > >  };
> > >    
> >   
