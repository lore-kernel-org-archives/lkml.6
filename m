Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9322080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 13:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Iw+HBFNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9322080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeKSAKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:10:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSAKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:10:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id 125so746866wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5oqMaE58KJdtAAjHlJsIRYArgxrB3RL6oevITiwMj3A=;
        b=Iw+HBFNKIskKqipsG7ntNfOFJSepOep+4WZUoq8ECwM8c/pzeYEzqEq7DFEvpvsvor
         2W6B/FBJcufzE1dyoLIiGRCTXYZvJRp/ficS9DeY2sNnBYojh0SUksufecxmTFeqhLqs
         Fdboj9KPCHZeUVt6avLXrEWIKgr4O0W29rJ8IR3TzCrVwGzkA/o2eDaPfwavUgBSxgWQ
         BU/PY8s3wet8M3z6se2auPBXg8H9q7aeAOeJxKh10D3wWTpR+0IKPwb9p7wi0FJhYLCW
         Riz/wq6fBpOJIkF/jXKnhFcT7xqz+1huUFSbX6woGxzn1Kxrwwd2QMUSQrX2S7YziDFT
         CVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5oqMaE58KJdtAAjHlJsIRYArgxrB3RL6oevITiwMj3A=;
        b=jqbjlPweqkRK5lBsXh7Ow9fK7hnDW7q8h418O2CYGzMa5iYThb19KW5fN+4+q5Xmiu
         F6PbrPeHFLL9yFCDFJWDqO//1TR3sa4bMsn5BfprHwlzU7mQw2bzVQ+Wd/3R2Tc4Uask
         NiXcywH3RQG3oRf7hU1OMAxkHqr+zWt7VKsruDer0UBTXc1crnqDZ8OPzU6Qh8OqX5sU
         aMa8xD5idUV7VCvYm49HhjWoOQMN40TGkt8PnsxxQbZVpqdoAjDElXf4jOzcOJwWlodW
         iILKBLsSJdY3lZYHX3dnJPddso1a7Ll9xhAJEqxZCnqMOgOEIrUSL7Ow2q2PvlGQf5KL
         LH3w==
X-Gm-Message-State: AA+aEWYtRhxJYJGZDLEfYnLFKJq5OQ49HcI8xYYFQq8Be6bh5cEJY/hW
        7HCpILFsQqTPufkGOeWnHgtIcw==
X-Google-Smtp-Source: AJdET5c/QhO7q7TNqaz9svmhbKscDdxGVLeX7Hq2rFDNU9cOVSc3Hd81OAkbRe0XdEV+8RevoLN9HA==
X-Received: by 2002:a1c:930d:: with SMTP id v13-v6mr4376558wmd.26.1542549028635;
        Sun, 18 Nov 2018 05:50:28 -0800 (PST)
Received: from bender.home (lfbn-nic-1-84-209.w2-15.abo.wanadoo.fr. [2.15.173.209])
        by smtp.gmail.com with ESMTPSA id y9sm4491721wrq.55.2018.11.18.05.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 05:50:27 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
Date:   Sun, 18 Nov 2018 14:50:21 +0100
Message-Id: <20181118135024.30720-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clocks frequencies.
The precision is determined by stepping into the duration until the counter
overflows.
The debugfs shows a pretty summary and each clock can be measured
individually aswell.

This patchset includes the dt-bindings, driver and the DT node added to the
meson-gx dtsi.

Changes since v2 at [2]:
- Removed all reference to GX
- Added compatibles for meson8/meson8b
- Used Martin's suggestions on the divider naming
- Added Martin's meson8/meson8b clk id table
- Added Martin's fixes to support 32bit SoCs

Changes since v1 at [1]:
- fixed clock names
- added summary in debugfs and moved indivudual clocks into a subdirectory
- added the GX table to the match data

[1] https://lkml.kernel.org/r/1530624110-4687-1-git-send-email-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20181114131627.17766-1-narmstrong@baylibre.com

Neil Armstrong (3):
  dt-bindings: amlogic: Add Internal Clock Measurer bindings
  soc: amlogic: Add Meson Clock Measure driver
  ARM64: dts: meson-gx: Add Internal Clock Measurer node

 .../bindings/soc/amlogic/clk-measure.txt      |  18 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   5 +
 drivers/soc/amlogic/Kconfig                   |   8 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-clk-measure.c       | 350 ++++++++++++++++++
 5 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/soc/amlogic/meson-clk-measure.c

-- 
2.19.1

