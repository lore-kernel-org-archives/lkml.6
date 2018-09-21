Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84BCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036C21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1e9r1vF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7036C21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbeIUXhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390433AbeIUXhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:37:33 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B48821557;
        Fri, 21 Sep 2018 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537552056;
        bh=bXlsAOe+hLY9g1g5WTZiuoKX8skEXTS86lH3gMy7oAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1e9r1vF1v94vxtLvDvcDUZfqG/FXoWFYcUNIOm+7pXeKOTPEl+p0V7vGham+MHa09
         iN44hGuXKOSLukHJyEVeNmbe8Nv6mM9s48fVvOH9RBhNeovCRPbup0SPPP8mxKTQ9X
         lRIKSU8hBg1DUxIlcLMZqjC6YuNPmO9ylzVlwXnE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] ARM: exynos: mach/soc for v4.20 (or 5.0)
Date:   Fri, 21 Sep 2018 19:45:20 +0200
Message-Id: <20180921174520.9126-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921174520.9126-1-krzk@kernel.org>
References: <20180921174520.9126-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Nothing special, description in tag.


Best regards,
Krzysztof


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.20

for you to fetch changes up to f30858439e7db9ce9847eaedf440635fc6349c6e:

  ARM: s3c24xx: Restore proper usage of pr_info/pr_cont (2018-09-19 19:11:17 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v4.20

1. Fix imprecise abort during Odroid XU3-family suspend to RAM (but it
   is not end of work needed for suspend).
2. Cleanup and fix of SD card write protect on MINI2440.

----------------------------------------------------------------
Cedric Roux (3):
      ARM: s3c24xx: formatting cleanup in mach-mini2440.c
      ARM: s3c24xx: Correct SD card write protect detection on Mini2440
      ARM: s3c24xx: Restore proper usage of pr_info/pr_cont

Krzysztof Kozlowski (4):
      ARM: exynos: Store Exynos5420 register state in one variable
      ARM: exynos: Fix imprecise abort during Exynos5422 suspend to RAM
      ARM: s3c24xx: Remove empty gta02_pmu children probe
      ARM: s3c24xx: Consistently use tab for indenting member assignments

 Documentation/arm/Samsung/Bootloader-interface.txt |   1 +
 arch/arm/mach-exynos/common.h                      |   1 +
 arch/arm/mach-exynos/firmware.c                    |  14 ++-
 arch/arm/mach-exynos/suspend.c                     |  34 +++++--
 arch/arm/mach-s3c24xx/mach-gta02.c                 |  42 --------
 arch/arm/mach-s3c24xx/mach-mini2440.c              | 113 +++++++++++----------
 6 files changed, 97 insertions(+), 108 deletions(-)
