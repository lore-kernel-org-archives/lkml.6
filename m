Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A14EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AE02086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SRTn6jY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AE02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeIJXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:25:55 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46561 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:25:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so42048831oie.13;
        Mon, 10 Sep 2018 11:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acTTCjmflRwKo6VDIuZ7RVQ9xomEVCvgh46cn9VsqrI=;
        b=SRTn6jY53/3RV7oSIpPVXgpZmWj6EhiJSswcmJiB2tiwZVnx2ICODh8QFyztrQKObA
         HSsUNQd4khNi0e7fO+K/PBTK10FCuS457RVuOrwlzUMCvv/IWzAT47+/36knl2Zrxezx
         UaJ9JEuTgtBk9KpII4/1D5SUIM3JJqTLXCxyc+hrNyRQItdkL3rsqQxQqZ8t3qYnmfAZ
         NFhhttQKCieyz6mcjwMr85oicyRkrnd9YCBugM4KZiaJ9itNflA8kqLAiw0Tq2SmIcn2
         Dp2q0h6f9ka5FQ/ChFXFPnpAzpmN1IyFO5Otkt8pP3MDoPYrpclALscEFL2BrFkjpXDs
         +dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acTTCjmflRwKo6VDIuZ7RVQ9xomEVCvgh46cn9VsqrI=;
        b=UIK0uBNEGc19wofgZnw46g5Mk8hM9N5WfM7N514QQA6cGl3w7PH7AbXMfwkQSttTIa
         8xFozTHAY1uPHzCLqLcxYezkbfqDjJtkKR+B2mpOzOagP+22rQBG2E2SU5TDv73I41a/
         K8edjhQSl6cIqgZWVz6HX2RvthebiUBo9cUNOGrdoQfLnDgTM0+Lylrr0GIdDArjWvZr
         U+vrQpO8YXvXXfs36/qshX67ZGDq6PlCa4mmHUlN04zuS5bpQjCE6mFQ/C0soIrdryHW
         JSXAZBP4/i9fYMqQIRCO9EK/MJ09asHRQBeYr0f6F/D8IuGUthNXaZW4XmD1N7DlJr47
         Lncg==
X-Gm-Message-State: APzg51DvJI33kfphEHPMxpyyMGXFCUGULfxhZsb+EPl/vTp1acPwMvvo
        yk1SvB192jkiUh4n9Tmhr04+x1Jlk28AV+gPFvI=
X-Google-Smtp-Source: ANB0VdauvQErrd4hDqaWaMhjTzqqoGby5eI4LSvEZMdIvqZccvreCM5N6dF51nrWrBsqFhI+2OFxqqCJp2+ZVxk/tqo=
X-Received: by 2002:aca:b904:: with SMTP id j4-v6mr2210224oif.89.1536604231563;
 Mon, 10 Sep 2018 11:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <1536072290-28015-1-git-send-email-christianshewitt@gmail.com> <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1536322536-53109-1-git-send-email-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Sep 2018 20:30:20 +0200
Message-ID: <CAFBinCA=sDT4mVD=ZA90SF+d84bg5HCWuv6O5uz4+dKVSxNgiw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM64: dts: meson-gxbb-wetek: add ttyAML1 uart for Bluetooth
To:     robh+dt@kernel.org
Cc:     christianshewitt@gmail.com,
        Neil Armstrong <narmstrong@baylibre.com>, mark.rutland@arm.com,
        carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Sep 7, 2018 at 2:16 PM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> This change adds the uart_A used by the brmcfmac sdio module in the
> WeTek Hub and WeTek Play 2 devices. meson_uart_probe seems to mandate
> an alias (without it, BT is not working) so this is also included.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index 70325b2..e75ace7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -10,6 +10,7 @@
>  / {
>         aliases {
>                 serial0 = &uart_AO;
> +               serial1 = &uart_A;
>                 ethernet0 = &ethmac;
>         };
>
> @@ -239,6 +240,18 @@
>         vqmmc-supply = <&vddio_boot>;
>  };
>
> +/* This is connected to the Bluetooth module: */
> +&uart_A {
> +       status = "okay";
> +       pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +       pinctrl-names = "default";
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
I have a question regarding the Broadcom Bluetooth compatible strings:
Christian mentioned earlier that the Bluetooth controller identifies
itself as BCM4335C0 (BCM4335 rev. C0)

do we need to add a new compatible string (to
Documentation/devicetree/bindings/net/broadcom-bluetooth.txt)?
if yes: should we also add a new of_device_id to hci_bcm.c or should
board.dts simply use compatible = "brcm,bcm4335c0-bt",
"brcm,bcm43438-bt"?


Regards
Martin
