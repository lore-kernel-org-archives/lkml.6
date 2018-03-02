Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625397-1519998190-2-17447236309385796141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519998190; b=P2cnA0PVMVqxjqIfz+GGnecZvT6a2e9+MktxT92IpgSky4x
    otRHDMXbK1sbLSA+48YNcVt0aPBxcUnSfWiDbfjiKV2SID2q4+vVK0A3LYugSugT
    zMXDsGowWXhG7y11P3s5zNqR47RIRqvS9YPBmZ/P4df1KapTnqMjxMPiKl3UkPp6
    i4fYFlpXGF774iiD3exdDHc/IENLYKu9FXfvJRMTZnIsz5gfVd+Jko1oheH4/bco
    eiiOOLj9p1wtBxM7h12/kwlMVa6LBOpObuT+ND3J5j6s6RLvEgr1aXIm455iacw9
    sP6jVEdwAQwzqqSMy7G29b//AMmREg5qpZjJRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519998190; bh=p6Q0ct7x/bHIp0L3+bowRBp3CF
    AQdLoe9Vz/m1TeDh4=; b=HhR7VUJx7LgowN38u+zs4RsDAIGVs27GIuUQWe3DuQ
    JyfAsca2zlf7uUSWaOgCjWNDg5Ij8pjm+Z9buU13valinUa9AfI23WB15C8pEq8x
    WXHF5A13GOwuqxnCzVi8M5MPO1S0tlqvghF/r+Zi+aXjoGPOmS6i3tr0ImS1v8h3
    AQYogi4muA/D6EJzJP2CRWbGqcuacmeIwwehGoqsoOhT419VYOKvO+3MjxjKadca
    Mre127sjUr8G2fCOrHd6YVV5bhH2SouZiPUy5AbZDccnDjGGlFXk/x1bUkUmMlta
    7bh5IJfIbJ9tM3f29KZShPqwpu245Pk+uffDnaqRTTwg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428235AbeCBNmu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 08:42:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423331AbeCBNmt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Mar 2018 08:42:49 -0500
From: Colin King <colin.king@canonical.com>
To: "David S . Miller" <davem@davemloft.net>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/usb/kalmia: use ARRAY_SIZE for various array sizing calculations
Date: Fri,  2 Mar 2018 13:42:39 +0000
Message-Id: <20180302134239.31599-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Use the ARRAY_SIZE macro on a couple of arrays to determine
size of the arrays. Also fix up alignment to clean up a checkpatch
warning. Improvement suggested by Coccinelle.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/usb/kalmia.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/kalmia.c b/drivers/net/usb/kalmia.c
index ce0b0b4e3a57..2243da0aa991 100644
--- a/drivers/net/usb/kalmia.c
+++ b/drivers/net/usb/kalmia.c
@@ -114,14 +114,14 @@ kalmia_init_and_get_ethernet_addr(struct usbnet *dev, u8 *ethernet_addr)
 		return -ENOMEM;
 
 	memcpy(usb_buf, init_msg_1, 12);
-	status = kalmia_send_init_packet(dev, usb_buf, sizeof(init_msg_1)
-		/ sizeof(init_msg_1[0]), usb_buf, 24);
+	status = kalmia_send_init_packet(dev, usb_buf, ARRAY_SIZE(init_msg_1),
+					 usb_buf, 24);
 	if (status != 0)
 		return status;
 
 	memcpy(usb_buf, init_msg_2, 12);
-	status = kalmia_send_init_packet(dev, usb_buf, sizeof(init_msg_2)
-		/ sizeof(init_msg_2[0]), usb_buf, 28);
+	status = kalmia_send_init_packet(dev, usb_buf, ARRAY_SIZE(init_msg_2),
+					 usb_buf, 28);
 	if (status != 0)
 		return status;
 
-- 
2.15.1

