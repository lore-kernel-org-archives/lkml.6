Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837441-2-16450081051642511448
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
    t=1519837440; b=jzt0h1wxuOTSoqWTqjUFNFMIvUJmVxPFmI45uFW/cO1gwbP
    6fQIyxmtr9m8ChSFSVwmouqgMzSKPN6UYc0NTJMG0Z8bBEZ6AJmVgvCWlyLFvivv
    UyzwSdlSLCewyU+/pn3DFotnYf+EeuCO9AQW1LCPmrlp8m/cnMAtVys2cRCO1tQ2
    11sgaSs+17SsLn3JeeCDK+5+nszwMEuzcaiJmoZegCsbhBVyVGElwoIb/nUwIaUm
    aanTmdmIXDI2N8CcCIHNt4OaNXdFSaF0BaVDVrv8pzzwwXKTSn1cv3UzCrapbTy1
    naPINsmGv3YTdscUo6WCGsElUHDCmXyjgu4Fl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837440; bh=lfs1Qjg9x6+YkNjy/Jw
    xhRmrfkg89+vR9wlMbXgDxLU=; b=aZALoDsnKNdqNrNEwASpz+giyP+y71L5dSb
    cSTIgCmxJLqdNdEZE8DCueB7GLSYcj09iFDj9hiEcnzyTF51eoUr+Fv3nCr4TCiV
    MgU/qM/+LCXcYJIFTbyMi6euYbwN5HoIOMdOCVeDey9FGR0u4lYWWbfJZ3qgnvkl
    NROxkCZaCBPJf9omJlCr1AdJWA+Ir93zFQz8FvNY2P5U7gnaG+Kvkm3q7nzdmm47
    sG6hzvNw9VXmPg0gPZvJMEzYEf+1PnvQu9u4X4+9mcM5T6K3kCeHTsrrtcI2A+J6
    2TG7ZqUiFhr7GuUpUWEwR0w4tpSvgRQKnh6XnGlB5jPX6bbRmYw==
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
        id S933687AbeB1Pvd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:51:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34337 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933272AbeB1Pvc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:51:32 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Iyappan Subramanian" <isubramanian@apm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.654801411@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 166/254] phy: Add helper function to check phy
 interface mode
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

From: Iyappan Subramanian <isubramanian@apm.com>

commit 32d0f7830d9be5b1652a718e050d808b4908155f upstream.

Added helper function that checks phy_mode is RGMII (all variants)
'bool phy_interface_mode_is_rgmii(phy_interface_t mode)'

Changed the following function, to use the above.
'bool phy_interface_is_rgmii(struct phy_device *phydev)'

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/phy.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -630,14 +630,24 @@ static inline bool phy_is_internal(struc
 }
 
 /**
+ * phy_interface_mode_is_rgmii - Convenience function for testing if a
+ * PHY interface mode is RGMII (all variants)
+ * @mode: the phy_interface_t enum
+ */
+static inline bool phy_interface_mode_is_rgmii(phy_interface_t mode)
+{
+	return mode >= PHY_INTERFACE_MODE_RGMII &&
+		mode <= PHY_INTERFACE_MODE_RGMII_TXID;
+};
+
+/**
  * phy_interface_is_rgmii - Convenience function for testing if a PHY interface
  * is RGMII (all variants)
  * @phydev: the phy_device struct
  */
 static inline bool phy_interface_is_rgmii(struct phy_device *phydev)
 {
-	return phydev->interface >= PHY_INTERFACE_MODE_RGMII &&
-		phydev->interface <= PHY_INTERFACE_MODE_RGMII_TXID;
+	return phy_interface_mode_is_rgmii(phydev->interface);
 }
 
 /**
