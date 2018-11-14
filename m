Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1D2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Pc86ONTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbeKNXTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:19:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40497 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeKNXTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:19:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so8070734wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 05:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kL8jvYvMFWDaNaJSeIaQxNfaY5lCTtC9sm3OCvvB3Wo=;
        b=Pc86ONTf9PAyRcDJ1tIMCOOdLR9umQFC7aDrVz8SQdjyToWPHXeZ2fTlDaUCAHr1MV
         hEY2G1E7R7+ZLYXg8BYtTnoy/RgG6P9S60EAaLUY/gK3WPq7FgR4a39Y1jAYvPSKRLks
         zE9RU0roJqNycoyFDmqxuoDY6vOkamfVRyegIbl7DC0g3/iDo98lNYgylSHLQrBe3vHi
         597B9YV57CeF19fUfTupzOPDJCLo0sWqp1DZRowRuw0n14TCMd4q48LejKRq80oLr+o2
         whVyKVlGSmzKgZeo/2p/DCl+P0/5QuIVasv+OPs46X0YRWa0a+ebp1ByCZUXFIRHQjCR
         aSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kL8jvYvMFWDaNaJSeIaQxNfaY5lCTtC9sm3OCvvB3Wo=;
        b=F/DFGyB05B3j+P84rHrNY64AFuMjpABPAajanV9Q8v1tYdPq7wQG2h4pkW647A7GGx
         T3Y64T/jzaFLlWG47Rsf3jXtB34oRYPAGcbepHmFXi9/fHV0ckzmQHTF9IRFB//yW42F
         SQs7O5tNMScSfpwdAYFALoYkhRyIigs5ONcX4gzlqrXKrCEW3ms+CG4y0dmfYacrRZve
         /yecMWKwAilYp22gBf54xDg1CyUc9QDeeRkdPBrVuceB/4y4mfsWFw+0LXPC5uW2uUoz
         ejLZN+pxJ/tOSicb9pjPUQ8xG4SjvSSvvm38ifGX1pqHslXFO2dAGhSZa+eHx6JbHmyv
         Q8yg==
X-Gm-Message-State: AGRZ1gJOwuNQxZI2mUIGd6FdpQxAUNbKyLvsgHd3fEN216L6owPemOzu
        PpgIcvUJgnp5V3TfqSW6tAtUnw==
X-Google-Smtp-Source: AJdET5dFcqF6BNZcdG5V6ZXXs/ShZ4GS+Jxs6rUNiHS/7F5fUn3jhBZqXBBB+dm9NmzAjUv1HyYuPw==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13-v6mr1842563wrt.298.1542201389864;
        Wed, 14 Nov 2018 05:16:29 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z7-v6sm22715225wrv.21.2018.11.14.05.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 05:16:28 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
Date:   Wed, 14 Nov 2018 14:16:24 +0100
Message-Id: <20181114131627.17766-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
clocks frequencyies.
The precision is determined by stepping into the divider until the counter
overflows.
The debugfs slows a pretty summary and each clock can be measured
individually aswell.

Thsi patchset includes the dt-bindings, driver and the DT node added to the
meson-gx dtsi.

Changes since v1 at [1]:
- fixed clock names
- added summary in debugfs and moved indivudual clocks into a subdirectory
- added the GX table to the match data

Neil Armstrong (3):
  dt-bindings: amlogic: Add Internal Clock Measurer bindings
  soc: amlogic: Add Meson GX Clock Measure driver
  ARM64: dts: meson-gx: Add Internal Clock Measurer node

 .../bindings/soc/amlogic/clk-measure.txt      |  15 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   5 +
 drivers/soc/amlogic/Kconfig                   |   8 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-gx-clk-measure.c    | 293 ++++++++++++++++++
 5 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
 create mode 100644 drivers/soc/amlogic/meson-gx-clk-measure.c

-- 
2.19.1

