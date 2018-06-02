Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeFBD1z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 23:27:55 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37976 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeFBD1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 23:27:52 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 01/11] macintosh/via-pmu: Fix section mismatch warning
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmu_init() function has the __init qualifier, but the ops struct
that holds a pointer to it does not. This causes a build warning.
The driver works fine because the pointer is only dereferenced early.

The function is so small that there's negligible benefit from using
the __init qualifier. Remove it to fix the warning, consistent with
the other ADB drivers.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index ff1b518e9ebe..aea147bd8754 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -378,7 +378,7 @@ static int pmu_probe(void)
 	return vias == NULL? -ENODEV: 0;
 }
 
-static int __init pmu_init(void)
+static int pmu_init(void)
 {
 	if (vias == NULL)
 		return -ENODEV;
-- 
2.16.1
