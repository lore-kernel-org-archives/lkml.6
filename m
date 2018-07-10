Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C59208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vCT1XBt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C59208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933078AbeGJJ0W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:26:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36671 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeGJJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:26:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so23566585wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVs3TtkyY8HidHolBZZBTK+JPxl/xqykgoao/TYheXI=;
        b=vCT1XBt9qhwKKupUpcZyIaxk+5dofOidEDAkVK/9OjyjQGTm4TxopS+thWwVWskE66
         8TlTpPKWJwfSfWzHUouWMRyZsVaFGlNFluUa1Z6mGuUPHNCNlF2U/5DQ/g8tLXImo3bk
         sueJc7BEIEY7z7NFQIntbw9GrOoY9f9j5s/vslFto29q46bUabTNIgpAl9NvgTNHlgCd
         HzsylZ1ObGSb9lgwVrTu8loc5NsQ6/wX/+7XOR0Ch2nPQUtmEC2YiZdf5gbffUiR7BBe
         kPKhnSj+nYnbdYN4/3cwZtVEZYbHt2sIo6tFUek+XXkQjxHkIRmtz6/RMncr/mygCyEz
         lOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVs3TtkyY8HidHolBZZBTK+JPxl/xqykgoao/TYheXI=;
        b=FalXJJxbGKzn9oa3uOyR+q3IMWGgbffQjuTQcHh5wmODmdSmwMHHUJPi6GsyCCtsYa
         H8LXLbZN+k9yPkgmr8PQOkl4sMrN60ruPJTdNQFS747ixi6Qc5mqOkS6T0ZeGFPP5F3k
         X9UCJg8bAUYZObctFqPRK510/f0UNArDRvWTiEwijkMwN5oHIeuu6dZ61asdw/T8RnhD
         j4u3iTzzIxl/PPulteJcADxZxEHm9B5I+Kl4ggPvkrBMtVFdKLRGvSjha+7Mp5xsRC7E
         h2iP/cAG9azKeHYBFhkkKbbGSKVCgFiBZh5i0qGHmwLbYt9ab1jGTo8vYEckbTBO/4Tj
         uRZA==
X-Gm-Message-State: APt69E1eHHzy4f59UK1KmxZ7DD7FtoBETKQUZysOd7S6t4F8B+8f2pHk
        eb6WFsRWEvr/NycuxSe0vWzlow==
X-Google-Smtp-Source: AAOMgpcc0fGT3TA05aLL12xOigeXQrrl4KriMZ6rIldG0PHWCqswYn+yDvYPuuTbvxOl94ov3h8gMQ==
X-Received: by 2002:a1c:6f44:: with SMTP id k65-v6mr13534579wmc.19.1531214777830;
        Tue, 10 Jul 2018 02:26:17 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id e13-v6sm35963072wrd.9.2018.07.10.02.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 02:26:17 -0700 (PDT)
Message-ID: <1531214774.2708.49.camel@baylibre.com>
Subject: Re: [PATCH 2/3] dt-bindings: clk: meson-g12a: Add G12A EE Clock
 Bindings
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jian.hu@amlogic.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        qianggui.song@amlogic.com, devicetree@vger.kernel.org,
        sboyd@kernel.org, khilman@baylibre.com, mturquette@baylibre.com,
        yixun.lan@amlogic.com, linux-kernel@vger.kernel.org,
        bo.yang@amlogic.com, qiufang.dai@amlogic.com,
        linux-arm-kernel@lists.infradead.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org, sunny.luo@amlogic.com,
        linux-clk@vger.kernel.org, xingyu.chen@amlogic.com
Date:   Tue, 10 Jul 2018 11:26:14 +0200
In-Reply-To: <CAFBinCB6LS=PT1cw-j-LZ+vWo-RFe81qVZ6uLeGfWKtKfHz7ag@mail.gmail.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
         <1531134767-29927-3-git-send-email-jian.hu@amlogic.com>
         <CAFBinCB6LS=PT1cw-j-LZ+vWo-RFe81qVZ6uLeGfWKtKfHz7ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 00:13 +0200, Martin Blumenstingl wrote:
