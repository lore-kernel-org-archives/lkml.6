Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836192-2-16155754911602159944
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
    t=1519836191; b=pDd55vXppLnajjofMpbtI3mwlVtUW/5JOCvTHS0/3kmOjN5
    fDp0/PhX1oCJx5s2ghWjcrqWRGVTnkvdI2nAY4Ew/n/zJROW64NWCGB/B3P+qR7A
    Cuw+pvUheAE4p6rh/z0pIHSLvsis07VmMM8s/m63IRBBEOrlCYD1f9JVphuRGOSJ
    evMxat0fmYOXgRR4kYfpSpQP7FO44u3Yly7OimuUFuoS9/1EvHowy15N5Cq9+55W
    wQEavkeUVByrZqTdkQ8ZnVLQdfD8Jt2zmlk4qn3Bg5HNOU4cJ7euv6DyYL2SmH14
    TTVJW8QD2HAmvZrGgMXe8Q+QKgwAat36HfVY++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836191; bh=OgkOgClNuPyCerLoX9e
    PCgnYp2ErgzH6wmxRgRml0sU=; b=r79EwzchsGeXBqprsL/YJDXgb1r0GXxBw/n
    T0cpNIZ2H1vUq8NSpjxHfT0GVV2hA3rwpbQTmPz+b1ZrkQHuF5ZrYu2YCn6aTQcw
    2lZNMn8Xh7CKt9gxNGXlQdMLMJTAUtNyUJIi0ksQEy/mL+JlZzCl7i1PZIVs7KT/
    4Tp32QX4fu6g64uOR1jTyiMBgteJ6D/yoYeNscnkX0H3cxwk5jTDih3a99Pb84jN
    82WKPceC41iuoSjS/jOy2x8NQO8JdO1OMfs3cVHz+5uRk4UrpmzoLDnh1tP7fNAL
    qEwtcS+6hpx5IA+tdeRE7GUUBSSyeXHbqvbpWJDCSabFoZBwzAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeB1QDO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:03:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34745 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932224AbeB1QDM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Florian Fainelli" <f.fainelli@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.738754130@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 165/254] net: phy: Add phy_interface_is_rgmii helper
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

From: Florian Fainelli <f.fainelli@gmail.com>

commit e463d88c36d42211aa72ed76d32fb8bf37820ef1 upstream.

RGMII interfaces come in 4 different flavors that the PHY library needs
to care about: regular RGMII (no delays), RGMII with either RX or TX
delay, and both. In order to avoid errors of checking only for one type
of RGMII interface and miss the 3 others, introduce a convenience
function which tests for all values.

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/phy.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -630,6 +630,17 @@ static inline bool phy_is_internal(struc
 }
 
 /**
+ * phy_interface_is_rgmii - Convenience function for testing if a PHY interface
+ * is RGMII (all variants)
+ * @phydev: the phy_device struct
+ */
+static inline bool phy_interface_is_rgmii(struct phy_device *phydev)
+{
+	return phydev->interface >= PHY_INTERFACE_MODE_RGMII &&
+		phydev->interface <= PHY_INTERFACE_MODE_RGMII_TXID;
+}
+
+/**
  * phy_write_mmd - Convenience function for writing a register
  * on an MMD on a given PHY.
  * @phydev: The phy_device struct
