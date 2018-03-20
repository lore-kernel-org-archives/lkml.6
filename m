Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-25021-1521510833-2-17546059668629664100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521510832; b=uqVKAchgvQt3DTpP76i4RrwIUXCGIQNfOMskPSe7iLwfnXG
    bp0Gjx2CZAeikNouxfU9sNBhhAbFuqCOCwD1AwjnDH3Cmkp6W8xePJQisZnS2dHJ
    CqI9SbWLleVXhe5pNooXhD9TrTwDbZcAPANPrejSfVvVUkM0RY37ZsYP7Doez4Hk
    wVX3/T0+204JwoUjms5srUoQIyX66Wv3PonfnByrRymJFzLUbv2bFdIMs4U+0447
    nnO5wYKcPMMSNwGqL7nQdXTjMYENlo5XnMLvHJ0Sqe/1yqbU2d5Uu+8So/tGwf+n
    kj+mwPhoLC24oGnUwTeT+beB2Z9bpRU4Crzd9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521510832; bh=a
    5AaSSLAfTi0XCnHu5GKJ5XsM76es5x1AueffQu0orA=; b=L23lOkIkANj9aj2VD
    KgsZs1ufWSql6IuCWKKlUwluvgy6lXmtKnz0YymwsXJpu3moyWQCJdDuIuPyynvo
    UWCcnBNFRbTfcS2Dzo6DI6ShwLy7X5fh2Wixj/omX5mnA99JKMNGVlWTneWio/lh
    J73NgLbGpjkdb3lnKiLZsCfhbPAMIuwFUyg5VEytsw5bFBw1Ou+lcBr6KuSRv7f7
    knIVqHupw8jXSjyhGXztdJLvFlkehn0D3O8UDTpW66C6J8M6sMO4MzpWze/etCGT
    xlo+LIC9928C3k+CfqqNj9+arCWH0vOEuH2COzxnzt0ECTV8I5gxXd1gmMUu/GbR
    6yRfg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SqiJDaab x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eLPTw8AY;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejtddttdervdenucfhrhhomheptfhoughrihhgohcuufhiqhhuvghirhgruceorhhoughrihhgohhsihhquhgvihhrrghmvghlohesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghdpkhgvrhhnvghlnhgvfigsihgvshdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefkedpudegfedruddtjedrgeehrddunecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeekpdhhvghlohepfihhihhtvggrlhguvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpedufeefgeefuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SqiJDaab x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eLPTw8AY;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejtddttdervdenucfhrhhomheptfhoughrihhgohcuufhiqhhuvghirhgruceorhhoughrihhgohhsihhquhgvihhrrghmvghlohesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghdpkhgvrhhnvghlnhgvfigsihgvshdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudefkedpudegfedruddtjedrgeehrddunecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeekpdhhvghlohepfihhihhtvggrlhguvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpedufeefgeefuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvimFY0kMfEaJZZklGtUhG+wRuDpsH62GzPXe3xon46ycDBuzn1DWlSHR/2iVC/cVYKr4g7ww==
Date: Mon, 19 Mar 2018 22:53:39 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/8] staging:iio:ade7854: Fix error handling on
 read/write
Message-ID: <20180320015339.3hald4gulfmul4e5@smtp.gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <c6329504bb92726dd1ca45cd5b44e180e86a407e.1521239766.git.rodrigosiqueiramelo@gmail.com>
 <20180318094541.24331a00@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180318094541.24331a00@archlinux>
User-Agent: NeoMutt/20180223
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

