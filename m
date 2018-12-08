Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D9DC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC84C20672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC84C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLHPsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:48:00 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33438 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:48:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1A5639E74BE;
        Sat,  8 Dec 2018 15:47:55 +0000 (GMT)
Date:   Sat, 8 Dec 2018 15:47:54 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.brauchli@elementarea.net
Subject: Re: [PATCH v2 1/3] iio: add IIO_MASSCONCENTRATION channel type
Message-ID: <20181208154745.79353ac5@archlinux>
In-Reply-To: <20181206210443.21052-2-tduszyns@gmail.com>
References: <20181206210443.21052-1-tduszyns@gmail.com>
        <20181206210443.21052-2-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Dec 2018 22:04:41 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Measuring particulate matter in ug / m3 (micro-grams per cubic meter)
> is de facto standard. Existing air quality sensors usually follow
> this convention and are capable of returning measurements using
> this unit.
> 
> IIO currently does not offer suitable channel type for this
> type of measurements hence this patch adds this.
> 
> In addition, extra modifiers are introduced used for distinguishing
> between fine pm1, pm2p5 and coarse pm4, pm10 particle measurements, i.e
> IIO_MOD_PM1, IIO_MOD_PM25 and IIO_MOD_PM4, IIO_MOD_PM10.
> 
> pmX consists of particles with aerodynamic diameter less or equal to
> X micrometers.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
I'm happy with this, but would like to give the whole series
a little more time on the list to let those others who looked
at V1 have plenty of time for another look.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 ++++++++++++++++-
>  drivers/iio/industrialio-core.c         |  5 +++++
>  include/uapi/linux/iio/types.h          |  5 +++++
>  tools/iio/iio_event_monitor.c           | 10 ++++++++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 8127a08e366d..ad9579a9385f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1684,4 +1684,19 @@ KernelVersion:	4.18
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) phase difference reading from channel Y
> -		that can be processed to radians.
> \ No newline at end of file
> +		that can be processed to radians.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm1_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm1_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm2p5_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm4_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm4_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm10_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm10_input
> +KernelVersion:	4.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Mass concentration reading of particulate matter in ug / m3.
> +		pmX consists of particles with aerodynamic diameter less or
> +		equal to X micrometers.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a062cfddc5af..cbc2c5c8bf36 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_GRAVITY]  = "gravity",
>  	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  	[IIO_PHASE] = "phase",
> +	[IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -127,6 +128,10 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_Q] = "q",
>  	[IIO_MOD_CO2] = "co2",
>  	[IIO_MOD_VOC] = "voc",
> +	[IIO_MOD_PM1] = "pm1",
> +	[IIO_MOD_PM2P5] = "pm2p5",
> +	[IIO_MOD_PM4] = "pm4",
> +	[IIO_MOD_PM10] = "pm10",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 92baabc103ac..c59adac24b1c 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -46,6 +46,7 @@ enum iio_chan_type {
>  	IIO_GRAVITY,
>  	IIO_POSITIONRELATIVE,
>  	IIO_PHASE,
> +	IIO_MASSCONCENTRATION,
>  };
>  
>  enum iio_modifier {
> @@ -87,6 +88,10 @@ enum iio_modifier {
>  	IIO_MOD_VOC,
>  	IIO_MOD_LIGHT_UV,
>  	IIO_MOD_LIGHT_DUV,
> +	IIO_MOD_PM1,
> +	IIO_MOD_PM2P5,
> +	IIO_MOD_PM4,
> +	IIO_MOD_PM10,
>  };
>  
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index ac2de6b7e89f..f6b8003fbe3c 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_GRAVITY] = "gravity",
>  	[IIO_POSITIONRELATIVE] = "positionrelative",
>  	[IIO_PHASE] = "phase",
> +	[IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -115,6 +116,10 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_Q] = "q",
>  	[IIO_MOD_CO2] = "co2",
>  	[IIO_MOD_VOC] = "voc",
> +	[IIO_MOD_PM1] = "pm1",
> +	[IIO_MOD_PM2P5] = "pm2p5",
> +	[IIO_MOD_PM4] = "pm4",
> +	[IIO_MOD_PM10] = "pm10",
>  };
>  
>  static bool event_is_known(struct iio_event_data *event)
> @@ -156,6 +161,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_GRAVITY:
>  	case IIO_POSITIONRELATIVE:
>  	case IIO_PHASE:
> +	case IIO_MASSCONCENTRATION:
>  		break;
>  	default:
>  		return false;
> @@ -200,6 +206,10 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_Q:
>  	case IIO_MOD_CO2:
>  	case IIO_MOD_VOC:
> +	case IIO_MOD_PM1:
> +	case IIO_MOD_PM2P5:
> +	case IIO_MOD_PM4:
> +	case IIO_MOD_PM10:
>  		break;
>  	default:
>  		return false;

