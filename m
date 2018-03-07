Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-29808-1520455431-5-6331983908375827331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1520455431; b=PL/kmBgdiFPDhT/6go3++8MATmffGqV0IxiFFx9VSeBIX2V
    lwRPCgLC6qYCuA4Yj70KoKq091joTkzA88/tghXd7ziAyLcMyB3vBGL03hq6eM3b
    +e+JBV0HkYehJQMHfs3VZTTxr4YX64ntc/xyC1vqBjf6EE64LR3FzdQnJNzv5Tc/
    LnPsS6+HeHP2ZKldpK1gEc1lZqchbGF5eY4vF48JWPqYSwyxvjxoD9LGPoynpTvX
    q7J24meFpGaQ5l8L6+Xac65/cE4IZjqQ4HBkPUETOrQvC38Oh3iM5pcaCQl42u4t
    EQtrOIDKp94vWD7Zn8eS9fF91KJ+Jxy7x7f3hmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1520455431; bh=a2Bh1b++rL4/sfiHucqpiBlQffq1ar66ZaQ
    Mzj8y4jM=; b=VcwOxp2wNlqZfkuYj5k3y7JOS2nCF7mrGNB75qXyRxLzvgezvIZ
    P0ASMdBxtd783TBMraVD4o6lTiIAbMqLUA4Tat/LkkVZw4w1LlmzYtV3g1IlfLfh
    dxZYZtPdLgyUQSOes1lZjaq6VO1Npof/9c7IS44kvGTYZr4RItsZGmzS/a2LAdFq
    yLiH2vHuXjsyU2rjasuAul8oQUhPCT/CNceMziDHFxqh0mYPEA6+T5bG+b1v/4aQ
    d8VkmB5j6GNHEb/BS00oG8twemGT7VpGgFpQft0EP/f3yTFQVdgXxR0H9o2U8A83
    VOltFLPcP76L+uXg78VT5JL99w7WxXM+P0w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934992AbeCGUmx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:42:53 -0500
Received: from osg.samsung.com ([64.30.133.232]:55326 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934701AbeCGUmu (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Mar 2018 15:42:50 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, yuyang.du@intel.com,
        k.opasiak@samsung.com, nobuo.iwata@fujixerox.co.jp,
        julien.boibessot@armadeus.com, jdieter@lesbg.com,
        peter.senna@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usbip: tools: add more error codes for usbip request/reply messages
Date: Wed,  7 Mar 2018 13:42:24 -0700
Message-Id: <6add3ebef26ac0a498696ae4e30c44a3af87fe47.1520455011.git.shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1520455010.git.shuahkh@osg.samsung.com>
References: <cover.1520455010.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1520455010.git.shuahkh@osg.samsung.com>
References: <cover.1520455010.git.shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently ST_OK and ST_NA are the only values defined to communicate
status of a request from a client. Add more error codes to clearly
indicate what failed. For example, when client sends request to import
a device that isn't export-able, server can send a specific error code
to the client.

Existing defines are moved to a common header in libsrc to be included
in the libusbip_la-usbip_common.o to be used by all the usbip tools.
Supporting interface to print error strings is added to the common lib.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/usb/usbip/libsrc/usbip_common.c | 23 +++++++++++++++++++++++
 tools/usb/usbip/libsrc/usbip_common.h | 11 +++++++++++
 tools/usb/usbip/src/usbip_network.h   |  4 +---
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/usb/usbip/libsrc/usbip_common.c b/tools/usb/usbip/libsrc/usbip_common.c
index 001bb8e8f668..bb424638d75b 100644
--- a/tools/usb/usbip/libsrc/usbip_common.c
+++ b/tools/usb/usbip/libsrc/usbip_common.c
@@ -66,6 +66,29 @@ const char *usbip_speed_string(int num)
 	return "Unknown Speed";
 }
 
+struct op_common_status_string {
+	int num;
+	char *desc;
+};
+
+static struct op_common_status_string op_common_status_strings[] = {
+	{ ST_OK,	"Request Completed Successfully" },
+	{ ST_NA,	"Request Failed" },
+	{ ST_DEV_BUSY,	"Device busy (exported)" },
+	{ ST_DEV_ERR,	"Device in error state" },
+	{ ST_NODEV,	"Device not found" },
+	{ ST_ERROR,	"Unexpected response" },
+	{ 0, NULL}
+};
+
+const char *usbip_op_common_status_string(int status)
+{
+	for (int i = 0; op_common_status_strings[i].desc != NULL; i++)
+		if (op_common_status_strings[i].num == status)
+			return op_common_status_strings[i].desc;
+
+	return "Unknown Op Common Status";
+}
 
 #define DBG_UDEV_INTEGER(name)\
 	dbg("%-20s = %x", to_string(name), (int) udev->name)
diff --git a/tools/usb/usbip/libsrc/usbip_common.h b/tools/usb/usbip/libsrc/usbip_common.h
index e45ec9d2fdbc..73a367a7fa10 100644
--- a/tools/usb/usbip/libsrc/usbip_common.h
+++ b/tools/usb/usbip/libsrc/usbip_common.h
@@ -43,6 +43,16 @@
 #define SYSFS_PATH_MAX		256
 #define SYSFS_BUS_ID_SIZE	32
 
+/* Defines for op_code status in server/client op_common PDUs */
+#define ST_OK	0x00
+#define ST_NA	0x01
+	/* Device requested for import is not available */
+#define ST_DEV_BUSY	0x02
+	/* Device requested for import is in error state */
+#define ST_DEV_ERR	0x03
+#define ST_NODEV	0x04
+#define ST_ERROR	0x05
+
 extern int usbip_use_syslog;
 extern int usbip_use_stderr;
 extern int usbip_use_debug ;
@@ -130,6 +140,7 @@ int read_usb_interface(struct usbip_usb_device *udev, int i,
 
 const char *usbip_speed_string(int num);
 const char *usbip_status_string(int32_t status);
+const char *usbip_op_common_status_string(int status);
 
 int usbip_names_init(char *);
 void usbip_names_free(void);
diff --git a/tools/usb/usbip/src/usbip_network.h b/tools/usb/usbip/src/usbip_network.h
index 7032687621d3..b6a2f9be888c 100644
--- a/tools/usb/usbip/src/usbip_network.h
+++ b/tools/usb/usbip/src/usbip_network.h
@@ -27,9 +27,7 @@ struct op_common {
 #define OP_REPLY	(0x00 << 8)
 	uint16_t code;
 
-	/* add more error code */
-#define ST_OK	0x00
-#define ST_NA	0x01
+	/* status codes defined in usbip_common.h */
 	uint32_t status; /* op_code status (for reply) */
 
 } __attribute__((packed));
-- 
2.14.1

