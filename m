Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YT1BE8VoGls7TwAAmS7hNA
	; Fri, 08 Jun 2018 11:32:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2A49E6089E; Fri,  8 Jun 2018 11:32:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AFB56606FA;
	Fri,  8 Jun 2018 11:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFB56606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeFHLcE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:32:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:32416 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752769AbeFHL3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:29:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 04:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="62388985"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2018 04:29:46 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 2/8] usb: typec: helper for checking cable plug orientation
Date: Fri,  8 Jun 2018 14:29:35 +0300
Message-Id: <20180608112941.26332-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds function typec_get_orientation() that can be used
for checking the current cable plug orientation.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/class.c | 11 +++++++++++
 include/linux/usb/typec.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 53df10df2f9d..02db9bcbac0c 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1279,6 +1279,17 @@ int typec_set_orientation(struct typec_port *port,
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
2.17.1
