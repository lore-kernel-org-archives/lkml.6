Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7204ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9E120854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N96x9NOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9E120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJYWoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbeJYWn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:59 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5414C20847;
        Thu, 25 Oct 2018 14:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476664;
        bh=OMVUQ7YV6kTqGfgt0cJeqKYdPOVuDiZ9n1GbNRX898o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N96x9NOUX/UHvJHoN//qtQwWsqH7wyiu1mvF8WTJlglrs5tSZWS9OgY0jsXXQcQbx
         MAgm2L1hXhbiyboHeoQ7CLSx+mosFS7btvEISc7TCK+b3ZrJ/SeyCByATJwzctQE+E
         p/FoN2YVRT709c5Ah2CRD3Oj6ajwV8oOZWdpaRuE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 06/46] usbip: vhci_hcd: update 'status' file header and format
Date:   Thu, 25 Oct 2018 10:10:13 -0400
Message-Id: <20181025141053.213330-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuahkh@osg.samsung.com>

[ Upstream commit 5468099c747240ed97dbb34340fece8ca87be34f ]

Commit 2f2d0088eb93
("usbip: prevent vhci_hcd driver from leaking a socket pointer address")
in the /sys/devices/platform/vhci_hcd/status.

Fix the header and field alignment to reflect the changes and make it
easier to read.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/usbip/vhci_sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 4a22a9f06d96..eb7898353457 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -34,10 +34,10 @@
 
 /*
  * output example:
- * hub port sta spd dev       sockfd    local_busid
- * hs  0000 004 000 00000000  3         1-2.3
+ * hub port sta spd dev       sockfd local_busid
+ * hs  0000 004 000 00000000  000003 1-2.3
  * ................................................
- * ss  0008 004 000 00000000  4         2-3.4
+ * ss  0008 004 000 00000000  000004 2-3.4
  * ................................................
  *
  * Output includes socket fd instead of socket pointer address to avoid
@@ -61,13 +61,13 @@ static void port_show_vhci(char **out, int hub, int port, struct vhci_device *vd
 	if (vdev->ud.status == VDEV_ST_USED) {
 		*out += sprintf(*out, "%03u %08x ",
 				      vdev->speed, vdev->devid);
-		*out += sprintf(*out, "%u %s",
+		*out += sprintf(*out, "%06u %s",
 				      vdev->ud.sockfd,
 				      dev_name(&vdev->udev->dev));
 
 	} else {
 		*out += sprintf(*out, "000 00000000 ");
-		*out += sprintf(*out, "0000000000000000 0-0");
+		*out += sprintf(*out, "000000 0-0");
 	}
 
 	*out += sprintf(*out, "\n");
@@ -165,7 +165,7 @@ static ssize_t status_show(struct device *dev,
 	int pdev_nr;
 
 	out += sprintf(out,
-		       "hub port sta spd dev      socket           local_busid\n");
+		       "hub port sta spd dev      sockfd local_busid\n");
 
 	pdev_nr = status_name_to_id(attr->attr.name);
 	if (pdev_nr < 0)
-- 
2.17.1

