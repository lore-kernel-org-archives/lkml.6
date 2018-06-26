Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE27C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C320F26E2F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI1bKaew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C320F26E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeFZT3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:29:03 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37263 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbeFZT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:29:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6-v6so18358066wrp.4;
        Tue, 26 Jun 2018 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OS1TVBgwkeKnhEXrjaJxSXw7lK2npkpf69eTiAJe1AQ=;
        b=nI1bKaewhP1kxvEqbc3DW/ZD2pg36G6TOvlOKZIpwQGKWDqlbFnhhdh2fI5N6a0ZHp
         zrv1sWyYYDKCRKMvZ+EA8tQrtzGuc+jexuigjkeLlyifLLI0rSe60BhiweVZmmeRXmxI
         iC9besiqIsAPZfZSfjiS8gtBKoZZDovtQ9XtQQ5HDUuyjMtfaqb1DOaJCbUirpsmBM9G
         2/8RlTo2nQdTKPILFkItRUgVL6UihRSyRyMQyZZK5n2Px0GM98N/RMCnmq5d8udSM46N
         dZwpCe1xRcyiaUGSC+FHaM21u+aTnCJHflLaQAhz9fKVx5LSHKYOs3E3MG7sI6WE79Js
         avGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OS1TVBgwkeKnhEXrjaJxSXw7lK2npkpf69eTiAJe1AQ=;
        b=Kk7yhC/fZhxKtQdyUS+xJ9WcYZaReC+0KJQxeimcVf+rLSfDiWmYv4x3agpD6i7rKB
         vbmukBoD7Ol5VwScHQNAXszdW6ubav/58Pt+noZq816ik2ZwhdpB0jqdOC7tjWuBFnGo
         1EQC1ENusUq9poangY0YZShWk9NHGcZczFCsfUEUoLtYk7OiAKBkKBr/X5w9ytwrk1R4
         iC7nmPyugZHwlIx82HcaLmBd2giCxMpt7LDzK+0wEV3o8o+Ke2T9AL8inHKReTo7DqpD
         XBEGjN0ZS64AuxToHoxGZx2LwWuKx3jovpaKiDqXR0qMlc7+J5wocVDzo7FJ+acZ95pk
         yLbw==
X-Gm-Message-State: APt69E2Ad3w/qoRi6WgfZKj+HPsEDPaNe1zgb8jw4pYI9fopeNQIf7tx
        Pa0GEM7K18WPj77GfFms0OY=
X-Google-Smtp-Source: AAOMgpfuXlPU6Q117L9ZHu48pp9+hO7yRYmEeQStMQT/RX9um0+iMRh4tFM5P8ALpV8N64f5P+ZdIw==
X-Received: by 2002:adf:ed52:: with SMTP id u18-v6mr2480872wro.262.1530041340481;
        Tue, 26 Jun 2018 12:29:00 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7A58.dip0.t-ipconnect.de. [91.63.122.88])
        by smtp.gmail.com with ESMTPSA id g11-v6sm1789197wrr.46.2018.06.26.12.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 12:28:59 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, sboyd@kernel.org
Cc:     pn@denx.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, manivannan.sadhasivam@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 0/2] Add clock driver for Actions S700 SoC 
Date:   Tue, 26 Jun 2018 21:28:18 +0200
Message-Id: <20180626192820.28237-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Actions Semi OWL series
S700 SoC with relevant clock bindings and device tree info.

Changed the UART clock using CMU instance and changes are
tested in cubieboard7 

Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (2):
  arm64: dts: actions: Enable clock controller for S700
  clk: actions: Add S700 SoC clock support

 .../boot/dts/actions/s700-cubieboard7.dts     |   7 -
 arch/arm64/boot/dts/actions/s700.dtsi         |   8 +
 drivers/clk/actions/Kconfig                   |   7 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 614 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 128 ++++
 6 files changed, 758 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0

