Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D27021736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550513188;
	bh=RuvwR1R55a5KW4teZl2ytprZ3Iq1pui/zuuVf2V8r44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vHQryUMTzA2f+cWbqk05DL2Z9v7OllPzPvTpwuBq9K7e87D0GHZgqzUV3W5vkDznz
	 +wp6PBL4GDeTwvi1k0KL/JIZHGLwNbl0KvWa/1orjll7m79or94PDyvI8ze4eUGT8w
	 lOIbDhW3tSRLTrF4z0a/y3DQrP+GLYEMmomP2Aoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390707AbfBRSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfBRSG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:06:26 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C696F21736;
        Mon, 18 Feb 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550513184;
        bh=RuvwR1R55a5KW4teZl2ytprZ3Iq1pui/zuuVf2V8r44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tGaH5Ktr/8S3qarWMNhlszrDjcbbLkejGoNV15Z0lOo3veLgDxnIe4UJvp09e0fdI
         F0fa0/aabiWNeZ3E9JxkaVx80J/e6VLZqq8G8pRo6YZVe7iFmShkUh/xZH/eIt5ojI
         +0QftJymQMqA4/TtCGqFMTp3+npZjI6MauEZHHNM=
Received: by mail-qt1-f175.google.com with SMTP id a48so20191763qtb.4;
        Mon, 18 Feb 2019 10:06:24 -0800 (PST)
X-Gm-Message-State: AHQUAubHbWGcb/kKNRgNGFtlVki/5aLkKgOJBWEbmus25amj1N+nvOD1
        o5fz2UPwllrFQk96ouKF3iSAWibdiihMN6y3pg==
X-Google-Smtp-Source: AHgI3IahU5boZB4w2ZD+OQSE6GUlc65R5MhLOdu/RKRbCOn/40JkVe5w9FQ0EoLHku84pWHkEbP+PFdQih0fwgBsnak=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr19041781qta.76.1550513184002;
 Mon, 18 Feb 2019 10:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20190212064353.7451-1-markz@nvidia.com> <20190212064353.7451-3-markz@nvidia.com>
In-Reply-To: <20190212064353.7451-3-markz@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 18 Feb 2019 12:06:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiL8A+SBwqLzYa9djWBT1S+2kxUUB4iuKWX7EoqXouCw@mail.gmail.com>
Message-ID: <CAL_JsqKiL8A+SBwqLzYa9djWBT1S+2kxUUB4iuKWX7EoqXouCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mfd: max77620: add documentation for backup
 battery charging
To:     Mark Zhang <markz@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:44 AM Mark Zhang <markz@nvidia.com> wrote:
>
> Adding documentation for 3 new backup battery charging dts
> properties:
> - maxim,charging-current-microamp
> - maxim,charging-voltage-microvolt
> - maxim,output-resister-ohms

What's the difference between the 77620 and 77650 as there's patches
on the list for the 77650 too. The properties are similar, but seems
to be main vs. backup battery charger. We should have common
properties for this.

> Signed-off-by: Mark Zhang <markz@nvidia.com>
> ---
>  .../devicetree/bindings/mfd/max77620.txt      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
> index 9c16d51cc15b..88825eaf2567 100644
> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -122,6 +122,26 @@ For DT binding details of different sub modules like GPIO, pincontrol,
>  regulator, power, please refer respective device-tree binding document
>  under their respective sub-system directories.
>
> +Backup Battery:
> +==============
> +This sub-node configure charging backup battery of the device. Device has
> +support of charging the backup battery. The subnode name is "backup-battery".
> +The property for backup-battery child nodes as:
> +Presence of this child node will enable the backup battery charging.
> +
> +Optional properties:
> +       -maxim,charging-current-microamp: Charging current setting.
> +                       The device supports 50/100/200/400/600/800uA.
> +                       If this property is unavailable then it will
> +                       charge with 50uA.
> +       -maxim,charging-voltage-microvolt: Charging Voltage Limit Setting.
> +                       Device supports 2500000/3000000/3300000/350000uV.
> +                       Default will be set to 2500mV. The voltage will be roundoff
> +                       to nearest lower side if other than above is configured.
> +       -maxim,output-resister-ohms: Output resistor on Ohm.
> +                       Device supports 100/1000/3000/6000 Ohms.
> +                       Default will be set to 1000 Ohm.
> +
>  Example:
>  --------
>  #include <dt-bindings/mfd/max77620.h>
> --
> 2.19.2
>
