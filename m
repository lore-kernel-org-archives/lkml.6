Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC38C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E186C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E186C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeH3OW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:22:27 -0400
Received: from www.osadl.org ([62.245.132.105]:36337 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeH3OW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:22:27 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w7UAITmL015957;
        Thu, 30 Aug 2018 12:18:35 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] usb: gadget: fsl_udc_core: fixup struct_udc_setup documentation 
Date:   Thu, 30 Aug 2018 12:16:59 +0200
Message-Id: <1535624219-17854-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535624219-17854-1-git-send-email-hofrat@osadl.org>
References: <1535624219-17854-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original implementation from commit b504882da539
("USB: add Freescale high-speed USB SOC device controller driver")
returned NULL on failure and an allocated + initialized struct fsl_udc on
success. The current code introduced in commit 4365831dadfe
("USB: fsl_usb2_udc: Get max ep number from DCCPARAMS register") only
provides partial initialization as well as returning 0 on success and -1
on failures. The function documentation is updated accordingly.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 4365831dadfe ("USB: fsl_usb2_udc: Get max ep number from DCCPARAMS register")
---

Problem located during code-review

Patch is against 4.19-rc1 (localversion-next is next-20180830)

 drivers/usb/gadget/udc/fsl_udc_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index e637afb..680b46e 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2234,8 +2234,10 @@ static void fsl_udc_release(struct device *dev)
 	Internal structure setup functions
 *******************************************************************/
 /*------------------------------------------------------------------
- * init resource for globle controller
- * Return the udc handle on success or NULL on failure
+ * init resource for global controller called by fsl_udc_probe()
+ * On success the udc handle is initialized, on failure it is
+ * unchanged (reset).
+ * Return 0 on success and -1 on allocation failure
  ------------------------------------------------------------------*/
 static int struct_udc_setup(struct fsl_udc *udc,
 		struct platform_device *pdev)
-- 
2.1.4

