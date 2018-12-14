Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F137C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D7820811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D7820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeLNI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:27:17 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:61763 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbeLNI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:27:16 -0500
X-IronPort-AV: E=Sophos;i="5.56,352,1539615600"; 
   d="scan'208";a="2834602"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2018 17:27:14 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.69])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 21ABF4068573;
        Fri, 14 Dec 2018 17:27:10 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: add support for RZ/G2E
Date:   Fri, 14 Dec 2018 08:27:03 +0000
Message-Id: <1544776023-13364-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HS-USB found in RZ/G2E (a.k.a. r8a774c0) is very similar to the
one found in R-Car E3 (a.k.a. r8a77990), as it needs to release
the PLL reset by the UGCTRL register like R-Car E3, therefore add
r8a774c0 support in a similar fashion to what was done for the
r8a77990.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 2ff7991..249fbee 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -540,6 +540,10 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
  */
 static const struct of_device_id usbhs_of_match[] = {
 	{
+		.compatible = "renesas,usbhs-r8a774c0",
+		.data = (void *)USBHS_TYPE_RCAR_GEN3_WITH_PLL,
+	},
+	{
 		.compatible = "renesas,usbhs-r8a7790",
 		.data = (void *)USBHS_TYPE_RCAR_GEN2,
 	},
-- 
2.7.4

