Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615DC2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsl6yxUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615DC2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeH3W7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:59:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45550 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeH3W7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:59:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id u83-v6so8089363lje.12;
        Thu, 30 Aug 2018 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BYvS0O5X6jqdECcgyHa7h20uv2YPuOkJVyKAAqt1BCE=;
        b=Jsl6yxUDup4y8qtj0Siw+BBVOGT8P22tzEliFf5NYwy39KkOxtdDELmNUMjvdqrwfI
         x2nmVH0sbLqYfOZ4qU9TMljfAy2qNHHbwLy27BTdgUl3w+bdmrxN5tyC3VaBteVJhy1p
         PdL6tZPrZVbTeHjhZ2wJg0Zhh2wbHNkqhB78DXKUqZ1TpxrXIkukHgma01ykFKKU/F54
         a4f2oF/X6kB1uMusqNagU9Fq1pJf0/cDR3hwZZ48/a0vlkb4GpjrOTAsgmhAxy2HS/Hv
         dzxYC5b3tcJbGFQVLIUFz65dJ1qyrQcbpIiBEpTh7MZA9ysNBU+5jYO7mpWobD47HfVW
         zTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BYvS0O5X6jqdECcgyHa7h20uv2YPuOkJVyKAAqt1BCE=;
        b=Yajurdr2zgZ+byqD4T1UkMZWIFkF8ent/5eOHeHHwwRkvSH14/qBleLZXnn7N6MPff
         2G1ehsOUp/8g+qWegc5eukSedwrI5HvSGkvZCFQTvJf4c5jBODUchQdBQin0nvxYfCUM
         DIpsblnOjKXctar32IBmIKMJs2Pw5vpQCCz2dauOA6oZYlA31eFfy45sn6afHPeAQ9As
         M+fc69ETlTbTZshaUO97gjUg0bJvFgTFsDAgf3rHcFdXS9MR+/NDHMtgc6MUchxljqm5
         5AGUuXhTm/z+EipQABbdMmE/3wWwntKe4uYOMm7ircC8KQMps6PguaJywGv/qfuoiWbu
         vLAQ==
X-Gm-Message-State: APzg51Dp3SYbSgRwv5yG5GyJj5ixZkdx6FHThrKOa1Jg/G45lckyAyo7
        cy9NMfOPViuY+2EiFJF3pQZzvODq
X-Google-Smtp-Source: ANB0VdZIuA1xn//SKZcAKX3sE4MAcbqDumW8slG2N7p0o+LBPWqWPbnUYI/bh+J4TQ97wiVAurTBFw==
X-Received: by 2002:a2e:2bd3:: with SMTP id r80-v6mr8529105ljr.57.1535655332936;
        Thu, 30 Aug 2018 11:55:32 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1373087ljd.61.2018.08.30.11.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:55:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] EMC fixes for Tegra30+
Date:   Thu, 30 Aug 2018 21:54:00 +0300
Message-Id: <20180830185404.7224-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series fixes couple bugs in the memory self-refresh code.
The EMC / MC state is properly restored after patches being applied,
please review.

Dmitry Osipenko (4):
  ARM: tegra: Fix missed EMC registers latching on resume from LP1 on
    Tegra30+
  ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on
    Tegra30
  ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+
  ARM: tegra: Clear EMC interrupts on resume from LP1 on Tegra30+

 arch/arm/mach-tegra/iomap.h         |  9 ++++++++
 arch/arm/mach-tegra/sleep-tegra30.S | 32 +++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.18.0

