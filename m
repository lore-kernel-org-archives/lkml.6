Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811314-1526501423-2-16518191170325427415
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526501423; b=SYegfqIYRx9D/rL4b+MxuTAOaCOyg9LnFADRucI304oOdzBqsm
    FCDMJu6CE9fZF04YZjc1La8P8kpmDOGL2ePgAAT7I0RvCufYHu+RpR4aQOeZfoSn
    RefWIGuWYWPEyV9ZkVSU8mbbDFCipFL/WxQK3F1a6upVjyzXoPVdHnLeIhTF+KMN
    0p6gWgVoFwCS42rAyVN0Td5u4NeUNhnipNJglfNrykY0ofHy8Q9Jv7rV53XBgqrM
    3gyr3kOeXRcOLE8PSCso41JyT3Pf0eoDR9iO1UWUcSCYmQ4CfZgKtB+WnvPlM7VF
    H/MTD2sRBSPVrRRatSJdj7b1ZFp3bSahHhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526501423; bh=o6udca/E92Y25nLa1+upsn+91DwD9K
    sYRlzksoQoNfo=; b=I+Setr1F2v0P7tVJ7Gqw4vkgPfbIR/7w/hdZl0yu+8eyM3
    0nCH5Pf0aVBTUz6rzOJxMJ/G+MtiC4dyYLTQMgsf77633JKviPKRz0vAzbQY1K9J
    m9SOzS8wBT/EYXI7pWCzHnGlJ+OkMTq9Mx79/oMw6yWRpy8uyP/zreuy8gGXiran
    d0nFJYkteVqo7sEj/IuB9eMDD8psG4zopzt3zjCJjz8NQu4XLVL5xO0hLG38e6Hk
    dWzm5ZOe6lxs2vstyI2DYJwvQNDqrBpkyYF+EFx91e8gDmyYczUOaF4vj+V0rR7m
    v0KFaAOVPUUvbCNQgr0dhwNtE4KvxKHjvIE4UhMw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=godking.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=godking.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=godking.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=godking.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH+51ab4n0L9UmfNHcm2ws/fJR4Fm8lk7KV45U/c97S57lXBxRrNZy+CBx2TO6iJUN3ikMtT/wNe9QvSOTaElzthcgVSeT5yGJZ2ESH/aXtBljYn42PO
    HpVD1hUNZ4JLY/vhUykBPt7rzIbSZq/h7+pql92eoUzlVzJNIwHaTxwxoFmpgCjzFB/3User25PdBjP/v7IkMn2TV8OK7kjeoPePO6UyCKQXjHpS4DdNoqCl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=97dSWYl1AAAA:8 a=FXmwvOYqAAAA:8 a=VwQbUJbxAAAA:8 a=pvUMkomslepPvw_d2LMA:9
    a=x8gzFH9gYPwA:10 a=OJayMvquMdr9gCXU5-l_:22 a=kXiaH_QbUnwHKQcifsFq:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeEPUKJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:10:09 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:60686 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeEPUKI (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 16 May 2018 16:10:08 -0400
From: Alexander Kappner <agk@godking.net>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Alexander Kappner <agk@godking.net>
Subject: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive" work 
Date: Wed, 16 May 2018 13:01:20 -0700
Message-Id: <1526500880-26512-1-git-send-email-agk@godking.net>
X-Mailer: git-send-email 2.1.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "G-Drive" (sold by G-Technology) external USB 3.0 drive
 hangs on write access under UAS:

[  136.079121] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  136.079144] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
[  136.079152] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
[  136.079176] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 00 00 00 00 00 00 00 08 00 00
[  136.079180] print_req_error: critical target error, dev sdi, sector 0
[  136.079183] Buffer I/O error on dev sdi, logical block 0, lost sync page write
[  136.173148] EXT4-fs (sdi): mounted filesystem with ordered data mode. Opts: (null)
[  140.583998] sd 15:0:0:0: [sdi] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[  140.584010] sd 15:0:0:0: [sdi] tag#0 Sense Key : Illegal Request [current]
[  140.584016] sd 15:0:0:0: [sdi] tag#0 Add. Sense: Invalid field in cdb
[  140.584022] sd 15:0:0:0: [sdi] tag#0 CDB: Write(16) 8a 08 00 00 00 00 e8 c4 00 18 00 00 00 08 00 00
[  140.584025] print_req_error: critical target error, dev sdi, sector 3905159192
[  140.584044] print_req_error: critical target error, dev sdi, sector 3905159192
[  140.584052] Aborting journal on device sdi-8.

The proposed patch adds compatibility quirks. Because the drive requires two
quirks (one to disable UAS, and another to work with usb-storage), adding this
under unusual_devs.h and not unusual_uas.h so kernels compiled without UAS
receive the quirk. With the patch, the drive works reliably
(tested on NEC Corporation uPD720200 USB 3.0 host controller).

Signed-off-by: Alexander Kappner <agk@godking.net>
---
 drivers/usb/storage/unusual_devs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 747d3a9..b8661a1 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2321,6 +2321,15 @@ UNUSUAL_DEV(  0x4146, 0xba01, 0x0100, 0x0100,
 		"Micro Mini 1GB",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
 
+/* "G-DRIVE" external HDD hangs on write without these.
+ * Reported-by: Alexander Kappner <agk@godking.net>
+ */
+UNUSUAL_DEV(0x4971, 0x8024, 0x0000, 0x9999,
+		"SimpleTech",
+		"External HDD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS | US_FL_NO_WP_DETECT),
+
 /*
  * Nick Bowler <nbowler@elliptictech.com>
  * SCSI stack spams (otherwise harmless) error messages.
-- 
2.1.4

