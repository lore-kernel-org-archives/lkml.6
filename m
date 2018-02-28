Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832186-2-5593741579056441358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832185; b=Vz4u9kFccYtORv2ircW3MwInAtSIunklsF/FN+8yn5FVqcx
    nzwrr9KdtNiwrobLm2T/SgORv/Q5vd84fz7Kfw/7GZ4jnVvbrT1AsjH3FPyN2Jro
    r4vJLx32mbVU20I3/6offv9628etGz/xoKG2sqSSNLnVNhWE0PffSENLkjqxUlPW
    3KEWFkWT2brlSf5y4Ik/XX4zdSsNjLAXW+m4z9HbB9c97vaVJimjJCEm0/cfgmhC
    /12OSVUXHBR6V1YzeqInQ9zBDtmL/c4PPQGKVHbvtus3Nuwv2qzQ1e4ipS+LDi++
    Th+SvoY7LfTHZ89tPHn6tU1dIkKjQnoxzx5lGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832185; bh=vjYmkZ8RX6qk06vPUad
    ZMx7B5nFUbU910Mj0C2giMK4=; b=YDy+A7cv34a1khgoExefaS+GmRrJ7xkeJu0
    iPqiRFYyqai0o4X9x0IypWg/gbwAREgJnPal8JOwSsJC4RapInH6sLI73kCjdNth
    beQdPsgHP88MJ6sdgkMrV1k3Aw9ovir9/hQryUGZuByg29GoBljxfm9Y9RA1AJZd
    exnA39XiX/Y8gXhIm4M8nt8ztGjEmjN/cZjSB4b9MFbGjbu8ZPvq9s4YWLchl1ko
    btWt1Zx2kTEq4hBwPcie2Q+LgwDkgq1JHcfn7aNCtXjzhqRhMySZdvkb/B+4R8sa
    Whdb+MctT4+UdOELuCN00ebRtmZlEzqTN+FbrLnmNF+3c/cIyMQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeB1Peo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:34:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33297 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752829AbeB1PWg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:36 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.530024627@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 093/140] SolutionEngine771x: fix Ether platform data
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 195e2addbce09e5afbc766efc1e6567c9ce840d3 upstream.

The 'sh_eth' driver's probe() method would fail  on the SolutionEngine7710
board and crash on SolutionEngine7712 board  as the platform code is
hopelessly behind the driver's platform data --  it passes the PHY address
instead of 'struct sh_eth_plat_data *'; pass the latter to the driver in
order to fix the bug...

Fixes: 71557a37adb5 ("[netdrvr] sh_eth: Add SH7619 support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sh/boards/mach-se/770x/setup.c | 10 ++++++++--
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
 	.name = "sh-eth",
 	.id	= 0,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth0_resources),
 	.resource = sh_eth0_resources,
@@ -154,7 +160,7 @@ static struct platform_device sh_eth1_de
 	.name = "sh-eth",
 	.id	= 1,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth1_resources),
 	.resource = sh_eth1_resources,
