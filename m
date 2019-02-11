Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E5FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB5F21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUK7X9XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfBKIVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:21:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41184 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKIVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:21:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so6999045lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAP+/QkaC/kPvD0d6Vhaj1cPtEZDAtF44P3YSanj1iM=;
        b=PUK7X9XZbvcnAXgdpuFDtpIDrpwjLcA7TAnPUkdEY+UPDT0CUCIU55KqiWttOC0pJM
         zpMRSwU2NSVK+YPmHLhNAbGjE6PSmc2Xq2o3/ULh96lol/yLCuBNig2Gd9ZFupJWxGts
         6gKaNq1tnlZlPak7R3c5tkMAeFkOO4nZKAAMof08U4Rup6Osp1yoFbukBN9amnyfa15V
         IUpb+ctuU4HL6IRC4pNW4exoYoOuQAK4yKLPdCOUryrUJS3l40yNMbfkzcZtiFgTVvlL
         krCqT38mUthOMHYq84FFCdNKSQdGLFcvzJjNl4y4uVI6qbJ+/fLe5Bk3VTzRawJqZmiS
         jT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAP+/QkaC/kPvD0d6Vhaj1cPtEZDAtF44P3YSanj1iM=;
        b=MVbuDN7W2DsDJPlBhmWokfISfTdfopmIt1Y/qPGbGu0IyQWt1MeuKEN2AzSQQpPl5a
         MkIZoq94C+AuoK8FZDH1FEDhrUKNFQmVPOk9ePiPNkkpgSMnhjTkRg/lrcPhMOAQLfpp
         ChZvG0iX+zdXj0oO+/Le3T8w6LOZasHgsL+ZacwDdKUbbCXaq5HAi5l7ndc2HwcYbQ/4
         WbImntzmH4OqQ/fzxSt01c4QuynwQhFfGsYHPw68CFn6EPzbw/M0rvtEg4igD3oe8ovS
         i6cYQSEdbfNDP4RuLl825brYCMJEVM9ohzxAaiDjXHkXRIoB3DzoHc7q4qQpaOM/Y7nl
         ZQfw==
X-Gm-Message-State: AHQUAuZxLrEeCszTu2XOjAzQK0/8RZjVjfKPHIBTmvEy/PpRqX3UWjri
        vZ2HKQaUozZ/1A/FKnKNKQYVFi6YQPFMGWyoREC0Zw==
X-Google-Smtp-Source: AHgI3IYQC9maKJWT1HSMkW62nOsngFfw9sDT7x5S4Z+L6hgFGU8dAP8Gzu8PjowSP41wpHOEaWRlGwxTBf8gfOgEGoM=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr19203143lfl.129.1549873264141;
 Mon, 11 Feb 2019 00:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20190206033239.3619-1-wens@csie.org> <20190206033239.3619-2-wens@csie.org>
In-Reply-To: <20190206033239.3619-2-wens@csie.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Feb 2019 09:20:52 +0100
Message-ID: <CACRpkdZFwG9-ap3jMe+eGDCgzG9+fKRXVEb4Q=pWasd5GUs9tQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: sunxi: Support I/O bias voltage setting on A80
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 4:32 AM Chen-Yu Tsai <wens@csie.org> wrote:

> The A80 SoC has configuration registers for I/O bias voltage. Incorrect
> settings would make the affected peripherals inoperable in some cases,
> such as Ethernet RGMII signals biased at 2.5V with the settings still
> at 3.3V. However low speed signals such as MDIO on the same group of
> pins seem to be unaffected.
>
> Previously there was no way to know what the actual voltage used was,
> short of hard-coding a value in the device tree. With the new pin bank
> regulator supply support in place, the driver can now query the
> regulator for its voltage, and if it's valid (as opposed to being the
> dummy regulator), set the bias voltage setting accordingly.
>
> Add a quirk to denote the presence of the configuration registers, and
> a function to set the correct setting based on the voltage read back
> from the regulator.
>
> This is only done when the regulator is first acquired and enabled.
> While it would be nice to have a notifier on the regulator so that when
> the voltage changes, the driver can update the setting, in practice no
> board currently supports dynamic changing of the I/O voltages.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I merged the v5.0-rc6 into my devel branch and applied this patch on
top now.

All the DTS file changes should be merged through ARM SoC, and
they should work fine now.

Yours,
Linus Walleij
