Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0A0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5162C2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGVJ6qMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5162C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbeKCD6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:58:48 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9CA20837;
        Fri,  2 Nov 2018 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184634;
        bh=Krofk7Aj0ma3dicA/jexx6jRYFCFyxPBlNrMvFTS51E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGVJ6qMrbRKJfIPhekwg0E0RO4pM7/Qf7RYE1N4R27u7PEY4qu5TWrbYjvYzEK0aQ
         cXD8kxmGbU3ylf/f4yfi0JAzIJ4sBEx0t32ofaZLhdw2Cem9xoH5dy++naOKFijDCg
         8WvyETUudlO0cOX40lIfvuhDWxIEEm61cYwSIi1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/143] usbip: vhci_hcd: update status file header and format
Date:   Fri,  2 Nov 2018 19:34:00 +0100
Message-Id: <20181102182901.479206232@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



