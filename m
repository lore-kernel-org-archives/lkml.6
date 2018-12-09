Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFF320837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544356176;
	bh=7jGy5fK06sx5jssyFS+lxvgyeVglkdKuKLJLqNMGjso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o9r9FP8F2uZekcxptC+F5wR4KfyEVid7JOufXkGABX8FIX7lB1UcJIS5bKzxlurQz
	 l/Y9vdbKTp+McteY8ULTV7CKsR/JxjvW2fnfNnKjYDUEqdT6jUD8E+Kwo92/66IA1+
	 EDS2fqfDq8xHBN3uLsD09U6qQdz4kC2hVHYE19TM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFF320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeLILtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeLILt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:49:29 -0500
Received: from localhost.localdomain (unknown [178.38.170.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB2B208E7;
        Sun,  9 Dec 2018 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544356168;
        bh=7jGy5fK06sx5jssyFS+lxvgyeVglkdKuKLJLqNMGjso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHKU5dzXojYQ8FKlORxstTVV5p164koa7o3wf68zfpl6RjDhB/77f+SV1Jzn/S/qg
         4dxdHI1O9dmMCL1jPpDoubgTuZotw1yfRaDIfigi7Cyq6tQfJvbfjOr7hjUGmn6jmZ
         ZtR7BJ2+9T3VQgvH7mVigLToeCdmddTChXfSIX/o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] ARM: samsung: SoC/mach for 4.21
Date:   Sun,  9 Dec 2018 12:49:11 +0100
Message-Id: <20181209114911.25194-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181209114911.25194-1-krzk@kernel.org>
References: <20181209114911.25194-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.21

for you to fetch changes up to cafbc79e327f44411b8bd8bdc101b9e6c65ab42a:

  ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus (2018-11-18 15:12:50 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v4.21

Just cleanups of: legacy way of setting external wakeup interrupts, old
power management debugging functions and duplicated secondary startup
initialization.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (2):
      ARM: exynos: Remove no longer needed s3c_pm_check_*() calls
      ARM: samsung: Limit SAMSUNG_PM_DEBUG config option to non-Exynos platforms

Krzysztof Kozlowski (2):
      ARM: s5pv210: Remove legacy setting of external wakeup interrupts
      ARM: exynos: Remove legacy setting of external wakeup interrupts

Pankaj Dubey (1):
      ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus

 arch/arm/mach-exynos/common.h  |  2 --
 arch/arm/mach-exynos/platsmp.c | 26 --------------------------
 arch/arm/mach-exynos/suspend.c | 37 ++++++++++++++++---------------------
 arch/arm/mach-s5pv210/common.h |  1 -
 arch/arm/mach-s5pv210/pm.c     | 16 ++++++++++++----
 arch/arm/plat-samsung/Kconfig  |  1 +
 6 files changed, 29 insertions(+), 54 deletions(-)
