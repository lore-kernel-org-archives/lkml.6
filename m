Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114D2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2482086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2482086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeIJKQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:16:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39114 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeIJKQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:16:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 427xL05HV8z9ttC8;
        Mon, 10 Sep 2018 07:24:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sv3OBvPt70VX; Mon, 10 Sep 2018 07:24:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 427xL04Y4mz9ttC1;
        Mon, 10 Sep 2018 07:24:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 061F18B786;
        Mon, 10 Sep 2018 07:24:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id E788avFEaoMF; Mon, 10 Sep 2018 07:24:16 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 529D38B74B;
        Mon, 10 Sep 2018 07:24:16 +0200 (CEST)
Subject: Re: [PATCH 0/5] introduce
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 functions
To:     Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, alexandre.torgue@st.com,
        alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org,
        davem@davemloft.net, galak@kernel.crashing.org,
        joabreu@synopsys.com, khilman@baylibre.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <93f879d1-ddae-9a7c-e629-ee34f97686c6@c-s.fr>
Date:   Mon, 10 Sep 2018 07:24:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/09/2018 à 21:41, Corentin Labbe a écrit :
> Hello
> 
> This patchset adds a new set of functions which are open-coded in lot of
> place.
> Basicly the pattern is always the same, "read, modify a bit, write"
> some driver already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> 
> The first patch rename some powerpc funtions which already use the same name (xxxbits32)
> but with only bigendian values.

The same name as what ?

> 
> The second patch adds the header.

But the second patch adds functions with the same name as the powerpc 
ones but doing something different. Why consider that setbits32() should 
be LE and not BE ?

Christophe


> The third patch is an ugly try to implement a coccinelle semantic patch to
> find all place where xxxbits function could be used.
> Probably this spatch could be better written and I didnt found an easy way to add the "linux/setbits" header.
> 
> The two last patch are example of convertion of two drivers.
> Thoses patchs give an example of the reduction of code won by using xxxbits32.
> 
> This patchset is tested with the ahci_sunxi and dwmac-sun8i drivers.
> 
> Regards
> 
> Corentin Labbe (5):
>    powerpc: rename setbits32/clrbits32 to setbits32_be/clrbits32_be
>    include: add
>      setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
>      linux/setbits.h
>    coccinelle: add xxxsetbitsXX converting spatch
>    net: ethernet: stmmac: use xxxsetbits32
>    ata: ahci_sunxi: use xxxsetbits32 functions
> 
>   arch/powerpc/include/asm/fsl_lbc.h                 |   2 +-
>   arch/powerpc/include/asm/io.h                      |   5 +-
>   arch/powerpc/platforms/44x/canyonlands.c           |   4 +-
>   arch/powerpc/platforms/4xx/gpio.c                  |  28 +-
>   arch/powerpc/platforms/512x/pdm360ng.c             |   6 +-
>   arch/powerpc/platforms/52xx/mpc52xx_common.c       |   6 +-
>   arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |  10 +-
>   arch/powerpc/platforms/82xx/ep8248e.c              |   2 +-
>   arch/powerpc/platforms/82xx/km82xx.c               |   6 +-
>   arch/powerpc/platforms/82xx/mpc8272_ads.c          |  10 +-
>   arch/powerpc/platforms/82xx/pq2.c                  |   2 +-
>   arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |   4 +-
>   arch/powerpc/platforms/82xx/pq2fads.c              |  10 +-
>   arch/powerpc/platforms/83xx/km83xx.c               |   6 +-
>   arch/powerpc/platforms/83xx/mpc836x_mds.c          |   2 +-
>   arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   2 +-
>   arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c       |   4 +-
>   arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   2 +-
>   arch/powerpc/platforms/85xx/p1022_ds.c             |   4 +-
>   arch/powerpc/platforms/85xx/p1022_rdk.c            |   4 +-
>   arch/powerpc/platforms/85xx/t1042rdb_diu.c         |   4 +-
>   arch/powerpc/platforms/85xx/twr_p102x.c            |   2 +-
>   arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   4 +-
>   arch/powerpc/platforms/8xx/adder875.c              |   2 +-
>   arch/powerpc/platforms/8xx/m8xx_setup.c            |   4 +-
>   arch/powerpc/platforms/8xx/mpc86xads_setup.c       |   4 +-
>   arch/powerpc/platforms/8xx/mpc885ads_setup.c       |  28 +-
>   arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   6 +-
>   arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   8 +-
>   arch/powerpc/platforms/embedded6xx/wii.c           |  10 +-
>   arch/powerpc/sysdev/cpm1.c                         |  26 +-
>   arch/powerpc/sysdev/cpm2.c                         |  16 +-
>   arch/powerpc/sysdev/cpm_common.c                   |   4 +-
>   arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |   8 +-
>   arch/powerpc/sysdev/fsl_lbc.c                      |   2 +-
>   arch/powerpc/sysdev/fsl_pci.c                      |   8 +-
>   arch/powerpc/sysdev/fsl_pmc.c                      |   2 +-
>   arch/powerpc/sysdev/fsl_rcpm.c                     |  74 ++--
>   arch/powerpc/sysdev/fsl_rio.c                      |   4 +-
>   arch/powerpc/sysdev/fsl_rmu.c                      |   8 +-
>   arch/powerpc/sysdev/mpic_timer.c                   |  12 +-
>   drivers/ata/ahci_sunxi.c                           |  51 +--
>   .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |  54 +--
>   drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  55 +--
>   .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  21 +-
>   drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  51 +--
>   drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  13 +-
>   drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  42 +-
>   drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |  11 +-
>   drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  17 +-
>   .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  30 +-
>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  69 +---
>   .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  11 +-
>   drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   7 +-
>   include/linux/setbits.h                            |  55 +++
>   scripts/coccinelle/misc/setbits.cocci              | 423 +++++++++++++++++++++
>   56 files changed, 776 insertions(+), 489 deletions(-)
>   create mode 100644 include/linux/setbits.h
>   create mode 100644 scripts/coccinelle/misc/setbits.cocci
> 
