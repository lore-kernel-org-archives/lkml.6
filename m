Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC00C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7178923BFD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HMetIRg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7178923BFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeGCNVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:21:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40776 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeGCNVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:21:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so2263600wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=n6yxd1XufDaH6wDTv37D0kySU2+I4nVix+GW/E1+c4s=;
        b=HMetIRg/09AMtVVXMtqaagQxdC4Gsy76bv7O25B75E5ZGL2KGFXljyq+k8A+arnXrC
         tEBQwhOa4kfQe7tZZXbBHvUrj3+tTy2A9HTNLQ+jscEWSHZW8+R49gHV/DTQrqj6BpX6
         IRPizrIJot2kF+ITNNcARrb9xZ/O981z2Gh3QB2BXqKX1U5DDwdH56qGLkKVlu0OMc/L
         1zLIKSueCoZuaR0V7oWWXsnZUQSyOkhMOqNn67VMHHApPBpIHOXF4qQ8el+V49SSN3/C
         KYY32pqycakwHWKe7tuafD0P//gLWXA2EYI8Xcl2kp6ParRmd9rLBVFUeZrbFMYaM0qP
         +B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n6yxd1XufDaH6wDTv37D0kySU2+I4nVix+GW/E1+c4s=;
        b=Kv7qKqCvYxhJugh67fjLHnqBGcS5sqEImpd7mgXYEI2AsWKV25L22Z/kJvg2u4vZcG
         b+Gv1+1BJTyjp+6a8NkSOX2tjjXM5WrL9obasaeYmr9LdHuvKlDp+ebOUUv3WcdesYYS
         q40wPJ8LL+yLVfMM+hMoc8MxLUPvQxJbn71x1TgEbCffS1iQ+5ZD+4cdpBqk5Xu4fBAc
         OTYNyJ7UVZfTPLYiP1CjfDM6NV5S9/0La+F9WBE+//K2h3chS3s4G0suc4nV6GA8By4Q
         wJg//sD/7ZES0tH1WwugiRYepybIHTz0imYHeI8Jm1CMrCjBDpgvO24b87tt4OkNRlBO
         5c4w==
X-Gm-Message-State: APt69E2DIQftVFhZqLCKuL6cbciEeHCexzVuCwj2C+N6N7OUsbugUHDP
        canzapLywPl/61RP/uaEUOtBP6Oiezo=
X-Google-Smtp-Source: AAOMgpdDk+JS5bvIFWBSbziVBiw0ZqyLvnbyZY/QwkcbLyWqgetOJTld6FbQngsG4XhRUmrTZKNZBw==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr5959515wma.101.1530624112547;
        Tue, 03 Jul 2018 06:21:52 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l17-v6sm2019844wrh.45.2018.07.03.06.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 06:21:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
Date:   Tue,  3 Jul 2018 15:21:47 +0200
Message-Id: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clocks frequency in the order of the MHz.

Thsi patchset includes the dt-bindings, driver and the DT node added to the
meson-gx dtsi.

Neil Armstrong (3):
  soc: amlogic: Add Meson GX Clock Measure driver
  dt-bindings: amlogic: Add Internal Clock Measurer bindings
  ARM64: dts: meson-gx: Add Internal Clock Measurer node

 .../bindings/soc/amlogic/clk-measure.txt           |  15 ++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   5 +
 drivers/soc/amlogic/Kconfig                        |   8 +
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-gx-clk-measure.c         | 224 +++++++++++++++++++++
 5 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c

-- 
2.7.4

