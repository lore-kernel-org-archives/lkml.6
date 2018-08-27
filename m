Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A355220858
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m5pxfHEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A355220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeH0Qq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:46:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36790 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0Qq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:46:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id m27-v6so13559514wrf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBmxrMJ84Tv3keNT5BHkJ2HwL0p9m2Yyk61SpRtvVTM=;
        b=m5pxfHEI2InrxsOyP+nWY8F/fOpB0WTIxrDgJXoRxh7JgRZvKmwluNIO8FGloVCBkw
         06eAEAmY3AhLDJwfKDM3hkmhOQsg5Eltw801uo9gwCKhhpR9rNWMzerG8oHfxGgzPpuf
         BgBrQzM8MIjcUMfMD2QiQ6dP8qCV/K+WChgyhOvWjEqDCLChTgBwhIHyGTPL9O86B0ss
         aMEdis28nmeP0VnGUuts5YnnczdP+kxKIPTa3SdPdqI9niAHe6Tgtb97Sn8rZJtYtgXm
         AeqPMqZCgM8truuK4iHMf6yIPI9H37YhX1HHCkELSRNu4+NQy/1zlKMI236+0/4M8CEm
         eZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBmxrMJ84Tv3keNT5BHkJ2HwL0p9m2Yyk61SpRtvVTM=;
        b=TYrcwBInXsfpgUbPC+oSD1cjF/3buYkDGREUOKvuW2R+fOwU2tEIxIkMoU/Zx8wgCD
         zZaW1GHd5MkJ1qpgaUolQlnT5Pod/IUNtRbdYbbCdfmHF2VIwqpZf36ebVNMYDeoEhVP
         jBGEzqsQTdNXsKUHnIxp9sjEr2nIacLBy+4cbFoqef96Ch/1R1DC9NBRR5Ug+IMe4+5D
         yHrpWIIs+FBUUFMVP9gpio2ZkWL8+neLE0tzJB8W4aZDDTEWb6/kiWjcpwBE7r7XOIH7
         V/inFaoS8BEtu4+71QvHCeS0AAiX2MUYrBjBetE2uOV42agCNXlLcoTjlbI7j/jRMRNt
         ZhtQ==
X-Gm-Message-State: APzg51DBxG2Zp/A9llu7eyb3Dv2c/06OOTHWHn07HAH1YxDXSARhyqL9
        9w1rE00Iw/J+lmxOFKcDfbifOA==
X-Google-Smtp-Source: ANB0VdYCao5UFQstCdEvGX+CRF2DxGdbHwkmPy4/Q2UaQbl1bidxGGPFJZy+1PLvwlmpRMreOKm0LA==
X-Received: by 2002:adf:9366:: with SMTP id 93-v6mr7996749wro.60.1535374794332;
        Mon, 27 Aug 2018 05:59:54 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v6-v6sm10853187wro.66.2018.08.27.05.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 05:59:53 -0700 (PDT)
Message-ID: <e6592bd2f2505e30bb27e1cd4cbb031344cc3459.camel@baylibre.com>
Subject: Re: [PATCH v2 0/4] clk: meson: clk-pll driver update
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Date:   Mon, 27 Aug 2018 14:59:52 +0200
In-Reply-To: <CAFBinCCNY3=yo42hQUqJJzeSetLni+whtWaBZCL-MV63DDYQow@mail.gmail.com>
References: <20180801140053.25899-1-jbrunet@baylibre.com>
         <CAFBinCCNY3=yo42hQUqJJzeSetLni+whtWaBZCL-MV63DDYQow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-12 at 20:26 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Wed, Aug 1, 2018 at 4:00 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > 
> > This patchset is yet another round of update to the amlogic pll driver.
> > 
> >  1) Enable bit is added so we don't rely on the bootloader or the init
> >     value to enable to pll device.
> >  2) Remove unnecessary CLK_GET_RATE_NOCACHE flags.
> >  3) OD post dividers are removed from the pll driver. This simplify the
> >     driver and let us provide the clocks which exist between those
> >     dividers. Some device are actually using these clocks.
> >  4) The rates hard coded in parameter tables are remove. Instead, we
> >     only rely on the parent rate and the parameters to calculate the
> >     output rate, which is a lot better.
> > 
> > This series has been tested on the gxl libretech cc and axg s400.
> > I did not test it on meson8b yet.
> > 
> > Changes since v1: [0]
> >  - improve commit description of patch 1
> >  - remove unnecessary CLK_GET_RATE_NOCACHE flags.
> >  - add missing CLK_SET_RATE_PARENT.
> > 
> > [0]: https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
> > 
> > Jerome Brunet (4):
> >   clk: meson: clk-pll: add enable bit
> >   clk: meson: clk-pll: drop CLK_GET_RATE_NOCACHE where unnecessary
> >   clk: meson: clk-pll: remove od parameters
> >   clk: meson: clk-pll: drop hard-coded rates from pll tables
> 
> for the whole series:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> as well as:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> (tested on Meson8b / Odroid-C1, even CPU frequency scaling still works
> with my out-of-tree patches)

Collected tags, rebased and queued for 4.20

> 
> 
> Regards
> Martin


