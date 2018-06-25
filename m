Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E39C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF80E25CD5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="V3iWs3wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF80E25CD5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeFYP3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:29:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39823 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbeFYP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so8695543wro.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6cgHBGWHCM3sAZ4GvRn+ypfWW3wytwgQ7TtI3DsMek0=;
        b=V3iWs3wAE/db9zFXMMjtlgFWqvEknpYdbmSqBAV/FhHTeBL4wrVX5iw5Tc6gOuTwY5
         X3qWsBHQ1Vvs95nfb3kSnHuWRX1RfPEFUB0Tee1ccfR5BKB9vR0m+d7+0TN1ZUJ4gwH6
         eK9B2IPkzcnq3hI2E1OzYFVhgV8cNvNW2knFRcKElcn9HJ2QnEafqiwXiu9WPmgSlRk0
         pRJxAScQtmpJEwh9AVv9FqSWzLoBiyS8lijBidRly5vAU4XT9mk6xEDYJHEn73kd1rYd
         JxJWeKvifKXUul5jaMGDMDr1kKolPmS2vrvOIYWMqWtmvXTVU9dw5O2vgQJRr8AMKN4S
         GTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6cgHBGWHCM3sAZ4GvRn+ypfWW3wytwgQ7TtI3DsMek0=;
        b=O7Eg5Rx11c8JhEpIIh9Sw4sq87r09hH62RVgpK0KFUIArNmrV0S5zPrlEylCFkp0xC
         mrR/+vGfNh6J68zYaNg0/Mhl3aPAErkP9b8+ruNZPOzD9Ck7xsSCsECRw3xrdpedyVXK
         9VttIGoelgrEqdg3B5QQqlOaS3PR//0UxRoa7E6KvLsmNl3pJk7sa49IlDaj6zH79LMm
         3da0uem6pJvQaCeRgGbgvHU88Ywe9qYAk5Uxipuo3Vv2pjpWdQJcIbDMuLJX9wNN0mIF
         HqZ7d3ETz9kkZpIbuYpp68kdXgzQDG9rTjGw3aams7mfKnQ3FFFLaXLmAFeN16O8FC90
         AWtQ==
X-Gm-Message-State: APt69E1iUA8C9U/tjhOH4DkWCXSXuJyt8BpVhOb22mW8F1viKWLglje2
        SMKvAWq1caGcUEaD26eO/Uy8/Q==
X-Google-Smtp-Source: AAOMgpfhmRCJbaHXdUKEgzMRYJxZ0lRahU2N4snZzLdxLkTAXbIRnngW4qNf5ioQTHou8sRbstD08w==
X-Received: by 2002:adf:a14a:: with SMTP id r10-v6mr10237805wrr.104.1529940589959;
        Mon, 25 Jun 2018 08:29:49 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l15-v6sm18829174wrs.95.2018.06.25.08.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:29:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/9] ARM: davinci: deduplicate aemif support
Date:   Mon, 25 Jun 2018 17:29:11 +0200
Message-Id: <20180625152920.11549-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series moves all aemif/nand users to using the ti-aemif platform
driver located in drivers/memory instead of the older API located in
mach-davinci.

The first patch adds a necessary clock lookup and the last patch
removes the duplicate aemif code.

Bartosz Golaszewski (9):
  clk: davinci: psc-dm365: use two lookup entries for the aemif clock
  ARM: davinci: omapl138-hawk: add aemif & nand support
  ARM: davinci: da850-evm: use aemif platform driver in legacy mode
  ARM: davinci: dm365-evm: use the ti-aemif soc driver
  ARM: davinci: dm644x-evm: use aemif platform driver
  ARM: davinci: da830-evm: use aemif platform driver
  ARM: davinci: dm646x-evm: use aemif platform driver
  ARM: davinci: mityomapl138: use aemif platform driver
  ARM: davinci: kill davinci_aemif_setup()

 arch/arm/mach-davinci/Makefile                |   2 +-
 arch/arm/mach-davinci/aemif.c                 | 218 ------------------
 arch/arm/mach-davinci/board-da830-evm.c       |  56 ++++-
 arch/arm/mach-davinci/board-da850-evm.c       |  93 ++++----
 arch/arm/mach-davinci/board-dm365-evm.c       |  59 +++--
 arch/arm/mach-davinci/board-dm644x-evm.c      |  55 +++--
 arch/arm/mach-davinci/board-dm646x-evm.c      |  52 ++++-
 arch/arm/mach-davinci/board-mityomapl138.c    |  55 +++--
 arch/arm/mach-davinci/board-omapl138-hawk.c   | 132 +++++++++++
 drivers/clk/davinci/psc-dm365.c               |   3 +-
 .../linux/platform_data/mtd-davinci-aemif.h   |   1 -
 11 files changed, 400 insertions(+), 326 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/aemif.c

-- 
2.17.1

