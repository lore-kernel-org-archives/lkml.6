Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33386C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC5021907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMcscsj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBHAuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:50:44 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37857 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfBHAun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:50:43 -0500
Received: by mail-ot1-f41.google.com with SMTP id s13so3237106otq.4;
        Thu, 07 Feb 2019 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVX8rr1eEmYNnSCBWoFDkJxWT8KNaY8PcA/mXMC8Mow=;
        b=QMcscsj5XAIQYzV0LeNxRBsmYQQP4tN7MoHmLzjFIIrvM6SP1oc/+gAu/VOetWxCLb
         cwjk34nEeHq0Se+51Pt4r5GJZGWEze3EoAe/Jco9WslUctu7Eeg50WqMeIdEUypxIZsV
         bIVFuA9wbyYW0Cfw0D3iwlMS+1UmR2QNsYJBMS0sEqes/oEfbY1K2DI9sLfRS0NdnxSg
         ZbioWYx2LzrnKaZSs6R6GMUTmR7odxhojBEMthVhD1fZ5CCZUZvWho/c+/2OZFkN/HgH
         ws72H4qecgSU6XK2Mynw7e504OKm4ETr6kocdSR5ec0eALAJz7oYlnOYJbjIcsE9dRIE
         BnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVX8rr1eEmYNnSCBWoFDkJxWT8KNaY8PcA/mXMC8Mow=;
        b=fkjwvquLkXHPrcN76OjkyLQqQZiey3NO/W0RC543jDTFyI5Dyn08nbDKG6y0CXvagm
         ln6xMbQNl6nqurGBCmdl0LCUcNpkADufZByQpFJsJ7F0QV3xayYlHvjpH7juaqbDpt1L
         UKUfRa9iJeL+WbK9Hca8TbUlgeOFCF85kc7idxeU3bRzCDqs9MnZ8PTUyrntZ6iKAKna
         yg8/u7QUezfAwJkr/InUV4/VB+5XQFjYLznrwSER7Bq5mVPjOpESjEDqunk1yhnuV8Gf
         Q3eDOxWS9bSbs3R4kpk+TCL3r/ryLBeZyr6uxWfTbSTf41Y2dsnGoXImWj3L1a2+0rzZ
         XNVA==
X-Gm-Message-State: AHQUAuZGkl+SzKUEVB9ZQMYslmbQbGdlxR1xcFjwnwrBRY9YlgcpemjC
        p/fpe5RktAbyx1BjBNMMBcf6f92waT/oxFkiZDA=
X-Google-Smtp-Source: AHgI3Ia18v7BZWfEroKirwRuuwATIf7BhF7uBIMxN/YqS1Y2ohYTCIza0NTPqB6WaUeWNHhlx24HPaRhmra1edWEoXs=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr11120598otp.225.1549587042164;
 Thu, 07 Feb 2019 16:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20190207225211.GA17552@latitude>
In-Reply-To: <20190207225211.GA17552@latitude>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 7 Feb 2019 22:50:28 -0200
Message-ID: <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is disabled
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Thu, Feb 7, 2019 at 8:52 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> Hi,
>
> I'm currently porting mainline Linux to an i.MX507-based board
> (preliminary DT here[1]). Recently I've enabled esdhc1 in the
> devicetree.
>
> However, as soon as the mmc driver (sdhci-esdhc-imx.c) disables clk_per
> in sdhci_esdhc_runtime_suspend[2], the whole system locks up in some way.
> Booting with CONFIG_PM=3Dn "fixes" the problem; commenting out the
> offending line in sdhci_esdhc_runtime_suspend lets the system survive,
> but leaves the MMC controller in an unusable state (of course it's not a
> proper solution anyway).
>
> I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
> unfortunately, the i.MX50 reference manual doesn't have the table called
> "Output clocks from CCM".

Please check Table 5-10. CCM_CCGR3 Gated Clock Mapping to Target
Module from the MX50 Referene Manual.

>
> Does anyone have any ideas or patches that I could try in order to
> narrow the problem further down?

Does the change below help?

--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -102,7 +102,7 @@
                                        reg =3D <0x50004000 0x4000>;
                                        interrupts =3D <1>;
                                        clocks =3D <&clks
IMX5_CLK_ESDHC1_IPG_GATE>,
-                                                <&clks IMX5_CLK_DUMMY>,
+                                                <&clks
IMX5_CLK_ESDHC1_IPG_GATE>,
                                                 <&clks
IMX5_CLK_ESDHC1_PER_GATE>;
                                        clock-names =3D "ipg", "ahb", "per"=
;
                                        bus-width =3D <4>;
@@ -114,7 +114,7 @@
                                        reg =3D <0x50008000 0x4000>;
                                        interrupts =3D <2>;
                                        clocks =3D <&clks
IMX5_CLK_ESDHC2_IPG_GATE>,
-                                                <&clks IMX5_CLK_DUMMY>,
+                                                <&clks
IMX5_CLK_ESDHC2_IPG_GATE>,
                                                 <&clks
IMX5_CLK_ESDHC2_PER_GATE>;
                                        clock-names =3D "ipg", "ahb", "per"=
;
                                        bus-width =3D <4>;
