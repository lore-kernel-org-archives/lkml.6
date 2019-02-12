Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFE3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB07217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="U4x9msIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfBLPjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:39:44 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:60748 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfBLPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:39:43 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 813D410C02CB;
        Tue, 12 Feb 2019 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549985983; bh=OE9qQw9ve0ht3xIKtnw2eYLPWwfCcyW/mfFoth1JFqM=;
        h=From:To:Cc:Subject:Date:From;
        b=U4x9msIKR5qsPi2/EckSnokzpgStvMXwbpak8VFY1f8gKhq8BnG3otqGydfwUDz5f
         XAxPj4C1xI7xiEnpOA1Su9qJ7Qs24WpM4jkwjzHNtZWg+E9rnAyKYU06+M2xEsAjBv
         O3BiR23btiDM3uYNunsknaAc4+C6n0HcrWorkOyhIcDDvVe+PRsFup3zp828js4XS6
         m5NkZHwRRz0u3wPbJk41CZbjkaphTg6+ZWScytdJ2xhRYfIY4EvF+JZa65xipDpglt
         gONZJ9xKZ8qmDXiOJ1Vt/+DJ9CQ2+Kh3f9SufaoTcgJ0uOLavWepQOftFl17punRjF
         0j5x5OP9lPh9Q==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.62])
        by mailhost.synopsys.com (Postfix) with ESMTP id 46CDBA0090;
        Tue, 12 Feb 2019 15:39:39 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 0/2] RC: rework U-boot arguments handling
Date:   Tue, 12 Feb 2019 18:39:30 +0300
Message-Id: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reworking U-boot args handling and enable uboot support
unconditionally.

Changes RFC->v1:
 * Don't add new ABI contract between kernel and uboot
 * Eliminate CONFIG_ARC_UBOOT_SUPPORT Kconfig option and
   enable uboot support unconditionally
 * Skip invalid U-boot args instead of panic
 * Check existing U-boot magic value
 * Improve uboot_arg validating
 * Minor code changes

Eugeniy Paltsev (2):
  ARC: U-boot: check arguments paranoidly
  ARC: enable uboot support unconditionally

 arch/arc/Kconfig                        | 12 -----
 arch/arc/configs/nps_defconfig          |  1 -
 arch/arc/configs/vdk_hs38_defconfig     |  1 -
 arch/arc/configs/vdk_hs38_smp_defconfig |  2 -
 arch/arc/kernel/head.S                  |  7 ++-
 arch/arc/kernel/setup.c                 | 96 +++++++++++++++++++++++----------
 6 files changed, 70 insertions(+), 49 deletions(-)

-- 
2.14.5

