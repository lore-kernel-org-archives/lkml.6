Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168518-1519572404-2-4097758227142334831
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
    t=1519572403; b=ukRAt/hWUl9zOoiJXI+T9QpGYDxBJRMwZEczaGz7zArBfYL
    w17Fw81raPEEYoMK7ypSP+4iEYIi8RiSerLpaPS94LHMkhw4cm8GP84qC7Y3Bt6S
    aUZgFGZJBujmElqVhkoaio0sHPv55aTjjZfy/ASoZtgThoPiSqIYDpgoY2Q82gbg
    vi6bYHbXTvYxB6shXnnDVu8kMAKFbWOg2eqsFHvEux04LNLvjNJ4VLOd62AxcUzU
    p3DIQuau30NmzS+QWf9R4zTZh9gtMx/9nkmZfO5XhI2g9fGw/aTDrkN20GhsCqi6
    Ma8T0fbFNvi0DkYSg8yT1phFbbHtBmdcMjEcbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519572403;
    bh=1iwCdCkNeN2vftlfioyF1vLH7n7WdRzozrhH9UfX2nM=; b=wzSEdyHNlyvp
    vGnWGSx9jlU3fPoYI/Z0eOpE2UAsZHJV7oy/TYG44PgLZlkg1QhHWGoIuDtYPiGK
    cf2wB9GJ0wAlpYNXHU8OE89ttnu0x1kngR74ptLIi4eP1enMm3agcnpjODHg9box
    r+16ID5sDbAY4PNnoaffQAceRtF97cDcv86eKdlD+rSxqewfPou5d3BaKZ3hISKX
    w0ePc7B2+jDUKqlzd//DL72Bd+ozjAEMrr8S9LT/7wlGkw1OlXQTWVNfY8vm+SGb
    oAyoDgkga2UZ8HLLKs5dxMR7yX3yhvJVq0sizYbMwwP7ET9mIY6M/CgEEvbr9bJG
    v23cC3ghDA==
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
        id S1751875AbeBYP0a (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:26:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751857AbeBYPZd (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:33 -0500
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
Subject: [PATCH v2 11/12] platform/x86: intel_cht_int33fe: Add device connections for the Type-C port
Date: Sun, 25 Feb 2018 16:25:09 +0100
Message-Id: <20180225152510.10159-12-hdegoede@redhat.com>
In-Reply-To: <20180225152510.10159-1-hdegoede@redhat.com>
References: <20180225152510.10159-1-hdegoede@redhat.com>
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

