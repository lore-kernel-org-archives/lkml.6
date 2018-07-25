Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B2BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D0620882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 10:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="onQz8sZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D0620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeGYL5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbeGYL5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:57:08 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D7C2088E;
        Wed, 25 Jul 2018 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532515561;
        bh=BB3Y9NXfu182YAXOsN/CTZzKdQZkAU/mWLf40ImcWXQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=onQz8sZ1UsTLnjNaYGfKY1NUdNd5SOv1FgC/FFTY2Ah2fm+Km8T0hkq1y/9JmETlM
         XvanuzmlOClBQxhVTcQw86NpNhop3fAdeyxzc/HOoe5R0Nmi6yKmlfSo6wA8vXXR7b
         hXZtobY3oRGu0hdcGDJ99GLoLEK7i4Y+NcSpFLGk=
Received: by mail-wm0-f53.google.com with SMTP id t25-v6so5486993wmi.3;
        Wed, 25 Jul 2018 03:46:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlF9Bdq4UXDPQljW514eYcqkzULBRuxmaf4wLt92/l/N7d3h8Uo9
        zQjvevMEL6+T1+L0SO4IZC4/A4TxnY5jjre+At4=
X-Google-Smtp-Source: AAOMgpd5KN818QYb76ERbAuhsB2+EdMBC10v5IJhyUWReJPcfARnvyqa8d4XFOaCWudN+v30Ro7PzHpmkIYJ2ElfU2M=
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr4040576wmd.135.1532515559705;
 Wed, 25 Jul 2018 03:45:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 03:45:59
 -0700 (PDT)
In-Reply-To: <20180723040816.19455-4-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br> <20180723040816.19455-4-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Jul 2018 12:45:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdfxeDR0ovNbNZYAAouxfnpAa6GccZsPMLAYJETKT5Szg@mail.gmail.com>
Message-ID: <CAJKOXPdfxeDR0ovNbNZYAAouxfnpAa6GccZsPMLAYJETKT5Szg@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: power: supply: Max17040: Add low level
 SOC alert threshold
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 at 06:08, Matheus Castello <matheus@castello.eng.br> wrote:
> For configure low level state of charge threshold alert signaled from
> max17040 we add "maxim,alert-soc-level" property.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../bindings/power/supply/max17040_battery.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> new file mode 100644
> index 000000000000..e6e4e46c03c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -0,0 +1,24 @@
> +max17040_battery
> +~~~~~~~~~~~~~~~~

> +
> +Required properties :
> + - compatible : "maxim,max17040"

Why you skipped "maxim,max77836-battery"?

> +
> +Optional threshold properties :
> + If skipped the power up default value will be used
> + - maxim,alert-soc-level :     The alert threshold that sets the state of
> +                               charge level where an interrupt is generated.
> +                               max17040 can be configured from 1 up to 32.
> +
> +Remembering that for the interrupt to be handled it must also be described the
> +information of the interruption in the node.

Just mention interrupts in optional properties, including the flags.
BTW, the driver hard-codes the flags which is in contrast with DT
here.

Best regards,
Krzysztof

> +
> +Example:
> +
> +       battery-charger@36 {
> +               compatible = "maxim,max17040";
> +               reg = <0x36>;
> +               maxim,alert-soc-level = <10>;
> +               interrupt-parent = <&gpio>;
> +               interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
> +       };
> --
> 2.13.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
