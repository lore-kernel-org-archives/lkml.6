Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415627-2-12166478705325096602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415626; b=ARurhpOnNEnsNe79Iy1FY90zgeyVZIggxnyBlKVTJDIkAdA
    kKhAsPqcMf1sCX+bjLdKiPVgNq/MWvKbtzJ+IXsu5OtzvgmvhhxmA/aOZ43K6cNz
    4NRWHFPgj3cnhTeeyhqyzKwPOvhbeSge3pLMmmw3db1rEGD/mUVHvcFgh5MVHhD2
    jMljAoa2TYzF+fksjzuIPg87tN5TL+e4dvmWHsZmskCe3gWeFhUnmR97yXHOMxu4
    4833n0cK4B+iUtAucbTaQV5GO9TssOUSFUpOY92oz2QQ2y0ihsE/Y/TmhgQlD7Sp
    KcjxgDb2aJH/KafwvZ6OwYJGSILf2rtccMy2DaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415626; bh=3vK3EF4uuVyunA5EcZVQesnWH3
    TDya0cw5xbaPS+dDE=; b=Qyrt0TR4JqgCgtRStfqmRO2+zmv25HNJlAFCSwuha6
    2HeSZg2q0IlrnDqyX6s475plqMp6pVMvQR6E7CY/6FTpAGTKvltYrhqTtTj1agtv
    q1KRCsdBOwiKcEUfZm6/hTuyaI2TCMqqLqoMQTe++PAq6PLaeiBd3pzkED1q/trN
    h1iIbJKe0hkvt8akAqVutUKqOM1gjghyPNN5QOaYpplH9AWoQHBUWGIgB1kHZuL3
    czvaJPCkjNr2ViuPcZN8h21o4wC+NfGYcOyosKCcqlzy7fHvXVcBDTzE86IV6ISl
    X7BG6tPZ8JrWUxJ9t84CjV0snrly75gP4huoHUE7s9oA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933789AbeBWSp0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933089AbeBWSpY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaohui Xie <Shaohui.Xie@nxp.com>,
        Yangbo Lu <Yangbo.lu@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 071/145] gianfar: Disable EEE autoneg by default
Date: Fri, 23 Feb 2018 19:26:17 +0100
Message-Id: <20180223170733.867043636@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Manoil <claudiu.manoil@nxp.com>


[ Upstream commit b6b5e8a691185606dfffff3198c89e3b4fd9d4f6 ]

This controller does not support EEE, but it may connect to a PHY
which supports EEE and advertises EEE by default, while its link
partner also advertises EEE. If this happens, the PHY enters low
power mode when the traffic rate is low and causes packet loss.
This patch disables EEE advertisement by default for any PHY that
gianfar connects to, to prevent the above unwanted outcome.

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
Tested-by: Yangbo Lu <Yangbo.lu@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1789,6 +1789,7 @@ static int init_phy(struct net_device *d
 		GFAR_SUPPORTED_GBIT : 0;
 	phy_interface_t interface;
 	struct phy_device *phydev;
+	struct ethtool_eee edata;
 
 	priv->oldlink = 0;
 	priv->oldspeed = 0;
@@ -1813,6 +1814,10 @@ static int init_phy(struct net_device *d
 	/* Add support for flow control, but don't advertise it by default */
 	phydev->supported |= (SUPPORTED_Pause | SUPPORTED_Asym_Pause);
 
+	/* disable EEE autoneg, EEE not supported by eTSEC */
+	memset(&edata, 0, sizeof(struct ethtool_eee));
+	phy_ethtool_set_eee(phydev, &edata);
+
 	return 0;
 }
 
