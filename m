Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04F2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8839320811
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8839320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeKQXyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 18:54:54 -0500
Received: from muru.com ([72.249.23.125]:54268 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbeKQXyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 18:54:54 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7A71D809F;
        Sat, 17 Nov 2018 13:38:12 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/2] Improve phy-mapphone pm
Date:   Sat, 17 Nov 2018 05:37:53 -0800
Message-Id: <20181117133755.9129-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two non-urgent patches to get phy-mapphone runtime PM working
better. Currently it only works when toggled from the userspace via the
sysfs entry for for "auto" and "on".

Regards,

Tony


Tony Lindgren (2):
  phy: core: Add phy_pm_runtime_enabled
  phy: mapphone-mdm6600: Improve phy related runtime PM calls

 drivers/phy/motorola/phy-mapphone-mdm6600.c | 71 +++++++++++++++------
 drivers/phy/phy-core.c                      |  9 +++
 include/linux/phy/phy.h                     |  6 ++
 3 files changed, 66 insertions(+), 20 deletions(-)

-- 
2.19.1
