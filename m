Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F4C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A90217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfBIPtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:49:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:56601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfBIPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:49:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 07:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,351,1544515200"; 
   d="scan'208";a="114934975"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2019 07:49:16 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: bus: export to_mei_cl_device for mei client devices drivers
Date:   Sat,  9 Feb 2019 18:42:05 +0200
Message-Id: <20190209164205.1583-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export to_mei_cl_device macro, as it is needed also
in the mei client drivers.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c     | 1 -
 include/linux/mei_cl_bus.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index fc3872fe7b25..e5456faf00e6 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -28,7 +28,6 @@
 #include "client.h"
 
 #define to_mei_cl_driver(d) container_of(d, struct mei_cl_driver, driver)
-#define to_mei_cl_device(d) container_of(d, struct mei_cl_device, dev)
 
 /**
  * __mei_cl_send - internal client send (write)
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 7fde40e17c8b..03b6ba2a63f8 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -55,6 +55,8 @@ struct mei_cl_device {
 	void *priv_data;
 };
 
+#define to_mei_cl_device(d) container_of(d, struct mei_cl_device, dev)
+
 struct mei_cl_driver {
 	struct device_driver driver;
 	const char *name;
-- 
2.20.1

