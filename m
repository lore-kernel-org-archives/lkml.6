Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A9C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DC020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYsfKjBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DC020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeILTsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbeILTsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:48:23 -0400
Received: from localhost.localdomain (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4062088E;
        Wed, 12 Sep 2018 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536763413;
        bh=mP4Bf0/c/wBawATTDnhsc+tAbQinsJif7dRSNWsHxGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYsfKjBFrT32XECqqT3CmQvtSzM6uy+wC3KpPHd6H/YhxDCz60O1QOCwRVnLNwrnu
         ndvmv6q1foCredR9UHxG4gcWgF1QmvDZAy5Y5c1OyJK48p8z1V+cl8oEw259wRJ6UU
         1FwOFrTyVqQLxYzA/yRN7ocUFyWqSuEn6XmXcXJs=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 2/5] fpga: bridge: fix obvious function documentation error
Date:   Wed, 12 Sep 2018 09:43:24 -0500
Message-Id: <20180912144327.3130-3-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180912144327.3130-1-atull@kernel.org>
References: <20180912144327.3130-1-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fpga_bridge_dev_match() returns a FPGA bridge struct, not a
FPGA manager struct so s/manager/bridge/.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 24b8f98..c983dac 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -125,7 +125,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
  *
  * Given a device, get an exclusive reference to a fpga bridge.
  *
- * Return: fpga manager struct or IS_ERR() condition containing error code.
+ * Return: fpga bridge struct or IS_ERR() condition containing error code.
  */
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
 				    struct fpga_image_info *info)
-- 
2.7.4

