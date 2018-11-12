Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00443C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4C7223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVTEBggg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4C7223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeKLSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbeKLSnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:43:35 -0500
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBEF223CB;
        Mon, 12 Nov 2018 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542012682;
        bh=32atDAVK8kDmfqg/3myjR3Mw8iFlsaExz9wi01JAhDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YVTEBggglmcwoNX/uNTpa3SINbJBtqiMbqhp0daOoqxHlfYWavvQUnJwWqaLEgErE
         /Y5LtFGIboK1g6VPEAdsB41FMKQirBlxaRPLzdF6s4jkCZicL3bvcXUGIJR8gH3GOL
         kdmJDYr6D1Mp4Zmp68KgL+5ZdTyrmXFy+5/Zi6hI=
Received: by mail-lf1-f44.google.com with SMTP id h192so5576775lfg.3;
        Mon, 12 Nov 2018 00:51:22 -0800 (PST)
X-Gm-Message-State: AGRZ1gJakXhdZ6obqIgiulU+e1sw4ghbfOWuT8IoSa8X7bahSN7DtLzb
        gCqP7iEA4ouGXvjywEoMuQKITxLlPYYlnOvlu4c=
X-Google-Smtp-Source: AJdET5cZ1BdL4oocgMfTHvKU/Q5dStgdchTi98zo3a46akFDHjtFqumTo0yqgiW4jrHlNdOU2SRKtGZ33PBCj0Y6UyA=
X-Received: by 2002:a19:a502:: with SMTP id o2mr68514lfe.92.1542012680474;
 Mon, 12 Nov 2018 00:51:20 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b@eucas1p2.samsung.com>
 <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com> <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Nov 2018 09:51:09 +0100
X-Gmail-Original-Message-ID: <CAJKOXPedw6OD1fWWVkYozgR03AWKz5t_-vWw0MV1jVGVR_UGTA@mail.gmail.com>
Message-ID: <CAJKOXPedw6OD1fWWVkYozgR03AWKz5t_-vWw0MV1jVGVR_UGTA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] Doc: DT: thermal: new irq-mode for trip point
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018 at 18:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>

Subject prefix:
dt-bindings: thermal:

> Thermal trip point gets new flag in DT: irq-mode.
> Trip point may have a new explicit flag which indicate
> IRQ support when the temperature is met (so the thermal framework
> deos not need to set polling for it).
> It is useful for 'passive' cooling trip point,
> which now will not register for polling the temperature.

You wrap lines in weird way making it more difficult to read.
I already asked about this while reviewing v1. Please fix it.
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L633

>
> Update documentation about irq-mode for trip points.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index ca14ba9..bee21e3 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -90,6 +90,10 @@ Required properties:
>         "critical":     Hardware not reliable.
>    Type: string
>
> +- irq-mode:            A flag indicating that trip rises irq, so there is no

"rises IRQ" (it is an abbreviation).

Best regards,
Krzysztof

> +  Type: bool           need of polling in thermal framework.
> +  Size: one cell
> +
>  * Cooling device maps
>
>  The cooling device maps node is a node to describe how cooling devices
> @@ -256,16 +260,19 @@ thermal-zones {
>                                 temperature = <90000>; /* millicelsius */
>                                 hysteresis = <2000>; /* millicelsius */
>                                 type = "active";
> +                               irq-mode;
>                         };
>                         cpu_alert1: cpu-alert1 {
>                                 temperature = <100000>; /* millicelsius */
>                                 hysteresis = <2000>; /* millicelsius */
>                                 type = "passive";
> +                               irq-mode;
>                         };
>                         cpu_crit: cpu-crit {
>                                 temperature = <125000>; /* millicelsius */
>                                 hysteresis = <2000>; /* millicelsius */
>                                 type = "critical";
> +                               irq-mode;
>                         };
>                 };
>
> --
> 2.7.4
>
