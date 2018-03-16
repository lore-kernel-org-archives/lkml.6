Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1574763-1521160093-2-15016437837923684116
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521160092; b=dtamPFsHizXJoFs3bZ78nxvdM+DYEoo5nKGFBSCz0Wn6h5q
    l+jVgSfxvXEohLxJdApm7ka/LbboJlaHyl/WJfg/75xa7NJTQlZypK9J50Za2JsF
    in0LQQsrli1+e3vhXYIXtj+qyyfmKFrzjFO64Hx9TGOONz5Y4bYIj5oxFbP4IVsQ
    7wGNqqA8vFgiyrKa0AYMz8nr8HuFH7IfrHV1QICqycXBait8qVEqwMWhjW112Z2V
    ZaTpOgFZO6Izz/wREGCXYonhhZ1bQuQohNseCo8acP1kP431K4pS83yHnHElcUi4
    2UgqYHd3jvJ+rAlBhV0mRkJWH5JeOfotcNJIlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521160092; bh=f
    TwhJVz+uymoa/S6KWNeSODu3wLObhIlAHRSJurbcbU=; b=Hb2puRbk6infHvXPc
    NFkffGJSNUd0hYVA+DmPNP88l2+M4cdPq7vM0nA839P5tafAwx6dZ7R9VJEqlDB8
    yrfZPAy5eGbQHJ7tiWEohngXUtrKF9+CSZ2Orjvb1xxkUvN1QMmIyJTf85QXdCWK
    QoXj+A0qWKXlb3vlg6qxEA6ynynIIGocCzymWOrN0bq+rQZUO+a7z2D7T9ZNZagj
    0MkHcCWofK2O5V6DVSVEuH5UdXFLTX3IVWxzxjiO1ZKw00+evPrL+UPMahBUplgo
    L46E0Dhu5cwZXvhCEfaq1dSk1TN2OTb9XCMxBb1TCb3d7pIt4E2cHf9w2kq09jdJ
    V2q0w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=g7hcSSgw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZHfQVb5K;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=g7hcSSgw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZHfQVb5K;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsfEjpyWYGXt6yPhLKw09QnqHys3NXJqn70knstBLIem5pZDk1nUd9a/bk0E/v4Cyr064HqSw==
Date: Thu, 15 Mar 2018 21:28:00 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180315121115.iwkx2dfikgpjeeec@mwanda>
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
 daniel.baluta@nxp.com, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/15, Dan Carpenter wrote:
> On Wed, Mar 14, 2018 at 03:12:18PM -0300, Rodrigo Siqueira wrote:
> > There is some improper error handling for IRQ and device register.  This
> > patch adds a proper verification. The IRQ correction was extracted from
> > John Syne patches.
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > Signed-off-by: John Syne <john3909@gmail.com>
> > ---
> >  drivers/staging/iio/meter/ade7854.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> > index 09fd8c067738..49cbe365e43d 100644
> > --- a/drivers/staging/iio/meter/ade7854.c
> > +++ b/drivers/staging/iio/meter/ade7854.c
> > @@ -436,7 +436,7 @@ static int ade7854_initial_setup(struct iio_dev *indio_dev)
> >  
> >  	/* Disable IRQ */
> >  	ret = ade7854_set_irq(dev, false);
> > -	if (ret) {
> > +	if (ret < 0) {
> >  		dev_err(dev, "disable irq failed");
> >  		goto err_ret;
> >  	}
> 
> Why is the original wrong?  It seems fine.

Hi,

If you look at "drivers/staging/iio/meter/ade7854-(i2c|spi).c", you will
find a line like this: " st->write_reg = ade7854_(i2c|spi)_write_reg;".
Than, if you go through the "ade7854_i2c_write_reg" (focus only on i2c
for while) you will see "i2c_master_send(st->i2c, st->tx, count)",
which can returns a positive number that does not necessary means an
error. If you find the same for the spi case, you will end up in the
function "spi_sync_transfer" that only return 0 for success or negative
for failure. So, handling the negative case better fit the i2c and spi case.

Thanks

> regards,
> dan carpenter
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
