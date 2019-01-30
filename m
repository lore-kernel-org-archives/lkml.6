Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA305C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C69207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfA3QDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:03:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:60152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731574AbfA3QDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:03:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 08:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="142760874"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2019 08:03:02 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] platform/x86: intel_cht_int33fe: Prepare for better mux naming scheme
Date:   Wed, 30 Jan 2019 19:02:51 +0300
Message-Id: <20190130160259.46919-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new connections with for the muxes with new
identifiers. The old connection are left in for now.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 02bc74608cf3..295fe19ad4c2 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -32,7 +32,7 @@ struct cht_int33fe_data {
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
-	struct device_connection connections[5];
+	struct device_connection connections[7];
 };
 
 /*
@@ -184,6 +184,12 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	data->connections[3].endpoint[0] = "i2c-fusb302";
 	data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
 	data->connections[3].id = "usb-role-switch";
+	data->connections[4].endpoint[0] = "port0";
+	data->connections[4].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[4].id = "orientation-switch";
+	data->connections[5].endpoint[0] = "port0";
+	data->connections[5].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[5].id = "mode-switch";
 
 	device_connections_add(data->connections);
 
-- 
2.20.1

