Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EF2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F2D206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfgDFK0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F2D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeH2M3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:29:22 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40575 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeH2M3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:29:21 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so6176813ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIum/HYC0IgmBx3kBSey5YVJ3phOVnPCokiE9CYm+9U=;
        b=hfgDFK0rpPZni8mHJ2LneyWzZS9EO238XMZl+MX/T1bh0lgz6s2eUtwohFPfXNJ+nQ
         rRts5CAP5MIdCLe/c/gUaP/ko2Uqu4cwZ/VMPeaSXUGx8VtVtVVU9H+e21ZZXXcR3p9S
         IGyL/4vPuMuDR5iAdZEel8Id8VsUaUoXrxcfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIum/HYC0IgmBx3kBSey5YVJ3phOVnPCokiE9CYm+9U=;
        b=PQ7e2y5gurBZwA0u75KaDajxeqeutxP7SCbypsNCWpInKAtZ6agtF2Aaqczh5SdUOS
         wr2gpMqS1AeVDsOvc0IfePYJIsMzwLFePNxGXDZ+tbMl/v5+r511rBIeBhvHEIRkW2Gs
         wrORVkaFPPu8I0enSo8IS/evdBm194BVLR+gyTpN0AilbT/64hY/knVFmxMs14jEu9oG
         rhu2PxYs8posZn2jB+C7LfV9j/Qkcnt84IlAUwUN0ozl4FQ7n+9v1pNAmwLx2OX2PMiL
         LlvpMabMHzjgT1PuoKQI0hfqrYEuulcnskGx+++S+SBUyn2DS84eBwfYbaefnTS3ekgA
         MfqA==
X-Gm-Message-State: APzg51BPkuESAVjW5rvTJy8dlRh5zffiLn11IXXOndtMhaJZZ3JQGLOk
        0MF5dzQkPQT3bp/wdK7l+9mDXielZJkpiQNumCtNReU5vmk=
X-Google-Smtp-Source: ANB0VdbfPMS72GFAuD8X+6Dk8HOpzJ5c91+t095d52ytbgVXhuQkNuSgV/U8dl5j/iMdYMAP+lEvO2Khrt7o9R7w2tw=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr4732915itc.16.1535531614309;
 Wed, 29 Aug 2018 01:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180807020634.18182-1-yixun.lan@amlogic.com> <20180807020634.18182-3-yixun.lan@amlogic.com>
In-Reply-To: <20180807020634.18182-3-yixun.lan@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:33:22 +0200
Message-ID: <CACRpkdZtzNhdY0OsT3M3YmMfHFkk5frrnf+dn=d5KfvXahRo6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: meson-g12a: add pinctrl driver support
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:07 AM Yixun Lan <yixun.lan@amlogic.com> wrote:

> Add the pinctrl driver for Meson-G12A SoC which share the similar IP as
> the previous Meson-AXG SoC, both use same pinmux ops (register layout).
> A new driver is needed here due to the differences in the pins.
>
> Starting from Meson-AXG SoC, the pinctrl controller block use 4
> continues register bits to specific the pin mux function, while comparing
> to old generation SoC which using variable length register bits for
> the pin mux definition. The new design greatly simplify the software model.
>
> For the detail example, one 32bit register can be divided into 8 parts,
> each has 4 bits whose value start from 0 - 7, each can describe one pin,
> the value 0 is always devoted to GPIO function, while 1 - 7 devoted to
> the mux pin function.
>
> Please note, the GPIOE is actually located at AO (always on) bank.
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied for v4.20.

Yours,
Linus Walleij
