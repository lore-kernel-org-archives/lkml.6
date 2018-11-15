Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F968C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5925D2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcJWK1OQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5925D2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeKPFaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeKPFaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:30:15 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEDC22133D;
        Thu, 15 Nov 2018 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542309671;
        bh=QXI5C+Ye96jf+48pvLdlRLxhqGorVauDUBYJEJI70cw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lcJWK1OQA0BWc48BPDs82bo4mwCrKtJxaI3KmD8Dy9Nuxb6drUGyJqADZD9QUT23X
         WqIA/uC0OiQ5KLsd0zmGh4v5Ei9BCouAiCnglLYUcYiAtEOhbU4cC5a5EOnBQld/HJ
         hE/MZATyZViKGbUdDsaQGvntqHahDSn+wiF0R5gA=
Received: by mail-wr1-f54.google.com with SMTP id u5-v6so17140349wrn.9;
        Thu, 15 Nov 2018 11:21:10 -0800 (PST)
X-Gm-Message-State: AGRZ1gIXKGczl50bRjOcfM2FQX7mNsF7AAqdYxAG5U2cf9Z+un+dIDLm
        ytinnqNFnaeUQqXiyXXCaSa8wsrZoWZxtq3XwxE=
X-Google-Smtp-Source: AJdET5cHr7ubgspxXlNDZBmZ5cr4mmgXFD3aAqv1nCccIq8G150ZDsYGIsvPfpMaAKBhgmPgZ2eXHNEmanH6HNoU3I0=
X-Received: by 2002:adf:8989:: with SMTP id x9-v6mr6926815wrx.184.1542309669469;
 Thu, 15 Nov 2018 11:21:09 -0800 (PST)
MIME-Version: 1.0
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <9043534495d49c532bdb0b904344b77faeb41359.1542074855.git.ryder.lee@mediatek.com>
In-Reply-To: <9043534495d49c532bdb0b904344b77faeb41359.1542074855.git.ryder.lee@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 15 Nov 2018 11:20:58 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzoko6ahpzLvDmBiEPLYmdhjtHeJXYDiFamZWiUYpcC9MA@mail.gmail.com>
Message-ID: <CAGp9Lzoko6ahpzLvDmBiEPLYmdhjtHeJXYDiFamZWiUYpcC9MA@mail.gmail.com>
Subject: Re: [resend PATCH 2/3] pwm: mediatek: add pwm support for MT7629 SoC
To:     ryder.lee@mediatek.com
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, weijie.gao@mediatek.com,
        linux-kernel@vger.kernel.org, cheng-hao.luo@mediatek.com,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 6:09 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> This adds pwm controller support for MT7629 SoC.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 9400c41..4ed95e5 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -292,11 +292,16 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>         .pwm45_fixup = true,
>  };
>
> +static const struct mtk_pwm_platform_data mt7629_pwm_data = {
> +       .num_pwms = 1,
> +};

How about adding a property for the num_pwms for the PWM controller?
It at least can help stop adding a new entry for every SoC with only
differences on PWM number.

> +
>  static const struct of_device_id mtk_pwm_of_match[] = {
>         { .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
>         { .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
>         { .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
>         { .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
> +       { .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
