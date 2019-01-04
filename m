Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F972C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0011B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546624327;
	bh=+su/Qs+Cz0cYpN2qfT/2Jx3q5qizXMee64zZMYwRNDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WuFGH/W931NFes3oqrILzJ/4kUdRszBDjt8jKmM5cji23ju8SpYJRZVAyImmdNUpU
	 iZ3YR7M/EbSh6++f43GAv0FosJNrGegbzHx4Eg4wQBi1F1Z4ESMoF1hINDdo84XPFT
	 Z6j3c2oebGvaGbPe9aJKkam58woZuN4i/MqJB/OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfADRwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfADRwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:52:05 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C3A218F0;
        Fri,  4 Jan 2019 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546624324;
        bh=+su/Qs+Cz0cYpN2qfT/2Jx3q5qizXMee64zZMYwRNDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qbdZX4vOxsE6R2gKeCL5QY/yuke8CSeK63lwUf+fPp3IjSq3TrQnLRaSbYj5VozIW
         KYrU8RCwwGFnM+b30xL3lhKmJ9RwnMFsxazdQxqoaqCd/WQ1J42fHyLdS3YRT3ZNxP
         W4faCiAcjEUWOX9DqwZLOLcfFv3vtzwnJko+mXzc=
Received: by mail-qt1-f180.google.com with SMTP id n32so41119115qte.11;
        Fri, 04 Jan 2019 09:52:03 -0800 (PST)
X-Gm-Message-State: AJcUukf+AYFX7KN5KW6GIaM9qFxCfXCKNOg32Az1Ng8FTmQctcrYPY8h
        GBmmpfmUYBNgzf9Gm1tYN6gZfufNQbZobj2HVQ==
X-Google-Smtp-Source: ALg8bN6A9gvdJDThaQyJEb2fcsKCnaiR7oYm2mjGYtl6z5WvAVM9xp8LskHUwx9Txu8y2EMxmGAhexuYuZ8/nBJ8+d0=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr51688167qvi.90.1546624323140;
 Fri, 04 Jan 2019 09:52:03 -0800 (PST)
MIME-Version: 1.0
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
In-Reply-To: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Jan 2019 11:51:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvSWF60eqLsXUcP5GL0ijgfE6XwvectiM1D1Y9LPpOkA@mail.gmail.com>
Message-ID: <CAL_JsqLvSWF60eqLsXUcP5GL0ijgfE6XwvectiM1D1Y9LPpOkA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add driver for globaltop GNSS receivers
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 4:51 AM Loys Ollivier <lollivier@baylibre.com> wrote:
>
> Hello !
>
> This patch series adds a new GNSS driver for the globaltop GNSS receivers.
> These receivers transmits NMEA output sequence as soon as they have booted.
> Power management can be done via the main supply and optional backup supply
> as defined in the device tree.
>
> The driver has been tested using a GlobalTop pa6h chipset on a Libretech-cc
> board using the expansion header. Changes made in the board device tree can
> be found below for reference and testing.
>
> Loys
>
> Loys Ollivier (4):
>   dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
>   dt-bindings: gnss: add gtop binding
>   gnss: add gtop receiver type support
>   gnss: add driver for globaltop receivers
>
>  Documentation/devicetree/bindings/gnss/gtop.txt    |  33 +++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/gnss/Kconfig                               |  13 ++
>  drivers/gnss/Makefile                              |   3 +
>  drivers/gnss/core.c                                |   1 +
>  drivers/gnss/gtop.c                                | 152 +++++++++++++++++++++
>  include/linux/gnss.h                               |   1 +
>  7 files changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/gtop.txt
>  create mode 100644 drivers/gnss/gtop.c
>
> ---
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index 90a56af967a7..3b3d4dcc47aa 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -17,6 +17,7 @@
>
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;

You should not need this as the UART is not used as a tty. It could be
that the serial driver requires aliases, but that should be fixed.
There should be some examples of fixing this in other serial drivers.

>                 ethernet0 = &ethmac;
>         };
