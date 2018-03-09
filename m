Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3238303-1520555866-2-5558580157510286030
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
    t=1520555865; b=no2x7UHkGl/gpid2xKf+KFKYWBFa2ZZzePnWcVWIkISJ+gd
    r3h15W+T5RwwmY/OSUodNaKbCDClNRzV3txJZg3JZcFG7f++Z0q4DDAV7lGdTzHs
    r2J0xIlGmMtx7DmdqJXlQnaU+c/lQ3vPdoggBwYzOz6+m/9GUw7zu1tkprPW7n3r
    hLSrWxz7bb70Yp2TFDL8BcrtlH8xjABX7pV6YvfKOThK/7JZ3prM68EdyEi4FFcn
    3424x789n2bTyXUrT7EOQLyCVvurixcVAZT9zh6t2n/aSZzaXJ1d623rQabM5ybL
    B89xWViaMYVbt/7YRyiRtso5YGzTMprPkGVokIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520555865; bh=x
    ozKlrDFNd14/SErZRb6M4qSTuocNWi4ulv1Lsb4us0=; b=Jk3hVP7y2hTZ4gLUc
    r6d4lOFvS9SXTUZcmUsd/qB2vgoI/vuUSCYiOUsQemH/oPGVAnLvZiQLe3/85+p4
    FnqHOSHiz7OWMZD2gMRv0600mgdHq/RhYHzh9w6adzvVsQLkbk473U3ow0Hrf/3X
    BFC6B7/GrR6hGNQgOJ6l+vAVfXsl9yGWc4/lX5uIN21uCOKSgd9jfhEFbPDujZZz
    5hjmzF4a1IEApIZ/0BdbxH+mWITve1PFaQrLH9CAiKpfZMIObHMjpOOoXFz6kw1J
    wsIWRSh143OubRUvutqwvpNsK3IeQ/3BAFg2tYEkjjKa//JwmO/6xQ3HA+K01f8A
    z+DDA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cZTjs+ly x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PDuH5Lsg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cZTjs+ly x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PDuH5Lsg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtx1iNTEWhD60RRRZ+jurpJUkHbqODMQl5pbb/dWuQQpC3lZOsn8F2A0s8Q7NSFhj03goAUtQ==
Date: Thu, 8 Mar 2018 21:37:33 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF
 by IIO_DEVICE_ATTR
Message-ID: <20180309003733.aichruo53vqryafg@smtp.gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <20180307200730.08ed3c2f@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180307200730.08ed3c2f@archlinux>
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

On 03/07, Jonathan Cameron wrote:
> On Tue, 6 Mar 2018 21:43:47 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> 
> > The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a
> > tiny change in the name definition. This extra macro does not improve
> > the readability and also creates some checkpatch errors.
> > 
> > This patch fixes the checkpatch.pl errors:
> > 
> > staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) not
> > decimal permissions
> > staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) not
> > decimal permissions
> > staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) not
> > decimal permissions
> > staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) not
> > decimal permissions
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> 
> Hmm. I wondered a bit about this one. It's a correct patch in of
> itself but the interface in question doesn't even vaguely conform
> to any of defined IIO ABI.  Anyhow, it's still and improvement so
> I'll take it.

I am not sure if I understood the comment about the ABI. The meter
interface is wrong because it uses things like IIO_DEVICE_ATTR? It
should use iio_info together with *write_raw and *read_raw. Right? Is it
the ABI problem that you refer?

Thanks :)
 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> 
> I also added the removal of the header define which is no
> longer used.
> 
> Please note, following discussions with Michael, I am going to send
> an email announcing an intent to drop these meter drivers next
> cycle unless someone can provide testing for any attempt to
> move them out of staging.  I'm still taking patches on the basis
> that 'might' happen - but I wouldn't focus on these until we
> have some certainty on whether they will be around long term!
> 
> Jonathan
> 
> > ---
> >  drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
> >  drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
> >  2 files changed, 20 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> > index c44eb577dc35..275e8dfff836 100644
> > --- a/drivers/staging/iio/meter/ade7753.c
> > +++ b/drivers/staging/iio/meter/ade7753.c
> > @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
> >  		ade7753_read_16bit,
> >  		NULL,
> >  		ADE7753_PERIOD);
> > -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> > -		ade7753_read_8bit,
> > -		ade7753_write_8bit,
> > -		ADE7753_CH1OS);
> > -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> > -		ade7753_read_8bit,
> > -		ade7753_write_8bit,
> > -		ADE7753_CH2OS);
> > +
> > +static IIO_DEVICE_ATTR(choff_1, 0644,
> > +			ade7753_read_8bit,
> > +			ade7753_write_8bit,
> > +			ADE7753_CH1OS);
> > +
> > +static IIO_DEVICE_ATTR(choff_2, 0644,
> > +			ade7753_read_8bit,
> > +			ade7753_write_8bit,
> > +			ADE7753_CH2OS);
> >  
> >  static int ade7753_set_irq(struct device *dev, bool enable)
> >  {
> > diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> > index 1decb2b8afab..c078b770fa53 100644
> > --- a/drivers/staging/iio/meter/ade7759.c
> > +++ b/drivers/staging/iio/meter/ade7759.c
> > @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
> >  		ade7759_read_16bit,
> >  		ade7759_write_16bit,
> >  		ADE7759_APGAIN);
> > -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> > -		ade7759_read_8bit,
> > -		ade7759_write_8bit,
> > -		ADE7759_CH1OS);
> > -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> > -		ade7759_read_8bit,
> > -		ade7759_write_8bit,
> > -		ADE7759_CH2OS);
> > +
> > +static IIO_DEVICE_ATTR(choff_1, 0644,
> > +			ade7759_read_8bit,
> > +			ade7759_write_8bit,
> > +			ADE7759_CH1OS);
> > +
> > +static IIO_DEVICE_ATTR(choff_2, 0644,
> > +			ade7759_read_8bit,
> > +			ade7759_write_8bit,
> > +			ADE7759_CH2OS);
> >  
> >  static int ade7759_set_irq(struct device *dev, bool enable)
> >  {
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
