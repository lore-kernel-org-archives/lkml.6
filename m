Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-515744-1520865351-2-15399861633626304644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520865350; b=YvaibSHUvLRQzfW/O/Pm4i0urP/gvcKAgoAEFFnMhPtCgui
    sz4mJ7ej8swO/ER4wCPvR7wovdCO2qfCf29MIK7te/HfmmQW2FbPYTisXCSZEXDQ
    SOowgosAY98JXs29tJWZHfQfVroNgaR0Qk1AtsQ7cWZe3Gu57cyJELnmhUvS7NfS
    a0gdKnVPrOJ1Q93mo3P+TLVG/dNetLClrJtzB+QLIXUIWWhGxc/k1mMwsECeeCj6
    hONKvlwolVRpU/8fC6yiRBnRzFwhCuITH1UmiKaJLkUOqEMWzqPKwrqXlJ2nJ177
    D//I/nLXb1wh0vgZhdMwPrd6bXkpPMGI7lkXTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520865350;
    bh=+UWg8GGEEoPBVj1BPQYNMJBO1zbV+oBT6LsqFyW3p/0=; b=chtUM+9SzaI/
    h/tqjf0op7fNMdzNilA2zhI7NzAQaKx0o6Dxahq/qp19HP9qhXayVyUl8Ehunmjc
    1Ag5cKPhpO5gwxyb6614/k94uMl57b7HV9yT/VlC57lx1oIPw/bytzxkDCdXFBHU
    NQov07qzyIYh29TeiIjFWKyhwFo76Wl0AxoXL1x2qAAziS5rYq9htwiDdpXXt6FS
    mZgj0HA+ATQ/TfFicOKtPPVw4BubZvDuAZtELMzLR9UO0sarY/Ia6ffB527F+LMP
    YtFLzCF4TIXXC3iNwfDaRZXpueuUpSzfvE9I266EU92bUwKSK514ov4obOibI3nu
    HgruIQFLHA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeCLOfR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 10:35:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:22085 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbeCLOfO (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Mar 2018 10:35:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="37471089"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v7 11/12] platform/x86: intel_cht_int33fe: Add device connections for the Type-C port
Date: Mon, 12 Mar 2018 17:34:30 +0300
Message-Id: <20180312143431.82396-12-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

We need to add device-connections for the Type-C mux/switch and usb-role
code to be able to find the PI3USB30532 Type-C cross-switch and the
device/host role-switch integrated in the CHT SoC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
-Replace Andy's Acked-by with his Reviewed-by

Changes in v2:
-Add Andy's Acked-by
-Add Heikki's Reviewed-by
---
 drivers/platform/x86/intel_cht_int33fe.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 380ef7ec094f..39d4100c60a2 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -33,6 +33,8 @@ struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
+	/* Contain a list-head must be per device */
+	struct device_connection connections[3];
 };
 
 /*
@@ -172,6 +174,20 @@ static int cht_int33fe_probe(struct i2c_client *client)
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
+	device_connection_add(&data->connections[0]);
+	device_connection_add(&data->connections[1]);
+	device_connection_add(&data->connections[2]);
+
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
@@ -201,6 +217,10 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
+	device_connection_remove(&data->connections[2]);
+	device_connection_remove(&data->connections[1]);
+	device_connection_remove(&data->connections[0]);
+
 	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 }
 
@@ -213,6 +233,10 @@ static int cht_int33fe_remove(struct i2c_client *i2c)
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
+	device_connection_remove(&data->connections[2]);
+	device_connection_remove(&data->connections[1]);
+	device_connection_remove(&data->connections[0]);
+
 	return 0;
 }
 
-- 
2.16.1