> On Mon, Jul 9, 2018 at 1:13 PM Jian Hu <jian.hu@amlogic.com> wrote:
> > 
> > Add dt-bindings headers for the Meson-G12A's Everything-Else
> > part clock controller.
> 
> I wonder if this should be folded into patch #1 along with an update
> to Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt so
> it's clear which header has to be used for G12A
> 

Yes, please squash patch 1 and 2.

> > 
> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> > ---
> >  include/dt-bindings/clock/g12a-clkc.h | 93 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> > 
> > diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
> > new file mode 100644
> > index 0000000..1473225
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/g12a-clkc.h
> > @@ -0,0 +1,93 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > +/*
> > + * Meson-G12A clock tree IDs
> > + *
> > + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> > + */
> > +
> > +#ifndef __G12A_CLKC_H
> > +#define __G12A_CLKC_H
> > +
> > +#define CLKID_SYS_PLL                          0
> > +#define CLKID_FIXED_PLL                                1
> > +#define CLKID_FCLK_DIV2                                2
> > +#define CLKID_FCLK_DIV3                                3
> > +#define CLKID_FCLK_DIV4                                4
> > +#define CLKID_FCLK_DIV5                                5
> > +#define CLKID_FCLK_DIV7                                6
> > +#define CLKID_GP0_PLL                          7

Please fix the alignement.

> > +#define CLKID_CLK81                                    10
> > +#define CLKID_MPLL0                                    11
> > +#define CLKID_MPLL1                                    12
> > +#define CLKID_MPLL2                                    13
> > +#define CLKID_MPLL3                                    14
> > +#define CLKID_DDR                                      15
> > +#define CLKID_DOS                                      16
> > +#define CLKID_AUDIO_LOCKER                     17
> > +#define CLKID_MIPI_DSI_HOST                    18
> > +#define CLKID_ETH_PHY                          19
> > +#define CLKID_ISA                                      20
> > +#define CLKID_PL301                                    21
> > +#define CLKID_PERIPHS                          22
> > +#define CLKID_SPICC0                           23
> > +#define CLKID_I2C                                      24
> > +#define CLKID_SANA                                     25
> > +#define CLKID_SD                                       26
> > +#define CLKID_RNG0                                     27
> > +#define CLKID_UART0                                    28
> > +#define CLKID_SPICC1                           29
> > +#define CLKID_HIU_IFACE                                30
> > +#define CLKID_MIPI_DSI_PHY                     31
> > +#define CLKID_ASSIST_MISC                      32
> > +#define CLKID_SD_EMMC_A                                33
> > +#define CLKID_SD_EMMC_B                                34
> > +#define CLKID_SD_EMMC_C                                35
> > +#define CLKID_AUDIO_CODEC                      36
> > +#define CLKID_AUDIO                                    37
> > +#define CLKID_ETH                                      38
> > +#define CLKID_DEMUX                                    39
> > +#define CLKID_AUDIO_IFIFO                      40
> > +#define CLKID_ADC                                      41
> > +#define CLKID_UART1                                    42
> > +#define CLKID_G2D                                      43
> > +#define CLKID_RESET                                    44
> > +#define CLKID_PCIE_COMB                                45
> > +#define CLKID_PARSER                           46
> > +#define CLKID_USB                                      47
> > +#define CLKID_PCIE_PHY                         48
> > +#define CLKID_AHB_ARB0                         49
> > +#define CLKID_AHB_DATA_BUS                     50
> > +#define CLKID_AHB_CTRL_BUS                     51
> > +#define CLKID_HTX_HDCP22                       52
> > +#define CLKID_HTX_PCLK                         53
> > +#define CLKID_BT656                                    54
> > +#define CLKID_USB1_DDR_BRIDGE          55
> > +#define CLKID_MMC_PCLK                         56
> > +#define CLKID_UART2                                    57
> > +#define CLKID_VPU_INTR                         58
> > +#define CLKID_GIC                                      59
> > +#define CLKID_SD_EMMC_B_CLK0           60
> > +#define CLKID_SD_EMMC_C_CLK0           61
> > +#define CLKID_HIFI_PLL                         71
> > +
> 
> is this empty line here on purpose? a comment would be great if
> there's a reason behind it (there's already a gap in the numbering
> between CLKID_GP0_PLL and CLKID_CLK81, but there's no empty line there
> - either way is fine, please just keep it consistent)

Please drop the empty line.
Otherwise, looks good.

> 
> 
> Regards
> Martin

