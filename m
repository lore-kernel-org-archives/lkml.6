Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85506217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfBFOhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:37:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:54675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfBFOhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:37:21 -0500
Received: from axis700.grange ([87.78.226.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6vSj-1h5kJF3Sth-00wlO6; Wed, 06
 Feb 2019 15:37:16 +0100
Received: by axis700.grange (Postfix, from userid 1000)
        id DCC9A61D03; Wed,  6 Feb 2019 09:06:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by axis700.grange (Postfix) with ESMTP id C75C161CFC;
        Wed,  6 Feb 2019 09:06:51 +0100 (CET)
Date:   Wed, 6 Feb 2019 09:06:51 +0100 (CET)
From:   Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-X-Sender: lyakh@axis700.grange
To:     linux-kernel@vger.kernel.org
cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: regulator: fix device unlinking
Message-ID: <alpine.DEB.2.20.1902060904060.14292@axis700.grange>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jHUsWiGGIbZ2NUEFFdIRl77IkXczcVIqILzHlay5Cc/OFxbxDOo
 NizEXraMUVz4V1FnHDWFcydhjPzqb0kTdFHl+NLADLaIaMhJeJ737W6mbAtoqhXQ78nd3Mq
 4hbycjAERu2MVjEoM87p8A0aIDzIq1u60TcanoRA7k/Nn0qkDYhjohpAHrppkoj3Labcyyw
 DwQopO8uFM4TGxfTmYBgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dk/dnJAx/Lc=:dsCq9M+T6G2EUlBkuow6bG
 EjPnDQPEkHq/z/1PJC94mEs3bDIR1A7IWjmKuuz7EFYB5cw1yp5acnGEsONmYbvfQPwutwNUH
 OhI15X/1tWyI4aYGRNK2h75Hlpxs9YsJKp+cej+E7VzXBFbt2p6ITkPvv/54CrEVvNfQU9oEH
 Ujb/iB++oPgjKt7PaaM6vIS5vpnhsAjrt9WRFCMgaA4da0zOfOFwBl64b2rpNu1RU7kWHQTi2
 ESNBLXLwaHrGu+yVoafhaNvqP0wlBfcsZbvGWAFbGUUD/rky4e0gqASyMsXX1ob2aAqXW4niA
 JGH5PE157pvEszO7p7CglGx8CHXONLFCOjcXEG752FK5s9khwUmyTIGwDngVpVjzaPvnZU3V1
 zMxjaJ/TsmPTjUKHJgK/ii8MZ0QpkbQjPMBNET3moAK85ejXUH8ucFbGBCbtEYuZiCaij6Dd+
 nIa5LyrXkVUyx0l5H75jz1zF8MTEnrMj4ZT+8BuDI3ndhor4O/41PeapKncbZzFNuEFtkgT/r
 jjYKuKPfK2SJy6dN3dh/sbVNvww6M6mMGYJWrCRmKmwXkqEcwqrvPL+0ZU4H/lIQVBxORjGDO
 HeHb8v6P/+73DDdfokHAiG+qFkdKmGPVNbItlmSklJEsHYMKTVFv/vsBd6eIaf9YWLPeaHOdT
 X2a+Dx6H75IVsqie84J9aMszC+xw0+rivNkkxQ+7q04yGGsmXA6ayswWvyX6wRvRIgZdy3UFc
 9GWV/qM54Ia+7VpZRwWdgY8N8k3N4urPo//zyk3V9uoM5/yYHmfYhINoL6ps4eg3p2w3pkD1j
 9I/gqvdznHBT7oPURjBwiV7Oq5iXAAcRNR9Bu5qaJObH2jivjta/ILACXmY7kPSyy1pHjxe2l
 l8d1NTzJ63fswIIokJyQ6bTBwzaTu/LQlqsMldaj8Zl6AYnznB8FNS/3p9035Q9e6h7NInRz5
 H7eB6apEi8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Device links are refcounted, device_link_remove() has to be called as
many times as device_link_add().

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/regulator/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aede..342102e8bc21 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1837,15 +1837,7 @@ static void _regulator_put(struct regulator *regulator)
 	debugfs_remove_recursive(regulator->debugfs);
 
 	if (regulator->dev) {
-		int count = 0;
-		struct regulator *r;
-
-		list_for_each_entry(r, &rdev->consumer_list, list)
-			if (r->dev == regulator->dev)
-				count++;
-
-		if (count == 1)
-			device_link_remove(regulator->dev, &rdev->dev);
+		device_link_remove(regulator->dev, &rdev->dev);
 
 		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
-- 
2.17.1

