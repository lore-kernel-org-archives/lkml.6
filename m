Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69C1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE00206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak6E5Sm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE00206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeIDUD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:03:29 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41764 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDUD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:03:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so7528342oiw.8;
        Tue, 04 Sep 2018 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=prTzGnVQO3YA1jhUIN7LaXp6jeQR+9uYgqvupWaiO44=;
        b=Ak6E5Sm31caFDEz/6DIxnXRhMrNOir4e20dhfMSo4dpl+oYxw7fwapEt0bd1dWOu5Y
         dd39rdbuhgHDin3Im2DJke/M6KP0VgK75D0efACmyb3gXBKsUJ/DPCNpcBBg4H1JTyNR
         BtiaV8AvIQXZg3kxgpk4AZ6xGo1BLZxU6T2fzQrYrur1AAw22zVPVRVlX+r4M29ks7Pc
         Y11b0Gcj2ZLUhtXspPU7SaMb3zAhZkwyogZWuC6+sAydGmZrBOyFjGOs+8CVp+W14M2U
         P0uf0KzLordxnrz7N9fCNFNlPUyYOwJz/wCFLh3S9EYTxmpYUs6tEBEMyg4DLbeLpH5P
         9ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=prTzGnVQO3YA1jhUIN7LaXp6jeQR+9uYgqvupWaiO44=;
        b=HEMu7NNmEbTzmj0QebdXPKMkhAhHt1OZbUrz+ZHHnOUuzkXT5Sc7OcUkuSOZGHBofa
         QjIBLZrB/bJBXTEVlopad8whevbIVMSsYIrwvPzJhkDOUXwq8cCJQ2tJ6ohl6ITzoo2m
         R/lR0XzGMvfX5S94vkMbUPcVh6TkAmORGzdLrWTBgEq6Cg15BlUR7I6c5Ui4btqtrTnc
         24nugVKUEvzYLkU0HlYNw2cD3Me8pXIfXmBS9gnZl1kQAHUWl613sGIBG5cAIV/J+Qqh
         CdidRsdVezQI9P5GTAFlK5og7RBXVS3Cvs7OogLN5J8Jc2hZnQ5G4eTxd1xVyMJOqT5i
         Kf0Q==
X-Gm-Message-State: APzg51BSPovWTD8w+/fG/ojRS5pASLWRN3OtiOkm97lYBEY6dTkAy+4m
        yUFeLDD3xj8avMuVXyhtYLUTYBMCi4TS4UO6GIk=
X-Google-Smtp-Source: ANB0VdbtRPw5TKZR3sN9UeZezOaxxwcbKswE9Q/L75TxFop5yi9vXx9sMNboQIkqM+R1v7R3y657TkVOosXh56Ft4XY=
X-Received: by 2002:aca:4886:: with SMTP id v128-v6mr1586931oia.69.1536075468982;
 Tue, 04 Sep 2018 08:37:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2b4d:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:37:48 -0700 (PDT)
In-Reply-To: <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
References: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com> <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Sep 2018 12:37:48 -0300
Message-ID: <CAOMZO5B26iFCY2DeBHa6_=uRT3zgdP5J+HBqzpPY-=7HHgP9EA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 12:28 PM, Alex Gonzalez <alex.gonzalez@digi.com> wrote:

> +&lcdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_lcdif_dat0_17
> +                    &pinctrl_lcdif_clken
> +                    &pinctrl_lcdif_hvsync>;
> +       lcd-supply = <&ldo4_ext>;       /* BU90T82 LVDS bridge power */
> +       status = "okay";

Missing a panel attached to the lcdif?

> +&pwm4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm4>;
> +       clocks = <&clks IMX6UL_CLK_PWM4>,
> +               <&clks IMX6UL_CLK_PWM4>;

Why do you need to pass the clocks here? imx6ul.dtsi already defines it.

> +       status = "okay";
> +};
> +
> +&pwm5 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pwm5>;
> +       clocks = <&clks IMX6UL_CLK_PWM5>,
> +                <&clks IMX6UL_CLK_PWM5>;

Same here.

> +       pinctrl_sai2: sai2grp {
> +               fsl,pins = <
> +                       MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA     0x11088
> +                       MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA        0x11088
> +                       MX6UL_PAD_JTAG_TMS__SAI2_MCLK           0x17088
> +                       MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK        0x17088
> +                       MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC        0x17088
> +                       /* Interrupt */
> +                       MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07      0x80000000

Please do not use 0x80000000. Use the real IOMUX value instead.
