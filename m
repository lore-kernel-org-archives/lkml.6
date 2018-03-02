Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519980761-2-1918392472254487709
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519980760; b=vvb7Z2YrxM9AXUPhdTk4fBahGqBpRW+0w4tkk8DOOxyXlnv
    BRSHkOps01aPRimIE4LvuVr245//EPjTqpFnl4IsjovI+Z4Rs1mOXB7PBHLdxntU
    tO9jJmLrRuGj1ADGElxcx/jY6b15F2+9ZRg3g8OFnP8R/mV3P9NFKs1BUIUMhgcC
    6pYOXWb2GmDPXn2gHn5oetGDmSdC4omR4OrE+aSyAjbLGkXjc5ZNyUA+xeyeWujI
    mkz91Sktxc662sF5UaUWDJ+Cb3kbEQdRwu6iUrbhw8ghX6jxV68GQTgtCPVYZ9mB
    eCJasz61ztmUN2ayB555ZnByJgzohHgqT7YxMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519980760; bh=Cts7hK7xOBewqM0RhYAfVTTFtD
    76NSRCRKWb5GuIK/A=; b=CfmJyLbdbzmvTkYQJCNOiVlIwwoWTGSaATP452Z3Xf
    rE5t9z2PleoJSIF1ktyO/XWBD9CBQu6rCguPOjSNrg/PT2lTlNIZLexlSGKl9vQp
    SH9duC6WNns4HH/vvKfQ5dOSQfvWEtlS7+oXsl6OvJeeOVEvbTv8T5+Bua/WuVyR
    SSZnQ1+jUXDLTuAF2r0WhbyUFkEDmFTLWR4KB/KMRTh8hGOQbXfLjRRzYQCpCNvy
    45qh6qYlywlrYnWFT7fNwzR2IOtugGG8ik9zJrrucQryCFZ4rdQPjrKOm7LCSIl1
    qkZoTy76BpHjckbUa2oHqPn+fHLOoUKJL5HwhR3ZFHBg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423278AbeCBIw2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:52:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423193AbeCBIwM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:52:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 20/24] SolutionEngine771x: fix Ether platform data
Date: Fri,  2 Mar 2018 09:51:17 +0100
Message-Id: <20180302084240.134845753@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
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

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


[ Upstream commit 195e2addbce09e5afbc766efc1e6567c9ce840d3 ]

The 'sh_eth' driver's probe() method would fail  on the SolutionEngine7710
board and crash on SolutionEngine7712 board  as the platform code is
hopelessly behind the driver's platform data --  it passes the PHY address
instead of 'struct sh_eth_plat_data *'; pass the latter to the driver in
order to fix the bug...

Fixes: 71557a37adb5 ("[netdrvr] sh_eth: Add SH7619 support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/boards/mach-se/770x/setup.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <mach-se/mach/se.h>
 #include <mach-se/mach/mrshpc.h>
 #include <asm/machvec.h>
@@ -114,6 +115,11 @@ static struct platform_device heartbeat_
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) ||\
 	defined(CONFIG_CPU_SUBTYPE_SH7712)
 /* SH771X Ethernet driver */
+static struct sh_eth_plat_data sh_eth_plat = {
+	.phy = PHY_ID,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+};
+
 static struct resource sh_eth0_resources[] = {
 	[0] = {
 		.start = SH_ETH0_BASE,
@@ -131,7 +137,7 @@ static struct platform_device sh_eth0_de
 	.name = "sh771x-ether",
 	.id = 0,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth0_resources),
 	.resource = sh_eth0_resources,
@@ -154,7 +160,7 @@ static struct platform_device sh_eth1_de
 	.name = "sh771x-ether",
 	.id = 1,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth1_resources),
 	.resource = sh_eth1_resources,
