Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80014C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F7D2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWn1CtZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F7D2154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeIVNpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:45:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33899 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:45:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so6951264plo.1;
        Sat, 22 Sep 2018 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=43L5RYxkov+mXGNBoSYqfF3+NoflZDa7xEDlbzcJ+64=;
        b=jWn1CtZ+HHu++iHjXDm897aEmDwyFcwISwOnNbh9+LKMD1qVqejPQZ22ACPOv/tx+O
         ygzT9iGxAz1eNJavkDtUi0iPBkCPFbk02LUxEAZdtAcsig+nNr2kYQdOFynkOcBJss2j
         x/kb68iITAGqk50WpuRsaE7UM6hd4x3HTiG+KyvyPb7D/T+pE8MpPFXAHnpQgVKqLfUH
         dn2Y7ThUvOITjn0BBUsY9xwBYy/O5B5IFu22IgjPJo3gPhYIcsK8rgpsTki3xf8SQc2d
         nYzIVkfv0TtuTIXZmoo6U+sjjB1mqtGVeLRVbWy20s6uptqE4ZbrVYd0B/9RIlCjUsAQ
         io6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=43L5RYxkov+mXGNBoSYqfF3+NoflZDa7xEDlbzcJ+64=;
        b=fW4PMe5mZIpWdHmboCISGlrt8kTDVUhxcLCZkXSCudpFbbIDNxUq3rjgbb0GrJXP6M
         WAbnl9fud8zJkZjpGE2E36txwkJev2X7JRs3BiPnHloijN2eh1gSicJWSzCfA1r2Swkd
         b1/ilVNli5e1NY9BszHpxjatVQDhAOBWXY1NWT7V6ZYkvPvI2T3mjOcBbdMfCTJGaOew
         yHL+NedqAYdu27PLtRaDGWgfXJ0rUyiOsCNfEZj1Ue4VDpvQrMoDnDdMl6E35lzItDnp
         EkOlt8LjscjsbRdBsSySWCTrbqo4+9yLP4dHWTgZQQEmTMqHWpW3F63pN/FJB518+uOp
         Lolg==
X-Gm-Message-State: ABuFfojeRJbVOo4yVPvID9hcBHdqfYsMD75qtXII5dPBncPe90qbaI6N
        VM1MRDuQQ+lZscsy5hXZm5M=
X-Google-Smtp-Source: ACcGV63o3guMYKZDFalxsdlG8TEyH4MFldgayaWhd6bLBil0kofevniNPCvYBewbQZtu6U8ltloUYQ==
X-Received: by 2002:a17:902:bccb:: with SMTP id o11-v6mr1453571pls.167.1537602775711;
        Sat, 22 Sep 2018 00:52:55 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id f67-v6sm53219253pff.29.2018.09.22.00.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:52:54 -0700 (PDT)
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
Date:   Sat, 22 Sep 2018 07:52:31 +0000
Message-Id: <20180922075238.884-1-linux.amoon@gmail.com>
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

