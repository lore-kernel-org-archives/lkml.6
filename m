Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8900BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433A520647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dTub7q4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433A520647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbeGZEqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 00:46:32 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:17556 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeGZEqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 00:46:31 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6Q3Ukma012011;
        Thu, 26 Jul 2018 12:30:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6Q3Ukma012011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532575848;
        bh=EEqpSaOIiLKXtDgT7Y6aO0wGsVqAQ/kQYtQDKX5JCJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTub7q4piXnDxzVAC5TN+ptpnjKkoqYRKMYhdrTcKJj35RqeX8FA93JGZtgMzxhi1
         SdNcbMOsclTeH7Su/Z3GOsZyCTiN1sd/FC/6eWAblMYrLnxstXwSkKlJvFVh3Qn725
         pGDCnMPdrZ2l9X+rgflDtuTMdWmnZWcMzEoyn1jblqqZiBtfYMB13KZsiTQoCmgHs0
         oVsH3+tVZqTnM80wXbikFZCHqlvbwuusYzw4wDy6DVcQUfsLfGnuSAKzsuXgguK+nv
         bVsOQ0GyisPHuaT1YYpLm+8BuTgPeBw7vih1HwcBJ5TTwTpV2bhdoK5xtzGwhTwJQU
         4Lz4TABXT5D8w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] dt-binding: mmc: rename tmio_mmc.txt to renesas_sdhi.txt
Date:   Thu, 26 Jul 2018 12:28:56 +0900
Message-Id: <1532575736-20138-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
MFD glue") said, these MMC controllers use the IP from Panasonic.

TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
The common driver code was split and expanded as 'tmio-mmc-core', then
it become historical misnomer since 'tmio' is not the name of this IP.

In the discussion [1], we decide to continue calling these variants
'TMIO MMC' at least in Linux driver level, but let's stop exposing
this unfortunate things to other projects.  DT should not be oriented
to a particular project even though it is developed in Linux communities.

Also, remove the first paragraph, "The tmio-mmc driver doesn't probe..."
entirely.  The DT-binding should describe the hardware.  It is wrong
to talk about Linux driver internals such as how the drivers are probed,
how platform data are handed off, etc.

[1] https://www.spinics.net/lists/linux-mmc/msg46952.html

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../bindings/mmc/{tmio_mmc.txt => renesas_sdhi.txt}           | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{tmio_mmc.txt => renesas_sdhi.txt} (86%)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/renesas_sdhi.txt
similarity index 86%
rename from Documentation/devicetree/bindings/mmc/tmio_mmc.txt
rename to Documentation/devicetree/bindings/mmc/renesas_sdhi.txt
index 839f469..a27e091 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas_sdhi.txt
@@ -1,13 +1,4 @@
-* Toshiba Mobile IO SD/MMC controller
-
-The tmio-mmc driver doesn't probe its devices actively, instead its binding to
-devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
-driver. Those drivers supply the tmio-mmc driver with platform data, that either
-describe hardware capabilities, known to them, or are obtained by them from
-their own platform data or from their DT information. In the latter case all
-compulsory and any optional properties, common to all SD/MMC drivers, as
-described in mmc.txt, can be used. Additionally the following tmio_mmc-specific
-optional bindings can be used.
+* Renesas SDHI SD/MMC controller
 
 Required properties:
 - compatible: should contain one or more of the following:
-- 
2.7.4

