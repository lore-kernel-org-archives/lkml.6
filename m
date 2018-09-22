Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D05C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256742154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9GL/cej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256742154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeIVNu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:50:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41596 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeIVNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:50:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so6942460plr.8;
        Sat, 22 Sep 2018 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=43L5RYxkov+mXGNBoSYqfF3+NoflZDa7xEDlbzcJ+64=;
        b=I9GL/cej0YjUf2bGBQwCLfofg/cD5haGEIx0F7VM5oNn/xzJrkEbfxKFQw2ulEffdc
         1OYITKiS5Fme2/hK95uzI5jrpSwYex8Igs4DnHtumxhT8txKPkbyOQJCY+HA4alpeFB5
         YXEL6ahimtLsbDiABYZyj6fczHQJDPy2yEqZf40vvjbVGAo1Nh82QcO5Z2N8LFW4v4Ai
         2FHs4iZ1wCjkI2Rzabs04KgTPdHh6LAGV+5X8nzdbPDuDPTcsrB/22UlnvlgEPe/FT9z
         V1FsGWg2DqGRzzYrvAXZYO+Zu1ZRSscV2hvKZKYpo5B4aY2DbMfUrf3P0fbBlGIsPV3D
         XnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=43L5RYxkov+mXGNBoSYqfF3+NoflZDa7xEDlbzcJ+64=;
        b=Gl1423oGQEu+E1SgXV/mDFbkIeCNKtqVu7kDbTTe0BWqMDf1FeEc855/LUERJXaf1E
         UwlIKStBgyjZBc3gJsPcyusv9AWoHZhT+sbXk/owmr7eZZUpAQUKl8piNnWggdhvrZfI
         x+3BBSxBWQ7f6VPx1t7/PF4TCd1pqHBX47NEc0btefMK+LKXFaQuTyzPwdPfwHEsTjvg
         1Ef+Gqeb+vzpy9otxaYWsysPlaks1BP/x0EqtU4pk/HGvCeb3Y+IRyMtnfmfONMWkJm/
         o0qpjviJQDiXVh2E5zaKPTV+2oSVATn9F0l/yOvkAM+otHeNMayMBe5CZwhzBS3J6tEX
         7ONA==
X-Gm-Message-State: ABuFfojSkGyZBevYY/wdeXjMCYc31ZGZbSciV+dwacaS23lVj7BoM2Eh
        Zy0n9/LZRoSMrw2ovUSc3BQ=
X-Google-Smtp-Source: ACcGV61bb6W4j1/KzIn1QUzL0iQUVU+eDcl/pzV4xmpcuEo728qpNj/640dhAUys8u7WCQ0Q9qny5g==
X-Received: by 2002:a17:902:599d:: with SMTP id p29-v6mr1455281pli.74.1537603068787;
        Sat, 22 Sep 2018 00:57:48 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id o10-v6sm30713164pgp.70.2018.09.22.00.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:57:48 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv4 0/6] Add support for UHS-I on Exynos5422 odroid boards
Date:   Sat, 22 Sep 2018 07:57:31 +0000
Message-Id: <20180922075732.946-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is series v4 since my previous patches were incomplete with driver
changes missing.

v4 changes.
squash cd-gpios and wp-gpio changes into single patch.
change the subject prefix to "ARM: dts: exynos:"

These changes add UHS-I tuning for dw_mmc-exynos driver.

Rebased on Krzysztof branch next/dt
[0] git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git 

Anand Moon (6):
  ARM: dts: exynos: Added UHS-I bus speed support
  ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
  ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
  ARM: dts: exynos: Add CD and WP pins to Odroid XU3/XU4 SD card
  ARM: dts: exynos: update maximum frequency for emmc to 200MHz
  mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode

 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  8 ++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 10 ++++++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.17.1

