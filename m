Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FN0KDfsZHVuBKgAAmS7hNA
	; Sun, 10 Jun 2018 12:30:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 79E7B607BB; Sun, 10 Jun 2018 12:30:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evcg28V1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E14B2604D4;
	Sun, 10 Jun 2018 12:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E14B2604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeFJMav (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeFJMas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:30:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC1272089C;
        Sun, 10 Jun 2018 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528633848;
        bh=7qsJo5RzNkzb6/eTTXSIz+G29xM72gvW+0o3e1MiCDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Evcg28V1SrpjSYnunWZtKvZMXS5plVn/NhRTc6+z1FkT3gUpwZ120EVFYGY+NgROr
         V2QIGuDRztInmmJkpEJ6BH/Bw5JKxYMlazx5LZCasKGJNxVlAg6yh5B9TehmwBjkLF
         yVhE4G7WXyOaEq6EPX2L1kOqtJQWFsetZEVI8obw=
Date: Sun, 10 Jun 2018 13:30:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 2/9] iio: Add channel for Position Relative
Message-ID: <20180610133042.55e21e5b@archlinux>
In-Reply-To: <1526975559-18966-3-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-3-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 10:52:32 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add new channel type for relative position on a pad.
> 
> These type of analog sensor offers the position of a pen
> on a touchpad, and is represented as a voltage, which can be
> converted to a position on X and Y axis on the pad.
> The channel will hand the relative position on the pad in both directions.
> 
> The channel can then be consumed by a touchscreen driver or
> read as-is for a raw indication of the touchpen on a touchpad.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Applied - with a trivial amount of fuzz.

Thanks,

Jonathan
> ---
> Changes in v2:
>  - modified channel name to relative position as suggested.
>  - modified kernel version to 4.18 (presumable)
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6a5f34b..42a9287 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -190,6 +190,18 @@ Description:
>  		but should match other such assignments on device).
>  		Units after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Relative position in direction x or y on a pad (may be
> +		arbitrarily assigned but should match other such assignments on
> +		device).
> +		Units after application of scale and offset are milli percents
> +		from the pad's size in both directions. Should be calibrated by
> +		the consumer.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 19bdf3d..14bf3d24 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_COUNT] = "count",
>  	[IIO_INDEX] = "index",
>  	[IIO_GRAVITY]  = "gravity",
> +	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 4213cdf..033c7d2 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -44,6 +44,7 @@ enum iio_chan_type {
>  	IIO_COUNT,
>  	IIO_INDEX,
>  	IIO_GRAVITY,
> +	IIO_POSITIONRELATIVE,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index b61245e..148f69d 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_GRAVITY] = "gravity",
> +	[IIO_POSITIONRELATIVE] = "positionrelative",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_PH:
>  	case IIO_UVINDEX:
>  	case IIO_GRAVITY:
> +	case IIO_POSITIONRELATIVE:
>  		break;
>  	default:
>  		return false;
