Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2448772-1519636198-2-5730812417830200743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519636197; b=C/7E3NOIh9IV3RaRC7zgYZc3Kihubkdwawu+3dBkYMD2PeC
    x7yANRRlSHacqODdMVeGEMVCIVM69lyKc3+gDnGxVdnaD2ktd/P67mzp4dxm9El2
    9SD8oe4+wFEtR2oGIyYeqc/UAVrk1+91EmxLdmcwimcF9gfpIdBLOd0pVL+uzyR9
    DMjJoWBnHtv/dUOBbJC/DeqE2JYrL+iGHpUyKxunDG704GjbQgkWcoEYBM47ojvz
    9fKZk8rHnXpIe/S1iParHUMR1cqb8QyRYYyX69K5itIkefQPbxQ7as+D6lV9H2Jp
    cctXU4yUBsd3YKTbRAWtyFPCUGUnV9fAn4OXm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519636197;
    bh=1iwCdCkNeN2vftlfioyF1vLH7n7WdRzozrhH9UfX2nM=; b=NiRplB394hE3
    teyNpbAvjBCueB/m4h7ZIl3CUHsZ73QvPfBeiTxOQBHCBti8HliUQ+XgSnqBTej9
    7O+5C6pPO7N7WXwrizSukeRBufzT5R6fWF+sMKj3ufVenMNdc3NoZxQsyxoopMIV
    EuilQH1RwVJgnhB2kDwrWlCmv327xwaXRYs5cDALyBfUoRuh92UOU0cJMHd2tUgE
    99Aw5/MUr2lWArIwtoZuE7slJzfHK0A1uOvEt4JA9dGk+ArHvxvq6q9Rd0hUXACw
    i+b2m/WAwvsbhOO2nPfaGJATjWyoZ9d1fdILWJLJt5JVqP2dQOyCj5gAJ5j1OFs0
    NQa4Bv9M8A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBZJJx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 04:09:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752218AbeBZJJv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 26 Feb 2018 04:09:51 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 11/12] platform/x86: intel_cht_int33fe: Add device connections for the Type-C port
Date: Mon, 26 Feb 2018 10:09:24 +0100
Message-Id: <20180226090925.29436-12-hdegoede@redhat.com>
In-Reply-To: <20180226090925.29436-1-hdegoede@redhat.com>
References: <20180226090925.29436-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to add device-connections for the Type-C mux/switch and usb-role
code to be able to find the PI3USB30532 Type-C cross-switch and the
device/host role-switch integrated in the CHT SoC.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Andy's Acked-by
-Add Heikki's Reviewed-by
---
 drivers/platform/x86/intel_cht_int33fe.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 380ef7ec094f..a3f8674f14da 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/connection.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -33,6 +34,8 @@ struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
+	/* Contain a list-head must be per device */
+	struct devcon connections[3];
 };
 
 /*
@@ -172,6 +175,20 @@ static int cht_int33fe_probe(struct i2c_client *client)
 			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
 	}
 
+	data->connections[0].endpoint[0] = "i2c-fusb302";
+	data->connections[0].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[0].id = "typec-switch";
+	data->connections[1].endpoint[0] = "i2c-fusb302";
+	data->connections[1].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[1].id = "typec-mux";
+	data->connections[2].endpoint[0] = "i2c-fusb302";
+	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
+	data->connections[2].id = "usb-role-switch";
+
+	add_device_connection(&data->connections[0]);
+	add_device_connection(&data->connections[1]);
+	add_device_connection(&data->connections[2]);
+
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
@@ -201,6 +218,10 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
+	remove_device_connection(&data->connections[2]);
+	remove_device_connection(&data->connections[1]);
+	remove_device_connection(&data->connections[0]);
+
 	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 }
 
@@ -213,6 +234,10 @@ static int cht_int33fe_remove(struct i2c_client *i2c)
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
+	remove_device_connection(&data->connections[2]);
+	remove_device_connection(&data->connections[1]);
+	remove_device_connection(&data->connections[0]);
+
 	return 0;
 }
 
-- 
2.14.3

