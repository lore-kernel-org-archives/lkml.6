Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AB8JxZo8gQ3w2wbNSKWqpam6FoMmEwpZhcJFLev2PfR7nKjax1H55hNg58FA5Kmjjjp8Q8Re4UT0
ARC-Seal: i=1; a=rsa-sha256; t=1526117497; cv=none;
        d=google.com; s=arc-20160816;
        b=jxuBGodoIUti1+0csmrN0JfTN11+a8iEd6havtVFMJQWY/Hr4PXkZXmA/SFTMaYj2J
         Ef7rad5OI9rOOYRcG5689uPVmFmP38AWiB5LPpeBZvIWhfi+Zn8jbOgqkL/qKV4MEP3a
         1DGfxeBT0FFOw60Oi3Hfhq1otfK7GR8aQZzfEEo0ivXeKHa+9ZOSJABmxfkyA1GzBEDy
         zfWaIcrSoiX3z5XDsN9AGLn2F1R469OUdMgIBY380nPbADuQZVcowjJBsytUcLeHw2zr
         ePByDpdzuzpuGyk8uReMBVb6RLjaKmF9S+JsHD0I2Qy4yG389gJuBdqp8otIIKrsGKQu
         Jkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=cpkOU7203qJd1BDjRHwnX5pW7oX8IBMABoscvaiPU18=;
        b=S/evQVx5UWVe4s0JzOnrbtdstXP+INqZ1Rb57UhkC/gMQQ4LE5JCSG5PX6Ag3pEJ/I
         cgoKj9S61Qc56pRq+XZVlzDCX2e5D5jM9zvzPbzr0mtrvx/J5xIV/+74uE87IJVdlGF9
         C983HyKx4Md64R2Iq7ppFUP0KoncHgoiK3gdjsg+Sn0Z3jqITX/+mBaeMgClnjww4gF2
         NqKJjMvyY8kBsBEO58QUJgQmlFbm4QAc0hnWmfHZ8XByroYJRQdT5jAAFdvo6AV5YJDp
         JZr5tisaUAYn3ixvOX6qaoIYb8S22Jv0xdToQ80rdv7L+4LEmkngj5RvScLY4wzQMNOc
         iIiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.49 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	jasowang@redhat.com,
	vkuznets@redhat.com
Cc: Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Date: Sat, 12 May 2018 02:30:33 -0700
Message-Id: <20180512093033.12325-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGL4+zOBVEatMcBtpsZOZC4DlCHguqkSeaDHwB6XT/UFe2dHMVDeeUUyJ6NoGZGH1Va8gHPfDats7+S0tEKzHIsYAzjZcP/RaLUzK0NfQyj5GrQOiV8D
 jRH2M1I187PIz+x9GjpVThXjnZQrPQjncikpKFnTxW9v4S4YciotVOIab6y0sIxz8O9lYxt/ow6luDIRD/0jMnlTUJ5MRuw8iyAwuSbkapdbn/X5c/6mhTX7
 ELiMJRl5vF+sWzpTxonnteU/1Y/oFkfraQf3M8ZSuqyaWWEEesOwNgFF/nNl4z3hrRPnoUUtTH4e7yB+kgEdR9DEcy4D5E7RT/B22mrzVT41mGzwWAVIkZRG
 7EGOEfna0vnvdKpx3r5gppUFuQgVwTcgcFPbtbIoEC7L5dVQ49W9UjIXLQemzNzWsbKAmuvzC3NZagJc9Edn8igKmtdd72kHd4YGZh+h/Be6X4EJa7ZqPXbg
 +KfMEecJ2SZQhmglXRuNvGsA/PIZRrk0den9shwE5TBxvl1y0saYJmj9L5IxjM+z+W/WroytW6kKElbq
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600250180438237407?=
X-GMAIL-MSGID: =?utf-8?q?1600250180438237407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dexuan Cui <decui@microsoft.com>

With VMBus protocol 5.0, we're able to better support new features, e.g.
running two or more VMBus drivers simultaneously in a single VM -- note:
we can't simply load the current VMBus driver twice, instead, a secondary
VMBus driver must be implemented.

This patch adds the support for the new VMBus protocol, which is available
on new Windows hosts, by:

1) We still use SINT2 for compatibility;
2) We must use Connection ID 4 for the Initiate Contact Message, and for
subsequent messages, we must use the Message Connection ID field in
the host-returned VersionResponse Message.

Notes for developers of the secondary VMBus driver:
1) Must use VMBus protocol 5.0 as well;
2) Must use a different SINT number that is not in use.
3) Must use Connection ID 4 for the Initiate Contact Message, and for
subsequent messages, must use the Message Connection ID field in
the host-returned VersionResponse Message.
4) It's possible that the primary VMBus driver using protocol version 4.0
can work with a secondary VMBus driver using protocol version 5.0, but it's
recommended that both should use 5.0 for new Hyper-V features in the future.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/connection.c   | 44 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h |  3 +++
 include/linux/hyperv.h    | 26 ++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 72855182b191..19e046820fda 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -63,6 +63,9 @@ static __u32 vmbus_get_next_version(__u32 current_version)
 	case (VERSION_WIN10):
 		return VERSION_WIN8_1;
 
+	case (VERSION_WIN10_V5):
+		return VERSION_WIN10;
+
 	case (VERSION_WS2008):
 	default:
 		return VERSION_INVAL;
@@ -80,9 +83,29 @@ static int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo,
 
 	msg = (struct vmbus_channel_initiate_contact *)msginfo->msg;
 
