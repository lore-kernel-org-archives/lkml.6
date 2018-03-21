Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218605-1521610103-2-9381414117914712235
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521610103; b=vVyivbxZhs1uVf7vIi48kW519GK+Q9SQDmnqDZAaiXr+ZyW
    jzizUGa49QNYQXBG4rigJOLZVSOHV2mQ3UdhPGCHUy+3M/QKU4oyMSex5bJpXWG/
    J49zoK8/u7pcKEjrgpQbw4FOOY/8UQXtNjc+9EECIafFvuzLzZeSgdSQryBVDfaj
    GRcygzYKJsZ+3G9w9qRNtxsGuWhtXEvs1swzUTIc+VY6zyYlniBM1JyOIXPEmKan
    aMaCB55p6nODl1E1BOnz0nCOFjFKkC1gzRF0Sv7quRDJ+iVagxdM+LiiYq9zUcFt
    ApXOFOuQaYUkgLDaIY+8CTsaFOI8vKnaUfpeLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521610103; bh=fEgU6FWcd7JWxBmvqoCN5ogq9T
    ADy+8ktD6Qv/OH1f0=; b=lIlel+cNhnYkZYZzuTYPGlFXcdyWjT0RdkvJ0sPvKO
    Jmo8+jAA3oz0GTlFmyUMoOb9gOtUIW4zPpPDB4icVIzchMLx7N2rA4t8oE4FyFav
    W6788Drs5tZtte5B92RFCM80vJ0eeNptBQYvOmW3fRV7xrVrh+m+bTwzDl/9kmtt
    5bo2arl0PG+eNDEnVv/peXIw3hFd5yUe/25W02uCMb10Ea8C5cY6I2B8g1fhk6zf
    F3mAe55ztNutGxopjQsPoGB18Jz8N3ajVKaINJTYCAXIZaaqzQLNC7yKUPDkj/rf
    C6965bTx+wvpgbN4yXOx+oH3UZ0MJoIO800Jr3D3RgXg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeCUF2S (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 01:28:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:54394 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCUF2R (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 21 Mar 2018 01:28:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="213241842"
From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH] USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw
Date: Wed, 21 Mar 2018 13:29:42 +0800
Message-Id: <20180321052942.2853-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

USB3 hubs don't support global suspend.

USB3 specification 10.10, Enhanced SuperSpeed hubs only support selective
suspend and resume, they do not support global suspend/resume where the
hub downstream facing ports states are not affected.

When system enters hibernation it first enters freeze process where only
the root hub enters suspend, usb_port_suspend() is not called for other
devices, and suspend status flags are not set for them. Other devices are
expected to suspend globally. Some external USB3 hubs will suspend the
downstream facing port at global suspend. These devices won't be resumed
at thaw as the suspend status flag is not set.

A USB3 removable hard disk connected through a USB3 hub that won't resume
at thaw will fail to synchronize SCSI cache, return “cmd cmplt err -71”
error, and needs a 60 seconds timeout which causing system hang for 60s
before the USB host reset the port for the USB3 removable hard disk to
recover.

Fix this by always calling usb_port_suspend() during freeze for USB3
devices.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/core/generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 83c14dda6300..bc8242bc4564 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -210,8 +210,13 @@ static int generic_suspend(struct usb_device *udev, pm_message_t msg)
 	if (!udev->parent)
 		rc = hcd_bus_suspend(udev, msg);
 
-	/* Non-root devices don't need to do anything for FREEZE or PRETHAW */
-	else if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+	/*
+	 * Non-root USB2 devices don't need to do anything for FREEZE
+	 * or PRETHAW. USB3 devices don't support global suspend and
+	 * needs to be selectively suspended.
+	 */
+	else if ((msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+		 && (udev->speed < USB_SPEED_SUPER))
 		rc = 0;
 	else
 		rc = usb_port_suspend(udev, msg);
-- 
2.11.0

