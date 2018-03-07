Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-29808-1520455420-2-8412539164042850645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455418; b=BgqEpmuiphEV6WLJtl0mDN742qjexd1KZ8TWFduvHsNHE4B
    A4kYj297WX16wRElXs1IKtP9tArjCOpjWFlyxFPMl0qKNhXKVa1DvYierynht/Rq
    OuEbpB+V0lWl0ZZpYF3shoW4EFHFURmjtQwVNIvVz9VtlTtN4tHfLQLwC2O4/BHp
    BizzQj5vYXMWdwT6ipv1IVqXFx3OhvNDHbWAEYYu0Um6DEP8Hpvqgm0yv0Lc+430
    RSBbP7aY95/TerwjPRpyri5jzxxnrMUVZ4o1ZBRtZEEKS+Fvgb3ZXnS5hgU6LznE
    r1YD6GATEYQ8uE1T2n9K4preJA5COyXfpjE1PIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1520455418; bh=j97GHQTCWs2qloq94a43JEkDxqG9Tma3eFS
    iB+rPQOY=; b=Mv7CNiac3KLwNTa853AzqIL0SFiiZgXvnRiHMOkc41peI0/CeyY
    m1CSZfXCPd3OU+c+2beiRVQd6RbtrWaYSHHjguZmIvn2jCHETuxXMQPacXgbKiFF
    GQ9sDD7DYloTZmJIUIQANvSWiCDw8aiYjqheJi1rLtE8lbP9T6Lemg9yMk58o7R8
    RHIuuLYDCxMplu9mEKVq75UPpfA16ldKSoDRBD+v7AgCAdPfGpBxAcgVRZFX/OO/
    frJWAer9L6ApsalGpMp2dCWP+yHfWlz+B3pSsU1PlaLWCdBT61FsDHHn+VF9xlIf
    cnGiYKn4Uvs4gJWdp4YduhSld0zmLYqo+Nw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=25 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
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
        id S964819AbeCGUmy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:42:54 -0500
Received: from osg.samsung.com ([64.30.133.232]:40207 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934750AbeCGUmv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 7 Mar 2018 15:42:51 -0500
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, yuyang.du@intel.com,
        k.opasiak@samsung.com, nobuo.iwata@fujixerox.co.jp,
        julien.boibessot@armadeus.com, jdieter@lesbg.com,
        peter.senna@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usbip: tools: change to use new error codes in server reply messages
Date: Wed,  7 Mar 2018 13:42:26 -0700
Message-Id: <0c71a0f246feec53ef79b8ea827767a5c0f76097.1520455011.git.shuahkh@osg.samsung.com>
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

Changed usbip_network, usbip_attach, usbip_list, and usbipd to use
and propagate the new error codes in server reply messages.

usbip_net_recv_op_common() is changed to take a pointer to status
return the status returned in the op_common.status to callers.

usbip_attach and usbip_list use the common interface to print error
messages to indicate why the request failed.

With this change the messages say why a request failed:

- when a client requests a device that is already exported:

usbip attach -r server_name -b 3-10.2
usbip: error: Attach Request for 3-10.2 failed - Device busy (exported)

- when a client requests a device that isn't exportable,

usbip attach -r server_name -b 3-10.4
usbip: error: Attach Request for 3-10.4 failed - Device not found

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/usb/usbip/src/usbip_attach.c  | 11 +++++------
 tools/usb/usbip/src/usbip_list.c    |  6 ++++--
 tools/usb/usbip/src/usbip_network.c |  6 +++++-
 tools/usb/usbip/src/usbip_network.h |  2 +-
 tools/usb/usbip/src/usbipd.c        | 18 +++++++++---------
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_attach.c b/tools/usb/usbip/src/usbip_attach.c
index f60738735398..ba88728483ff 100644
--- a/tools/usb/usbip/src/usbip_attach.c
+++ b/tools/usb/usbip/src/usbip_attach.c
@@ -135,6 +135,7 @@ static int query_import_device(int sockfd, char *busid)
 	struct op_import_request request;
 	struct op_import_reply   reply;
 	uint16_t code = OP_REP_IMPORT;
+	int status;
 
 	memset(&request, 0, sizeof(request));
 	memset(&reply, 0, sizeof(reply));
@@ -157,9 +158,10 @@ static int query_import_device(int sockfd, char *busid)
 	}
 
 	/* receive a reply */
-	rc = usbip_net_recv_op_common(sockfd, &code);
+	rc = usbip_net_recv_op_common(sockfd, &code, &status);
 	if (rc < 0) {
-		err("recv op_common");
+		err("Attach Request for %s failed - %s\n",
+		    busid, usbip_op_common_status_string(status));
 		return -1;
 	}
 
@@ -194,11 +196,8 @@ static int attach_device(char *host, char *busid)
 	}
 
 	rhport = query_import_device(sockfd, busid);
-	if (rhport < 0) {
-		err("Attach request for Device %s. Is this device exported?",
-		    busid);
+	if (rhport < 0)
 		return -1;
-	}
 
 	close(sockfd);
 
diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usbip_list.c
index d65a9f444174..8d4ccf4b9480 100644
--- a/tools/usb/usbip/src/usbip_list.c
+++ b/tools/usb/usbip/src/usbip_list.c
@@ -62,6 +62,7 @@ static int get_exported_devices(char *host, int sockfd)
 	struct usbip_usb_interface uintf;
 	unsigned int i;
 	int rc, j;
+	int status;
 
 	rc = usbip_net_send_op_common(sockfd, OP_REQ_DEVLIST, 0);
 	if (rc < 0) {
@@ -69,9 +70,10 @@ static int get_exported_devices(char *host, int sockfd)
 		return -1;
 	}
 
-	rc = usbip_net_recv_op_common(sockfd, &code);
+	rc = usbip_net_recv_op_common(sockfd, &code, &status);
 	if (rc < 0) {
-		dbg("usbip_net_recv_op_common failed");
+		err("Exported Device List Request failed - %s\n",
+		    usbip_op_common_status_string(status));
 		return -1;
 	}
 
diff --git a/tools/usb/usbip/src/usbip_network.c b/tools/usb/usbip/src/usbip_network.c
index 90325fa8bc38..8ffcd47d9638 100644
--- a/tools/usb/usbip/src/usbip_network.c
+++ b/tools/usb/usbip/src/usbip_network.c
@@ -163,7 +163,7 @@ int usbip_net_send_op_common(int sockfd, uint32_t code, uint32_t status)
 	return 0;
 }
 
-int usbip_net_recv_op_common(int sockfd, uint16_t *code)
+int usbip_net_recv_op_common(int sockfd, uint16_t *code, int *status)
 {
 	struct op_common op_common;
 	int rc;
@@ -191,10 +191,14 @@ int usbip_net_recv_op_common(int sockfd, uint16_t *code)
 		if (op_common.code != *code) {
 			dbg("unexpected pdu %#0x for %#0x", op_common.code,
 			    *code);
+			/* return error status */
+			*status = ST_ERROR;
 			goto err;
 		}
 	}
 
+	*status = op_common.status;
+
 	if (op_common.status != ST_OK) {
 		dbg("request failed at peer: %d", op_common.status);
 		goto err;
diff --git a/tools/usb/usbip/src/usbip_network.h b/tools/usb/usbip/src/usbip_network.h
index b6a2f9be888c..555215eae43e 100644
--- a/tools/usb/usbip/src/usbip_network.h
+++ b/tools/usb/usbip/src/usbip_network.h
@@ -174,7 +174,7 @@ void usbip_net_pack_usb_interface(int pack, struct usbip_usb_interface *uinf);
 ssize_t usbip_net_recv(int sockfd, void *buff, size_t bufflen);
 ssize_t usbip_net_send(int sockfd, void *buff, size_t bufflen);
 int usbip_net_send_op_common(int sockfd, uint32_t code, uint32_t status);
-int usbip_net_recv_op_common(int sockfd, uint16_t *code);
+int usbip_net_recv_op_common(int sockfd, uint16_t *code, int *status);
 int usbip_net_set_reuseaddr(int sockfd);
 int usbip_net_set_nodelay(int sockfd);
 int usbip_net_set_keepalive(int sockfd);
diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
index c6dad2a13c80..f8ff735eb100 100644
--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -107,7 +107,7 @@ static int recv_request_import(int sockfd)
 	struct usbip_usb_device pdu_udev;
 	struct list_head *i;
 	int found = 0;
-	int error = 0;
+	int status = ST_OK;
 	int rc;
 
 	memset(&req, 0, sizeof(req));
@@ -133,22 +133,21 @@ static int recv_request_import(int sockfd)
 		usbip_net_set_nodelay(sockfd);
 
 		/* export device needs a TCP/IP socket descriptor */
-		rc = usbip_export_device(edev, sockfd);
-		if (rc < 0)
-			error = 1;
+		status = usbip_export_device(edev, sockfd);
+		if (status < 0)
+			status = ST_NA;
 	} else {
 		info("requested device not found: %s", req.busid);
-		error = 1;
+		status = ST_NODEV;
 	}
 
-	rc = usbip_net_send_op_common(sockfd, OP_REP_IMPORT,
-				      (!error ? ST_OK : ST_NA));
+	rc = usbip_net_send_op_common(sockfd, OP_REP_IMPORT, status);
 	if (rc < 0) {
 		dbg("usbip_net_send_op_common failed: %#0x", OP_REP_IMPORT);
 		return -1;
 	}
 
-	if (error) {
+	if (status) {
 		dbg("import request busid %s: failed", req.busid);
 		return -1;
 	}
@@ -251,8 +250,9 @@ static int recv_pdu(int connfd)
 {
 	uint16_t code = OP_UNSPEC;
 	int ret;
+	int status;
 
-	ret = usbip_net_recv_op_common(connfd, &code);
+	ret = usbip_net_recv_op_common(connfd, &code, &status);
 	if (ret < 0) {
 		dbg("could not receive opcode: %#0x", code);
 		return -1;
-- 
2.14.1

