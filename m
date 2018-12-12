Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D742C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3140620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544634406;
	bh=MA9j7yNHyEaH3NdeSr24lwe9hZhkaVM7kHj29+c33mI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O8EZH1YMzEpZoZ3CYTQm+KnSz5SXUfbEgpFem0fJx3A7vKgXNZLnkwrsizNaQ4DcI
	 3gWV9uZzqQCIfLDJckmUscrdvWl2jS4xl382PPGBTa1Z7NWZPOk7wbt01TWhEDy4j8
	 C5zH4I/QH8O/EY4vrEaslES+EToKv7dWno+hJR2Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3140620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbeLLRGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:06:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbeLLRGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:06:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0132B20849;
        Wed, 12 Dec 2018 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544634403;
        bh=MA9j7yNHyEaH3NdeSr24lwe9hZhkaVM7kHj29+c33mI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L9/q6bqau5cew3qGq/0Uw5g0755WLBmstSkh612ng7haVhCabzoE3cQS/DkdTDxuk
         qWmcK5hG0aivELamuP4eTrz2Sr1PwSyPRE3uLsag7m0YgeIVOvK87ZqKOiI8GwmPjn
         Pyw3kReAyvdeyVblIWf0aYwCxOHG2gYAEZJbzo8Y=
Date:   Wed, 12 Dec 2018 17:06:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, linux-rtc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Message-ID: <20181212170635.09c3363d@archlinux>
In-Reply-To: <20181211190953.13626-1-enric.balletbo@collabora.com>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 20:09:52 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for iio parts.
> ---
> 
> Changes in v2:
> - Fix typo in Benson email address.
> 
>  MAINTAINERS | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24129b0b043..bbe7180e2851 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3625,6 +3625,30 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:	drivers/platform/chrome/
>  
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> +F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> +F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> +F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
> +F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +F:	drivers/extcon/extcon-usbc-cros-ec.c
> +F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +F:	drivers/iio/accel/cros_ec*
> +F:	drivers/iio/common/cros_ec_sensors/
> +F:	drivers/iio/light/cros_ec*
> +F:	drivers/iio/pressure/cros_ec*
> +F:	drivers/input/keyboard/cros_ec*
> +F:	drivers/mfd/cros_ec*
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +F:	drivers/pwm/pwm-cros-ec.c
> +F:	drivers/rtc/rtc-cros-ec.c
> +F:	include/linux/iio/common/cros_ec_sensors_core.h
> +F:	include/linux/mfd/cros_ec*
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>

