Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7355BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361DB2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ0yQiQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361DB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeLDVAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeLDVAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:00:03 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7DAB2081B;
        Tue,  4 Dec 2018 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543957202;
        bh=Zp40oi2zrHM9nMJJoroaalE/xCepEb9055yCnugJd2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJ0yQiQg3thq08QagSqfOxAAB3jE9BcEFJdCxvdp7yE6e3fBXFzIufP1iRmuKBLxf
         f2U7f8KQiGwrhQfGcelc88o0c3XAkvJYQdkPDKIgKdqKj0WBAiefSkysLk7GjmNX4P
         DTiGez0hvTzhtGZ8hcdbaxTpk0r1f/pxVKs6xwM4=
Received: by mail-wr1-f50.google.com with SMTP id l9so17427770wrt.13;
        Tue, 04 Dec 2018 13:00:01 -0800 (PST)
X-Gm-Message-State: AA+aEWYRcO3d73a8Vo59yX5mGQqGGUt/uTnhQwqMp/I9W/q4otmnVYz2
        OKQ9pMYXAPTUs8chsZfHXlJdKSFe5YIH1i1Qbl0=
X-Google-Smtp-Source: AFSGD/XL81VbXo4dYiMR06QTCaCKFzwrl/cRMalKqE4z3gAg0xIEX0H/VhpAkAHhGmUPng9cKETM+P46fFgH3vv/M5Y=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr19009272wru.291.1543957200318;
 Tue, 04 Dec 2018 13:00:00 -0800 (PST)
MIME-Version: 1.0
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com> <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 4 Dec 2018 12:59:49 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpBn=bdRa_jf7+R1hPm7GC+San_63ZOG7U6W3ToaEzjaQ@mail.gmail.com>
Message-ID: <CAGp9LzpBn=bdRa_jf7+R1hPm7GC+San_63ZOG7U6W3ToaEzjaQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
To:     qii.wang@mediatek.com
Cc:     wsa@the-dreams.de, devicetree@vger.kernel.org,
        ryder.lee@mediatek.com, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:34 AM <qii.wang@mediatek.com> wrote:
>
> From: qii wang <qii.wang@mediatek.com>
>
> Add MT8183 i2c binding to binding file. Compare to 2712 i2c
> controller, MT8183 has different registers, offsets, clock,
> and multi-user function.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> index 7729e57..dfde624 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> @@ -12,14 +12,15 @@ Required properties:
>        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
>        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek mt7629
>        "mediatek,mt8173-i2c": for MediaTek MT8173
> +      "mediatek,mt8183-i2c": for MediaTek MT8183
>    - reg: physical base address of the controller and dma base, length of memory
>      mapped region.
>    - interrupts: interrupt number to the cpu.
>    - clock-div: the fixed value for frequency divider of clock source in i2c
>      module. Each IC may be different.
>    - clocks: clock name from clock manager
> -  - clock-names: Must include "main" and "dma", if enable have-pmic need include
> -    "pmic" extra.
> +  - clock-names: Must include "main" and "dma", "arb" is optional, if enable

if arb is optional, the multi-user function still can work? arb seems
like the clock fed to arbitrating bus when multiple users are
accessing at the same time.

> +    have-pmic need include "pmic" extra.
>
>  Optional properties:
>    - clock-frequency: Frequency in Hz of the bus when transfer, the default value
> @@ -27,6 +28,8 @@ Optional properties:
>    - mediatek,have-pmic: platform can control i2c form special pmic side.
>      Only mt6589 and mt8135 support this feature.
>    - mediatek,use-push-pull: IO config use push-pull mode.
> +  - ch-offset: base reg offset for multi-user.

add a vendor prefix if the property is vendor-specific one.

> +  - mediatek,share-i3c: i3c controller can share i2c function.
>
>  Example:
>
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
