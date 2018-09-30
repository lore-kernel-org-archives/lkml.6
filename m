Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7144EC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CFF206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="jSaqd+DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CFF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeJACAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:00:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41416 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbeJACAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:00:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3-v6so7888718pgv.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gYZc+HQeXwt2AvdzV7lk8qTTd0a8TFLExx7nncRk9/w=;
        b=jSaqd+DOoxLV02QMKjjDNr0yNLbgIQcpuGHGLSHINcYR2Z1tWtilcSnADcuus/EtEY
         XBkX7m076UKX+TgtbaJFYNa8LVg7X77THRbrsv5hR0ob7OE7v4YaPXArKBMS+1eywSmS
         bDO2Bo/C1iLFN+AoNZKgfGCy93grfKTPFLlauvXHmw+hJPhG7k0LQJZxJoa7N1Obj6Mo
         tdmBvEwIhIykqNg0BaQVt8vgW5NQBNKAiuCY/qKGyBCO2SUDsOu8t46vvqDvXzQWFmPu
         o3qsYqDVqpcWNals2KJkJYo/o+IAVX4ay8whyuHKbzQGsLLNr0+3BMXRyQZUDfkwNCPA
         MR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gYZc+HQeXwt2AvdzV7lk8qTTd0a8TFLExx7nncRk9/w=;
        b=KumdHbNRvZ8ww0Fb2EWesUHM3+06fEDpqrjSODDi4oewfikKGjSqKGL4eeef2nIAiN
         +HYbcEl7F4fYfkOunQz0tFODXfxt/FASKnsQpk+YAc4OivvizNrmEI3F8RQo/mjSRujA
         lBZVYVn24WohdsN0NROKwJrTIroHtUW0lGcO20gPt0k5x8wFwq9bf2YKu4PhaHpW5c2h
         p80uJC6L7sVpiHSGZl3ODT2oI03PkZpvVRTiQX1Be6YcczyTglNqUDXIksXFpOZqgd1I
         DikMh/Zwj0pezE6KCycJeV6b+NgZ5vK55g8/Q6fvCHZtnrM27/2w7rWaT7Pj3taVHZAH
         PSIA==
X-Gm-Message-State: ABuFfoj+aDxI/teZ3wQpLUp7DXUa8Qza6TJvjIYKNCxy/yR+CzBz9sWI
        ASjPyZwF8r37OoLjj6pnAV7qjg==
X-Google-Smtp-Source: ACcGV637Ctz3iArewfrSu231xqiHxdrSxYIQKjcVGeu11LpGeS/9CtIetf6VNRbA9u3cCa9C0f2BMQ==
X-Received: by 2002:a63:4044:: with SMTP id n65-v6mr7139910pga.90.1538335582302;
        Sun, 30 Sep 2018 12:26:22 -0700 (PDT)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 20-v6sm3074925pge.77.2018.09.30.12.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 12:26:19 -0700 (PDT)
Date:   Sun, 30 Sep 2018 12:23:43 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180930192343.erige7yfbrnvil2m@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Greg,

The following changes since commit a132bb90414bfad4f8ee23cb45fe6946a89b167d:

  Merge tag 'sunxi-fixes-for-4.19' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into fixes (2018-09-08 10:04:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 082dc55e3c5e559b0e6855c0de23ebd674bcc91e:

  ARM: dts: stm32: update SPI6 dmas property on stm32mp157c (2018-09-25 20:39:06 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A handful of fixes that have been coming in the last couple of weeks:

 - Freescale fixes for on-chip accellerators
 - A DT fix for stm32 to avoid fallback to non-DMA SPI mode
 - Fixes for badly specified interrupts on BCM63xx SoCs
 - Allwinner A64 HDMI was incorrectly specified as fully compatble with R40
 - Drive strength fix for SAMA5D2 NAND pins on one board

----------------------------------------------------------------
Alexandre Belloni (1):
      soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Amelie Delaunay (1):
      ARM: dts: stm32: update SPI6 dmas property on stm32mp157c

Antoine Tenart (1):
      MAINTAINERS: update the Annapurna Labs maintainer email

Florian Fainelli (1):
      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers

Icenowy Zheng (1):
      ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl

Olof Johansson (3):
      Merge tag 'sunxi-fixes-for-4.19-2' of https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'at91-4.19-fixes' of git://git.kernel.org/.../at91/linux into fixes
      Merge tag 'arm-soc/for-4.19/devicetree-fixes' of https://github.com/Broadcom/stblinux into fixes

Zhao Qiang (1):
      soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()

 MAINTAINERS                               |  2 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts |  2 ++
 arch/arm/boot/dts/bcm63138.dtsi           | 14 ++++++++------
 arch/arm/boot/dts/stm32mp157c.dtsi        |  4 ++--
 arch/arm/boot/dts/sun8i-r40.dtsi          |  3 +--
 drivers/soc/fsl/qbman/qman.c              |  3 +++
 drivers/soc/fsl/qe/ucc.c                  |  2 +-
 7 files changed, 18 insertions(+), 12 deletions(-)
