Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC4AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5810420869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5810420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbeKLGcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:32:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49306 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729750AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0000lL-2x; Sun, 11 Nov 2018 19:58:32 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001NO-Rb; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.377308543@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 017/366] media: omap3isp/isp: remove an unused static var
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit 3f4836beb2ebeb0211d9911d878a267d687e0e6e upstream.

The isp_xclk_init_data const data isn't used anywere.

drivers/media/platform/omap3isp/isp.c:294:35: warning: ‘isp_xclk_init_data’ defined but not used [-Wunused-const-variable=]
 static const struct clk_init_data isp_xclk_init_data = {
                                   ^~~~~~~~~~~~~~~~~~

Fixes: 9b28ee3c9122 ("[media] omap3isp: Use the common clock framework")

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/platform/omap3isp/isp.c | 7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -279,13 +279,6 @@ static const struct clk_ops isp_xclk_ops
 
 static const char *isp_xclk_parent_name = "cam_mclk";
 
-static const struct clk_init_data isp_xclk_init_data = {
-	.name = "cam_xclk",
-	.ops = &isp_xclk_ops,
-	.parent_names = &isp_xclk_parent_name,
-	.num_parents = 1,
-};
-
 static int isp_xclk_init(struct isp_device *isp)
 {
 	struct isp_platform_data *pdata = isp->pdata;

