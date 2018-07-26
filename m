Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F35DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95720844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xHWsQQyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A95720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbeGZOCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:02:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbeGZOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:02:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so1596858wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3SUlYiaOGZ9DNx+9WIinv3apEkr5veTR81fDOvIirSw=;
        b=xHWsQQyW9rRObA7sB6pQ3SWh6w7O1JWjb2Gi7TkLiqTtZCzngUyI1AS4lc97Cz4jyh
         G3qxEBD7PDZ0Xorc+a/o3E3cAU1VqfFvyC+ciTuBgO7D/auShLfCGhqZBha7iL6EDJ8B
         AM3RJ330VkqIT7OWw8vqk5vB8perWAD2gZUASCTn6yVLPNdjSY1qKCMqNaQvAZrFLxNG
         i6zuXStzCw3T3CNBqPd3KH+zZ6JYr1I3h4yiUaAImSG+62ohxOUhLf06f2mhenHxPcTf
         0h2Wre9+8CXc8/sLKioxhO+NbpzQqYJF3xkiAvWTKzX1jteRzsb1y+XcY+eJc3W21nYY
         TbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3SUlYiaOGZ9DNx+9WIinv3apEkr5veTR81fDOvIirSw=;
        b=fGYrI8TP9Vq7BUyPWfJitt60Sj3nh1fPynSjdMRFLyfElBX2nv0vmEHRKAFlyfBEq6
         3YmEOhx8JqWv/vwmPHjIOVyzlEmyNaUHfWgHoM+tyvowGKJkyXXUNZwhHSTmzPqFHKuo
         j534LORckgl+3MfGK/oBIX2YJkYPQYtQndyfIyZedu933sKqORv3K236nKtW/Pbi8FVm
         zY+Cwl8iF4LwWLN674b4B4A7HYbqtjbHRYBh1Yx/cJ9gUdX8FBB0sIfUTcYjvM+wNQtB
         RNThUTqo7NEnvogThAHvUKW0YJQE+9zR6JHhigdSbogYo6yLnIfQq0M2EFw/2uvBe55w
         zAlw==
X-Gm-Message-State: AOUpUlGB/OAcsF3i3B6oUYN8IVqLK5QqWjoHFb5ZpJecuxLLij7VwnM0
        /qDwi0DCPj9/zdwo8bA/6FZzIA==
X-Google-Smtp-Source: AAOMgpfDSFryiFkiEvv6K0Mi+pa0ij6Tptr4U6dl4bYHnnbI5te6xi2Yu4U0ho6KxJ4ncsvg3/5QNw==
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr1603863wrj.212.1532609149692;
        Thu, 26 Jul 2018 05:45:49 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m207-v6sm1867744wma.31.2018.07.26.05.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 05:45:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/3] ASoC: meson-axg: fifo and card fixup
Date:   Thu, 26 Jul 2018 14:45:41 +0200
Message-Id: <20180726124544.14740-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to solve the problems which have
been raised since the initial axg sound support has been accepted.

Jerome Brunet (3):
  ASoC: meson: use IRQ_RETVAL in the fifo irq handler
  ASoC: meson: update axg sound card bindings
  ASoC: meson: align axg card driver with DT bindings documentation

 .../bindings/sound/amlogic,axg-sound-card.txt | 68 +++++++++----------
 sound/soc/meson/axg-card.c                    | 12 ++--
 sound/soc/meson/axg-fifo.c                    |  2 +-
 3 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.17.1

