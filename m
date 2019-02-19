Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="csNkuCjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfBSLkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:40:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33939 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfBSLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:40:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so10038025pgd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 03:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DQZHSSspZBlsenwx5k5O9poRCEoCd4P+xUehuph/A9U=;
        b=csNkuCjUKGsXUpAI1PL2/U6szs9hyeTkh9euBYymEkdYBep5pyzOlMSkrsjEI4z77S
         J9Lq9z7Fgr6mS4iG5LpBgJNoLx4I2LTCB7glT/LXhiUptGpYS7uu+TjlsPaLyA45R4tt
         HPyujdnm7H4RMlSEFT0Bk9G6ctVZo+5R9OWo00gSpf54NSFRR/HRwhqLcgKRivwpXvKy
         gKGRgH5PfBSd3nyLrZre1Mem8YPMyan0SGoV45KCAFaqxGTf/Zr7a76pP7qIz0qoX8Xg
         VWbuOYGm7yNLQ9OV8paJNG152aPPts9H/iOsURpkv2uBBrDSDjnzay3FjgyhlEUM4Exu
         Tq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DQZHSSspZBlsenwx5k5O9poRCEoCd4P+xUehuph/A9U=;
        b=M9zMc8SxKMtcLeVE2WfK9xXQZCG/S+jYjd3CF3jyzGf4TLhOzFoK644rBYB8ivapdp
         mKnaz+D1JVvz+emSF9YJN+62VrxEvUujGxTyIsYiglDQYoswM6eLmPfPVZZ5iQylWl7T
         Weaqg6n9Y20t7+hE1hslmPVPi/2RHiQr31HqTuz9ehlaom0QCKYhgHvb8sACUcJj3q0l
         /Nq9i3eg8BxpUyl9G2uB6d/fgA+6h1B64HoGiPWdYlTdSFRYsOgoE1grdoEEGE4+v89d
         YZiyJTTh/98NiVWoW5NsyBL0PfggESdWGDkHbknqQPXGogFFO8dNksH559LLWRvdXOWv
         xnMQ==
X-Gm-Message-State: AHQUAubFyiJKDanhZ98wMg//x4UG04BWg+IYqFnzvwGciIqLnUq/yT9r
        QAXJS+UP/jIWEdtZfHzW0IDrJw==
X-Google-Smtp-Source: AHgI3IZclla3/S38bs8rCfTC1zJTe7P4s7pX6RBtEQGf/r8s4L3fqc0TDfoVZ+3j1ctCuFiW0RaD7w==
X-Received: by 2002:aa7:83c2:: with SMTP id j2mr28839490pfn.119.1550576444085;
        Tue, 19 Feb 2019 03:40:44 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id t3sm32250678pfa.50.2019.02.19.03.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 03:40:43 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] SPI support for HiFive Unleashed
Date:   Tue, 19 Feb 2019 17:10:05 +0530
Message-Id: <1550576407-17778-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a SPI driver and DT documentation
for HiFive Unleashed board.

Yash Shah (2):
  spi: sifive: Add DT documentation for SiFive SPI controller
  spi: sifive: Add driver for the SiFive SPI controller

 .../devicetree/bindings/spi/spi-sifive.txt         |  37 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sifive.c                           | 450 +++++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
 create mode 100644 drivers/spi/spi-sifive.c

-- 
1.9.1

