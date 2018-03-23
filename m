Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521807060-2-4530588319862085601
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
    t=1521807059; b=mZvVCicrTc0/ewY/RWMD2zdCCZijgaQQw+gCU1m6lrhELIu
    3qBF6dB2nBJ2qJuSSuK3a2I7mQMl55AWLRt4j+8ACus7DNiFWKJZmXeya0n32Nw5
    7nAaPua+JZ4CUFRVnyzPlhFMNshkE48bNMbuV1p0NxWfWgOjyMq3e+wyNrk08HFU
    VUf04jM3KnOHT8IPczNRBE0Z9V2jDdcdB+M88TZvfY/36Erk7gAwCIM5JIOXTgO1
    stEkqN8UPxvBfKpxMy8npCdzfs5MBzkaoGKCanfE6aQ06A2Y3ACrwlfX6nPWEsch
    a9mHXAnt0w6aY5jP4GgIA+EfF8WShCZ1cEj2eHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807059; bh=oi55sPSikm6Mx+EcRW+BBw9j7T
    uGUDojxD2KTzdLig0=; b=ihO7B2HMbRyOtSY8RHkTcEzk+xp4+VNc5JVANiYw8r
    CqeAf0xwOUsq3OGBsR/8bpzBNZJwiBZf29xa+ub/4b2AOLcdK52qsZ2MQ+3sCdVq
    A/n//nALJ2PdYFw/ogVjbFYDKu0gFmdotB7+9PJotSFwUU9nfOhbbUi/KFYYkHxj
    XsfI4SZS6mPrjSfgQg1o09yqfzgYg85+AmTyP2n89GhX5LF4vZE/tV/utESsL4K+
    TBFhiES7+YgpdKq+7etqon+f/7llzen+/plBhwAIcO75yP8UZLMr7L4U/DFm/3U6
    OBWi4vcUxyQrJ286Kh9BeVAY2bAdBzwxCTTZ9EUX4L2g==
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
        id S1753169AbeCWMKd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:10:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbeCWJ55 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 34/84] net: phy: meson-gxl: check phy_write return value
Date: Fri, 23 Mar 2018 10:53:48 +0100
Message-Id: <20180323095417.060448025@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -26,27 +26,53 @@
 
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
