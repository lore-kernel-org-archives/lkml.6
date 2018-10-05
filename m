Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84C220652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84C220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJERme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:42:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44697 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJERme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:42:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id z21-v6so6806661edb.11;
        Fri, 05 Oct 2018 03:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dn59ahvY5Oo+NEOPS7ht0eD3KbRC2yO+tJ74054lYmQ=;
        b=OeXj2hM4HHoKm+HwTZXWET/OKeTORV9Mqvp15CFvPxu73cWn65dlTOk791TjWe/vjC
         Uj3O5CLnR5ycxMcVZtaFOaNZfg+uyTDk0SB/sqzxnbhfin4EQFTLadkUuMHlLqpuM1bv
         0AkMw5nlq9G/7lWqhG6LRpxJv3BiUkC7zlDTZlPalg2OgDPRZTlj47BKcKc0mN+4Unin
         0qyP3qP6noRQVkbcwtxPphMCB82vzyMW61+DopcyxJxtCzO7XNNV/fwCPEBj/vtvkrRb
         iaunGiX7VqCUL0k6UzT2sQGM33AYIarMeKsSNZxdlD+KbmyhSA34fB2G47sRwPOX6Ko1
         whsA==
X-Gm-Message-State: ABuFfoguHrwPRLgkwE4kfdTwi3jHkVv9UMddsz6OQytOVJDEI3InmunQ
        adWBkWP+uWBFkcZR21W52QdGmMKkdfY=
X-Google-Smtp-Source: ACcGV62c3Ol21qVAtZZJoRECv5pnQXlrnMB9beo2z4FQvjlNHIHFl1jMHhp8ggPZmCRQr583w19IGA==
X-Received: by 2002:a50:86f0:: with SMTP id 45-v6mr13414008edu.52.1538736259232;
        Fri, 05 Oct 2018 03:44:19 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id q18-v6sm1340516ejr.8.2018.10.05.03.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 03:44:18 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id z4-v6so13055510wrb.1;
        Fri, 05 Oct 2018 03:44:18 -0700 (PDT)
X-Received: by 2002:adf:c748:: with SMTP id b8-v6mr7899795wrh.134.1538736258246;
 Fri, 05 Oct 2018 03:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181004122855.22981-1-icenowy@aosc.io>
In-Reply-To: <20181004122855.22981-1-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Oct 2018 18:44:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v65qEsJ6Pn+_McSZ8Srsu3JKrfyWhKwUuQOwwOCOpBwOBg@mail.gmail.com>
Message-ID: <CAGb2v65qEsJ6Pn+_McSZ8Srsu3JKrfyWhKwUuQOwwOCOpBwOBg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 00/10] Allwinner H6 USB support
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

On Thu, Oct 4, 2018 at 8:29 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This patchset introduces support for the USB ports (both USB2 and USB3)
> on the Allwinner H6 SoC.
>
> The first 6 PATCHes are the USB2 part, and the latter 4 PATCHes are the
> USB3 part.
>
> PATCH 1, 2, 3, 7, 8 should go through the PHY tree, and the remaining
> patches should go through the armsoc tree via sunxi tree.
>
> Icenowy Zheng (10):
>   dt-bindings: phy: add binding for Allwinner H6 USB2 PHY
>   phy: sun4i-usb: add support for missing USB PHY index
>   phy: sun4i-usb: add support for H6 USB2 PHY
>   arm64: allwinner: dts: h6: add USB2-related device nodes
>   arm64: allwinner: dts: h6: add USB Vbus regulator
>   arm64: allwinner: dts: h6: enable USB2 on Pine H64
>   dt-bindings: phy: add binding for Allwinner USB3 PHY
>   phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
>   arm64: allwinner: dts: h6: add USB3 device nodes
>   arm64: allwinner: dts: h6: enable USB3 port on Pine H64

Tested-by: Chen-Yu Tsai <wens@csie.org>
