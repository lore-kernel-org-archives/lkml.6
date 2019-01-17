Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C34C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A540720868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IQ6eanC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfAQT6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:58:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36308 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfAQT6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:58:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so7171346oix.3;
        Thu, 17 Jan 2019 11:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kbKi4J7Pv9IIt9CBOSUEb0XV0HiJDsajvAfbgVCqRQ=;
        b=IQ6eanC66pjhHSw+qR+yqc8Nk/r2rfYuT5E5WofHBRVio+rAaN2KP773yKs73Lgdbq
         WVgMRaaaK/hImynyFTLOwDHjBf6U2STzNY+wqJNkX6pYx5PTQS4ICiE3mo/Uxv5+pduL
         mwEYFfWr6LpfC2fQka7DD8z9sjg/gjMLhORzSs9n1guMJOZr4h3UP9ZIujCR5BMxSEb2
         srzLY8jDqxu3Mmsksj4p/O3pOQ/8vMJ2srtzF06Wz3CKWgGqMHjv307I3uLYh+/c6b0a
         ZLG9hN7NUjWF0eePaxZHFIRylbeNe+TwgOaKvAQEngA0nGU4YY4o/Z7dHhdNSSUU0cFe
         KdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kbKi4J7Pv9IIt9CBOSUEb0XV0HiJDsajvAfbgVCqRQ=;
        b=U4KtAzjuFg1SHzbY9ibgEWGWN2EpG2v8yX+v/nhv50NhA1PJaSTZakK7MXyzm7tkR2
         FdrFlaWjTbRrUZGyqYIC0H75t210ZUNRZLBJM1kMQI/T2V5exzK904XA5UfacPBiei4I
         +PD4VuCRfpivqq8i8pZXbBiKC/9wq3xiaYU0HPwyQCgFu32GU+0XAhc0mmGA1zzxZE0i
         TVyd0JTfw14MSyIw+qmOt7CH8W6sbe68HmEAnCn9tLJlghjT0mgD4rKSoRJGKR8BFofT
         QI1frGJZVApwii5x/g45DydR1uZ0FCwFQujDaHOLe/yMgTxGwHGMfgkOhsCPGJOpEC8l
         OWQw==
X-Gm-Message-State: AJcUukdVP5N2bBLFyJUIzPMGhaRkt91j9x1LtND1z2uxAtM0XEumElgJ
        DQB3JrKEBC/nVda+eh/kwXJgJY5SFxIjZl5dTTgclsiX
X-Google-Smtp-Source: ALg8bN413LM7538gOPe2Ql03TGdmQlTBK38KWqOcQbIjKIoU7v96tHWL9yDClCeloo6ATYzVpP9d2gCa/3DCrg2p88w=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr4276274oib.41.1547755082532;
 Thu, 17 Jan 2019 11:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20190117164838.8008-1-jbrunet@baylibre.com> <20190117164838.8008-4-jbrunet@baylibre.com>
In-Reply-To: <20190117164838.8008-4-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 17 Jan 2019 20:57:50 +0100
Message-ID: <CAFBinCChyyWaiju6ghaCHBFktTXV6DbtuCgZFjEENrf3t3eOxg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: meson: axg: add clk measure support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        patchwork-bot+notify@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Jan 17, 2019 at 5:48 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the clock measure device to the axg SoC family
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 0e0abb1a03e2..94ea36a2417a 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1611,6 +1611,11 @@
>                                 status = "disabled";
>                         };
>
> +                       clk_msr: clock-sensor@18000 {
in the dt-bindings specify "clock-measure@..."
this also applies to patch 4/4 from this series


[0] https://elixir.bootlin.com/linux/v5.0-rc1/source/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
