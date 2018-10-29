Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB193C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AED20664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCdxsYJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AED20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeJ2SFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:05:11 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36451 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbeJ2SFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:05:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id v205so2130353vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQuSCeL9CaQaGHFatAngeB9Vi1WQM94AuDYlcnPMtks=;
        b=aCdxsYJFAeSfkB5bysDHMQcTO2yNXt+Q40A8AlaexTVXn58KTEPL3UNx+tC7SC657d
         qcAhU1hdObOkIDkqRd7yXsNGA40uJveXSr+hxfaaTa8lFqAmqKqqrE7sDet9/nUf5V/I
         3bgLsmkuEtLvgh4FYS3PD27FhUKuX9P3xHGxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQuSCeL9CaQaGHFatAngeB9Vi1WQM94AuDYlcnPMtks=;
        b=B4yxvgtgikY++lrLtyoJo1TCMBi5RKgQ3F8UeZ6PTKKNab6eWXpNdvt3nHb21vPjHd
         ttSkeVdLLC8zW1RxvLcoBhOY3UuEz03HlXbG2ZIcpyYviDEPv9Jtdxvxz1LVMEQSFc9R
         44awx7gzlJyNEPdq2aIPeXwHAJ02l6mKIpr1It1fdgy/GAmdqPgpQ6vjC5lNUVA7al0d
         ivlPYrZF+91/Maip+P0sdlXMG4pQKUDf4g2DNiYgFsDrXbcimJSRu3Xzq8j0X2OT8Uvz
         Fd0aowXzoujYrMgUtVVuvrkg82atQ1/6os4kqfjUnf4OR5HPdLW9Wv4gRT8fbgy1ZA6H
         KdGQ==
X-Gm-Message-State: AGRZ1gJUYHmA2dGSDaM3LrteReVInkM2i/GN4Yj/L9TH/O/e3hENhcLK
        6cS+SIRdbjZK0trEFVdG8NNFkwCRrOZa4cqpiPMY6w==
X-Google-Smtp-Source: AJdET5f5tjVeimCqiAT8uYw59K1oBNUuLc1+6B+BlhHVBrJJNHI/meRSOOzpCOxZd3j5R56TBvnMDxv7FTpj4rDa2s4=
X-Received: by 2002:a67:e0d4:: with SMTP id m20mr4113140vsl.182.1540804643166;
 Mon, 29 Oct 2018 02:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181029090006.4353-1-manivannan.sadhasivam@linaro.org> <20181029090006.4353-8-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181029090006.4353-8-manivannan.sadhasivam@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 29 Oct 2018 14:47:11 +0530
Message-ID: <CAHLCerM91ukzAJZHaxXxwoHU-6mVUV+X9_y_Rs0zmybNnRJCfA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED labels
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        ezequiel@collabora.com, Wei Xu <xuwei5@hisilicon.com>,
        Michal Simek <michal.simek@xilinx.com>, pavel@ucw.cz,
        Andy Gross <andy.gross@linaro.org>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, koen.kooi@linaro.org,
        nicolas.dechesne@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:31 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> For all 96Boards, the following standard is used for onboard LEDs.
>
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> green:user3  default-trigger: mmc1 (SD-card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
>
> So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> one of the 96Boards CE platform.

You are missing a signed-off here :-)

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 46feedf7c989..35f95154316b 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -300,28 +300,28 @@
>                         compatible = "gpio-leds";
>
>                         led@1 {
> -                               label = "apq8016-sbc:green:user1";
> +                               label = "green:user1";
>                                 gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "heartbeat";
>                                 default-state = "off";
>                         };
>
>                         led@2 {
> -                               label = "apq8016-sbc:green:user2";
> +                               label = "green:user2";
>                                 gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "mmc0";
>                                 default-state = "off";
>                         };
>
>                         led@3 {
> -                               label = "apq8016-sbc:green:user3";
> +                               label = "green:user3";
>                                 gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "mmc1";
>                                 default-state = "off";
>                         };
>
>                         led@4 {
> -                               label = "apq8016-sbc:green:user4";
> +                               label = "green:user4";
>                                 gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "none";
>                                 panic-indicator;
> @@ -329,14 +329,14 @@
>                         };
>
>                         led@5 {
> -                               label = "apq8016-sbc:yellow:wlan";
> +                               label = "yellow:wlan";
>                                 gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "phy0tx";
>                                 default-state = "off";
>                         };
>
>                         led@6 {
> -                               label = "apq8016-sbc:blue:bt";
> +                               label = "blue:bt";
>                                 gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
>                                 linux,default-trigger = "bluetooth-power";
>                                 default-state = "off";
> --
> 2.17.1
>
