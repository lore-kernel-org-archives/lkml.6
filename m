Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeETKQ0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:16:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45615 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:16:23 -0400
X-Google-Smtp-Source: AB8JxZponSvlhs1/JktHu/gByCx08ZSOQTEDjIppq8Q0NNp3WJ6ZFKLAPPNU8DlxJZdUFgCNoERzhQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v1 0/5] Initial support of Trusted Foundations on Tegra30
Date: Sun, 20 May 2018 13:15:37 +0300
Message-Id: <20180520101542.12206-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series of patches brings initial support of Trusted Foundations to
Tegra30, that is to the consumer-grade Tegra30 devices which do not allow
to easily replace the proprietary bootloader. Support is initial because
this series implements only a proper CPU boot-up (main + secondary cores)
and a basic L2 cache maintenance that is done using the TF firmware.
Suspend-resume support is missing yet as I couldn't get it to work
(CPU hangs on resume from suspend after awhile and seems that is related
to inappropriately done cache maintenance during of suspend-resume using
the firmware), it is work-in-progress for now.

This patchset is partially based on the work done by Michał Mirosław [0].

Please review, thanks.

[0] https://www.spinics.net/lists/linux-tegra/msg30368.html

Dmitry Osipenko (5):
  ARM: trusted_foundations: Implement L2 cache initialization callback
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Setup L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode

 arch/arm/firmware/trusted_foundations.c    | 28 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h |  7 ++++++
 arch/arm/mach-tegra/reset-handler.S        | 28 +++++++++++++++-------
 arch/arm/mach-tegra/reset.c                |  5 +++-
 arch/arm/mach-tegra/reset.h                |  4 +++-
 arch/arm/mach-tegra/tegra.c                | 15 ++++++++++++
 6 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.17.0
