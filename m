Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8588C676C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB1B20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWGDWAhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB1B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJHTDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:03:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35601 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeJHTDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:03:22 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so15604449iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PDpU3XUg48EpaE940h0BvdhNsLFeyjkcqhToUXvJT4k=;
        b=dWGDWAhds3NHsmJXF3VkQwK7PJexiHDt+Vfc5ImdOUyH2ijhhRnjBtl+ddsL/gkUmr
         g7EvHHongS6ji5YuRgYTtvwsFamYjXub385q63TOtuBH4JWyO2o0VV3fmSBInW1FFBMt
         rGAdKV7aNG+a6/6Xr4Dkytyfg2FLJfFvDQxIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PDpU3XUg48EpaE940h0BvdhNsLFeyjkcqhToUXvJT4k=;
        b=TV9oV7z8E2Se81JHeDNZo9YR2YGTbWDPUG0Z0VeUrYkKQZv0Ihn1Q+DlnRsXB2Dud2
         4GmG+q8e0dXpU0qFv2yEaBRA7AAtEUcjHs0smNbDSQcihdQYqiZmo2bPU2GoBR7HGrax
         VkbOZmV20gj8Z00Z72wYbGdSkkvFGs8p59KEaFnky8GdaKTJK59ls7IPQtPNSeKWF9bz
         pwS7+PW2Hjzb/vZXe2yPz0mzMfsaks4P4w9uWL1VAgDilocfyk/mGud51Kp5LeNyeSHT
         OPdHg5ejYnQ3bCH/Ao/54uh+430s3SuICjBjPWxFzGS26YlX7/ZaoOosA2U9GJs00cVC
         WmZA==
X-Gm-Message-State: ABuFfoiOEDCkMGV83WJihL7NBo0G2GRB1hBZZhU/ff96a7WzIkf3Eh6W
        bH1EN04vp+aHeHwKSt42VmVyGgFWZ76UUpEtNeFtPA==
X-Google-Smtp-Source: ACcGV615NutFt/dG4Nz9yTlIUGvlxWguCECjWKIF8LKihld3UskTriCzAKiOVN9XczSeJaD0V3FSr8u5sEaRK07pkdw=
X-Received: by 2002:a6b:8fcb:: with SMTP id r194-v6mr4638165iod.266.1538999521050;
 Mon, 08 Oct 2018 04:52:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 04:51:20 -0700 (PDT)
In-Reply-To: <1538188195-3608-1-git-send-email-chaotian.jing@mediatek.com>
References: <1538188195-3608-1-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Oct 2018 13:51:20 +0200
Message-ID: <CAPDyKFoS82cFE=C0OXLa3rULET7QsMW0dOt0B_jJ61C6G2bPGw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: dt-bindings: add "bus-clk" for MT2712
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 September 2018 at 04:29, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On MT2712 MSDC0/3, HCLK/bus-clk need gate/ungate together,
> or will hang when access MSDC register.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> index f33467a..f2208f4 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> @@ -22,6 +22,7 @@ Required properties:
>         "source" - source clock (required)
>         "hclk" - HCLK which used for host (required)
>         "source_cg" - independent source clock gate (required for MT2712)
> +       "bus_clk" - bus clock used for internal register access (required for MT2712 MSDC0/3)
>  - pinctrl-names: should be "default", "state_uhs"
>  - pinctrl-0: should contain default/high speed pin ctrl
>  - pinctrl-1: should contain uhs mode pin ctrl
> --
> 1.8.1.1.dirty
>
