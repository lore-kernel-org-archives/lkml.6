Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2899236-1521998248-2-12607025100127450802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521998246; b=kTcHhAQBME0V5B5dNLo315LW9kufFdlKR14IYLUhchPtjhV
    FMT3had+ETgHXvtBJWxGD5txfm9XocJWd1+kl2VGv89hOp4rHPZrvMRX6bgxtC2y
    uTVStbGsW2831MJ9fODfYl8nDCa1FTJ54Ml5EJZRDHojZUlXjGm7NYCOzpy3h+uQ
    og+3CcxHJtqV2DtNd46DrR6cKR9x3XFgEFbQbB4GZUdq2cLCgBVBdcUCQnD6kV5t
    eir2L2SwB7r/oYdWUtjk+UTB506GZi7MXVZym4N9lJjpbepRcucbDwWbkMBGTITc
    JIXg/Sc+ghEpBqEIhxt2cwxVWOjChsttIwbsVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521998246; bh=E
    UyKCUz2fZXGzNnm5ClHSHSdt7GpQ5RCrv6AcMTY85E=; b=NwynzXyhDO/NqVXZ+
    gMaUe7FWZYK5P/hVlnqnWhKrHkiNVEq6QxCWQwjguGP+uL+FIxH4rWVXyJNoF/Zg
    lLMYetsw+1C/hhT6cDmZcu3abR2dWNtsw2+AnL58SoS2XVJaB7bjTIL9yRKoe9TO
    vALgP98JJyg87c9joR1Jt+eLS5xMNdn4hilY0gc4iNTBf1ULz4AymqT5XIIFZnuB
    I3SmjWPHJQwnEmLb/yBDkUbCLzNhXYihAZAqtq1u144P0aRv0EQfBDHkanEFDmww
    r/wH5Mto9FnllMfW47QGdlkMYFJ5JBWuegZ44r8JKDcEA+8Xz3/vDsqv7eU+YdD8
    PPcKA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEB121716
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 25 Mar 2018 18:17:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 2/4] staging: iio: tsl2x7x: move
 IIO_CHAN_INFO_CALIB{SCALE,BIAS} to IIO_LIGHT channel
Message-ID: <20180325181715.648dc57f@archlinux>
In-Reply-To: <20180324200555.1403-3-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
 <20180324200555.1403-3-masneyb@onstation.org>
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

On Sat, 24 Mar 2018 16:05:53 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The IIO_CHAN_INFO_CALIBSCALE and IIO_CHAN_INFO_CALIBBIAS masks are
> currently associated with the IIO_INTENSITY channel but should be
> associated with the IIO_LIGHT channel since these values are used to
> calculate the lux. Directory listing of the sysfs attributes for a
> TSL2772 with this patch applied:
They may be used to calculate the lux, but as far as I can tell
they are gain controls on the underlying intensity channels.

> 
> dev
> events
> in_illuminance0_calibbias
> in_illuminance0_calibrate
> in_illuminance0_calibscale
> in_illuminance0_calibscale_available
> in_illuminance0_input
> in_illuminance0_integration_time
> in_illuminance0_integration_time_available
I'd missed this before, but the integration time is also for
the two intensity readings.  An argument could be made
for it also being a parameter of illuminance but
it definitely needs to be on for the intensity channels.

> in_illuminance0_lux_table
> in_illuminance0_target_input
> in_intensity0_raw
> in_intensity1_raw
> in_proximity0_calibrate
> in_proximity0_calibscale
> in_proximity0_calibscale_available
> in_proximity0_raw
> name
> of_node
> power
> subsystem
> uevent

So for this one I'm unconvinced.

Jonathan

> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 8530bccdb317..d5a237fb0a0b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1491,14 +1491,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> -				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1531,14 +1531,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> -				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {
> @@ -1580,14 +1580,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
>  			.indexed = 1,
>  			.channel = 0,
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -					      BIT(IIO_CHAN_INFO_INT_TIME),
> +				BIT(IIO_CHAN_INFO_INT_TIME) |
> +				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS),
>  			}, {
>  			.type = IIO_INTENSITY,
>  			.indexed = 1,
>  			.channel = 0,
> -			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				BIT(IIO_CHAN_INFO_CALIBSCALE) |
> -				BIT(IIO_CHAN_INFO_CALIBBIAS),
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  			.event_spec = tsl2x7x_events,
>  			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
>  			}, {

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
