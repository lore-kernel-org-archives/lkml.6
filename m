Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834087-2-7501984770285335858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834086; b=HXTWNH8SD5vMDq0H2428oC+3dJRoCFnVQgBS97YJdmheQt2
    Jhmyy5lwJDhbDuRtswK+51WNRAQ/+4+ntWgAky+m4Nh/ze0GqZ4eGox3IUPY1CJi
    y72SAFaHrClH5PpYUT06g9z49wJuRHqxGuMnH8k0TRsdTeqkiCPBH/H9s2XQrr+S
    Oi40mct4FWE8Ib1i7NRDks3coPWVMVRAzPT4sHTqvxc/Hk+J56lwWFgwyol1mz1o
    8HnRLjALzH/ediJ6Jlhw7QDmG5dnum/IeUKqK1DSC4TCUXqlYGbGsonpGzvi83MY
    OXsJMhIVLAPARlJasuzNKBhByaWe5h6wefrvhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834086; bh=42ks7Py6FDC21om1mz4
    UsQGtkY0sM99Da6lM981KlBE=; b=laOjsKW1jLk6HROAH4EtbvApFxxc3xn3UqJ
    eRYQ9HF62CHjMVznOomM6HVYDsM4ME8U1+E4itjpvb4+OiokaKXqLpX/q4bZrL2r
    Yr2LOznieET7XONaNMK3Id1QeQtkhJuPF3bzWR63qlunXy0cRk5mnzeAO2mX4jp6
    7uxZRD1S3F6aO1TJCjraTG0z399mc7d3Br40PtD/j1yJEf5a9BlLRD3Vur61hRZv
    DU0whXsdhlYQd3Wgr/3SziQEK8lmynDLOp0ShvA8Lb76Jw1qtOSR54rdeb9mMglg
    KVu9i/66kN6FxfnwfPsHdzQgqLHNh7l8N0MKiiCLrD8cMnlPg6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeB1QHr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:07:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34874 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934455AbeB1QFO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Greg Kroah-Hartman" <gregkh@suse.de>,
        "Bart Westgeest" <bart@elbrys.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.992100649@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 057/140] staging: usbip: removed dead code from
 receive function
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Westgeest <bart@elbrys.com>

commit 5a08c5267e45fe936452051a8c126e8418984eb7 upstream.

The usbip_xmit function supported sending and receiving data, however
the sending part of the function was never used/executed. Renamed the
function to usbip_recv, and removed the unused code.

Signed-off-by: Bart Westgeest <bart@elbrys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_rx.c      |  2 +-
 drivers/staging/usbip/usbip_common.c | 61 ++++++++++--------------------------
 drivers/staging/usbip/usbip_common.h |  3 +-
 drivers/staging/usbip/vhci_rx.c      |  2 +-
 4 files changed, 20 insertions(+), 48 deletions(-)

