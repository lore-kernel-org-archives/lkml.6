Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481223-2-2617168179428909592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481223; b=asEeF675fH/aYqa2tPjjp1mmnoKwx0gYpleJp/zXV3f6zcpAoH
    zY60X0GuTcqs4/5O4zTNt/bMas6tP5cvhlIXSzpnYgp1AwYz4M6KTwslo4CVDbPo
    GfZhYh1mMNW/PgzbRj6jnzmRujQY4GKzdsPH1tVtSYjnfe5Fe1K9IVY44b4m51X0
    VZ1g0SY5oPNeJQOQeNZGLaVsg63FF2msfbfaGP5mcI1nHsnudmGXWYtofdF+mWhT
    VqifH069IPhgjLg5QcTpT16L9fzRFJgfYwEAOmxSbrJItXyM5kBwu7EUwhszPvA9
    UswmbBzC6E4FtKOHpYJ3Z5XFCd5t3nNIjwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481223; bh=p1ZK3sd0O7VynTTScUpFtqVeSAORX1
    PZ3zvJeoNMuf8=; b=vq5vugpPNiVnHv2MpE5M3PcQD3lbcJY2WwR6R0c5msk0AV
    4VkODFhsDg1lOjxmLO8YhPzOyvodhyauB9qm9fzeWoIJU2FmTKIePCSBX7Qa3hdn
    KZRT3xGNnRkba8p1hc5BN2B64MFsENqxvljK0QvWpz0ClrDlZ2hQ9d8ZG2BQo2JW
    rXTbTYhe+WIWA0MC6KJQD2M2YpbS401cZ85v9lVM+IWCZejoUdbYe693AaBhBxTT
    3coE207zmbzgfFDugY8Z6egJ1PrOIURBv3KwgOG+LtbsnDg/8vrmil5/G4OhkoPp
    RnrB7BkB6fAkI0GRWztbpFVDikaBe8agoseKgo4w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFS5J1jHea3yybrvSO40D08y/NdXuEmVjkabYkXSxuiRGuEr2bAwLKbYxVEsiz/WLhkhO90Uxa1xD1oAE3SLE3XL841dryWAkgqWX/iMTKH4pmh9Mh+b
    Zak3sT84LPYwN3F6g+BBovBlzUyq8+oYU5HKCnI2jlfLNd6r0kWmLnBuMQP1MBQNEdyPWd5E58XJ2rNY+Uzt5bcAWYMP41/BVlxwsJmUYWCIsHeVDqTzxlZ1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=PHq6YzTAAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=vIFw0XP82na-7QQtWxwA:9 a=K8vUX97VMtdewC4X:21
    a=TvhyB4WreVeA7ieX:21 a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754933AbeDKVN3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:13:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56686 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754772AbeDKSlH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:41:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 074/121] net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support
Date: Wed, 11 Apr 2018 20:36:17 +0200
Message-Id: <20180411183500.640842614@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit 41408ad519f7a2a1c5229e61f2a97f4df1b61adc ]

Avoid calling genphy_aneg_done() for PHYs that do not implement the
Clause 22 register set.

Clause 45 PHYs may implement the Clause 22 register set along with the
Clause 22 extension MMD.  Hence, we can't simply block access to the
Clause 22 functions based on the PHY being a Clause 45 PHY.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -123,6 +123,12 @@ static inline int phy_aneg_done(struct p
 	if (phydev->drv->aneg_done)
 		return phydev->drv->aneg_done(phydev);
 
+	/* Avoid genphy_aneg_done() if the Clause 45 PHY does not
+	 * implement Clause 22 registers
+	 */
+	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+		return -EINVAL;
+
 	return genphy_aneg_done(phydev);
 }
 
