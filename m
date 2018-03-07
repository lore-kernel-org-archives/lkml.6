Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-32406-1520455697-2-12315638648852473160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455697; b=pjEMDO8yMH7wRNrdAy67Ja1LrXLxqkupdqurDmMr0VA+B53
    WojtvTDp6xoanOMqPYhozrvzH6FBFD7QFYKagoWBVZVKBJKd5lM19LLkwnibW6og
    nMWdS9TPHafmUAdLz+VA5kNM8+NSQDEIWPbvmdK65P+Mz/xwZf5c8lsPRBVVsJiq
    zvos0/qMR7F7FVYyM4TbupoQE4OpIlMyUx/TPu8cbF2cPH+LM4hgiOx68juixzu5
    pAeXNoDyYZocZyRo4mSTYr5nKXMj00dRFDbubZS3qRycvMRCW0w/DWj/n4nTM0f+
    5amDiFjJTmcJ+dSqzcz3eSKdFUxnl75OHp7q6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520455697; bh=4
    79SMAMCZQj9mPV2nTQSuuO/6YT9iA0kWeuczU43qVc=; b=mTRwB4X2uswvMWX+y
    EmO+/QYTS6GZEEqfjUSWr1tb+pXh/5ppThKHu57zjUm7H3U/QZanWVWf8NaFem7j
    hsx4GgRhqOfuSFXV94W/1Jj9+U2fCp0HWsrf5RO6sp4ZioZsKhjo6w4QMRzY9rcd
    t2+n9bbPviD1ynab8lf7LN83/tXFt2dGdYlpRBaTM/QtBR8eKqAllHWaB9y0IhiA
    HTwd0ao8y+xSlO16gbj+/2DSA6vdSt6e9JFItFLvm2tcXOIoLO/KWt84PJ90rOGT
    zNzVgW7CMEIFDIwQmTNa9XCKytVG/sktjbLeo+JbXGfj+tL1AzwNoJSbizp5aZxb
    n+yTg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73222133D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:48:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 08/11] Staging: iio: accel: Use switch statement than
 if-else
Message-ID: <20180307204805.44ae9eac@archlinux>
In-Reply-To: <1520236170-14668-9-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-9-git-send-email-himanshujha199640@gmail.com>
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  5 Mar 2018 13:19:27 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Use switch statement instead of if-else pair to explicitly match
> the only two channels present.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
I think this is going to generate some warnings in the various static
analysers as they will point out there are lots of values channel can
take that aren't handled by the switch statement..  You should have
a default.

(This is what made Dan less than convinced of whether this was a good
change when I originally suggested it)  I still think it's a marginal
improvement in making it explicit that we only have two valid choices
though - and Dan didn't care strongly about it.

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 1737708..307d4ab 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -114,12 +114,15 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> +			switch (chan->channel) {
> +			case 0:
>  				*val = 1;
>  				*val2 = 220000;
> -			} else {
> +				break;
> +			case 1:
>  				*val = 0;
>  				*val2 = 610000;
> +				break;
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
