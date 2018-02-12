Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1541957-1518446534-2-15430740789722258315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.8
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SBL_CSS 3.335, RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518446533; b=pI7L3A4uljbEuVUk0VQudaFKF+n/KlPGtz284Md3EMz6L45
    wJmlf05ASzNpFD89F9HkYVKlqaS6IH2fKFBdforMX/Wh10OwjAVmCvMzOoDikNIs
    Ddq4lAA3c6Ey/hQbL9Prjn27udzVQRXx4U6Xs/9nGtcGJHFAufDZ+0EJ1qKYqrU2
    yfkksrCCKghMhtawnzFcTcCSwVbg0kk1xJfKlRqLDYbDnst60xAcuzOoTOoW/Eto
    OmtcBxJvd/Uwsl+DXfqJD9K/r/9bUUw9VEmdVG2cKiSyYsbA91UINecq7EiYh4ir
    hjvpXgeXOsk5MnesFu/Li5Efiz9WRc1imNSfpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518446533; bh=Z
    xk6NAw3jhITTbILA65PZbde9n5PhBV8XqKNAQu0imc=; b=jmZoByr1JQ4mnM4Dq
    +LyCiqSSHfJNtcQXwSrhf11ackTycAsSfBJHnpMKeI/BgAqBvbJRFTRhboYs60NW
    OWXYMq3IFQlkyRMKQoWadVVvD3Yo0R5gIGr+NMFSgmlxkGykh4tfGP7Htv/mjFDj
    JQ7cp05c962uh9DWNhYQ+SSO4oi3WA159C8SeaYMED371Psjx7GJ2RHelvKl0yRL
    0QcWrfxlJIH8YfdhjrCGzVt49/xpuX3IISY3R7nJv9XP4U8OeDM+5Jochrpe4HwC
    o4pW5VuQ8uaCgNEgAA1VPQ2+cLD1GCWuUFs7qamaF8TUYzcCgpP9Y3OlSYd0lVhj
    +dvhQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Fuitc/1K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JyzLiStB;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Fuitc/1K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JyzLiStB;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225Fr3Sr20ke481HgtI0UkjGqLlEpAigdJI0uYCv0A55CDwV8U/xUtDMrIzN5kAc4Mk67Zy/aQ==
Date: Mon, 12 Feb 2018 20:11:57 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212144157.GC12142@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
 <20180212131826.ebazvmp6iv7i5fav@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180212131826.ebazvmp6iv7i5fav@mwanda>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 04:18:26PM +0300, Dan Carpenter wrote:
> I think -M is prefered for these types of diffs?  Not sure.

I wrote about that in the cover letter if you missed. :)

> On Mon, Feb 12, 2018 at 05:24:59PM +0530, Himanshu Jha wrote:
> > +static int adis16201_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adis *st;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	indio_dev->name = spi->dev.driver->name;
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->info = &adis16201_info;
> > +
> > +	indio_dev->channels = adis16201_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> > +	if (ret)
> > +		return ret;
> 
> We should clean up the IRQ which we enabled in adis_init() instead of
> returning directly.

I'm not sure about how to do that.

-- 
Thanks
Himanshu Jha
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
