Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9660020658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="G8Z38Oed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9660020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeIDXcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:32:20 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38439 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIDXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:32:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so8865076oix.5;
        Tue, 04 Sep 2018 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zg3d8KCgNiCtnxua7Wou3BiptpqZ37ERUimjRQBAGa8=;
        b=G8Z38OedpTnZCVLDU3qTBrVNWBr+S/UPCpyKd8UboV5y5z6J9VJh8rRhCYCwgIoSj6
         vuw9IJbp+eaVCzeoo0mb483UtpEYFkSi1VsxWwkaCnQvDbEI6AEmnSRR9bABzWoGAjzM
         KQ2TYN8d1IMgdyTsWzmVV6YPJga3tJPcM5Psmy5mE64KCmbxFReshgix5yn8KNrAyYJO
         +i0vuCLT0keGQ3g+ZDkx1HaIsFyjmM/pgsJRbCptIXKkPwcijHeyfejeGhxIRC3r7+dc
         BeApqqD0BIx58i6WCBD0d+9wNvO088GJIfNSqkWo8J32KwLsrocRLskQUWvJpWx6e37k
         kOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zg3d8KCgNiCtnxua7Wou3BiptpqZ37ERUimjRQBAGa8=;
        b=hY2FA0Gw4hnq19gJeWSzT1xJDjT+EPEq4QLWo1RraCr+NToNCMyT/RYWNtIGadlQpH
         tyTpJRHjZQddnce3HnigsJf6XcKFr9+URKJB7iQHLpeCdYC10ZrhrBrPzFtXzrJcwCtW
         I4bH7TUfueiWcFY6OfnsdSfO558NXf8sbhiNmK/jgqWH/00zR+p6SXldmTT1y+bqAKEB
         w9HPCBB+xCikNlhZ+RsGeBVe+R8CTQB7A6SMOO7/mFP1EWTqVhb5R5ngG8AXOH1PwpHC
         gMTOYkEhWn6yA6QertNVb/+ew+Ua+xEZ7h+pndLNJ/urtb0pvCz2JrRE7jT6dgWguk7w
         sVqQ==
X-Gm-Message-State: APzg51Dtmil9SQN0sW+tl3oV+8wKDxSrn3A8mFzbgkxb0TgO60mJCfFn
        3Zwp/3uK+KfmhOe589SvE0yK4bNHJe5OALCDVrGT9jRU
X-Google-Smtp-Source: ANB0VdZZnjtKPK2RU+xZTVdxTbXEcqSoJyUtC+AKd062yqx7p0JKf1q9OukaUBUDAyibZvhhb6i6I4oUaCd9UrXuWy0=
X-Received: by 2002:aca:e748:: with SMTP id e69-v6mr26923868oih.263.1536087953106;
 Tue, 04 Sep 2018 12:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 4 Sep 2018 21:05:42 +0200
Message-ID: <CAFBinCAQFcYKRCr72vOtuB9x=Zdt4Ox=pY0E9oxZFCO2XKF7oQ@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for Bluetooth
To:     christianshewitt@gmail.com
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, Sep 4, 2018 at 4:47 PM chewitt <christianshewitt@gmail.com> wrote:
>
> This change adds the ttyAML1 uart used by the brmcfmac sdio module in
> the WeTek Hub and WeTek Play 2 devices.
do you know which Broadcom chip this is exactly?

I assume you want to use the "patchram" userspace program (or
something similar) to initialize the HCI controller?
it's been a while since a similar patch was rejected, but things have
gotten better since then. more details below

> Signed-off-by: chewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index 70325b2..9476868 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -10,6 +10,7 @@
>  / {
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;
this can be dropped if you read on

>                 ethernet0 = &ethmac;
>         };
>
> @@ -239,6 +240,13 @@
>         vqmmc-supply = <&vddio_boot>;
>  };
>
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +       status = "okay";
> +       pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +       pinctrl-names = "default";
insert bluetooth child-node from [0] here (with the correct max-speed,
*-gpios and clock* properties for this board)

some background: with Rob's serdev framework some Bluetooth controller
drivers recently gained the ability to get the controller into a
working state without any userspace utility. if you add the bluetooth
child-node here the kernel will:
- not create a /dev/ttyAMLn
- load the matching Bluetooth controller driver (the Broadcom one in your case)
- do the "initialize this Bluetooth controller with all the vendor
specific magic" dance (toggling GPIOs, loading firmware from userspace
via standard request_firmware, etc.)
- provide you with a ready-to-use hci0 interface


Regards
Martin


[0] https://elixir.bootlin.com/linux/v4.18/source/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
