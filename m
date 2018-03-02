Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2835548-1520033945-2-4902107333821916618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520033944; b=sKraep4EzOi5tGj9S1uDwuHecBtFy0v18gGGH2VEzhBmPK4
    lzYu4merInyz/AEoLRn7h1LqEA/cIuvZhAUe8tNJ5r5aGfz4wukALXUtN4XSPCva
    C4nfwUDwEJRVskdumxZsSIFw6M3r2OdXgm+PS8BG/tAP2Z+NgEUz+TsdY3RQte2H
    FPQhYP5ATVrUWRRahBX5whB9I6p6q8eKk46LsySoT/zLcnSMoQwwy1RNuWEAvsLN
    VQP86kZXCUQoL08pMW7KNHRexzgj3OaMNgpnGazZPzc9xEGjxqadbBm7/s3QKbsN
    R7jYRn3DCOxsgXF3pHZ01DBnc4kdkbPfbRpM6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520033944; bh=6
    xC1pHBFQNy2+LdjLrcWLjtjaWOQJvTtin3mExZMcWQ=; b=Jv1XSpri5XU5IiBWw
    HA3NzYQWiVdRMThdBI80987zjp1pQEPC1qi02Vq8zio/L4f0nVMyCbp5bPQ3Exj7
    afaew3mszuX1qZst8RU8CIYiOTI3ZUmqFRazOy/ari/f42h/XaYLBryjPcYgp3xv
    9ylsbbTg2+KDe9euxqpFDvXr5y2w7IIuYYbbV11AiIScqiNxutQniFzNIfik+KOB
    9Lp4+ZTtx8fdsKWNEvPTXCdVV7WDxjtoTHdrVPPodjQc0OORjJGht0SwakXFKodm
    04bjsli9zntfpQdDGVMfCpwlEZhS2XV8mgzICQ0BAtokSDjKoP2AwdijF7MK4sUp
    y5Ikw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BvoK7ACu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mtu86G0J;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BvoK7ACu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mtu86G0J;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuDgZqDS/l19TaZu4FnAI/CnOM9N6GWMRm/HKRvHKEAPx1EhS4FYboqflTId217G4jevw0OMA==
Date: Fri, 2 Mar 2018 20:38:47 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3] staging:iio:meter: Add name to function definition
 arguments
Message-ID: <20180302233847.xwvs6qnpzhyqd6oq@smtp.gmail.com>
References: <20180221195435.bycvg26n6sm45lx5@smtp.gmail.com>
 <20180224134229.297acded@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180224134229.297acded@archlinux>
User-Agent: NeoMutt/20171215
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
 Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/24, Jonathan Cameron wrote:
> On Wed, 21 Feb 2018 16:54:35 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> 
> > This patch fixes the checkpatch.pl warning:
> > 
> > drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
> > argument 'struct device *' should also have an identifier name...
> > 
> > This commit adds arguments names to the signature declared in the
> > ade7854_state struct. For consistency reason, It also renames all
> > arguments in function definitions.
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> 
> I would have slightly preferred this as two patches - one doing the
> renames and one introducing them where they were missing.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Hi Jonathan,

I looked at 'togreg' and 'testing' branch, and I did not find the patch.
Is it in another branch?