On 03/18, Jonathan Cameron wrote:
> On Fri, 16 Mar 2018 19:48:33 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> 
> > The original code does not correctly handle the error related to I2C
> > read and write. This patch fixes the error handling related to all
> > read/write functions for I2C. This patch is an adaptation of the John
> > Syne patches.
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Signed-off-by: John Syne <john3909@gmail.com>
> Hi Rodrigo,
> 
> I'm not sure what the chain of authorship was here.  If this is fundamentally
> John's original patch he should still be the author and his sign off should be
> first.  You then sign off afterwards to indicate that you 'handled' the patch
> and believe the work to be John's (you are trusting his sign off).  This
> is 'fun' legal stuff - read the docs on developers certificate of origin.
> 
> If the patch has changed 'enough' (where that is a fuzzy definition)
> then you should as you have here take the authorship, but John's sign off is
> no longer true (it's a different patch).  If John has reviewed the code
> it is fine to have a reviewed-by or acked-by from John there to reflect
> that.
> 
> Anyhow, please clarify the situation as I shouldn't take a patch where
> I'm applying my sign-off without knowing the origins etc.

Hi Jonathan,

Just for clarification, this is fundamentally John's original patch with
some changes on the way that write_reg operation returns the error. I
should ask for someone else, how to correctly handle this situation
since I did not have experience with this situation.

Actually, when I worked on this patch, I was confused about using
different authorship from the email. I got confused because of the
following statement:

"Make sure that the email you specify here is the same email you used to
set up sending mail. The Linux kernel developers will not accept a patch
where the "From" email differs from the "Signed-off-by" line, which is
what will happen if these two emails do not match." [1]

Anyway, I think this is not a newbie issue, and I should asked first.
Thanks for the great explanation, I will not make this kind of mistake
again.

Thanks

[1] - https://kernelnewbies.org/FirstKernelPatch
 
> > ---
> >  drivers/staging/iio/meter/ade7854-i2c.c | 24 ++++++++++++------------
> >  drivers/staging/iio/meter/ade7854.c     | 10 +++++-----
> >  2 files changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> > index 317e4f0d8176..4437f1e33261 100644
> > --- a/drivers/staging/iio/meter/ade7854-i2c.c
> > +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> > @@ -31,7 +31,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
> >  	ret = i2c_master_send(st->i2c, st->tx, 3);
> >  	mutex_unlock(&st->buf_lock);
> >  
> > -	return ret;
> > +	return ret < 0 ? ret : 0;
> >  }
> >  
> >  static int ade7854_i2c_write_reg_16(struct device *dev,
> > @@ -51,7 +51,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
> >  	ret = i2c_master_send(st->i2c, st->tx, 4);
> >  	mutex_unlock(&st->buf_lock);
> >  
> > -	return ret;
> > +	return ret < 0 ? ret : 0;
> >  }
> >  
> >  static int ade7854_i2c_write_reg_24(struct device *dev,
> > @@ -72,7 +72,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
> >  	ret = i2c_master_send(st->i2c, st->tx, 5);
> >  	mutex_unlock(&st->buf_lock);
> >  
> > -	return ret;
> > +	return ret < 0 ? ret : 0;
> >  }
> >  
> >  static int ade7854_i2c_write_reg_32(struct device *dev,
> > @@ -94,7 +94,7 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
> >  	ret = i2c_master_send(st->i2c, st->tx, 6);
> >  	mutex_unlock(&st->buf_lock);
> >  
> > -	return ret;
> > +	return ret < 0 ? ret : 0;
> >  }
> So for write cases you are flattening to 0 for good and < 0 for bad.
> good.
> >  
> >  static int ade7854_i2c_read_reg_8(struct device *dev,
> > @@ -110,11 +110,11 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
> >  	st->tx[1] = reg_address & 0xFF;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 2);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	ret = i2c_master_recv(st->i2c, st->rx, 1);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	*val = st->rx[0];
> But in read cases you are returning the number of bytes read...
> Given these functions can know the 'right' answer to that why not check
> it here and do the same as for writes in return 0 for good and < 0 for
> bad?
> > @@ -136,11 +136,11 @@ static int ade7854_i2c_read_reg_16(struct device *dev,
> >  	st->tx[1] = reg_address & 0xFF;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 2);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	ret = i2c_master_recv(st->i2c, st->rx, 2);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	*val = (st->rx[0] << 8) | st->rx[1];
> > @@ -162,11 +162,11 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
> >  	st->tx[1] = reg_address & 0xFF;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 2);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> > @@ -188,11 +188,11 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
> >  	st->tx[1] = reg_address & 0xFF;
> >  
> >  	ret = i2c_master_send(st->i2c, st->tx, 2);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> > -	if (ret)
> > +	if (ret < 0)
> >  		goto out;
> >  
> >  	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> > diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> > index 90d07cdca4b8..0193ae3aae29 100644
> > --- a/drivers/staging/iio/meter/ade7854.c
> > +++ b/drivers/staging/iio/meter/ade7854.c
> > @@ -33,7 +33,7 @@ static ssize_t ade7854_read_8bit(struct device *dev,
> >  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> >  
> >  	ret = st->read_reg_8(dev, this_attr->address, &val);
> > -	if (ret)
> > +	if (ret < 0)
> If you did as discussed above with the reads then this change would not
> be needed and all the changes would be confined to the i2c code.
> 
> Thanks,
> 
> Jonathan
> 
> 
> >  		return ret;
> >  
> >  	return sprintf(buf, "%u\n", val);
> > @@ -50,7 +50,7 @@ static ssize_t ade7854_read_16bit(struct device *dev,
> >  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> >  
> >  	ret = st->read_reg_16(dev, this_attr->address, &val);
> > -	if (ret)
> > +	if (ret < 0)
> >  		return ret;
> >  
> >  	return sprintf(buf, "%u\n", val);
> > @@ -67,7 +67,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
> >  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> >  
> >  	ret = st->read_reg_24(dev, this_attr->address, &val);
> > -	if (ret)
> > +	if (ret < 0)
> >  		return ret;
> >  
> >  	return sprintf(buf, "%u\n", val);
> > @@ -84,7 +84,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
> >  	struct ade7854_state *st = iio_priv(indio_dev);
> >  
> >  	ret = st->read_reg_32(dev, this_attr->address, &val);
> > -	if (ret)
> > +	if (ret < 0)
> >  		return ret;
> >  
> >  	return sprintf(buf, "%u\n", val);
> > @@ -416,7 +416,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
> >  	u32 irqen;
> >  
> >  	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
> > -	if (ret)
> > +	if (ret < 0)
> >  		return ret;
> >  
> >  	if (enable)
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
