Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELtgpr5pcBm4azU8P2H5Uepx8ADU7Uuhe/Zm3U0lvBzDxmm6BGg/09PdrC1NqgKHmt4OIze9
ARC-Seal: i=1; a=rsa-sha256; t=1521550676; cv=none;
        d=google.com; s=arc-20160816;
        b=QDeLraMdYl3IwZ488ao0bTGR1SFrXy+zY78RNnbylFoXhcRNJyV5psx+YShlQ1SKS4
         jFeO1KhoKIW7hGY8cdZ//vPrc1atndi9gFK2HG0+xSqDWxhlqGCPoeN3AnnBYU8FC/rm
         nTMJXmAR1MDjNGWZL50iSG3xNIWduOE08CI3jx0xWeq1qCK9u97PNbb/Ba+HqN1exrh/
         NJSFV+bDu/c+pzuzOEhR7thAqda+eZ0sFGRx+OBBLb+nX9KQQCTYF5SfPkTdE6ewZ1b7
         Z/gdiARHodEjEMEcJNTMGqdqD5gJAiFWfzcRLsAsM7S9an3xFl6obI2R7S96x43QLRe/
         PpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HX0pgSAs6Tz3z0tSkMJYDLlb27EOO5rJ4WAdQIis+VQ=;
        b=a3LXINOho+PYz452s7cvli2/cxlWoC9OtwUmJ5cBVm/C3kFPt1ys/bQDVcMZfNjfqm
         hxvirH9ziTfn7ABmSYiVUMRzOTpeCjIEibEAB28Se+D6kQ2KnsD6TtexUTozR0SVIxnP
         VFRddE1C2kjkfCOXmtV0R79RXoRRX1jO3p3Q6RM+9yU2LXf//HnDBwb/x1rNYA5b7Uty
         hyQu74hd1uqZuYfGHozk7ltQ13r+LBFiwR9RX4no61KoV6vRbdxGSXEAvNIZ++mMoP+G
         IooWs23plSFk8WZYH+aXeadPcHRNKjqtKhhccPeKrk/MnjZ5Bu0VeBf6+eCghhcGtCtC
         h6tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="39592623"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v9 11/12] platform/x86: intel_cht_int33fe: Add device connections for the Type-C port
Date: Tue, 20 Mar 2018 15:57:12 +0300
Message-Id: <20180320125713.85465-12-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
References: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595461521890971939?=
X-GMAIL-MSGID: =?utf-8?q?1595461521890971939?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

We need to add device-connections for the Type-C mux/switch and usb-role
code to be able to find the PI3USB30532 Type-C cross-switch and the
device/host role-switch integrated in the CHT SoC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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
2.16.2
