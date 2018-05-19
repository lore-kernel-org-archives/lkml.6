Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807590-1526705454-2-3311130338460117768
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
    1526705453; b=SCZERDNg1DHy4ZGzEA30LlUz8wdaMymKiz5EsjHrNEKLsdGlN4
    jPBrpJWsnq8sZljGoY2XokTPHszeBzGRdzVwQ5/xMMfRneHTE6Xu0elu5Gp1sJJi
    72MmorFubh4AlFG8FVa4w2boRqhHZkNtFds6dMWifg0+WDj2pye7ZS3BC+C5Xm80
    MksqTlMw643fOs4WrbfEtrKQkABkEj+IAGiwOYcDV/KASiSe2oXuRXs9pI36T9e9
    TVBvmAkEDE0iMWYoqk4Dz56vUFG85ry2TRZa+ohOojMmDBKrbMPBdnYyXpXYEn7K
    njT0Dflv84w8sqTXtz9DMGHOmxsepu36mApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526705453; bh=
    vmWagzgzx/uV9obBIJlbNWjzeQHSxPxVWOzbytYErs0=; b=AluTxYwrUfi7L39h
    U+kNolxWPdcn8n7nrW3sxbYtV2j4C93apQSMmsRnlhienjiPyqxckFk04Nj/SPJg
    wdw9kjLm0Bii6XY2xffiBvkK09dO1LlXBxTw5dHLH9G6EBwiQETj9HuUhbDdYJ10
    bkDFfNDS7fJJmupVB90r7JZT6r0igfjYhZLt8407sbC//15FgAHi95LxPDl65y6Z
    MrKDmwzYMIYwOg0mLF6Qzya0rv4grC2aMIvLEFGGAgV5iHOgmIBXyxgypz3dwD0A
    iL1lc02q0sgURbWH3HkqM/jnlCHq/kSPS4Gp0DlV+Lbis5bUCAQEvfonCn65VoBK
    R7tT5w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDSXI/NHlCALOA3VkK7WkGczCqgMalSbCNGTnNIOr3Ie5Z3gvqIHJUvFV+2jO/CIUOLvfSvoEHuXnH+l+JtyV49bUFz0OSOM9myADMJzP5NtUUzQxgmc
    qFa4vm6v+HoJLcZsP3ZFitu76rsJ09TEHcMzbd2PI+OxgAfzyuOW1GNTPhyp8k4+vJARjNoBBRWfZudxr/7udny0gnFgni+5HK/m9/SON3es45cuxID44o3O
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=97dSWYl1AAAA:8 a=FXmwvOYqAAAA:8 a=VwQbUJbxAAAA:8 a=9-BEeznyIrX7e9MKCu4A:9
    a=x8gzFH9gYPwA:10 a=OJayMvquMdr9gCXU5-l_:22 a=kXiaH_QbUnwHKQcifsFq:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeESEuf (ORCPT <rfc822;greg@kroah.com>);
        Sat, 19 May 2018 00:50:35 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:42472 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbeESEub (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 19 May 2018 00:50:31 -0400
From: Alexander Kappner <agk@godking.net>
To: stern@rowland.harvard.edu, oneukum@suse.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, gregkh@linuxfoundation.org,
        Alexander Kappner <agk@godking.net>
Subject: [PATCH v2 2/2] usb-storage: Add compatibility quirk flags for G-Technologies G-Drive
Date: Fri, 18 May 2018 21:50:16 -0700
Message-Id: <1526705416-12573-3-git-send-email-agk@godking.net>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526705416-12573-1-git-send-email-agk@godking.net>
References: <Pine.LNX.4.44L0.1805181634000.1645-100000@iolanthe.rowland.org>
 <1526705416-12573-1-git-send-email-agk@godking.net>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "G-Drive" (sold by G-Technology) external USB 3.0 drive
 hangs on write access under UAS and usb-storage:

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
quirks (one to work with UAS, and another to work with usb-storage), adding this
under unusual_devs.h and not just unusual_uas.h so kernels compiled without UAS
receive the quirk. With the patch, the drive works reliably on UAS and usb-
storage.
(tested on NEC Corporation uPD720200 USB 3.0 host controller).

Signed-off-by: Alexander Kappner <agk@godking.net>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/storage/unusual_devs.h | 9 +++++++++
 drivers/usb/storage/unusual_uas.h  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 747d3a9..22fcfcc 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2321,6 +2321,15 @@ UNUSUAL_DEV(  0x4146, 0xba01, 0x0100, 0x0100,
 		"Micro Mini 1GB",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
 
+/* "G-DRIVE" external HDD hangs on write without these.
+ * Patch submitted by Alexander Kappner <agk@godking.net>
+ */
+UNUSUAL_DEV(0x4971, 0x8024, 0x0000, 0x9999,
+		"SimpleTech",
+		"External HDD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_ALWAYS_SYNC),
+
 /*
  * Nick Bowler <nbowler@elliptictech.com>
  * SCSI stack spams (otherwise harmless) error messages.
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 38434d8..d0bdebd 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -107,3 +107,12 @@ UNUSUAL_DEV(0x4971, 0x8017, 0x0000, 0x9999,
 		"External HDD",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES),
+
+/* "G-DRIVE" external HDD hangs on write without these.
+ * Patch submitted by Alexander Kappner <agk@godking.net>
+ */
+UNUSUAL_DEV(0x4971, 0x8024, 0x0000, 0x9999,
+		"SimpleTech",
+		"External HDD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_ALWAYS_SYNC),
-- 
2.1.4

