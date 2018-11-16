Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDBFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B047F208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U+E2VAnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B047F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbeKPTvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:51:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeKPTvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:51:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so2288699wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUQbjzSPtYxELG6eB6yThmzLpiNj1dWSru6Sk1dZhx0=;
        b=U+E2VAnXO2wchn1FyalhHlURfXcHWt29ypEhj3vai7vkFtizbs1pCKqavrH/46lOUl
         uvMn5tMWMxLuMPJyGH/DChN2FX7KpQc5wPD3zbqVRmSrNRgzSnqh9+apfK53L+ZcUO63
         XjIY+PL0VAt7WHx7BoC96onGaXxb3GmIrTwuimEvuTHi0EANJF8RGD0RiOaUJGjBb7fS
         mtMBh4unIne6F9jKBN0DSYXoMsj0dc+v7QWaVlGHG2pANA3Ft4oamLdoyQlrf6e7GJRa
         L+6GUsdE61e2N97jlHopblZFu3bPle63/Ilw1PmXf5C8uppjo18ftjI0durUXf0tKPLL
         YT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SUQbjzSPtYxELG6eB6yThmzLpiNj1dWSru6Sk1dZhx0=;
        b=XHAqkv9O49upYHZigBgyrKGnvuvXzySWxK0OrlerwjSLjH1FUKwX9/7ysUaiVr5MFL
         SW7YNVMYyzCwGIxlSMGhg7IwAfSn+YVr1IWgruRRFKD/Pa2gtcIjVhOqF46kQzOr0/ML
         /tTH/R/2s0yxUOcB+TZINa29Ns+h/OD84NynMyaLrZ14DgFbgVBrWVRCsp182Dw8rXMu
         +HzL5b5PQjuHSu+nH7cBu2DIzVsPgd6xtf8h7kFjF4aCob64BZiHvAhvS/ZhKlKCmf6e
         9R26yEkPFPIgglM+Ch8N+8L4rLk9ZskSHKPuQRvkUdpoWa01Pwxl7R2TfTJB1C+arI7Z
         2PGQ==
X-Gm-Message-State: AGRZ1gJRAhUuO8OpDaJ9cC766rP447CBbJGx131MW/wZ6AqOlnVShrZ+
        qdX1ndTLTgwzGpMznWKr8he9Lw==
X-Google-Smtp-Source: AJdET5e05fYWD2/b1lG3IwnooINgSlQwVmHxGH4Tt99TEEAByFzI78K1itQ/FEMarfGdeprXNGnBLQ==
X-Received: by 2002:adf:fa91:: with SMTP id h17mr7865507wrr.320.1542361184659;
        Fri, 16 Nov 2018 01:39:44 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id o15sm12760780wrp.12.2018.11.16.01.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 01:39:43 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: meson: add Libretech aml-s805x-ac support
Date:   Fri, 16 Nov 2018 10:39:36 +0100
Message-Id: <20181116093938.26373-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the libretech aml-s805x-ac, aka 'La Frite'

Changes since v1: [0]
 * Update gpio line names to align on Neil's recent series [1]
 * fix typo in comment

[0]: https://lkml.kernel.org/r/20181114101925.10526-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/1541587550-17842-1-git-send-email-narmstrong@baylibre.com

Jerome Brunet (1):
  dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings

Neil Armstrong (1):
  arm64: dts: meson: add libretech aml-s805x-ac board

 .../devicetree/bindings/arm/amlogic.txt       |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  | 248 ++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts

-- 
2.19.1

