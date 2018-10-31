Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8ECC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05002082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5wwlS5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05002082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeJaWhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:37:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46087 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbeJaWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:37:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id x3-v6so14838517lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qyvys34vf1qIimjNCAwNOfxOhRg3WtfSWWYeB3pwWRg=;
        b=J5wwlS5sUPZceaxMdPGfKZpP9yF8JALB2L4QRk/8da3c++1H/xjn9nQxUtp89y+uBY
         6fN/87PhLPgWlOtfScBM6FgPr3jnIQI7LZxNV1tAC3Wg410d/yIo/oTP6hrGlt56yAUZ
         mFLTixgb3OAi3Bbg5mYcxMMKzrmA58WmQEpIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qyvys34vf1qIimjNCAwNOfxOhRg3WtfSWWYeB3pwWRg=;
        b=ZSCCwKM2ExK3un4vFIxaIOCj812/G9W9kV7ozfIvrXgMhkJFk5dCiO2WZ7mF3707Uz
         aOACTLwNX9ifcDceCVytlYesL0Vq31spzLHpFUnKWdgJ9QPJ7hvBSK2iP4IM7Bi3FKWF
         bUsIrVLOZPTUINfbdC0oN1hPCxysRHq97VPLXIczRsg3/STjNIlW6mu/c3t0+1wnNkUL
         +BUpv3NBRlZ4EzosdD4ockFfW9iMchHk81ETcPCq2PBj5tGl79w0llAmmBgcn2S4oddz
         bbwwTcI5xA8yWxrzu+bfQ+sLZVIjsd1anNzvferoS6aaAo4/X5LY8qhDgM5/G7JoQvBE
         ukBQ==
X-Gm-Message-State: AGRZ1gLW3kAd68e2mtQrDpeedddCy/kWK4zXHKl2vVKqDFYQNE+qRd8h
        khLAw95D2r8GSshJfkLm3o0bzqWA/gwR9r7FrD6qGQ==
X-Google-Smtp-Source: AJdET5d3q3yT6ZDIWLDmTLyE/TXWdCkXqOKgZqQkJ0uP9bZFmz5fken0DUvm8/prmLVby/fWwuYyOGeM8D+VCjUtapo=
X-Received: by 2002:a2e:1510:: with SMTP id s16-v6mr2064317ljd.4.1540993148258;
 Wed, 31 Oct 2018 06:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 14:38:56 +0100
Message-ID: <CACRpkdYThcGjdV9Ezs4qMr8K6_jH40SDUgt0Tps8d+_4sSESyg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        ezequiel@collabora.com, Xu Wei <xuwei5@hisilicon.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Gross <andy.gross@linaro.org>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Koen Kooi <koen.kooi@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:43 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> This patchset standardizes the onboard LEDs on 96Boards by maintaining
> common labels and triggers as below:
>
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity (onboard-storage)
> green:user3  default-trigger: mmc1 (SD card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
>
> This standardization is required to provide a common behaviour of LEDs
> across all mainline supported 96Boards and also making it easier to
> control it using an userspace library like MRAA.
>
> For Rock960 and Ficus boards, the LED support is added in this patchset.
> Rest of the boards are converted to adopt the standard.
>
> Note: Since there is no UFS trigger available for now, user2 LED trigger
> is set to none on HiKey960.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It makes a lot of sense to try to unify the userspace ABI so we get
some kind of order here instead of trying to counteract it with
per-device kludges in userspace. It definately makes things better!

Yours,
Linus Walleij
