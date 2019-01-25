Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1313218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfAYNQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:16:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbfAYNP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141283967"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:27 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] device connection: Add fwnode member to struct device_connection
Date:   Fri, 25 Jan 2019 16:15:14 +0300
Message-Id: <20190125131519.88416-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will prepare the device connection API for connections
described in firmware.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 5663003a95eb..1fb077f5a936 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -757,11 +757,17 @@ struct device_dma_parameters {
 
 /**
  * struct device_connection - Device Connection Descriptor
+ * @fwnode: The device node of the connected device
  * @endpoint: The names of the two devices connected together
  * @id: Unique identifier for the connection
  * @list: List head, private, for internal use only
+ *
+ * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
+ * platform firmware defines the connection. When the connection is registered
+ * with device_connection_add() @endpoint is used instead.
  */
 struct device_connection {
+	struct fwnode_handle	*fwnode;
 	const char		*endpoint[2];
 	const char		*id;
 	struct list_head	list;
-- 
2.20.1

