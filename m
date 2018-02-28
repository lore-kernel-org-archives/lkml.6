Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837314-2-18116004031407253681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837313; b=ASYOC+maVS1Ivwde0wYkuGhk92NyEuzcon4vPRXydQbF4vh
    I4Ga9zOTJLuRrActJslnN42nrjmh2XhYSV+QEiIc/o2dFeO7vMbr/0964hppvdDs
    WcngKx3XXgkcnkiL+YN7E/2jUFzdnJ9bRX9pOAef+759zZTC/3go/eq6g6G1L64j
    8+KsjnlXdrar3cTRdoHbY0E98hOib3WCVYJlZ8oJeBYNba8J2mmZQHHySQkv1mN+
    Oq8H4By2bEbyVrB8oNB87slKEWqYa+VxM2A8asoPBJTnkRuqSBUih/0dxQi+r0P9
    pCF2s7ZbZC7b3NyF98LwqaDZxVik3mtmC8JY2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837313; bh=NwjeTM+/q7Fb2rNSYpG
    dOYtRrN7bzNKa4EtIy4Bg4q8=; b=DkXU/vfh9MIfM/zf1vtz6fApJb4HxgrgNFn
    uOsOQyTz41qqzgq8YbF5XABJdsETkUvPKHCwf3VzY7+A4I7eyAmc1Za2Fjsq4naI
    0G5qE+23LyYv+hyHKi4AWo8Pe7IymDgtQhQqzqQLMptNgWutKD/En7+dlewzk/FK
    JdStKPYTyuMvHepJAjmIkq+2ajs3nH5SOtpA6HGrRbYTj+/OzMDHmFnH3iTSPcd9
    8wSzXD99BNxD3YzyvYw37HKUzYnP8L7bsel266v1poOHxwFXjfHCGULzQ46DSb6i
    azpC13ExjOiCAsAvynhdkz0ma2txrSR59hIPM9n4RPl8YnhR7+A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeB1PwE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34366 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933786AbeB1PwA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:00 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Zhao Qiang" <qiang.zhao@nxp.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.442329863@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 122/254] net: phy: marvell: Limit 88m1101 autoneg
 errata to 88E1145 as well.
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Zhao Qiang <qiang.zhao@nxp.com>

commit c505873eaece2b4aefd07d339dc7e1400e0235ac upstream.

88E1145 also need this autoneg errata.

Fixes: f2899788353c ("net: phy: marvell: Limit errata to 88m1101")
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/phy/marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -988,7 +988,7 @@ static struct phy_driver marvell_drivers
 		.features = PHY_GBIT_FEATURES,
 		.flags = PHY_HAS_INTERRUPT,
 		.config_init = &m88e1145_config_init,
-		.config_aneg = &marvell_config_aneg,
+		.config_aneg = &m88e1101_config_aneg,
 		.read_status = &genphy_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
 		.config_intr = &marvell_config_intr,
