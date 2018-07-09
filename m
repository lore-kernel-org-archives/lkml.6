Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8493C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 02:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEAC20883
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 02:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEAC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbeGICwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 22:52:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46137 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754379AbeGICwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 22:52:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id r17-v6so12695849edo.13;
        Sun, 08 Jul 2018 19:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GuhT12H8tdJ9wu9wPwvbqoxeqNHH2m+3NbNgjaxjsCk=;
        b=IuOd8vff+Jx0nzX1dJmFRDBhfW/yALh4qWyLiFVnabDnoLY8AsaQghC40gQJZFhktv
         s03WA1XskNu1nV/Ay9BdZr3eM9EUHkRhKdPx1itTY6V3vdYMnmNidGf17OmAVOL1aWOK
         PwiIPaXcPUlvC6qa98VuauMZdDvp76/5SizO8CMHHbaGN6GSEZjpCSe2qQLWlUAcr2CO
         d5eVkzMUljKR0Rb3/0PaO4WmE/onJkjYMGIvtJLr3k6A4XEqn5WcKUGnaX/V4Gwiy/9p
         owcftkZzYZ6AY7OD/UO8m0Yobd/KO7seqTkEkTvGl4OQek7PDqvmHVQaTlLA9/lFpH+E
         4Q2g==
X-Gm-Message-State: APt69E3B+QG9iZHevgS/vTh9SB2f31b/8O3BpNqBktkjlzoLdzSYHvII
        rQCZHuU1j/vRGqAmV7NtQ2o/GbKA
X-Google-Smtp-Source: AAOMgpewAB089X4LEa6WI1N1FaRzJckp/xb6JjjbXDhYpRfEgt7zEMwe1Jjufc1yQaTCS+pvRP3XbA==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr20833550edp.7.1531104742001;
        Sun, 08 Jul 2018 19:52:22 -0700 (PDT)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id z4-v6sm6669923edi.90.2018.07.08.19.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 19:52:21 -0700 (PDT)
Received: by mail-wm0-f48.google.com with SMTP id s12-v6so19574503wmc.1;
        Sun, 08 Jul 2018 19:52:21 -0700 (PDT)
X-Received: by 2002:a1c:ee9a:: with SMTP id j26-v6mr10145949wmi.116.1531104741338;
 Sun, 08 Jul 2018 19:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 19:52:00 -0700 (PDT)
In-Reply-To: <20180706153805.25842-1-icenowy@aosc.io>
References: <20180706153805.25842-1-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 9 Jul 2018 10:52:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v6613vcxaA0J5L_bm=ZCU_bkCkeK-icrq_y7Mmd1+MMrHQ@mail.gmail.com>
Message-ID: <CAGb2v6613vcxaA0J5L_bm=ZCU_bkCkeK-icrq_y7Mmd1+MMrHQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 0/9] Allwinner H6 USB support
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 11:37 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> This patchset introduces support for the USB ports (both USB2 and USB3)
> on the Allwinner H6 SoC.
>
> This revision adds the USB2 support, and places it before the USB3
> support. So only the USB3 part will have changelog in this revision.
>
> The first 5 PATCHes are the USB2 part, and the latter 4 PATCHes are the
> USB3 part.
>
> PATCH 1, 2, 6, 7 should go through the PHY tree, and the remaining
> patches should go through the armsoc tree via sunxi tree.
>
> Icenowy Zheng (9):
>   phy: sun4i-usb: add support for missing USB PHY index
>   phy: sun4i-usb: add support for H6 USB2 PHY
>   arm64: allwinner: dts: h6: add USB2-related device nodes
>   arm64: allwinner: dts: h6: add USB Vbus regulator
>   arm64: allwinner: dts: h6: enable USB2 on Pine H64
>   dt-bindings: phy: add binding for Allwinner USB3 PHY
>   phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
>   arm64: allwinner: dts: h6: add USB3 device nodes
>   arm64: allwinner: dts: h6: enable USB3 port on Pine H64

Apart from my comments in a few patches, this series is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
