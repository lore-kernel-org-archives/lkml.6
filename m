Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED01ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C72A20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CAbHxxMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C72A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbeGTQPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:15:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37339 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeGTQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:15:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so11693007wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hNXV/Fv9UOYiD1FMsFzSOoDnvIy+bv68RDKfFg/goZI=;
        b=CAbHxxMtgxJKuUZd+ppTmQcsQ76aH9bPYtXuY+0xkYtJw24EWYTFx1yIzuAK2Uv84Q
         CTZ2NwDBdcuRPjxmV7gn1jG28YUnNpbTXK5r37O9Kkn5cYb0Z880w9yJ9P/hKM3l8nvY
         s4d+bFhrQU01CU+FlFy1jy8mn37S+gdk4UHx5XAh+coyvf8D1KiY7/TXrnLdM+jCFyEK
         lfHSvaYb4NKzDOgr2CnJCVhBrLv6Mx9LE437ahfUPVqYYwJtpGImo/AtxShejO0ha6+0
         Uc3rHBEuoCIoj2aUuOf0p+PhNw+8UAq6Dzeus/VjKtU/OpqQp22QPNpz6k6ODVLFJqru
         zLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hNXV/Fv9UOYiD1FMsFzSOoDnvIy+bv68RDKfFg/goZI=;
        b=KFGDInvQCKl5YNRa+dauMOqmBg0ucFRLG0tSkBoHVoipTRbaAltiwJjmfxaRJBC6Cy
         VBxVTXHap4tG/gGNSLnoEzvydqoFTuABG1WoBK3GA0E4nZ3NOrzbfNFzaUJnHsie+HfN
         bMXGzKrFZPQ6RJwbcISbJo08f+MyOklpYakzSBtj3ZjglFXzpkFryeYpc5y3/JO66X9H
         6YkIraSCLz1622bw0daz6X4imAmbRXrv1i0lvjpDlRN1CyPbVvhekgCk6dM2BIe2W7DI
         msSLasNPiAMLmow3cRIYpsULzwG+XEOKQhIVR/CWBSGaf542pxYPFSyWXS0CsZ/Njp3D
         EfEw==
X-Gm-Message-State: AOUpUlHO1sD3csnb29v2DG42JGoKXRfRek5QBNdh7ImeHeCYhSUVFha7
        pIylIC1x2152DCNOW0WTJadypjnd6lE=
X-Google-Smtp-Source: AAOMgpeWXhs5OqB8jB1CohESuF4/ZTUsuU4w5AEaaibyvE2H9IyvHD0YYUE9ZDPTeKIHJlAPZgLKuQ==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr1977300wrj.212.1532100396530;
        Fri, 20 Jul 2018 08:26:36 -0700 (PDT)
Received: from boomer.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id j3-v6sm2910051wrt.70.2018.07.20.08.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:26:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] reset: meson: add audio arb controller
Date:   Fri, 20 Jul 2018 17:26:31 +0200
Message-Id: <20180720152633.6227-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the audio ARB controller which is necessary to
enable or disable the DDR access for the FIFOs of the audio subsystem.

Changes since v1 [0]:
 * Fix typo s/arbitror/arbiter
 * Collect Rob's tag

[0]: https://lkml.kernel.org/r/20180706143122.7612-1-jbrunet@baylibre.com

Jerome Brunet (2):
  reset: meson: add dt-bindings for meson-axg audio arb
  reset: meson: add meson audio arb driver

 .../bindings/reset/amlogic,meson-axg-audio-arb.txt |  21 +++
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson-audio-arb.c              | 168 +++++++++++++++++++++
 .../reset/amlogic,meson-axg-audio-arb.h            |  17 +++
 5 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 drivers/reset/reset-meson-audio-arb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h

-- 
2.14.4

