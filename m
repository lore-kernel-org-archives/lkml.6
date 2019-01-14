Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E09C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BE420656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547505200;
	bh=3t/pyQRCB6Q5xZVSDZqImGxoZ0NiHWsJ4CnOHaezNAQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ADXbeDQF33IYEk5aTwtsdPKMabJfr8KKic+z71+tzFrAxu7OfmMSCEhM3Y1Qd+qtk
	 +Ki1G+YyQ60nfuEaivGwBwouLBLKu6Z+OxemLeX3BBHg8tPNuMt2xabWB3hYa3QFjp
	 EPVcuS0sJNH4l/bCNbV5O/21aU6Mhmm0YD5OYNg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfANWdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:33:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfANWdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:33:18 -0500
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B10920656;
        Mon, 14 Jan 2019 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547505197;
        bh=3t/pyQRCB6Q5xZVSDZqImGxoZ0NiHWsJ4CnOHaezNAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=eKnwq3nl7XPa+X9aeOVaisdBC6HGBtYhCSUr9Wgjh8XOYmEy5MYy/Op2CBDztf1Tc
         f5wZ0REI4EJM9zsYtXB2+iY2ax+3ppSVHK/fwmUSOvMHUoz5r5Yj03LZJoONP7n4l6
         9H5/YWAdPKrIjRbiEQzuE9nEdsCF8eZ65WMD1BTw=
From:   Alan Tull <atull@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2] fpga: altera_freeze_bridge: remove restriction to socfpga
Date:   Mon, 14 Jan 2019 16:33:12 -0600
Message-Id: <20190114223312.3254-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
since it can be used on other platforms such as Stratix10.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..da5786a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -104,7 +104,8 @@ config SOCFPGA_FPGA_BRIDGE
 
 config ALTERA_FREEZE_BRIDGE
 	tristate "Altera FPGA Freeze Bridge"
-	depends on ARCH_SOCFPGA && FPGA_BRIDGE
+	depends on FPGA_BRIDGE
+	depends on HAS_IOMEM
 	help
 	  Say Y to enable drivers for Altera FPGA Freeze bridges.  A
 	  freeze bridge is a bridge that exists in the FPGA fabric to
-- 
2.7.4

