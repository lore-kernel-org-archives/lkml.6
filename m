Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807590-1526705460-2-3975667180841439604
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
    1526705460; b=I9L8Yn4L7uDJG7gnt5yy+MkC2Hk5b2JCT5eRYjJuMzIsFuDLdz
    j9O6GbPE6h6jvvrpstv39rHDLdLwrD52bxiM80f5MdLpCHgB47rGjdbo/WJK34oN
    CmRFLbH/HnY8+ijc+mt+NwNkkyt6/v0rMqCjed7j4z+5vg3HpnHIK8vaP4bdmKso
    VIJ4Ma/LzgqD4dQafl2P8jUoZYqT1VfB2Y5KL71xANF0xN/Ou7HOe8Vrsw6YVhJj
    TPK4yfOrngqhqP175XzLLp4PQzzC+CdBU5IOjJxcPurVopja3skU9ppz4hTT+ezZ
    BqfHs2ovTOZ6L7hfjWqJYabJZG5sXS8RSXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526705460; bh=
    XnHY+1iPWgTOpWX4zuJ4ueFFWq3xyMvD4iUxvudYJSM=; b=hGvIbKo+UdfIPC8a
    cRCt+wL+bUZzQK0i/JNDjEzJMyY3YOL66iLn934a4LnRELKOxynaJHtCawnT79hf
    paVvWVf5goNxgIgb/6VsHAQk5ubarptTB5jRyiMW+YmZRsnRqsGveEE+8I/10dS3
    d/03H8l2BnkU5uH92soomnBZjNB3//EP2CpaotPo2E5sRKEH1ApwpyzbG2iBTZ68
    2HrmudTt0tQTy31/mitjNhPTL/WaDDGVvMu8lmF2cEjJpCPx6Zg0plfQFswysQ1f
    rIIGeLD6UERe1jCgzvIozx3S2xbfJ/Vjut/E/Q7BLeBQZ1veNR1aM6QGlra74zeB
    li3SRA==
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
X-CM-Envelope: MS4wfLjCWvFZGO8qwOU83U8XSWAaaRcBRo9pNuD5da8gQQXj7/Xdu618ynYqAXFdKUEfcIMbom8qrJZh19MNZKmnWtRtzQzzeNu/fTgyi4Vrz9nc0ZKeF8tP
    cXU3RjkUmGrwlbIfzcGeWac3cq0jYSbTJzlgzaIhk6xdnXg6S/dZ7om/DbZljTCqYpHJWnoSgzer8RvWC1hjq4GpDUAF8h+TdmS1FCEryX907d/zKQGmVUP0
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=97dSWYl1AAAA:8 a=VwQbUJbxAAAA:8 a=0vreUxKbzhizQVWKFaQA:9 a=x8gzFH9gYPwA:10
    a=OJayMvquMdr9gCXU5-l_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeESEuc (ORCPT <rfc822;greg@kroah.com>);
        Sat, 19 May 2018 00:50:32 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:42458 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeESEu2 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 19 May 2018 00:50:28 -0400
From: Alexander Kappner <agk@godking.net>
To: stern@rowland.harvard.edu, oneukum@suse.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, gregkh@linuxfoundation.org,
        Alexander Kappner <agk@godking.net>
Subject: [PATCH v2 1/2] usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver
Date: Fri, 18 May 2018 21:50:15 -0700
Message-Id: <1526705416-12573-2-git-send-email-agk@godking.net>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526705416-12573-1-git-send-email-agk@godking.net>
References: <Pine.LNX.4.44L0.1805181634000.1645-100000@iolanthe.rowland.org>
 <1526705416-12573-1-git-send-email-agk@godking.net>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ALWAYS_SYNC flag is currently honored by the usb-storage driver but not UAS
and is required to work around devices that become unstable upon being
queried for cache. This code is taken straight from:
drivers/usb/storage/scsiglue.c:284

Signed-off-by: Alexander Kappner <agk@godking.net>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/storage/uas.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 6034c39..9e9de54 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -836,6 +836,12 @@ static int uas_slave_configure(struct scsi_device *sdev)
 	if (devinfo->flags & US_FL_BROKEN_FUA)
 		sdev->broken_fua = 1;
 
+	/* UAS also needs to support FL_ALWAYS_SYNC */
+	if (devinfo->flags & US_FL_ALWAYS_SYNC) {
+		sdev->skip_ms_page_3f = 1;
+		sdev->skip_ms_page_8 = 1;
+		sdev->wce_default_on = 1;
+	}
 	scsi_change_queue_depth(sdev, devinfo->qdepth - 2);
 	return 0;
 }
-- 
2.1.4