--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -586,7 +586,7 @@ static void stub_rx_pdu(struct usbip_dev
 	memset(&pdu, 0, sizeof(pdu));
 
 	/* 1. receive a pdu header */
-	ret = usbip_xmit(0, ud->tcp_socket, (char *) &pdu, sizeof(pdu), 0);
+	ret = usbip_recv(ud->tcp_socket, &pdu, sizeof(pdu));
 	if (ret != sizeof(pdu)) {
 		dev_err(dev, "recv a header, %d\n", ret);
 		usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
--- a/drivers/staging/usbip/usbip_common.c
+++ b/drivers/staging/usbip/usbip_common.c
@@ -334,9 +334,8 @@ void usbip_dump_header(struct usbip_head
 }
 EXPORT_SYMBOL_GPL(usbip_dump_header);
 
-/* Send/receive messages over TCP/IP. I refer drivers/block/nbd.c */
-int usbip_xmit(int send, struct socket *sock, char *buf, int size,
-	       int msg_flags)
+/* Receive data over TCP/IP. */
+int usbip_recv(struct socket *sock, void *buf, int size)
 {
 	int result;
 	struct msghdr msg;
@@ -355,19 +354,6 @@ int usbip_xmit(int send, struct socket *
 		return -EINVAL;
 	}
 
-	if (usbip_dbg_flag_xmit) {
-		if (send) {
-			if (!in_interrupt())
-				pr_debug("%-10s:", current->comm);
-			else
-				pr_debug("interrupt  :");
-
-			pr_debug("sending... , sock %p, buf %p, size %d, "
-				 "msg_flags %d\n", sock, buf, size, msg_flags);
-			usbip_dump_buffer(buf, size);
-		}
-	}
-
 	do {
 		sock->sk->sk_allocation = GFP_NOIO;
 		iov.iov_base    = buf;
@@ -377,42 +363,30 @@ int usbip_xmit(int send, struct socket *
 		msg.msg_control = NULL;
 		msg.msg_controllen = 0;
 		msg.msg_namelen    = 0;
-		msg.msg_flags      = msg_flags | MSG_NOSIGNAL;
-
-		if (send)
-			result = kernel_sendmsg(sock, &msg, &iov, 1, size);
-		else
-			result = kernel_recvmsg(sock, &msg, &iov, 1, size,
-						MSG_WAITALL);
+		msg.msg_flags      = MSG_NOSIGNAL;
 
+		result = kernel_recvmsg(sock, &msg, &iov, 1, size, MSG_WAITALL);
 		if (result <= 0) {
-			pr_debug("%s sock %p buf %p size %u ret %d total %d\n",
-				 send ? "send" : "receive", sock, buf, size,
-				 result, total);
+			pr_debug("receive sock %p buf %p size %u ret %d total %d\n",
+				 sock, buf, size, result, total);
 			goto err;
 		}
 
 		size -= result;
 		buf += result;
 		total += result;
-
 	} while (size > 0);
 
 	if (usbip_dbg_flag_xmit) {
-		if (!send) {
-			if (!in_interrupt())
-				pr_debug("%-10s:", current->comm);
-			else
-				pr_debug("interrupt  :");
-
-			pr_debug("receiving....\n");
-			usbip_dump_buffer(bp, osize);
-			pr_debug("received, osize %d ret %d size %d total %d\n",
-				 osize, result, size, total);
-		}
+		if (!in_interrupt())
+			pr_debug("%-10s:", current->comm);
+		else
+			pr_debug("interrupt  :");
 
-		if (send)
-			pr_debug("send, total %d\n", total);
+		pr_debug("receiving....\n");
+		usbip_dump_buffer(bp, osize);
+		pr_debug("received, osize %d ret %d size %d total %d\n",
+			osize, result, size, total);
 	}
 
 	return total;
@@ -420,7 +394,7 @@ int usbip_xmit(int send, struct socket *
 err:
 	return result;
 }
-EXPORT_SYMBOL_GPL(usbip_xmit);
+EXPORT_SYMBOL_GPL(usbip_recv);
 
 struct socket *sockfd_to_socket(unsigned int sockfd)
 {
@@ -712,7 +686,7 @@ int usbip_recv_iso(struct usbip_device *
 	if (!buff)
 		return -ENOMEM;
 
-	ret = usbip_xmit(0, ud->tcp_socket, buff, size, 0);
+	ret = usbip_recv(ud->tcp_socket, buff, size);
 	if (ret != size) {
 		dev_err(&urb->dev->dev, "recv iso_frame_descriptor, %d\n",
 			ret);
@@ -831,8 +805,7 @@ int usbip_recv_xbuff(struct usbip_device
 		}
 	}
 
-	ret = usbip_xmit(0, ud->tcp_socket, (char *)urb->transfer_buffer,
-			 size, 0);
+	ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
 	if (ret != size) {
 		dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
 		if (ud->side == USBIP_STUB) {
--- a/drivers/staging/usbip/usbip_common.h
+++ b/drivers/staging/usbip/usbip_common.h
@@ -306,8 +306,7 @@ void setreuse(struct socket *);
 void usbip_dump_urb(struct urb *purb);
 void usbip_dump_header(struct usbip_header *pdu);
 
-int usbip_xmit(int send, struct socket *sock, char *buf, int size,
-	       int msg_flags);
+int usbip_recv(struct socket *sock, void *buf, int size);
 struct socket *sockfd_to_socket(unsigned int sockfd);
 
 void usbip_pack_pdu(struct usbip_header *pdu, struct urb *urb, int cmd,
--- a/drivers/staging/usbip/vhci_rx.c
+++ b/drivers/staging/usbip/vhci_rx.c
@@ -205,7 +205,7 @@ static void vhci_rx_pdu(struct usbip_dev
 	memset(&pdu, 0, sizeof(pdu));
 
 	/* 1. receive a pdu header */
-	ret = usbip_xmit(0, ud->tcp_socket, (char *) &pdu, sizeof(pdu), 0);
+	ret = usbip_recv(ud->tcp_socket, &pdu, sizeof(pdu));
 	if (ret < 0) {
 		if (ret == -ECONNRESET)
 			pr_info("connection reset by peer\n");
