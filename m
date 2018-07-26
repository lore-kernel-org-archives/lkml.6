Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2113720647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bErAemIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2113720647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeGZEqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 00:46:32 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:17565 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeGZEqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 00:46:31 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6Q3UkmY012011;
        Thu, 26 Jul 2018 12:30:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6Q3UkmY012011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532575847;
        bh=18Uhx8VNq1ynaQYN0Fmv78fw4aoKgz2xqnddjbLHsUM=;
        h=From:To:Cc:Subject:Date:From;
        b=bErAemIAtNRgY8QIs+P4xXmwkyJQgx8NZH1ku3VRADgbF/P0TBAoVEGWrWpmvSUYr
         99vSv8HS1E18lMU6lUH0xmV7Knlcf7h5LpNyjl3TZ7K+sCT1NwaaXAx9SvQ9DgbQJI
         X4y+rRP7jhtQ0CbK8SppgZwaI9Y3fjIrUgsd5TpPSBWu0F3vOOiamFNRTmmd5Q2Ppy
         QAysLZ25sR+11gvbknQ1tLVX0o/HAAW8yt0GeZNSzASRm3ZFPTg6++Cw0E79pbVRf+
         iujn/YLdtzob9djNDfVI5TSaotWOIkV26rEr3PQylc0VxBlozovbXlsJrnJKPVacM8
         NFVJ3tVy0Kmcg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] mmc: tmio: rename variants to have consistent prefix
Date:   Thu, 26 Jul 2018 12:28:54 +0900
Message-Id: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Based on the former discussion:
https://www.spinics.net/lists/linux-mmc/msg46952.html



Masahiro Yamada (2):
  mmc: tmio: rename files and CONFIG options to have the same prefix
  dt-binding: mmc: rename tmio_mmc.txt to renesas_sdhi.txt

 .../mmc/{tmio_mmc.txt => renesas_sdhi.txt}         |   11 +-
 MAINTAINERS                                        |    1 -
 arch/arm/configs/eseries_pxa_defconfig             |    2 +-
 arch/arm/configs/pxa_defconfig                     |    2 +-
 drivers/mmc/host/Kconfig                           |   25 +-
 drivers/mmc/host/Makefile                          |    8 +-
 drivers/mmc/host/tmio_mmc.c                        | 1415 ++++++++++++++++++--
 drivers/mmc/host/tmio_mmc_core.c                   | 1394 -------------------
 drivers/mmc/host/tmio_mmc_original.c               |  167 +++
 .../host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c}  |    2 +-
 .../mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h}   |    0
 ...ternal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} |    2 +-
 ...as_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} |    2 +-
 13 files changed, 1519 insertions(+), 1512 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{tmio_mmc.txt => renesas_sdhi.txt} (86%)
 delete mode 100644 drivers/mmc/host/tmio_mmc_core.c
 create mode 100644 drivers/mmc/host/tmio_mmc_original.c
 rename drivers/mmc/host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c} (99%)
 rename drivers/mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h} (100%)
 rename drivers/mmc/host/{renesas_sdhi_internal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} (99%)
 rename drivers/mmc/host/{renesas_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} (99%)

-- 
2.7.4

