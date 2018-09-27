Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2525FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF9D21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUToTjPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF9D21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeI0U0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:26:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42144 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeI0U0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:26:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so1995012pff.9;
        Thu, 27 Sep 2018 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4wU85w7H+oaarIb16lBdT5BL2pUjU6Tw9xWJ71FPLqE=;
        b=AUToTjPO+0MqX+6ENrNwF633WKWlvDLyoVzwASb6SsgqLAnSvTfF8NJgfh7A1VMvgs
         h4xsAgi/BSXBOZZolVNqIyQe1aOO79jPtcgpLk3+cfAhsWG3PlyNQQ3QFWiZVeUG8emQ
         wTDUlmyC3+c7ZrQwEFSshXfntT2rulaSoR+5/AtXVadSK59IXlu0rXZ6SlisPzqQXfzJ
         Xo1sOnFvf7VksmBQS6Avd8sbVulJslpjMKk579tYJj07G+KwMf5nWQMXDRe+pWNVdv8v
         G9kbnkCmygUj3wEB91ekvZV0hphWBujgniSrABGzOZ+Fw8YL6kI2LgHgskYp1vGiB7bC
         yVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4wU85w7H+oaarIb16lBdT5BL2pUjU6Tw9xWJ71FPLqE=;
        b=JoumQqdT37KllT9QJGnNSYAT/QXQyK5PkmNNozdac4K0UFHRJCWOZ4SIPoBwJg++pF
         bPOKSweZXfBLGUNd5k3ma7nKReuI2qDB3Ur0wQrbJo7HjHhNnrTMppLusjCFo6KpewMn
         1bPC3AwCV9oojKzxsimUicFL4CvsuG7ytmjr9xFGVfjEf0yvAMm50hcGeWSK2g/luJaf
         2OXNCJA/g9SAwLre9TDlv6HxD0FeFAaRpN3aPFU2beqcH8Ugz8oTUeBFAptC9nadC3K8
         sA0BQReBTdIfvpGIzASHjc1lQQLzEKqzvQLW4wTqYWHbJiud1FJxNXycCfj6MgWlN8yo
         a6mQ==
X-Gm-Message-State: ABuFfoi/OFEOD1kJYBRTVRgfHi8LoLrP50/u9C4Z674hp0TQeEYPoSL2
        n+4MFmK66ht21hFq8IUpqCA=
X-Google-Smtp-Source: ACcGV639jB6sl3ck0qsKCH9YUBqLSujnZtUtxWzt+84QHN0YTGJWgYgn6uuMQ3yJ6YiyB3ISTM/Orw==
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr10048766pgm.225.1538057275678;
        Thu, 27 Sep 2018 07:07:55 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.185])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4259763pgr.11.2018.09.27.07.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:07:55 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv5 0/6] Add support for UHS-I on Exynos5422 odroid boards
Date:   Thu, 27 Sep 2018 14:07:32 +0000
Message-Id: <20180927140738.1006-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is series v4 since my previous patches were incomplete with driver
changes missing.

v5 changes.
drop the cd-gpios wp-gpio gpio pin setting, just add the pinctrl
configration to support write protect.

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
  ARM: dts: exynos: Add pin configuration for SD write protect on Odroid
    XU3/XU4
  ARM: dts: exynos: update maximum frequency for emmc to 200MHz
  mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode

 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  7 +++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.17.1

