Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3452210-1525818412-2-6333925568020054710
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525818411; b=T9DFJs8sxj1tcpyIbf6GjBSePQLu6bj0KazPuUitvTwdLzIFoV
    Usgf3GqI+wJW15FOtoeKsXAi3R2/ue+QV9JPW0kVUsUhzd437A0HS5oaibm+etK5
    dKVCzcHKyv6Lu4+5c7fVQVg14LwGMef2HX/IO4v+QAJ+bH9+z1Aj82S9YDtK7/A1
    uSsvZGsMPm/NHudJ9wJJ3lkhg06ioNRn97JrJXIjcbwyJc0bJ7TebrzdqRqekFaM
    i8wir3oXnQhOzvcHYfe37k2QYxhHLYiao44t7NHqXJzRhrS1uCfjM8H0qTW9l4qz
    dtxzIt6jon93xNI31DC0mOFJjoZw+yf8uSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525818411; bh=TKQst
    lrmaS9L0/H0+cvFniHcR5RJMglS0bNeq7v+/oQ=; b=c5qtKGFLt6orNq8kyg6w2
    beAlfwn3NCl6h+CWvanY4sKdkIAcrlHwBkKybY2FDGoxLoUtgec//DbyL1arLkWR
    urUmA8EN2TGVPVjFjWv2reV4oV4TtQlM9gmphOaSYrYt0lbeidood4cWpbKlZc73
    zqiUUvhfoHCuHNd2OCBXoY+X6/OmAsUvyxyUHvIy3crCqOsJtbTbNuxwnuOeiiB3
    rmK1bJkell/d1XmYSLu3zeW5pzN84xfxgpSxba25arVbety8NHjQPTH1RngR2yz5
    axQCFW4WSeViVgXsvERlB6B1n5/CmmcSDMhkew6uaZ8Gfo44GfEWg25VKxh9bcpH
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=microsoft.com header.i=@microsoft.com header.b=myQhsqJa
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
    header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=microsoft.com header.i=@microsoft.com header.b=myQhsqJa
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject)
      header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHe2ZSPKazPEMjFcsSpCiKk5XDsOE4Blh89Q6d/O2P5701uxKempcnmcDAFCfbxdAG0CUhV2GGJdjnHu4RAKI9BDTdljYe6frkWI11xoZQgnP4KJGev
    TGJhqShW61aTKh6oFPtMbE3oE5Oqf6o8ZJVCOnd5B2jSENrUkF/M9tLLJvtIAE+BO7A1ual9p1kBTERh9se0/x2iH67HhS6MxRih4VV/2sVskFTWf1ZMsVHC
    TSCEDzVZYTTIkHDb9Z8LDA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=pP0Gbf12DoIA:10 a=hyy5rRJ4iSQA:10
    a=6RrQ652yKWUA:10 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=fA0CCBg6TC6KNMmbjp0A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, "Michael Kelley (EOSG)"
 <Michael.H.Kelley@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Thread-Topic: [PATCH] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Thread-Index: AdPnGpZjEjN6JH3ySGSQrnm2yoYh9w==
Date: Tue, 8 May 2018 22:26:21 +0000
Message-ID: <KL1P15301MB00067B95F6D0B3D97387E315BF9A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-08T22:26:18.1825905Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [131.107.159.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0087;
 7:1ITn5nU5oSIio4I1mCTmrcJyoCAUcYPsecCeRWYMt21yJKDRUX4v6Yy7QpGQ85agzYl2p4XrwGw6l8Zjr6iKtJP4mbGrnPgAT8SNhJ7Ilp9MZlODpUQGIEFDt6V4GUCwpa/3R6SCGdlfF8+WvVNLcvymlKLbB9Kj+kJInPmWg480TEww1Zv0B30iDscvzoMtgtrdyY1Sk70lwtJ+gfIXkoen6lW8NE8CK2i4oyFs7pbtTN6913oRrqioWp0qjFbQ;
 20:/jURTARTfOg12QRCVt6cUX1r+AORw+srIEm7kI2uJw4SZ0qU+zRnOppznemPC6TfAhvZEb6qx/oAq5FtgzmMsb9QRAIuIZc+laNPA259HIiSBEgitf5+G6WuvySkMboCXj8DiKgJG/5FsrgW78UIn/JqDk/sNYFo//Fw73QgW5g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);
 SRVR:KL1P15301MB0087;
x-ms-traffictypediagnostic: KL1P15301MB0087:
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <KL1P15301MB0087FC1C61298B27F2A5A472BF9A0@KL1P15301MB0087.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21532816269658); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0087; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0087;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(396003)(376002)(366004)(346002)(39860400002)(24433001)(199004)(189003)(6436002)(25786009)(10090500001)(66066001)(7696005)(9686003)(102836004)(4326008)(107886003)(1511001)(55016002)(2900100001)(476003)(486006)(6506007)(59450400001)(53936002)(81156014)(6636002)(1857600001)(8676002)(74316002)(81166006)(10290500003)(316002)(22452003)(8936002)(5660300001)(106356001)(305945005)(14454004)(105586002)(3660700001)(54906003)(110136005)(3280700002)(68736007)(7736002)(97736004)(99286004)(86612001)(33656002)(86362001)(8990500004)(77096007)(3846002)(6116002)(26005)(478600001)(186003)(2906002)(491001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0087;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: 5IBIqYzi85ILiH5fp7TNopVNM/YED3g3kXbkAA9R1bWaXbq0WNUH8cANtY/kNGx5ieuAQtJp3TuyhKYcfikgJkqJYkTaPOf81JDB0sBSWw61kef7RdQAwodiMAR2M4VShSwzZuVROtouN2XUgS1xSWyHyKTPceBTk6IMZzjYEOA9kMZIrHZQlxY0D3CcX9ch
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f9a280bf-8ae4-474a-d9bb-08d5b532b9f2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a280bf-8ae4-474a-d9bb-08d5b532b9f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 22:26:21.0821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0087
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "'olaf@aepfle.de'" <olaf@aepfle.de>,
 Jork Loeser <Jork.Loeser@microsoft.com>,
 "'jasowang@redhat.com'" <jasowang@redhat.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 "'apw@canonical.com'" <apw@canonical.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


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
---
 drivers/hv/connection.c   | 44 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/hv/hyperv_vmbus.h |  3 +++
 include/linux/hyperv.h    | 26 ++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 7285518..19e0468 100644
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
@@ -373,6 +401,18 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
 		switch (ret) {
 		case HV_STATUS_INVALID_CONNECTION_ID:
 			/*
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
+			/*
 			 * We could get this if we send messages too
 			 * frequently.
 			 */
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f761bef3..72eaba3 100644
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
index 192ed8f..11b5612 100644
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
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
