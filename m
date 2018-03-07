Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520453260-5-8051325581081183229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453260; b=XFurU3240xmpRkz31dG8hCV+5RyyoECiBBmhGbV/Zj6IvIs
    LQ6vNvZtDcElunkIHCDRtGWJFYBsJkGrUZv0WMInMEpFweGKZuJeVn9v7i41+jTP
    coOu0eAbY+PkXPQtAasU5KNTJpivbkpito9Dtl6RlV2a5FruWlFOgM2SbIfn5P8Y
    sVmAK2vuvp6RZc8c8Z8aUZLWVrf0a3J9wAozYN2+nkj2qSD8gvaRvHErWqbaKaHh
    fGV982TIIG1SiwLZEtmMAFAiSu+37c9aO+M3Iq+ud/MaIHXY0G9agW1R7cIsJT+y
    +vwXk2NbAOY/ehfFawz2A6UuTwKSFSMYcm5pojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520453260; bh=X
    7Cb6KIJG8ciMY32/cVfVp8w5SqKf8l5vyR1dOk1lkY=; b=N9ckTv2AWvKN7RV07
    SoxKjRMeuDTQQBfPLux1BWHLTY1UGmsbuduzGeHJQmPYYZNLXaH5T8RrUwMfY7/O
    mTCIqBkE4W5ZbiV2Dtom9qnLxACIXFw0EHVJGKMsv4OKO3tAOAHCfPGTsHFlymTn
    flquXhTXoGULhi0SBPiIebD76kXZCb66NAmGbXPIFHSsggvZLIX+kwIy7tGJuLqL
    lMJEDa27t56idrC4ZOGHH5BLpJw93X7g5dvJEG1OwNkau7yva3mtzJvt5HCPF+TX
    ImB9zSftZ6gJaHUSAtaCsf7GmFdTQ4kCIsu7OJAvPwnVZ3oL/btF5JY/+el0C24d
    xXukg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFEA20685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:07:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF
 by IIO_DEVICE_ATTR
Message-ID: <20180307200730.08ed3c2f@archlinux>
In-Reply-To: <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
 <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
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

On Tue, 6 Mar 2018 21:43:47 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a
> tiny change in the name definition. This extra macro does not improve
> the readability and also creates some checkpatch errors.
> 
> This patch fixes the checkpatch.pl errors:
> 
> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) not
> decimal permissions
> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) not
> decimal permissions
> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) not
> decimal permissions
> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) not
> decimal permissions
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Hmm. I wondered a bit about this one. It's a correct patch in of
itself but the interface in question doesn't even vaguely conform
to any of defined IIO ABI.  Anyhow, it's still and improvement so
I'll take it.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I also added the removal of the header define which is no
longer used.

Please note, following discussions with Michael, I am going to send
an email announcing an intent to drop these meter drivers next
cycle unless someone can provide testing for any attempt to
move them out of staging.  I'm still taking patches on the basis
that 'might' happen - but I wouldn't focus on these until we
have some certainty on whether they will be around long term!

Jonathan

> ---
>  drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
>  drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
>  2 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index c44eb577dc35..275e8dfff836 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
>  		ade7753_read_16bit,
>  		NULL,
>  		ADE7753_PERIOD);
> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> -		ade7753_read_8bit,
> -		ade7753_write_8bit,
> -		ADE7753_CH1OS);
> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> -		ade7753_read_8bit,
> -		ade7753_write_8bit,
> -		ADE7753_CH2OS);
> +
> +static IIO_DEVICE_ATTR(choff_1, 0644,
> +			ade7753_read_8bit,
> +			ade7753_write_8bit,
> +			ADE7753_CH1OS);
> +
> +static IIO_DEVICE_ATTR(choff_2, 0644,
> +			ade7753_read_8bit,
> +			ade7753_write_8bit,
> +			ADE7753_CH2OS);
>  
>  static int ade7753_set_irq(struct device *dev, bool enable)
>  {
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 1decb2b8afab..c078b770fa53 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>  		ade7759_read_16bit,
>  		ade7759_write_16bit,
>  		ADE7759_APGAIN);
> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> -		ade7759_read_8bit,
> -		ade7759_write_8bit,
> -		ADE7759_CH1OS);
> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> -		ade7759_read_8bit,
> -		ade7759_write_8bit,
> -		ADE7759_CH2OS);
> +
> +static IIO_DEVICE_ATTR(choff_1, 0644,
> +			ade7759_read_8bit,
> +			ade7759_write_8bit,
> +			ADE7759_CH1OS);
> +
> +static IIO_DEVICE_ATTR(choff_2, 0644,
> +			ade7759_read_8bit,
> +			ade7759_write_8bit,
> +			ADE7759_CH2OS);
>  
>  static int ade7759_set_irq(struct device *dev, bool enable)
>  {

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
