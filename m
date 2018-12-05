Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E34AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF8B20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF8B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeLEWbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:31:51 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:37876 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEWbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:31:51 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 2825C30087;
        Thu,  6 Dec 2018 00:31:49 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] staging: octeon-ethernet: delete redundant include
Date:   Thu,  6 Dec 2018 00:31:39 +0200
Message-Id: <20181205223139.2317-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cvmx-smix-defs.h is not needed by this driver.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/staging/octeon/ethernet-mdio.c | 1 -
 drivers/staging/octeon/ethernet.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index f67f95043887..2848fa71a33d 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -21,7 +21,6 @@
 #include "ethernet-util.h"
 
 #include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-smix-defs.h>
 
 static void cvm_oct_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9b15c9ed844b..0f70da4963ca 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -36,7 +36,6 @@
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-smix-defs.h>
 
 #define OCTEON_MAX_MTU 65392
 
-- 
2.17.0

