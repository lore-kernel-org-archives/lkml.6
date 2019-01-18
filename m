Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD86C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524CE2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jLZxN8YF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfARV6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:58:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42856 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfARV6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:58:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so10135232oiw.9;
        Fri, 18 Jan 2019 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzU6t1Dt7NW3z9OyLSLM1mvqbluntTfKi+oSjEMCJ3c=;
        b=jLZxN8YFt7DA6h67fxza6sFDdpTjHbOwI4CoR6ZXM6jz1uPTeK7s8fR53814UykLMB
         BeobnUAjRGkY3FAb02tqn3nLMmUk90lKFlNvNu/b/G+WL0typyBk+eLgIwdmA8Vmqrre
         NSFtOHY5Wu3eT3nVL/JABLnI1GbDVKyWQ0x0E+luVUULeUDfmjsTvp3bEe8dFgJR6NLU
         F0kifxpvQfJ8ZwuR75iR0Bpoe7D9q2cey0rw9KP/9nVQYcQrKFcQMgrr2+VrrFNpZKCq
         Y7mp4a3hja0jxox2GByDl5zLdOOgL5I/lpJIfiGyABwzi/ZvPDqC43KfApJa86ZuVJKr
         6IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzU6t1Dt7NW3z9OyLSLM1mvqbluntTfKi+oSjEMCJ3c=;
        b=Oo5e1uBDqpkLt7hokyInn1j8vC5O2LwBz3syAGZ/rAR5Edsta/SWLhlByGeB+C4rKH
         ErFUJomR7vU5CgMzdHw/9ddibbmOC6/VFJ9EOzfFoTVULZ1vAANDqeQ04JzFbIXs8bKb
         h+VtzZ5fDbrDR8xEg8v/SU+HvhYQQYOiUy8TKwloQCBwddd60Pq5q2eTHZ3yl6rFK/zd
         nLlaFiFXpXvF/lJsteaZYrklgdxgOeo2gVgosyfKnvaoQr6AEpQg3wY9UWGaKVVNTHCO
         YtJmYoXjm4ic/2asHpjR2MoKsIHp65kpt1bKdjsQl4ix3bYnJOaQyfqV64C5nuEOeLtE
         Wqjw==
X-Gm-Message-State: AJcUukd6i2028BePYz3ik/r1aB3QncgewKLVHj2McZbl2/HlhxZ22j6y
        YvcVhJY2hXAzResM7B5eps3rQPyJwgOnvrZpNKU=
X-Google-Smtp-Source: ALg8bN7vxHg1nhiDiWNoJEMgG3/cSI7VqTbdORuDOrpEOXE0d8s6ROSVneT4dfDUX7l+c4JSZis1LzVn1Bgf/GMui4Y=
X-Received: by 2002:aca:e884:: with SMTP id f126mr1751681oih.181.1547848685856;
 Fri, 18 Jan 2019 13:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20190118103423.15075-1-jbrunet@baylibre.com> <20190118103423.15075-4-jbrunet@baylibre.com>
In-Reply-To: <20190118103423.15075-4-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jan 2019 22:57:55 +0100
Message-ID: <CAFBinCAi70sfpWqiSDorN4ds5eYGbh7GVuU5qZ4Ak3myyYPe7Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: meson: axg: add clk measure support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        patchwork-bot+notify@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:34 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the clock measure device to the axg SoC family
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index f044473dc7d0..398b7ac1b107 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1610,6 +1610,11 @@
>                                 status = "disabled";
>                         };
>
> +                       clk_msr: clock-measure@18000 {
thanks for updating this to use "clock-measure" (for consistency with
what Rob acked in the example and what we use on the GX SoCs)!
