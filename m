Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805816-2-11012777993820220732
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805815; b=wNBXPJdQRz/Ufq8RLjVY1uK6Jdgj3bBkeW7/7bEqWfflY/Z
    Mg/+lzqmJA3aclmjgtnyKalDkNm0FRfspNu4pBPoDv/w2pT/UdQvSrIbsKx2lFtq
    pazIwVSlUqE9VueLEATXYgufCXv2pjCE0KF4rNJvE64K4m7RbwhB0M80/fCjY8N3
    qNju+yIsMppAzOwvPu4KBT28aUqniPsN9Pd6I9aJ7hrC301o2N2cqss+wRodzo5/
    cVNC5plTVMt/j1p/QfaewgQ7Q2RzXWQgn8geajJdTLBx3Zo1uVkLFaL0qbVquNAh
    omKtj9dcOUmy5iZ0N8+NEPvdMpTeR26wlr1m14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805815; bh=Vl8/qkyaaflXRu2C1QXdrImWTF
    tO5qy/lST99ymYvWw=; b=FPaP2EQrPPHYzVLxxvg8nYXvIKAu+UiBbH4Pj8aopE
    FUbkIe+6trHs6UoiCVILLem/v+uBMnfwOmQzpVhNf95fmNA9EJk/r7lQ9ezZWMao
    5IKTykJ8qXsUEIbZH2LO+5mCzci1uT6HguNjuy77fQ9l63RKNE1Rfs0IORJZPhgx
    f959jdFbWpR9eT8pOxIMtXjCsgqelT6Ez3BW5OIJex9BNydcUgIk5/C1vsqmFgLM
    USvr1nPqw7jQvK1GQbOWJT+ZPISemYYRnVZhPtjGtepuf9LS3IGRb622FMfKYU67
    UauQbWURjac73ki5cCo//295CoBOc3/RVwDG3YYZhbYQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCWLt6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:49:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753854AbeCWKCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 30/77] net: phy: meson-gxl: check phy_write return value
Date: Fri, 23 Mar 2018 10:54:04 +0100
Message-Id: <20180323094144.237759807@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>


[ Upstream commit 9042b46eda33ef5db3cdfc9e12b3c8cabb196141 ]

Always check phy_write return values. Better to be safe than sorry

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/meson-gxl.c |   50 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 12 deletions(-)

--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -25,27 +25,53 @@
 
 static int meson_gxl_config_init(struct phy_device *phydev)
 {
+	int ret;
+
 	/* Enable Analog and DSP register Bank access by */
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
-	phy_write(phydev, 0x14, 0x0000);
-	phy_write(phydev, 0x14, 0x0400);
+	ret = phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x0000);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x0400);
+	if (ret)
+		return ret;
 
 	/* Write Analog register 23 */
-	phy_write(phydev, 0x17, 0x8E0D);
-	phy_write(phydev, 0x14, 0x4417);
+	ret = phy_write(phydev, 0x17, 0x8E0D);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x4417);
+	if (ret)
+		return ret;
 
 	/* Enable fractional PLL */
-	phy_write(phydev, 0x17, 0x0005);
-	phy_write(phydev, 0x14, 0x5C1B);
+	ret = phy_write(phydev, 0x17, 0x0005);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x5C1B);
+	if (ret)
+		return ret;
 
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0x029A);
-	phy_write(phydev, 0x14, 0x5C1D);
+	ret = phy_write(phydev, 0x17, 0x029A);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x5C1D);
+	if (ret)
+		return ret;
 
 	/* Program fraction FR_PLL_DIV1 */
-	phy_write(phydev, 0x17, 0xAAAA);
-	phy_write(phydev, 0x14, 0x5C1C);
+	ret = phy_write(phydev, 0x17, 0xAAAA);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x14, 0x5C1C);
+	if (ret)
+		return ret;
 
 	return 0;
 }
