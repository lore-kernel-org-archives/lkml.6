Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4909D218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfAYNP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:15:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:65210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfAYNPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:15:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 05:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="141283951"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2019 05:15:22 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] platform/x86: intel_cht_int33fe: Remove connection for the alt mode mux
Date:   Fri, 25 Jan 2019 16:15:12 +0300
Message-Id: <20190125131519.88416-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for fusb302 does not support alternate modes, so the
connection is not really needed for now. Removing that
connection description allows us to improve the USB Type-C
mux API.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 02bc74608cf3..fbd24daa7f8d 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -32,7 +32,7 @@ struct cht_int33fe_data {
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
-	struct device_connection connections[5];
+	struct device_connection connections[4];
 };
 
 /*
@@ -178,12 +178,9 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	data->connections[1].endpoint[0] = "port0";
 	data->connections[1].endpoint[1] = "i2c-pi3usb30532";
 	data->connections[1].id = "typec-mux";
-	data->connections[2].endpoint[0] = "port0";
-	data->connections[2].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[2].id = "idff01m01";
-	data->connections[3].endpoint[0] = "i2c-fusb302";
-	data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
-	data->connections[3].id = "usb-role-switch";
+	data->connections[2].endpoint[0] = "i2c-fusb302";
+	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
+	data->connections[2].id = "usb-role-switch";
 
 	device_connections_add(data->connections);
 
-- 
2.20.1

