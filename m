Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF8AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24B220849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otDY7uur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24B220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeLMOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:43:17 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38577 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeLMOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:43:15 -0500
Received: by mail-yb1-f196.google.com with SMTP id d187so882358ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOnn/n4LPkiDFTvjproHCRcPfd9P9L5PF6TwtBYO1RI=;
        b=otDY7uurWun3Nceokfezvs9m4a/EYIJPiCAtzQ7W0Lxa9Z67/bGM5hnNcBV+EJqRMJ
         8ndjriRpB+AvCLgIvrvq/qnICUY+2jfjxKciU2UMlxMnrOEsx3Qg6pajzE5Vni1hFzDz
         PWiDk8wLgtO3EOiGa1w2+UwtcIlcVqQb2b/0ExaDfnd4YXTUKyI1BcjrPeVhJIgKHeg8
         m3lxdXz5pPheeDHseZ7uzCVdu6lqpc5u0Q1vOncstYrkv9dABUiPXumieGRYjBL4kA/p
         oixZd6NNg7gGLQC8ZqHUEaalvmJ9a9po5DrgREkIjQ6oLT1TqCEqj4x4WxA8Wg8sTRxz
         WanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOnn/n4LPkiDFTvjproHCRcPfd9P9L5PF6TwtBYO1RI=;
        b=b818mTZUb5aYsM3S9eSkGAcGA9iwTzUtlFIyvAsIIuIZKLOciMZach+0LOpGKBZVWl
         Mk437+9toHMvE8D7RSBuiB0wa2t6J0jdOGn4f5yphP7OiVcKAW3pc0FvX1UglV+eIdn8
         c/t8iMm2Jnn82ZBOtO1OizBoVhmFndwSp5Ue3ZWxNct8J4xaQFwAO0E2Xu2EzPiQ0nIR
         qk1i22lDwl65CVZBr2a4n+5TeRcIiC/rLJMOP8GSZxbBJwnDngbbwLQIF/uj8RyNIBVA
         JwVTW5N5BwJXk7j48nvJ6wW44NClCKIbrsrhRmcDuIOhANkTNAYc/y05DG39489ushir
         NnGA==
X-Gm-Message-State: AA+aEWaDXd3P0ZmcIcqPP2XAIfyRu3ECNn1CgiVQvFzO3Prd+CULWQRY
        sDKpBQoQrDppdp4CYxKuflc5s6VgL345E5uKKHmUUQ==
X-Google-Smtp-Source: AFSGD/UBj1IgCxqV0Vk+zhx0OD76T3Q/Ai2wZqpHxLCPP1Z3Ex1fIHiedyw2NBs/qH4zDtQnAuwemuqry8poVLZVFdo=
X-Received: by 2002:a25:d9d2:: with SMTP id q201mr6188045ybg.151.1544712193640;
 Thu, 13 Dec 2018 06:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20181211190053.9997-1-enric.balletbo@collabora.com>
In-Reply-To: <20181211190053.9997-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 13 Dec 2018 06:43:02 -0800
Message-ID: <CABXOdTcN5d69w4vorq_5hGPiaq_nDcAGDNVbU6gyVjNWy9Yubw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add maintainers for ChromeOS EC sub-drivers
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, a.zummo@towertech.it,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, thierry.reding@gmail.com,
        linux-pm@vger.kernel.org, bleung@chromiumg.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Miller <davem@davemloft.net>, mchehab+samsung@kernel.org,
        nicolas.ferre@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric,

On Tue, Dec 11, 2018 at 11:01 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  MAINTAINERS | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24129b0b043..2f24f5c977ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3625,6 +3625,30 @@ S:       Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:     drivers/platform/chrome/
>
> +CHROMEOS EC SUBDRIVERS
> +M:     Benson Leung <bleung@chromiumg.org>
> +M:     Enric Balletbo i Serra <enric.balletbo@collabora.com>

It might possibly make sense to add

R: Guenter Roeck <groeck@chromium.org>

since it looks like I am doing a lot of the actual reviewing anyway.

Thanks,
Guenter

> +S:     Maintained
> +F:     Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +F:     Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> +F:     Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> +F:     Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> +F:     Documentation/devicetree/bindings/mfd/cros-ec.txt
> +F:     Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +F:     drivers/extcon/extcon-usbc-cros-ec.c
> +F:     drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +F:     drivers/iio/accel/cros_ec*
> +F:     drivers/iio/common/cros_ec_sensors/
> +F:     drivers/iio/light/cros_ec*
> +F:     drivers/iio/pressure/cros_ec*
> +F:     drivers/input/keyboard/cros_ec*
> +F:     drivers/mfd/cros_ec*
> +F:     drivers/power/supply/cros_usbpd-charger.c
> +F:     drivers/pwm/pwm-cros-ec.c
> +F:     drivers/rtc/rtc-cros-ec.c
> +F:     include/linux/iio/common/cros_ec_sensors_core.h
> +F:     include/linux/mfd/cros_ec*
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:     Brian Austin <brian.austin@cirrus.com>
>  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> --
> 2.19.2
>
