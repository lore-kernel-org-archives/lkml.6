Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAEAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D5420869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D5420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeJPMAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:00:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42522 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJPMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id b7-v6so19883885edd.9;
        Mon, 15 Oct 2018 21:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUuaN5lJWbU1TdxWRAIkTGmLARPuUJesk9CbkcAuhAA=;
        b=kGu2paLu3/3w3RbIxLSLmNCEUw0yCsiQzjXP3q/z/s5G+j7QnrJHajUYl+MNu5WHtG
         uTk6j/y1L84JidjptSzQaaQziI6iP8DQlxlulcgdmFy6MN7/n7xuawNX9b0edGIILwR/
         zAlgPShZT1waMgxbdBnl9/Hif4CNGL9tKFItzqRrNUulJhXMTLf1/KB4LGIYet/9oSET
         rrstfEZO/Lv4XDozgX+bKde1fEDJVrbOjltUZhcd4jTzJ3jVOXMoNyrWmCs/Nx00li/X
         tuYK8UDTWZ2aQWT3agWzVZoHi87Edvz3hnXMlHgxoGc3OHh1aW4epIWZjUfvog1YFBkx
         u47A==
X-Gm-Message-State: ABuFfohfxzz5B6o9uhB7WqDvcvKh0h+0+M0bIUTMnnur+9ohp/REAIhx
        3Vl2kghGUrNJ26Sn8GfoQGSLO9JZkxI=
X-Google-Smtp-Source: ACcGV61sQpP9n2HTAGAOamaTFrFE6iJwYW8SnpllG2BRNworfiqGi0sAJ+zK2HI5Gq9n3XbD/v1svA==
X-Received: by 2002:a50:8a42:: with SMTP id i60-v6mr27416241edi.236.1539663120214;
        Mon, 15 Oct 2018 21:12:00 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id q25-v6sm5311872eda.18.2018.10.15.21.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 21:12:00 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id a8-v6so21600212wmf.1;
        Mon, 15 Oct 2018 21:11:59 -0700 (PDT)
X-Received: by 2002:a1c:e717:: with SMTP id e23-v6mr15519720wmh.145.1539663119189;
 Mon, 15 Oct 2018 21:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-4-oskari@lemmela.net>
In-Reply-To: <20181013080848.29894-4-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 16 Oct 2018 12:11:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mUEOzN97655pz6EWvN4fu+b-bT02JhwrTE+Ru+6gR8Q@mail.gmail.com>
Message-ID: <CAGb2v66mUEOzN97655pz6EWvN4fu+b-bT02JhwrTE+Ru+6gR8Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] arm64: dts: allwinner: axp803: add AC and battery
 power supplies
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> AXP803 is compatible with AXP813. Add DT nodes ADC, GPIO,
> AC and battery power supplies.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> index e5eae8bafc42..128177178615 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -49,6 +49,37 @@
>         interrupt-controller;
>         #interrupt-cells = <1>;
>
> +       ac_power_supply: ac-power-supply {
> +               compatible = "x-powers,axp813-ac-power-supply";

Even though they seem to be compatible, please add a model specific
compatible string in front for all the new nodes just in case. In
this case it would be "x-powers,axp803-ac-power-supply".

ChenYu

> +               status = "disabled";
> +       };
> +
> +       axp_adc: adc {
> +               compatible = "x-powers,axp813-adc";
> +               #io-channel-cells = <1>;
> +       };
> +
> +       axp_gpio: gpio {
> +               compatible = "x-powers,axp813-gpio";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio0_ldo: gpio0-ldo {
> +                       pins = "GPIO0";
> +                       function = "ldo";
> +               };
> +
> +               gpio1_ldo: gpio1-ldo {
> +                       pins = "GPIO1";
> +                       function = "ldo";
> +               };
> +       };
> +
> +       battery_power_supply: battery-power-supply {
> +               compatible = "x-powers,axp813-battery-power-supply";
> +               status = "disabled";
> +       };
> +
>         regulators {
>                 /* Default work frequency for buck regulators */
>                 x-powers,dcdc-freq = <3000>;
> --
> 2.17.1
>
