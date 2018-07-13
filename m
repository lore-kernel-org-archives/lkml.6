Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7FEECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E68208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORYW5W/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E68208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbeGMSOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:14:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39298 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbeGMSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:14:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so63739183oib.6;
        Fri, 13 Jul 2018 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GuLGPlYvO4+XGSSMRm5lDFTWkBcr9elu+iuxM2z2FWI=;
        b=ORYW5W/q58+VKGgHGqSrkhrryw/KzZ9yGGtuZ6Z68HmO2oclbdHPJbFxjcDia3W1DQ
         ovaBN4S7fPp4Yz0LNmpFt6ZXOPNZjUSln5U8u9mQX3vwz1EAMGk2pXvjv0oHLXH/31ek
         SDLjtggqkVeprsWZgZb40ClcVFATUljr8YBXEmwZZ7vXIuXClJXtWO7azugYowt3c3vg
         xaqy78lSi9JSjdmlbiSjxWvzfUkMZ5yqplxc0mYVcbk1jEquqOsswQ4IMn0fc0XLAuEx
         t2O5kOELapQ7SHUZdN/iWkXqZZ0iw/ILmqqCs7l9at4wAb5Zwpl5nL0VzG7S0EBwx9vd
         83qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GuLGPlYvO4+XGSSMRm5lDFTWkBcr9elu+iuxM2z2FWI=;
        b=kGyUj5pH+mYz990UXvy87eQqRjJJ0jucoy0Vb0BUjwBKyLTL/5y4FK7tpQ2wCve2MY
         l5Wzq3qTQg06TKwJU2HII3Fr5zglISrwun9q+3fz2D7HChNi3/F082efDNtiHDlzF7v8
         PAIRD06NCEYfXb9UJ8sZt+KJSx79up40WLQNsP5iDjhlEIityLYXuw/l8froFRvgGd5w
         Xt0PHMMkxRX/YvUS8V2RYZr9Lz0KvRc3CuCO9eOTqFDMIotoaYPWAoxAa/5QwEBK4TeS
         StyDlFfDP3y0HgilFjiRMjLYTr6d17/xixR5RXOq25QAqvnRJmD7C95XXZPm01FkHVAG
         NHKg==
X-Gm-Message-State: AOUpUlEqFjfVVtl9f592faftilJibRa4EjuuyVB9uOEduHlbJ6Y3TR5M
        4C9r27cnAMyIuv01UxwB7VUIJYMBD9VsWn1xnHE=
X-Google-Smtp-Source: AAOMgpdtokxhF5V7j5GJoCNIh22GU17COzSzVIG39NNR+l2pBm4mycTyswbx7VJiRzIf3+xR8CcK93D+iZ/GI++m9Og=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr8565547oif.9.1531504753410;
 Fri, 13 Jul 2018 10:59:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:59:13
 -0700 (PDT)
In-Reply-To: <1531468530-25667-1-git-send-email-Anson.Huang@nxp.com>
References: <1531468530-25667-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 14:59:13 -0300
Message-ID: <CAOMZO5D2HiWsYYKUXV-7srXwvOBQE487ARs8J3=hvYpXcqm3TQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Fri, Jul 13, 2018 at 4:55 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SL EVK board, the MX6SL_PAD_KEY_ROW5 pin is
> used as lcd 3v3 regulator control pin, need to make
> sure MX6SL_PAD_KEY_ROW5 is muxed as GPIO function
> for controlling lcd 3v3 regulator.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index 50bdc65..1294fba 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -283,6 +283,7 @@
>         imx6sl-evk {
>                 pinctrl_hog: hoggrp {
>                         fsl,pins = <
> +                               MX6SL_PAD_KEY_ROW5__GPIO4_IO03    0x17059

You could add a specific group for it instead of putting it inside the
hog group.
