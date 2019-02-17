Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66567C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2900C217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZLbX1Sy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfBQWDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:03:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36984 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:03:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id b3so25211633otp.4;
        Sun, 17 Feb 2019 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jO9MzCC73MnV6m85PMkVBIfhuvLVlrxHdM19Ba0nRg=;
        b=ZLbX1Sy4vV2LLMwAEICGHVikesUd42wJAcf09IsEKd5G6hwutdPsPiwR+A1L7gIfTs
         vOv0DQDHhVZ9dgW1rQ6RzIgUEmu9fwkHNwhDpF0PUplojIGlGRUkhQIpo5pF6zLPnORt
         VyPCx3icKLH1IJrkmY5lZ37FMfHRD+KrRqXbOtlTlA+AjZghGYMmm4zm33IeNh+7h6cn
         +zxkWJytvYUnrJDDtw522Q1A7bcZkM5eXQGwtH+WyhifsFySSQnt/olhMFxdShDqYh6x
         LdlOXfHOOemkc2Cdycn6bz6hZO8R/jzP0M5/NhBDS+XzGgYQ8BF0jv0BSPEywcq3QYWQ
         0wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jO9MzCC73MnV6m85PMkVBIfhuvLVlrxHdM19Ba0nRg=;
        b=CokjINh/COlWIFl0veG/gdKWyG+9D2YrAuZthBBRd4IzYhYU/8ufgUTcGiAPiwGn9u
         emUtZcKV2PxnQHIMzoIE9JMbxgE72UJjyWkM/FYo4oA8hME1S1IqQv297dGJh7UmMZ/r
         VqN/bgI+58S4GKHk4Rq4v9tnhuk0ONI4q5nll0LxbgTKxoH4v3PpOAYAbXQ9j3E1gCR/
         6k1DCydG+BURvb18GlYqh25RE9y6D1tNpXDYjWursmboMwjRFTera1/PYZos4HrJ/4bP
         J19cU6wtGgQYRUH3PsxF/w4uYHr5pryfvkFIK/qXhch6uizVHXanZX7qXigZ1Ef8XZWX
         D/0A==
X-Gm-Message-State: AHQUAuYNqYQ/k0Lclt5GOQ56fJWtoELucorHJ+i1sYrf+GALRskmPK1L
        ey6DrV/n4EDOSHtMbaJXmtghANroU4L29XzlWgk=
X-Google-Smtp-Source: AHgI3Ib7sWjIbwwd6DEwqjxVJdURd1adkMhrvKp68Iwf4pX6EECEMQVfFIJ7yeo1e5BtpjFKFgEJYcpxRcHBG/bRMNw=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr13173460otf.131.1550440994225;
 Sun, 17 Feb 2019 14:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com> <20190212151413.24632-3-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 17 Feb 2019 23:03:03 +0100
Message-ID: <CAFBinCA37waCTqGrMqaLmb5n8XuGJof_7iQsWkBdAYr7s2en=g@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo
 PHY Bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic G12A Family USB3 + PCIE Combo PHY Bindings.
>
> This PHY can provide exclusively USB3 or PCIE support on shared I/Os.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
one nit-pick below, but apart from that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../bindings/phy/meson-g12a-usb3-pcie-phy.txt | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> new file mode 100644
> index 000000000000..714d751091f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> @@ -0,0 +1,25 @@
> +* Amlogic G12A USB3 + PCIE Combo PHY binding
> +
> +Required properties:
> +- compatible:  Should be "amlogic,meson-g12a-usb3-pcie-phy"
> +- #phys-cells: must be 1. The cell number is used to select the phy mode
> +  as defined in <dt-bindings/phy/phy.h> between PHY_TYPE_USB3 and PHY_TYPE_PCIE
> +- reg:         The base address and length of the registers
> +- clocks:      a phandle to the 100MHz reference clock of this PHY
> +- clock-names: must be "ref_clk"
> +- resets:      phandle to the reset lines for:
> +               - the PHY control
> +               - the USB3+PCIE PHY
> +               - the PHY registers
no reset-names (like in the G12A USB2 PHY bindings) here?
even if you don't use them in the driver I suggest you add them for
consistency (and maybe to make it easier to compare the bindings with
the datasheet. I don't have access to the datasheet so I'm not sure if
having the reset-names is relevant for this case)


Regards
Martin
