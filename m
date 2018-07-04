Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD19C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A64240AD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YIVxY0pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A64240AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933867AbeGDIJN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:09:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39643 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932535AbeGDIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:07:11 -0400
Received: by mail-wr0-f194.google.com with SMTP id b8-v6so4343324wro.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TL6Jswk2DdEk8vss93A1Jl8y17AfslM7t4lNYn8J1s=;
        b=YIVxY0pz6s8OUAb7KBZtgl2MdHCi/CDPshemWc9LtpJgGf0mHPHoB1l+KqQ3Qslv/C
         IoYfJMt4ysH47DEaoZmdrCKmB8FCkquRcSkUXIzS/gNgvT50eZ+WX75W20/NmcR9R+Sg
         DUlXU27SYtYSi0N63MSbbSPqZny2OW3h1QG46XVNWSmbm0e3w8UE08KhgoRiWGkt2OBd
         1lQ4fR7UdXil3OdIgtNFzhuLs6Fraq+P4aClXcgTvbOKgR3LsaXe+393ZuWcEI+hmwRs
         nOpaVCudQO7u/tVKHLOSrNQ4aMYDvLmcimmRfvS8LgDV0RU9FkTc9uOYEHZcgJFFPi0A
         ILZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TL6Jswk2DdEk8vss93A1Jl8y17AfslM7t4lNYn8J1s=;
        b=qzvXziOK8b0wuah6KzSFlwuSRPobVEtWbcWSPYreWERCtzIwvlKAwisitRsTyCLQ2I
         pq6WuRxL9JS+Bd6mnZ4RKqhq7C1gWwT4HsW3TZnunE+6K6s1Y1U8/wp1G9fbEHa8DqDt
         rln56hL6++1dEo8diKbKwyadQaCYnaleMXH/GU+ve07GdsMjve0s+n/qTrkJm6UqlyUR
         8i80EhAg85d2Syv6zgsXrMzb0mkWM082YreN5/Ux0c/RALnhehl1sH/xGVE//yVnycnV
         DOMIeku5W7nFboEm30jOO8ni9m9np4dA5pGTcOMHqP/fF2mVpBHSxAGk4QPSFvzj6EQf
         LORQ==
X-Gm-Message-State: APt69E3ay+qxW5AkmPUDjuvAe6qQwiH0eMNQAwZ6WXStyf9dmvqHy6hX
        SdQhJyaNDDRvgb7j70h+dmRrKA==
X-Google-Smtp-Source: AAOMgpePppcOCdrdHZB96aTRvu8gv5jLMYQIBddZU9fV04AmtEaCcx4/yznnh4YfatGIchRWu7F1rA==
X-Received: by 2002:adf:9e48:: with SMTP id v8-v6mr714060wre.277.1530691630194;
        Wed, 04 Jul 2018 01:07:10 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o17-v6sm2523352wrp.62.2018.07.04.01.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 01:07:09 -0700 (PDT)
Message-ID: <1530691628.2900.216.camel@baylibre.com>
Subject: Re: [PATCH 3/3] clk: meson: add sub EMMC clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh@kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        sboyd@kernel.org, khilman@baylibre.com, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        jian.hu@amlogic.com, liang.yang@amlogic.com,
        qiufang.dai@amlogic.com, miquel.raynal@bootlin.com,
        carlo@caione.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed, 04 Jul 2018 10:07:08 +0200
In-Reply-To: <ad673997-927e-76f4-23a4-bcf28f269968@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
         <20180703145716.31860-4-yixun.lan@amlogic.com>
         <CAFBinCCFQr+_k7bkda0a3wVQdyG8DzEyim6v_OBikUifCxyVXg@mail.gmail.com>
         <ad673997-927e-76f4-23a4-bcf28f269968@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 15:17 +0800, Yixun Lan wrote:
> > you are describing the mux and the divider here
> > however, meson-gx-mmc.c has a few more clock related bits:
> > - CLK_CORE_PHASE_MASK
> > - CLK_TX_PHASE_MASK
> > - CLK_RX_PHASE_MASK
> > - CLK_V2_TX_DELAY_MASK / CLK_V3_TX_DELAY_MASK
> > - CLK_V2_RX_DELAY_MASK / CLK_V3_RX_DELAY_MASK
> > - CLK_V2_ALWAYS_ON / CLK_V3_ALWAYS_ON
> > 
> > are these used for the MMC clock or are some of these routed to the
> > NAND pins as well?
> 
> There clocks are not used in NAND driver..
> 
> I understand your concern here, if there clocks are also routed to NAND
> pins, then we also need to implement them here
> actually, to answer your question, I need to query the ASIC team..

Even if the NAND driver does not need to change the phases, it might need to
make sure these phases are reset on init. It would not hurt to handle these
phases in your clock controller.
