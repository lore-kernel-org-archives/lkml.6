Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468FDC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133C620892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133C620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLBVPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:15:50 -0500
Received: from www17.your-server.de ([213.133.104.17]:57638 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeLBVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:15:49 -0500
X-Greylist: delayed 1230 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2018 16:15:48 EST
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYlo-00015m-9K; Sun, 02 Dec 2018 21:55:16 +0100
Received: from [2a02:908:4c28:3f60:fff6:43c5:695c:41d6] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYlo-000248-3f; Sun, 02 Dec 2018 21:55:16 +0100
Subject: [PATCH] PM / AVS: SmartReflex: NULL check before some freeing
 functions is not needed.
From:   Thomas Meyer <thomas@m3y3r.de>
To:     khilman@kernel.org, nm@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1543760930051-514988180-4-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 4
Date:   Sun, 02 Dec 2018 21:52:11 +0100
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25173/Sun Dec  2 15:13:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -1010,8 +1010,7 @@ static int omap_sr_remove(struct platfor
 
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
-	if (sr_info->dbg_dir)
-		debugfs_remove_recursive(sr_info->dbg_dir);
+	debugfs_remove_recursive(sr_info->dbg_dir);
 
 	pm_runtime_disable(&pdev->dev);
 	list_del(&sr_info->node);
