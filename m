Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB9C2245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yHJ/Jbrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB9C2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeKPFM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725741AbeKPFM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:12:28 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16052224E0;
        Thu, 15 Nov 2018 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542308609;
        bh=D4H2gd0G/Qe0GAPa1uFf3D6Igy/HWoDrMqTaYL1OR+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yHJ/JbrxOJcfGAP5AryMtXRHj66l2m/ecWG3GwaYn+yZf2ahVJGLQsk4k9byASG1i
         4f3puQg6nT+V4McEvWtVfUsJ45CJbwWX3pKl8Cf2+snSNmcnivB7a0Q/HK67YJkxEz
         rubI7h+43XBIsp4LDY5j3+cH5lUGKMKzrDjFjJjs=
Received: by mail-wr1-f51.google.com with SMTP id b13so22351448wrx.6;
        Thu, 15 Nov 2018 11:03:29 -0800 (PST)
X-Gm-Message-State: AA+aEWYLEBwvp+INoZ0rjvwaM3kPw1qG/+yUVTjf5KKXFdwrHNYCAclm
        svq3MBpB3pa/FX4qj5F8RU4NbASaQb+mZLiAGqQ=
X-Google-Smtp-Source: AFSGD/WF3UXizlB3L2JeJ9S/kdTmtwLDsuuV1rcDuRGHteeiUdQxAN4fnOZKtsONNY/fPGPgBuGc9X0i1ch3kORe6M4=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr5018251wro.78.1542308607583;
 Thu, 15 Nov 2018 11:03:27 -0800 (PST)
MIME-Version: 1.0
References: <0f5fe0d5b6a9c81b3f4395a1007ed0ba2239ae45.1541574485.git.ryder.lee@mediatek.com>
In-Reply-To: <0f5fe0d5b6a9c81b3f4395a1007ed0ba2239ae45.1541574485.git.ryder.lee@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 15 Nov 2018 11:03:16 -0800
X-Gmail-Original-Message-ID: <CAGp9LzofO3SPXcXsqj2pheKAP-fNSDupiR3WzW5_0_LDesLzdg@mail.gmail.com>
Message-ID: <CAGp9LzofO3SPXcXsqj2pheKAP-fNSDupiR3WzW5_0_LDesLzdg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: rng: update bindings for MT7629 SoC
To:     ryder.lee@mediatek.com
Cc:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        devicetree@vger.kernel.org, weijie.gao@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-crypto@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 11:11 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> This updates bindings for MT7629 RNG driver.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Acked-by: Sean Wang <sean.wang@kernel.org>

> ---
>  Documentation/devicetree/bindings/rng/mtk-rng.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> index 366b99b..ffa6a66 100644
> --- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
> +++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> @@ -1,9 +1,10 @@
>  Device-Tree bindings for Mediatek random number generator
> -found in Mediatek SoC family
> +found in MediaTek SoC family
>
>  Required properties:
>  - compatible       : Should be
>                         "mediatek,mt7622-rng",  "mediatek,mt7623-rng" : for MT7622
> +                       "mediatek,mt7629-rng",  "mediatek,mt7623-rng" : for MT7629
>                         "mediatek,mt7623-rng" : for MT7623
>  - clocks           : list of clock specifiers, corresponding to
>                       entries in clock-names property;
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
