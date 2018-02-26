Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3834174-1519679595-2-12675648092889508141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519679594; b=kLkeLk63gxkP5VE5h8AbIleAVUlk38c8BvsloY0J9wD7fSa
    MIf6UfYk10iIdEedSEBE6sIz1fKqu/CfHXxd49LweE6wYpZLdMH1DKUp2kNzhxNN
    q79BhJFmzwjtmSN30lsi7ksfpX1UVVfSbeicv/9R82VgdIuOI+earVVhc6DuLjng
    h3uIAeZeRMCsEJYFLi76xXxDmmZThcEjr1eq02euAKXECAGMMG50i/wjbgTxOOoY
    BSP43K90HD9JJb3SKH7sonAimskBrjAyWwtapBBoooQ98tg2aL5jtzaEWcBb6V7d
    yV8bB68/PZkYWNQbNTMVDSElSZfvuHySn1k9l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519679594; bh=fyfR7qUOti2xv2jtMqyFWO9ULo
    d2NqozpXrTSiyf+X8=; b=qYaahwquBLAViJNIE+18ft+OCDEntpSRhexaSlzbxy
    4kPGVhGFyH61NunaDkBGslSp2obp8grp5Jdy5MF74lxSgfnCZCdgOoRnx+gBwg/U
    DlXZ7Kx6UzGKAPLO+nmckjLgp/EYgKZ/IlmqpDmoPS5I/SbQ71GoWc2Qa8RcHlnD
    DQq6cihr+OWdmPuwEDFzCETIKFd4wbHOrddijjupFhiRiUaEHd4vcaeTfI5DZtWD
    97yyljPfHcTfGQzROX8zdJodwkizJCaiZplS6E9gRhFJRmz1e0unv5do8LZtaT6+
    SBP2jKAw2pQaDAYIXm/FyWM2j3VZZbYQb3y0t0zGSqog==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeBZVNL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 16:13:11 -0500
Received: from osg.samsung.com ([64.30.133.232]:42683 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeBZVNL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 16:13:11 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bwh@kernel.org, dan.carpenter@oracle.com
Subject: [PATCH 3.16] staging: usbip stub_rx fix static checker warning on unnecessary checks
Date: Mon, 26 Feb 2018 14:12:41 -0700
Message-Id: <20180226211241.19335-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Upstream commit 10c901209306
("usbip: stub_rx: fix static checker warning on unnecessary checks")

Back-port fix for static checker warning on unnecessary checks

smatch warnings:
drivers/staging/usbip/stub_rx.c:360 get_pipe() warn: impossible
condition '(pdu->u.cmd_submit.transfer_buffer_length > ((~0 >> 1))) =>
(s32min-s32max > s32max)'
drivers/staging/usbip/stub_rx.c:501 stub_recv_cmd_submit() warn: always
true condition '(pdu->u.cmd_submit.transfer_buffer_length <= ((~0 >>
1))) => (s32min-s32max <= s32max)'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/staging/usbip/stub_rx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/usbip/stub_rx.c b/drivers/staging/usbip/stub_rx.c
index 35f59747122a..d8544ab9577b 100644
--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -356,14 +356,6 @@ static int get_pipe(struct stub_device *sdev, struct usbip_header *pdu)
 
 	epd = &ep->desc;
 
-	/* validate transfer_buffer_length */
-	if (pdu->u.cmd_submit.transfer_buffer_length > INT_MAX) {
-		dev_err(&sdev->udev->dev,
-			"CMD_SUBMIT: -EMSGSIZE transfer_buffer_length %d\n",
-			pdu->u.cmd_submit.transfer_buffer_length);
-		return -1;
-	}
-
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir == USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -497,8 +489,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	}
 
 	/* allocate urb transfer buffer, if needed */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0 &&
-	    pdu->u.cmd_submit.transfer_buffer_length <= INT_MAX) {
+	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
 		priv->urb->transfer_buffer =
 			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
 				GFP_KERNEL);
-- 
2.14.1
