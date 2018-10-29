Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BCC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF3320870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF3320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJ3GJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:09:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42975 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJ3GJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:09:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id z20-v6so11080437qti.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RNCrqwPr0FJkggrh3CcCJxdYK2ODCiSXHV3XWWJlCTE=;
        b=Id/2a8lXs56wjNLk+nRt5Q1qJqyzZJsaUH8hPUDzEepAC4kCkGJytuD2QpiBHjmZqg
         YXHQXroSNSayqi95Dltqbuc7xuLLwCqalgO3pbbRavhEGDdQybEW76ejnKrZ72p+xhQm
         PPsLuWQsiG0ZVeZhMH/ETCadrSYrbnR2L7RXv1d6eXNQEUoapgMa+cJUFjdHgc9hcSBJ
         MahyBeD6nJ9Fv9fbMNvLIAMVMH/h3ZEnqpquQ+VolveNGVpx9kRFVJcLfWLtzItH0KC4
         8/oP8ubdlUbAkjYj+q1VNgSI4WBRMkuB4qhfBCfCjLuTQzkw6A7CIzcmmCOapwRn+s0i
         iCqQ==
X-Gm-Message-State: AGRZ1gKXQayyyCPrCcX+CIUhX7zDrwmXx9qAjScRcTFGICM0bGDTszfj
        353CiS1etbaS+64m/jv85J33XEcflvsLQT3Q8f8=
X-Google-Smtp-Source: AJdET5eYE8MVUrj8sq+2O7XzmIfK5srIAtlpzyiNLZN4gyl3VzQs7shTgk2c8c5EHtD77dZaFBawNScdtd/ubj9vxsw=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr25065qtl.343.1540847919635;
 Mon, 29 Oct 2018 14:18:39 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 22:18:18 +0100
Message-ID: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
Subject: [GIT PULL 0/4] ARM: SoC changes for 4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the arm-soc changes for the current merge window, with a
little delay due to the conference travel last week.

This is feels a little bigger than the last few I did before Olof took
over for the summer. We have 965 non-merge changesets in the
branch, and we pulled from a total of 101 downstream branches this
time. In the top contributors, we have a few new names this time,
most of these worked specifically on one SoC platform:

    128 Marcel Ziswiler
     35 Biju Das
     34 H. Nikolaus Schaller
     27 Grygorii Strashko
     25 Rob Herring
     25 Manivannan Sadhasivam
     23 Geert Uytterhoeven
     23 Fabio Estevam
     22 Aapo Vienamo
     21 Fabrizio Castro
     21 Anson Huang
     15 Bjorn Andersson
     14 Sergei Shtylyov
     13 Krzysztof Kozlowski
     12 Niklas Cassel
     12 Nicolas Ferre
     12 Alex Elder
     11 Martin Blumenstingl
     11 Marek Szyprowski
     10 Suzuki K Poulose
     10 Jerome Brunet

While the majority of the patches went into 32-bit ARM, this is
the first time I noticed more new boards getting added on 64-bit,
which seems like a significant departure from the past. Around
76% of the patches arch for dts files and bindings, 12% are for
drivers, and the rest is architecture specific code (the numbers
are not exact because of overlapping changes). In more detail,
this looks like

$ git diff --dirstat=0.1 v4.19-rc6..
   0.5% Documentation/devicetree/bindings/arm/freescale/
   0.5% Documentation/devicetree/bindings/arm/tegra/
   0.5% Documentation/devicetree/bindings/arm/
   0.2% Documentation/devicetree/bindings/firmware/xilinx/
   0.1% Documentation/devicetree/bindings/firmware/
   0.1% Documentation/devicetree/bindings/net/dsa/
   0.1% Documentation/devicetree/bindings/reset/
   0.2% Documentation/devicetree/bindings/
   0.2% Documentation/xilinx/
  36.2% arch/arm/boot/dts/
   0.1% arch/arm/mach-exynos/
   0.1% arch/arm/mach-imx/
   0.5% arch/arm/mach-omap1/
   0.2% arch/arm/mach-omap2/
   0.4% arch/arm/mach-s3c24xx/
   0.7% arch/arm/mach-shmobile/
   0.8% arch/arm/mach-u300/
   1.2% arch/arm/
   0.9% arch/arm64/boot/dts/actions/
   1.7% arch/arm64/boot/dts/allwinner/
   1.5% arch/arm64/boot/dts/amlogic/
   0.3% arch/arm64/boot/dts/arm/
   0.6% arch/arm64/boot/dts/hisilicon/
   1.7% arch/arm64/boot/dts/marvell/
   1.0% arch/arm64/boot/dts/mediatek/
   0.5% arch/arm64/boot/dts/nvidia/
   3.9% arch/arm64/boot/dts/qcom/
  11.2% arch/arm64/boot/dts/renesas/
  10.3% arch/arm64/boot/dts/rockchip/
   1.4% arch/arm64/boot/dts/socionext/
   0.3% arch/arm64/boot/dts/synaptics/
   0.5% arch/arm64/boot/dts/ti/
   0.2% arch/arm64/boot/dts/
   0.5% drivers/bus/
   3.8% drivers/clk/zynqmp/
   1.1% drivers/edac/
   0.1% drivers/firmware/arm_scmi/
   0.8% drivers/firmware/imx/
   0.1% drivers/firmware/meson/
   2.0% drivers/firmware/xilinx/
   0.3% drivers/firmware/
   0.3% drivers/reset/
   0.1% drivers/soc/actions/
   0.4% drivers/soc/amlogic/
   0.3% drivers/soc/fsl/qbman/
   0.4% drivers/soc/imx/
   0.8% drivers/soc/mediatek/
   0.9% drivers/soc/qcom/
   1.0% drivers/soc/renesas/
   1.9% drivers/soc/tegra/
   0.2% drivers/tee/
   0.1% drivers/
   0.2% include/dt-bindings/clock/
   0.2% include/dt-bindings/power/
   0.1% include/linux/firmware/imx/svc/
   1.6% include/linux/firmware/imx/
   0.2% include/linux/firmware/
   0.1% include/linux/soc/amlogic/
   0.4% include/linux/
   0.1% include/soc/fsl/
   0.1% include/

         Arnd
