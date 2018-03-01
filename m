Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1959376-1519883001-2-1408343983126102382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519883001; b=jgjBif8Hpwe2KOvkcTndzYfvcXC9tcjyldYinSfEuIZ0dmV
    rEM6r8AaJDEeQvU+j6n8kjO53rqkqYoaI25YXMihLt18qT8jSzOSXDhqsEbr8QTm
    7BXXmPRQry2xrDkav0yx5ccXB6xxFq6s0wsHIJ/fMU4gzWwtNTYicAgSw6xdLtrC
    oCqv3xAe9aQM1zObVdvyfJ3MTdSaUTWKsJpf7EfYsedcr+Kmn/4nu5P7bjy84POx
    0Es6xQ6FGL6LhQp29N/LD9JW3dzfDX1qd7+krIAIt1tJzMQ0NH1s3GIr4aziavbJ
    5xA+/f/kpOLuOnDx6yuTmdUdTBg+f4oVmEltMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519883001; bh=AkGwX1m3GvUHgnUSE8kOQBTczI
    dCPxa5pev1RcaLNcM=; b=AOVrOn/1ykeZSyY/fNTsx6dCHCVUH/eClTxtkKUDwc
    D2L7n2nY+gkX1ZjBFCSzwFmFQCI0plQmTvrHLi0x+gD9a4pY2Bb6gJxSYZiDoOk6
    z2LWeg9+9JRbfSqCN81QzhTPZwrqd11dFfam1vhLVoACpHZkMUkSsTy95tIj4P36
    GoEp9NDdXJpwWESmU2pp2HRybU00oA0eWhJyzsJUJUolgoZwmjrfv5SkPTb6acx+
    ZhbMGl6wBUPrLYqvmF5dJ5RBYoOWoDGWNzGqt79ObjfNyFAlOrcGeBs6mkQgHg8e
    6/EYMpul7UlFCYiwA/zzl8w2Uh39guyTkP404rSyV15A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966116AbeCAFm7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 00:42:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47713 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966069AbeCAFm6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 00:42:58 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table
Date: Thu,  1 Mar 2018 13:42:52 +0800
Message-Id: <20180301054252.16007-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The issue can be reproduced before commit fd865802c66b ("Bluetooth:
btusb: fix QCA Rome suspend/resume") gets introduced, so the reset
resume quirk is still needed for this system.

T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e007 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Cc: stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c5cebf53eae5..e98fb5343a00 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -389,6 +389,13 @@ static const struct usb_device_id blacklist_table[] = {
  * the module itself. So we use a DMI list to match known broken platforms.
  */
 static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
+	{
+		/* Dell OptiPlex 3060 (QCA ROME device 0cf3:e007) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 3060"),
+		},
+	},
 	{}
 };
 
-- 
2.15.1