Thanks.

 
> Thanks,
> 
> Jonathan
> 
> > ---
> > Changes in v2:
> >   - Make the commit message clearer.
> >   - Use the same arguments name across signatures and definitions.
> > Changes in v3:
> >   - Fix name in the email header.
> > 
> >  drivers/staging/iio/meter/ade7754.c     |  6 +++---
> >  drivers/staging/iio/meter/ade7854-i2c.c | 28 ++++++++++++++--------------
> >  drivers/staging/iio/meter/ade7854-spi.c | 28 ++++++++++++++--------------
> >  drivers/staging/iio/meter/ade7854.h     | 28 ++++++++++++++--------------
> >  4 files changed, 45 insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> > index 3a1e342d75fb..9aa067736715 100644
> > --- a/drivers/staging/iio/meter/ade7754.c
> > +++ b/drivers/staging/iio/meter/ade7754.c
> > @@ -132,7 +132,7 @@ static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> >  }
> >  
> >  static int ade7754_spi_write_reg_16(struct device *dev,
> > -				    u8 reg_address, u16 value)
> > +				    u8 reg_address, u16 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -140,8 +140,8 @@ static int ade7754_spi_write_reg_16(struct device *dev,
> >  
> >  	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = ADE7754_WRITE_REG(reg_address);
> > -	st->tx[1] = (value >> 8) & 0xFF;
> > -	st->tx[2] = value & 0xFF;
> > +	st->tx[1] = (val >> 8) & 0xFF;
> > +	st->tx[2] = val & 0xFF;
> >  	ret = spi_write(st->us, st->tx, 3);
> >  	mutex_unlock(&st->buf_lock);
> >  
> > diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> > index 8106f8cceeab..317e4f0d8176 100644
> > --- a/drivers/staging/iio/meter/ade7854-i2c.c
> > +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> > @@ -17,7 +17,7 @@
> >  
> >  static int ade7854_i2c_write_reg_8(struct device *dev,
> >  				   u16 reg_address,
> > -				   u8 value)
> > +				   u8 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -26,7 +26,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
> >  	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> >  	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = value;
> > +	st->tx[2] = val;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 3);
> >  	mutex_unlock(&st->buf_lock);
> > @@ -36,7 +36,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
> >  
> >  static int ade7854_i2c_write_reg_16(struct device *dev,
> >  				    u16 reg_address,
> > -				    u16 value)
> > +				    u16 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -45,8 +45,8 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
> >  	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> >  	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = (value >> 8) & 0xFF;
> > -	st->tx[3] = value & 0xFF;
> > +	st->tx[2] = (val >> 8) & 0xFF;
> > +	st->tx[3] = val & 0xFF;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 4);
> >  	mutex_unlock(&st->buf_lock);
> > @@ -56,7 +56,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
> >  
> >  static int ade7854_i2c_write_reg_24(struct device *dev,
> >  				    u16 reg_address,
> > -				    u32 value)
> > +				    u32 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -65,9 +65,9 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
> >  	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> >  	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = (value >> 16) & 0xFF;
> > -	st->tx[3] = (value >> 8) & 0xFF;
> > -	st->tx[4] = value & 0xFF;
> > +	st->tx[2] = (val >> 16) & 0xFF;
> > +	st->tx[3] = (val >> 8) & 0xFF;
> > +	st->tx[4] = val & 0xFF;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 5);
> >  	mutex_unlock(&st->buf_lock);
> > @@ -77,7 +77,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
> >  
> >  static int ade7854_i2c_write_reg_32(struct device *dev,
> >  				    u16 reg_address,
> > -				    u32 value)
> > +				    u32 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -86,10 +86,10 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
> >  	mutex_lock(&st->buf_lock);
> >  	st->tx[0] = (reg_address >> 8) & 0xFF;
> >  	st->tx[1] = reg_address & 0xFF;
> > -	st->tx[2] = (value >> 24) & 0xFF;
> > -	st->tx[3] = (value >> 16) & 0xFF;
> > -	st->tx[4] = (value >> 8) & 0xFF;
> > -	st->tx[5] = value & 0xFF;
> > +	st->tx[2] = (val >> 24) & 0xFF;
> > +	st->tx[3] = (val >> 16) & 0xFF;
> > +	st->tx[4] = (val >> 8) & 0xFF;
> > +	st->tx[5] = val & 0xFF;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 6);
> >  	mutex_unlock(&st->buf_lock);
> > diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> > index 63e200ffd1f2..72eddfec21f7 100644
> > --- a/drivers/staging/iio/meter/ade7854-spi.c
> > +++ b/drivers/staging/iio/meter/ade7854-spi.c
> > @@ -17,7 +17,7 @@
> >  
> >  static int ade7854_spi_write_reg_8(struct device *dev,
> >  		u16 reg_address,
> > -		u8 value)
> > +		u8 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -32,7 +32,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
> >  	st->tx[0] = ADE7854_WRITE_REG;
> >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> >  	st->tx[2] = reg_address & 0xFF;
> > -	st->tx[3] = value & 0xFF;
> > +	st->tx[3] = val & 0xFF;
> >  
> >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> >  	mutex_unlock(&st->buf_lock);
> > @@ -42,7 +42,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
> >  
> >  static int ade7854_spi_write_reg_16(struct device *dev,
> >  		u16 reg_address,
> > -		u16 value)
> > +		u16 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -57,8 +57,8 @@ static int ade7854_spi_write_reg_16(struct device *dev,
> >  	st->tx[0] = ADE7854_WRITE_REG;
> >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> >  	st->tx[2] = reg_address & 0xFF;
> > -	st->tx[3] = (value >> 8) & 0xFF;
> > -	st->tx[4] = value & 0xFF;
> > +	st->tx[3] = (val >> 8) & 0xFF;
> > +	st->tx[4] = val & 0xFF;
> >  
> >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> >  	mutex_unlock(&st->buf_lock);
> > @@ -68,7 +68,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
> >  
> >  static int ade7854_spi_write_reg_24(struct device *dev,
> >  		u16 reg_address,
> > -		u32 value)
> > +		u32 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -83,9 +83,9 @@ static int ade7854_spi_write_reg_24(struct device *dev,
> >  	st->tx[0] = ADE7854_WRITE_REG;
> >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> >  	st->tx[2] = reg_address & 0xFF;
> > -	st->tx[3] = (value >> 16) & 0xFF;
> > -	st->tx[4] = (value >> 8) & 0xFF;
> > -	st->tx[5] = value & 0xFF;
> > +	st->tx[3] = (val >> 16) & 0xFF;
> > +	st->tx[4] = (val >> 8) & 0xFF;
> > +	st->tx[5] = val & 0xFF;
> >  
> >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> >  	mutex_unlock(&st->buf_lock);
> > @@ -95,7 +95,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
> >  
> >  static int ade7854_spi_write_reg_32(struct device *dev,
> >  		u16 reg_address,
> > -		u32 value)
> > +		u32 val)
> >  {
> >  	int ret;
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > @@ -110,10 +110,10 @@ static int ade7854_spi_write_reg_32(struct device *dev,
> >  	st->tx[0] = ADE7854_WRITE_REG;
> >  	st->tx[1] = (reg_address >> 8) & 0xFF;
> >  	st->tx[2] = reg_address & 0xFF;
> > -	st->tx[3] = (value >> 24) & 0xFF;
> > -	st->tx[4] = (value >> 16) & 0xFF;
> > -	st->tx[5] = (value >> 8) & 0xFF;
> > -	st->tx[6] = value & 0xFF;
> > +	st->tx[3] = (val >> 24) & 0xFF;
> > +	st->tx[4] = (val >> 16) & 0xFF;
> > +	st->tx[5] = (val >> 8) & 0xFF;
> > +	st->tx[6] = val & 0xFF;
> >  
> >  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> >  	mutex_unlock(&st->buf_lock);
> > diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> > index c27247a7891a..a82d38224cbd 100644
> > --- a/drivers/staging/iio/meter/ade7854.h
> > +++ b/drivers/staging/iio/meter/ade7854.h
> > @@ -152,20 +152,20 @@
> >   * @rx:			receive buffer
> >   **/
> >  struct ade7854_state {
> > -	struct spi_device	*spi;
> > -	struct i2c_client	*i2c;
> > -	int			(*read_reg_8)(struct device *, u16, u8 *);
> > -	int			(*read_reg_16)(struct device *, u16, u16 *);
> > -	int			(*read_reg_24)(struct device *, u16, u32 *);
> > -	int			(*read_reg_32)(struct device *, u16, u32 *);
> > -	int			(*write_reg_8)(struct device *, u16, u8);
> > -	int			(*write_reg_16)(struct device *, u16, u16);
> > -	int			(*write_reg_24)(struct device *, u16, u32);
> > -	int			(*write_reg_32)(struct device *, u16, u32);
> > -	int			irq;
> > -	struct mutex		buf_lock;
> > -	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
> > -	u8			rx[ADE7854_MAX_RX];
> > +	struct spi_device *spi;
> > +	struct i2c_client *i2c;
> > +	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
> > +	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
> > +	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
> > +	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> > +	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 val);
> > +	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 val);
> > +	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 val);
> > +	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 val);
> > +	int irq;
> > +	struct mutex buf_lock;
> > +	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
> > +	u8 rx[ADE7854_MAX_RX];
> >  
> >  };
> >  
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
