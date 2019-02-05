Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC596C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EF5217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfBEQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:17:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38581 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfBEQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:17:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so3326194ede.5;
        Tue, 05 Feb 2019 08:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nc69Rr/zC19ZjVyKRZ+L0NUBfAxP3RCMPA3CpLvAJBs=;
        b=OZMmkpLRA+IyS1Gt7b1in5qygemhponDKCkpA5R94GnpJcTlvECbk1C353Mwm08gY7
         DK3dZ5ohOUKXUMfDG5CHAASLJfwWuzsSI56z2V3x0riCI+b4d6S6/eXjld6kBjQg7OpD
         KBd2jtwJyx4ImGI6EmjbP+EZnZYHQBGRpHSBKPnSnq9q/zDtQiHpiEFdwOo0KwoMjL/Q
         AnWsnYi9tr0dVa0xlncq/Iy/ZXGEtwCy6xcRnZrktazqRZGWkGdbZT1m+C2jaV2BfBD1
         7vShAX5nv4rxeMitEoZH8n4HNB2KI6HEeEXo5Dwvipg42RuYGAjsYb2zstgHj5JDCI2P
         keTg==
X-Gm-Message-State: AHQUAuYtxuN6IwHphemNhrOU6xIx5uLfO6Db9f6aMhf6EnaFK/welZl2
        XbW2f/1DRo70J780zUB1Zd4J0UrZzvc=
X-Google-Smtp-Source: AHgI3IZpJbp38kUS+xVssGgizEip767FAlW1LjFmk9kTwJxht7h1N5/HrFDmpOtFGlass62rwyqZNg==
X-Received: by 2002:a17:906:a40a:: with SMTP id l10mr4045287ejz.248.1549383428503;
        Tue, 05 Feb 2019 08:17:08 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id f51sm535573edb.16.2019.02.05.08.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 08:17:08 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id p4so4263554wrt.7;
        Tue, 05 Feb 2019 08:17:07 -0800 (PST)
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr2214305wrx.87.1549383427512;
 Tue, 05 Feb 2019 08:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20190131082308.22522-1-stefan@olimex.com> <20190131082308.22522-5-stefan@olimex.com>
In-Reply-To: <20190131082308.22522-5-stefan@olimex.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Feb 2019 00:16:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66B3X=hyCCanUv6yGziVcu3WrRcKODBp266ODL+yQ4m1w@mail.gmail.com>
Message-ID: <CAGb2v66B3X=hyCCanUv6yGziVcu3WrRcKODBp266ODL+yQ4m1w@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm: dts: axpxx: add charge led node
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 4:25 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
>
> Add dt node for axp20x-led driver controlling CHGLED.
> Default status is disabled, since it may be not used.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Please include a cover letter for such a patch series.

Also, do any boards actually use this? I know the Pine64 does, but the
LED is left to the user to populate. I would really like to have an in
kernel user of this function, so that we can verify it.

ChenYu

> ---
>  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>  arch/arm/boot/dts/axp22x.dtsi | 5 +++++
>  arch/arm/boot/dts/axp81x.dtsi | 5 +++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 0d9ff12bdf28..f972b6f3ecd0 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -69,6 +69,11 @@
>                 #gpio-cells = <2>;
>         };
>
> +       axp_led: led {
> +               compatible = "x-powers,axp20x-led";
> +               status = "disabled";
> +       };
> +
>         battery_power_supply: battery-power-supply {
>                 compatible = "x-powers,axp209-battery-power-supply";
>                 status = "disabled";
> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
> index 65a07a67aca9..92a0b64252b1 100644
> --- a/arch/arm/boot/dts/axp22x.dtsi
> +++ b/arch/arm/boot/dts/axp22x.dtsi
> @@ -62,6 +62,11 @@
>                 #io-channel-cells = <1>;
>         };
>
> +       axp_led: led {
> +               compatible = "x-powers,axp20x-led";
> +               status = "disabled";
> +       };
> +
>         battery_power_supply: battery-power-supply {
>                 compatible = "x-powers,axp221-battery-power-supply";
>                 status = "disabled";
> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
> index bd83962d3627..22e243cc40d5 100644
> --- a/arch/arm/boot/dts/axp81x.dtsi
> +++ b/arch/arm/boot/dts/axp81x.dtsi
> @@ -74,6 +74,11 @@
>                 };
>         };
>
> +       axp_led: led {
> +               compatible = "x-powers,axp20x-led";
> +               status = "disabled";
> +       };
> +
>         battery_power_supply: battery-power-supply {
>                 compatible = "x-powers,axp813-battery-power-supply";
>                 status = "disabled";
> --
> 2.17.1
>
