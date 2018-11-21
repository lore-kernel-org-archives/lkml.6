Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6292214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSxqzfou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6292214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeKVFgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:36:41 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38336 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbeKVFgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:36:40 -0500
Received: by mail-yw1-f67.google.com with SMTP id i20so2671223ywc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXuDhUzBIOlngXgh3hD/37maUn1sXb+VDKr6KPCykrg=;
        b=PSxqzfoujzUMASjExEoFTPkitFdrt7TC2nEsHCdLFGLR2DRhwu/x6DwuF/xgREaO82
         udVhygiAot7IEQIzku8XH2RWj6gvgZv4u8vNEZh+fQXwKkgrKGflnfQuSYXCniYu8KbW
         FwL5+6/kkHXfImzmFNMYTkfGZ33exKvfdRlKt41+6xRA6ib7Q8JSctJNqu8gPF2zlO3O
         MSbhNWoGhY8RnsbpAxuex5LAdTwXDs7QAuQIOq6sBSBIAnJjZX34dsH8/JOdpKgeK7Q3
         NBXtYbheUJA9Dyj3JkGth8x8+EZyawvISZ+2Ulxzf2EzmxL+V8KwBQbmdFsmXqVWnSMB
         D+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXuDhUzBIOlngXgh3hD/37maUn1sXb+VDKr6KPCykrg=;
        b=hpHc3/xC5x+xcvj17ButfaVFbeI0SWUwQL8ydH6FThIdSiaQnjwbfOv5Qxbgamtbi9
         /NN6uGdxRwGoLXomCYD6K5B16RnIdPtN1RsH8mTuGjRrDELG1bF785qYThH0XWbVa5xT
         8yGgW5G8bp5983T8P08yPOcBkT0vPyJ/jfHZR97kIxPxB4QppEFrcqBfI16L7WIrX/ag
         gDaq3T0MBlycNjA8U8YPBwznJttlDDZIxNWRo82YT+kJfxVymFnpwM/zSSIk97XsuSCq
         HrivmO5IVcjkE4u6/NMdQyy1AK0VKgqM6B125L+LrrOzna/Bzxn1sYdJWOH7Mpuumi2f
         EbZg==
X-Gm-Message-State: AGRZ1gLWpbHhGAbFKCClL4JimEzLJUOTT1O7BceRxtyQkCLIZE+0EGPo
        0p5E464N2nvVYYjDfCRZVZSU3Ubq29jawM/gKYoMaw==
X-Google-Smtp-Source: AJdET5eBY4/eg2zpfeNohc6gYINKJg90Yu1sWxN01aLH4Cx8pkOynkClSKVQqEkwD404c97i1kOKNEx4vqeRHpU6tdI=
X-Received: by 2002:a81:ac1f:: with SMTP id k31mr7759704ywh.320.1542826868265;
 Wed, 21 Nov 2018 11:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20181121153444.24747-1-enric.balletbo@collabora.com>
In-Reply-To: <20181121153444.24747-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 21 Nov 2018 11:00:57 -0800
Message-ID: <CABXOdTc3+ffgdjs6TbC0hZu0rbtExyO4RehGbD89ktqygA17dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: add input voltage limit property.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Sameer Nanda <snanda@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>, rjw@rjwysocki.net,
        len.brown@intel.com, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 7:34 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> We have a problem with USBPD chargers which under certain conditions
> can result in system overheating if the voltage provided by the USBPD
> port is too high. While the preferred means to control this would be
> through devicetree or ACPI settings, this is not always possible, and
> we need to have a means to set a voltage limit.
>
> This patch exposes a new property, similar to input current limit, to
> re-configure the maximum voltage from the external supply at runtime
> based on system-level knowledge or user input.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
>
>  Documentation/power/power_supply_class.txt | 2 ++
>  drivers/power/supply/power_supply_sysfs.c  | 1 +
>  include/linux/power_supply.h               | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
> index 300d37896e51..7b4be615b4f8 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,8 @@ power supply object.
>
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
>  the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicates
> +the voltage limit from a charging source.
>
>  CHARGE_CONTROL_LIMIT - current charge control limit setting
>  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index dce24f596160..5848742ebb59 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] = {
>         POWER_SUPPLY_ATTR(charge_control_limit),
>         POWER_SUPPLY_ATTR(charge_control_limit_max),
>         POWER_SUPPLY_ATTR(input_current_limit),
> +       POWER_SUPPLY_ATTR(input_voltage_limit),
>         POWER_SUPPLY_ATTR(energy_full_design),
>         POWER_SUPPLY_ATTR(energy_empty_design),
>         POWER_SUPPLY_ATTR(energy_full),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f80769175c56..608ba88e32ee 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -122,6 +122,7 @@ enum power_supply_property {
>         POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>         POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>         POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +       POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>         POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>         POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
>         POWER_SUPPLY_PROP_ENERGY_FULL,
> --
> 2.19.1
>
