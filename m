Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B11C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B1820878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICCPNvnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B1820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJCJLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:11:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36869 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeJCJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:11:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id o13-v6so4038681otl.4;
        Tue, 02 Oct 2018 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgNth7F8j22jNs/wGFXTYdZWqLqH2OWQ1F7HQIKcbMc=;
        b=ICCPNvnwclD724Jtbk5TKrcuQZ4DcoxOcG0/7rxY+CaAupaCI+Dn6RLIXTTLcYtyxv
         KpyxaP2HmIs+YUiKnIat0ndJtbkmfdaOzuBPACSJ1TOTQcCSqmwcoBpVbo1CXpE5kuSZ
         t2eGCIBCr7PHX0jbE0AcGRfi9gFeVbnIL/QAxyDkevb2tPUwvAHNDoQljp3wNM1Tbqh+
         hss7HpHJYpfjn0p9Z+0xnyrA3aW49dbp+JHz7Zb5Niu0uE2FACZ8zlTOjIUDrvz/PS13
         5uZ5Yer6B7VuRuXBZBMakTZ66xhzyk4muJA4BAXjl6AN49+w+f8O8bAmc9bLT1Tf3fKt
         jmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgNth7F8j22jNs/wGFXTYdZWqLqH2OWQ1F7HQIKcbMc=;
        b=ubdulcSPNBkwnWjxjRrpjaJJbcYEQ2n5CbdNxQCtfXfzdRw1A58lgmRe3o2/TEUT1d
         pmPdYsxSGQ4CHEVqPAzFC1wG/fzu9cGrwBG4iwW0wRfkMylLp79VfR9gPoUhBisPc3IQ
         gArNE7ZQJddUfvspkIclUZfVYN/T4ErB6Le8z1wIRburZJkezgMqZmKwmjf80TgDg2uT
         YmSNRkBCLHL5bzFuzaGg/ffNYujaSqGcWIZBhUs9nxRNk0fg6B8gK5NPqiRgm/HUk8TH
         Vq0dy2HTEbeFucRTCuN9Pe70YF2MjdXOnyrSy4syu4fWXGZK7gIcmiCl2vU5+kMJ54jt
         aSpg==
X-Gm-Message-State: ABuFfoh7D/yE/SZ6YPeYsnyf+SphXJ/XqGrVirCk2D3o3v3zh865YwM2
        aWIhPDC+0g3wU7i4iuoCCpA2+kaJoo6nNgauQBg=
X-Google-Smtp-Source: ACcGV62jNA8SUMREReRK07buIkMMGzk7BcFE2Lj0S3GSwcNHeyIRMqV9lB+lf0deJyt2auC83R+2ceMUh+MV9vsYvT0=
X-Received: by 2002:a9d:9fc:: with SMTP id 57-v6mr3462915otz.225.1538533503247;
 Tue, 02 Oct 2018 19:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <1147be600733a1bcde194f7df61866019f34a531.1538504729.git.leonard.crestez@nxp.com>
In-Reply-To: <1147be600733a1bcde194f7df61866019f34a531.1538504729.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 2 Oct 2018 23:25:22 -0300
Message-ID: <CAOMZO5BcVXZx5YKoKxCTK5uJMX8q=5uRiZsyX6sL=QcYjKkhNw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Fix enet phy regulator
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonard,

On Tue, Oct 2, 2018 at 3:42 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:

> @@ -371,10 +372,12 @@
>                                 MX6SX_PAD_RGMII1_RD1__ENET1_RX_DATA_1   0x3081
>                                 MX6SX_PAD_RGMII1_RD2__ENET1_RX_DATA_2   0x3081
>                                 MX6SX_PAD_RGMII1_RD3__ENET1_RX_DATA_3   0x3081
>                                 MX6SX_PAD_RGMII1_RX_CTL__ENET1_RX_EN    0x3081
>                                 MX6SX_PAD_ENET2_RX_CLK__ENET2_REF_CLK_25M       0x91
> +                               /* phy reset */
> +                               MX6SX_PAD_ENET2_CRS__GPIO2_IO_7         0x80000000

We should avoid using 0x80000000 as this relies on the bootloader
setting the IOMUX.

Please do like this insted:

MX6SX_PAD_ENET2_CRS__GPIO2_IO_7         0x10b0

Then you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
