Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C658C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AED20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AED20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLIWGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37100 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbeLIWGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:40 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73P-0002pr-En; Sun, 09 Dec 2018 21:55:59 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003FY-I5; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Martin Kaiser" <martin@kaiser.cx>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.437031256@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 043/328] mtd: rawnand: mxc: remove __init qualifier
 from mxcnd_probe_dt
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kaiser <martin@kaiser.cx>

commit 24f0ae995deb728076e3ea93fea1949a9775debf upstream.

Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
potentially be called at any time. After the __init functions are cleaned,
mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.

mxcnd_probe used to be marked as __init, this was removed years ago.
Remove the __init qualifier from from mxcnd_probe_dt as well.

Fixes: 06f255106923 ("mtd: remove use of __devinit")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/nand/mxc_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1360,7 +1360,7 @@ static const struct of_device_id mxcnd_d
 	{ /* sentinel */ }
 };
 
-static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+static int mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	struct device_node *np = host->dev->of_node;
 	struct mxc_nand_platform_data *pdata = &host->pdata;
@@ -1387,7 +1387,7 @@ static int __init mxcnd_probe_dt(struct
 	return 0;
 }
 #else
-static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+static int mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	return 1;
 }

