Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C20DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5422151C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AGv9VVBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5422151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJJSaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:30:13 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:54692 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:30:13 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w9AB8STD006306;
        Wed, 10 Oct 2018 20:08:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w9AB8STD006306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539169709;
        bh=m9l54q4gKXv6sAdRgjMhZwmgTF23fMjYy/bqkZRYF0I=;
        h=From:Date:Subject:To:Cc:From;
        b=AGv9VVBEvNgHlTnOCtcPaKV5d8btdnN5wSvqq/Y4epKgyyEoq6qXjZrJhCjqFtXAu
         f4lzvTr1STfXvi1ri0g366dbvfNHYCNv6D++W6Y4XuYZLwao0rnrGwFlh5hp5ZyzUu
         9T1aZlQECs/dHViURMNgAYSCouh4UDxbpsgZX7Klub2pV2TmbWPNf7A2tZQ1LXfdvh
         OLqvRoA0rUfekGVPBlP9Ug6naP8rXdbZLHZejJJOu3Jo+ibz0KaQRIIWWhcuD4zbnm
         Nnwk6ypsTW+RGaPe0sPoqe1FOc+ZxTs/QrQxr4ImiQ7M5orPqgThiqzI/lqt5fbv4m
         Zfe0FQDtK3ykw==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id t202-v6so1152053vke.9;
        Wed, 10 Oct 2018 04:08:29 -0700 (PDT)
X-Gm-Message-State: ABuFfojJZdCLG+atHyMjaqwAyVhA03MZc/M7dhdGeGof0aoAia/svQo8
        3IFuIWTXk665pGp0GgPcN5Qo/nJIC8nE7SHRScw=
X-Google-Smtp-Source: ACcGV62vacH6yUtsi9vg1WLMGmisXRQDaGTz98d7kny8kyNI6vXXZfC/h91VUwgm4gVAvNcVxaqsLv1ysdeTo/nNdGA=
X-Received: by 2002:a1f:5503:: with SMTP id j3-v6mr4648241vkb.34.1539169708005;
 Wed, 10 Oct 2018 04:08:28 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Oct 2018 20:07:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
Message-ID: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
Subject: [Question] directory for SoC-related DT binding
To:     DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I see a bunch of vendor (or SoC) names in
Documentation/device/bindings/arm/

./Documentation/devicetree/bindings/arm/altera
./Documentation/devicetree/bindings/arm/amlogic
./Documentation/devicetree/bindings/arm/apm
./Documentation/devicetree/bindings/arm/bcm
./Documentation/devicetree/bindings/arm/calxeda
./Documentation/devicetree/bindings/arm/freescale
./Documentation/devicetree/bindings/arm/hisilicon
./Documentation/devicetree/bindings/arm/keystone
./Documentation/devicetree/bindings/arm/marvell
./Documentation/devicetree/bindings/arm/mediatek
./Documentation/devicetree/bindings/arm/mrvl
./Documentation/devicetree/bindings/arm/msm
./Documentation/devicetree/bindings/arm/npcm
./Documentation/devicetree/bindings/arm/nxp
./Documentation/devicetree/bindings/arm/omap
./Documentation/devicetree/bindings/arm/rockchip
./Documentation/devicetree/bindings/arm/samsung
./Documentation/devicetree/bindings/arm/stm32
./Documentation/devicetree/bindings/arm/sunxi
./Documentation/devicetree/bindings/arm/tegra
./Documentation/devicetree/bindings/arm/ti
./Documentation/devicetree/bindings/arm/uniphier
./Documentation/devicetree/bindings/arm/ux500
./Documentation/devicetree/bindings/arm/vt8500


I also see some vendor names in
Documentation/device/bindings/soc/

./Documentation/devicetree/bindings/soc/bcm
./Documentation/devicetree/bindings/soc/dove
./Documentation/devicetree/bindings/soc/fsl
./Documentation/devicetree/bindings/soc/mediatek
./Documentation/devicetree/bindings/soc/qcom
./Documentation/devicetree/bindings/soc/rockchip
./Documentation/devicetree/bindings/soc/ti
./Documentation/devicetree/bindings/soc/xilinx
./Documentation/devicetree/bindings/soc/zte



Confusingly, I see bcm, mediatek, rockchip
in both locations.

Is there any rule to choose one than the other?




-- 
Best Regards
Masahiro Yamada
