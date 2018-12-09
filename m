Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF1C67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C459520989
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544356164;
	bh=wIZt+jQYqUS6fUV1d8DgP5TSupV7p7p2ygQwl0dXTEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1o8fvp2hYXJ1MUABPUiQuxcprRWiCEyGodnpWZDL3FPn6Ew8pYUA5LSXmudQxx7vP
	 cRJLIN5gnsTuFElCgRQPKxqfUwO8EF+w2n37Y82biDrjXmkjsEyLQcANa0yy7agcfu
	 LMSImT9GOv+XfJP45mt6c7VaQF0+xZGWr8K3bqHs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C459520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLILtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeLILtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:49:23 -0500
Received: from localhost.localdomain (unknown [178.38.170.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 105982086E;
        Sun,  9 Dec 2018 11:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544356162;
        bh=wIZt+jQYqUS6fUV1d8DgP5TSupV7p7p2ygQwl0dXTEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bvv0DObTdjnAiNNrObhg8N/zUEsJ20oK5aNmOV+JT6W+6wok3V6lyww+Qo5sVbyG0
         hproRJZPKO8JWyYdatj3Rmjb/Z+/sjnf5v+VNlW1zmn2O4HI5Db654N/YLDauoRhYV
         gPcWn5MnZn08XjPs613la/3cN+KIiu423cZcH+Pg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] ARM: defconfig: Exynos for v4.21
Date:   Sun,  9 Dec 2018 12:49:08 +0100
Message-Id: <20181209114911.25194-2-krzk@kernel.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.21

for you to fetch changes up to 24c8e4b85399b00f4ae96e7957b0eeaa374e9380:

  ARM: multi_v7_defconfig: Add TOSHIBA TC358764 bridge driver (2018-12-07 20:18:47 +0100)

----------------------------------------------------------------
Samsung defconfig changes for v4.21

Enable drivers in exynos and multi_v7 defconfigs for MAX8952, MAX8998
(Samsung UniversalC210 board) and TC358764 (Arndale board).

----------------------------------------------------------------
Marek Szyprowski (5):
      ARM: exynos_defconfig: Add MAX8998 RTC and charger drivers
      ARM: exynos_defconfig: Add MAX8952 regulator driver
      ARM: exynos_defconfig: Add TOSHIBA TC358764 bridge driver
      ARM: multi_v7_defconfig: Add MAX8952 regulator driver
      ARM: multi_v7_defconfig: Add TOSHIBA TC358764 bridge driver

 arch/arm/configs/exynos_defconfig   | 4 ++++
 arch/arm/configs/multi_v7_defconfig | 2 ++
 2 files changed, 6 insertions(+)