+	memset(msg, 0, sizeof(*msg));
 	msg->header.msgtype = CHANNELMSG_INITIATE_CONTACT;
 	msg->vmbus_version_requested = version;
-	msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
+
+	/*
+	 * VMBus protocol 5.0 (VERSION_WIN10_V5) requires that we must use
+	 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
+	 * and for subsequent messages, we must use the Message Connection ID
+	 * field in the host-returned Version Response Message. And, with
+	 * VERSION_WIN10_V5, we don't use msg->interrupt_page, but we tell
+	 * the host explicitly that we still use VMBUS_MESSAGE_SINT(2) for
+	 * compatibility.
+	 *
+	 * On old hosts, we should always use VMBUS_MESSAGE_CONNECTION_ID (1).
+	 */
+	if (version >= VERSION_WIN10_V5) {
+		msg->msg_sint = VMBUS_MESSAGE_SINT;
+		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
+	} else {
+		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
+		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
+	}
+
 	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]);
 	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]);
 	/*
@@ -137,6 +160,10 @@ static int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo,
 	/* Check if successful */
 	if (msginfo->response.version_response.version_supported) {
 		vmbus_connection.conn_state = CONNECTED;
+
+		if (version >= VERSION_WIN10_V5)
+			vmbus_connection.msg_conn_id =
+				msginfo->response.version_response.msg_conn_id;
 	} else {
 		return -ECONNREFUSED;
 	}
@@ -354,13 +381,14 @@ void vmbus_on_event(unsigned long data)
  */
 int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
 {
+	struct vmbus_channel_message_header *hdr;
 	union hv_connection_id conn_id;
 	int ret = 0;
 	int retries = 0;
 	u32 usec = 1;
 
 	conn_id.asu32 = 0;
-	conn_id.u.id = VMBUS_MESSAGE_CONNECTION_ID;
+	conn_id.u.id = vmbus_connection.msg_conn_id;
 
 	/*
 	 * hv_post_message() can have transient failures because of
@@ -372,6 +400,18 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
 
 		switch (ret) {
 		case HV_STATUS_INVALID_CONNECTION_ID:
+			/*
+			 * See vmbus_negotiate_version(): VMBus protocol 5.0
+			 * requires that we must use
+			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
+			 * Contact message, but on old hosts that only
+			 * support VMBus protocol 4.0 or lower, here we get
+			 * HV_STATUS_INVALID_CONNECTION_ID and we should
+			 * return an error immediately without retrying.
+			 */
+			hdr = (struct vmbus_channel_message_header *)buffer;
+			if (hdr->msgtype == CHANNELMSG_INITIATE_CONTACT)
+				return -EINVAL;
 			/*
 			 * We could get this if we send messages too
 			 * frequently.
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f761bef36e77..72eaba3d50fc 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -187,6 +187,7 @@ struct hv_input_post_message {
 
 enum {
 	VMBUS_MESSAGE_CONNECTION_ID	= 1,
+	VMBUS_MESSAGE_CONNECTION_ID_4	= 4,
 	VMBUS_MESSAGE_PORT_ID		= 1,
 	VMBUS_EVENT_CONNECTION_ID	= 2,
 	VMBUS_EVENT_PORT_ID		= 2,
@@ -302,6 +303,8 @@ struct vmbus_connection {
 	 */
 	int connect_cpu;
 
+	u32 msg_conn_id;
+
 	atomic_t offer_in_progress;
 
 	enum vmbus_connect_state conn_state;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 192ed8fbc403..11b5612dc066 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -163,6 +163,7 @@ static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
  * 2 . 4  (Windows 8)
  * 3 . 0  (Windows 8 R2)
  * 4 . 0  (Windows 10)
+ * 5 . 0  (Newer Windows 10)
  */
 
 #define VERSION_WS2008  ((0 << 16) | (13))
@@ -170,10 +171,11 @@ static inline u32 hv_get_bytes_to_write(const struct hv_ring_buffer_info *rbi)
 #define VERSION_WIN8    ((2 << 16) | (4))
 #define VERSION_WIN8_1    ((3 << 16) | (0))
 #define VERSION_WIN10	((4 << 16) | (0))
+#define VERSION_WIN10_V5 ((5 << 16) | (0))
 
 #define VERSION_INVAL -1
 
-#define VERSION_CURRENT VERSION_WIN10
+#define VERSION_CURRENT VERSION_WIN10_V5
 
 /* Make maximum size of pipe payload of 16K */
 #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
@@ -570,7 +572,14 @@ struct vmbus_channel_initiate_contact {
 	struct vmbus_channel_message_header header;
 	u32 vmbus_version_requested;
 	u32 target_vcpu; /* The VCPU the host should respond to */
-	u64 interrupt_page;
+	union {
+		u64 interrupt_page;
+		struct {
+			u8	msg_sint;
+			u8	padding1[3];
+			u32	padding2;
+		};
+	};
 	u64 monitor_page1;
 	u64 monitor_page2;
 } __packed;
@@ -585,6 +594,19 @@ struct vmbus_channel_tl_connect_request {
 struct vmbus_channel_version_response {
 	struct vmbus_channel_message_header header;
 	u8 version_supported;
+
+	u8 connection_state;
+	u16 padding;
+
+	/*
+	 * On new hosts that support VMBus protocol 5.0, we must use
+	 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
+	 * and for subsequent messages, we must use the Message Connection ID
+	 * field in the host-returned Version Response Message.
+	 *
+	 * On old hosts, we should always use VMBUS_MESSAGE_CONNECTION_ID (1).
+	 */
+	u32 msg_conn_id;
 } __packed;
 
 enum vmbus_channel_state {
-- 
2.15.1
