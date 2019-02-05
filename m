Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C852175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSHrv0jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfBETA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:00:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46068 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfBETA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:00:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so3807979ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ii1zkpJMnUP4gV1GDZFzp7asIhaprUu1dNgN/0w9hY=;
        b=hSHrv0jlbQxfkkR+ZTsf1C/QyvKqgbBkz8drQzZnTF4AfCoIAOdm+GoZEdFd7SbypM
         UG+fk99FditjoHSwikN2qKergCEb9HWHc3mPT9FnG/XOz9/Q2bNj/EF50x3bfhZVireC
         x5r/K/1MCZF4QEoACZ3qffJDyQRy9EWJy3u4SfUK1L+c4KXy/XnmaFKyxEOsH/xnks+k
         d46vCCE+JX57og7oEX7wxOUycSJ6L4p6yX0TzlnBRiLq0PVRqF+rRE0S+EMOm+/WmZRs
         xlM9PSUcBuX/4EnEn6nm6GEGaqJSmO/N7cR6jQbmuEfB0JYj68InlsY4e11q8r2ejCLK
         I+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ii1zkpJMnUP4gV1GDZFzp7asIhaprUu1dNgN/0w9hY=;
        b=N6wYfTIzTV/DT23laAvxEhERpEdBJctWKvnIpn17hA8PxOz4EByFtbHRqSZLIKdy4g
         X1QdR9inWmOEZGKU6EnrXcD1t2Bgyk+851GPFuc3ncwSqMN8ukth3yDfFqq7O79DLGgV
         +h3n+tSfZIes44cvRoKGitBFwANyrkaPGwYcyAqMAV6Y4dIiKqCuUsOyO+cxDcYRBCcR
         kr6TZHx6whySi7SfU87S+sCmjpfeUouvjhPT8uwXdncvsXmXNTGsUU0S5M69hFfSv+P3
         uAVojUaCYtLvpxLIzOrLro7fAxDaseZ9wfTw148v4CKq18QpKFyyAJ8xZ8SOvWJHRX9x
         I57w==
X-Gm-Message-State: AHQUAuYrqscKcMm7aS9DuqD4xQY+VMrBVJC9SeAsdYE7ctqT0wru07A3
        tkDYOjVJpnnpzxc3JWTDrtc2SfVvAWdlac1elRY5vg==
X-Google-Smtp-Source: AHgI3Ib+ob7GlrP05cPcePXjRO1T3vArIJCAAT72qlUnxxqX8WgwX6UmHhNISqA0qOSCs44u6iSUSN3VzHK4WoKuKR0=
X-Received: by 2002:a2e:8087:: with SMTP id i7-v6mr3802701ljg.179.1549393255057;
 Tue, 05 Feb 2019 11:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-8-manivannan.sadhasivam@linaro.org> <20181221023554.GB3233@Mani-XPS-13-9360>
In-Reply-To: <20181221023554.GB3233@Mani-XPS-13-9360>
From:   Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date:   Tue, 5 Feb 2019 20:00:43 +0100
Message-ID: <CAP71WjzWiCg-NXDnh58N-5O7kvNj+DDndSK04DeoPxFE2L8W0g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: apq8016-sbc: Standardize LED labels
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Koen Kooi <koen.kooi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mani,

thanks for sending this out, it should have been just like that in the
first place ;)

On Fri, Dec 21, 2018 at 3:36 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 03:12:45PM +0530, Manivannan Sadhasivam wrote:
> > For all 96Boards, the following standard is used for onboard LEDs.
> >
> > green:user1  default-trigger: heartbeat
> > green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> > green:user3  default-trigger: mmc1 (SD-card)
> > green:user4  default-trigger: none, panic-indicator
> > yellow:wlan  default-trigger: phy0tx
> > blue:bt      default-trigger: hci0-power
> >
> > So lets adopt the same for APQ8016 SBC (Dragonboard410c), which is
> > one of the 96Boards CE platform.
> >
>
> Hello,
>
> Any update on this patch?

Reviewed-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

>
> Regards,
> Mani
>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > index 46feedf7c989..35f95154316b 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -300,28 +300,28 @@
> >                       compatible = "gpio-leds";
> >
> >                       led@1 {
> > -                             label = "apq8016-sbc:green:user1";
> > +                             label = "green:user1";
> >                               gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "heartbeat";
> >                               default-state = "off";
> >                       };
> >
> >                       led@2 {
> > -                             label = "apq8016-sbc:green:user2";
> > +                             label = "green:user2";
> >                               gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "mmc0";
> >                               default-state = "off";
> >                       };
> >
> >                       led@3 {
> > -                             label = "apq8016-sbc:green:user3";
> > +                             label = "green:user3";
> >                               gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "mmc1";
> >                               default-state = "off";
> >                       };
> >
> >                       led@4 {
> > -                             label = "apq8016-sbc:green:user4";
> > +                             label = "green:user4";
> >                               gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "none";
> >                               panic-indicator;
> > @@ -329,14 +329,14 @@
> >                       };
> >
> >                       led@5 {
> > -                             label = "apq8016-sbc:yellow:wlan";
> > +                             label = "yellow:wlan";
> >                               gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "phy0tx";
> >                               default-state = "off";
> >                       };
> >
> >                       led@6 {
> > -                             label = "apq8016-sbc:blue:bt";
> > +                             label = "blue:bt";
> >                               gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
> >                               linux,default-trigger = "bluetooth-power";
> >                               default-state = "off";
> > --
> > 2.17.1
> >
