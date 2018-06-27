Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17EDC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7267C25E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7267C25E5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965438AbeF0PVU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:21:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:43102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934481AbeF0PUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:20:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 08:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="67768734"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 08:19:55 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] usb: typec: function for checking cable plug orientation
Date:   Wed, 27 Jun 2018 18:19:47 +0300
Message-Id: <20180627151953.30942-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds function typec_get_orientation() that can be used
for checking the current cable plug orientation.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 12 ++++++++++++
 include/linux/usb/typec.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 53df10df2f9d..2b3eaa969f3b 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1279,6 +1279,18 @@ int typec_set_orientation(struct typec_port *port,
 }
 EXPORT_SYMBOL_GPL(typec_set_orientation);
 
+/**
+ * typec_get_orientation - Get USB Type-C cable plug orientation
+ * @port: USB Type-C Port
+ *
+ * Get current cable plug orientation for @port.
+ */
+enum typec_orientation typec_get_orientation(struct typec_port *port)
+{
+	return port->orientation;
+}
+EXPORT_SYMBOL_GPL(typec_get_orientation);
+
 /**
  * typec_set_mode - Set mode of operation for USB Type-C connector
  * @port: USB Type-C port for the connector
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 672b39bb0adc..a5f6433e218b 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -265,6 +265,7 @@ void typec_set_pwr_opmode(struct typec_port *port, enum typec_pwr_opmode mode);
 
 int typec_set_orientation(struct typec_port *port,
 			  enum typec_orientation orientation);
+enum typec_orientation typec_get_orientation(struct typec_port *port);
 int typec_set_mode(struct typec_port *port, int mode);
 
 #endif /* __LINUX_USB_TYPEC_H */
-- 
2.18.0

