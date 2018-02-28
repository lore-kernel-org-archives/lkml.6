Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835900-2-17348371517761724573
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835899; b=Y+Bxehab+djdO2b3sqgpTPQFFLTjaAXVKWhKXrvRg93Fk8C
    W7d2dSr5ElRyaJzkMyW+uoDZXzh447bau4NCZR95Sxg9JzFWQqYdOuvKDhwch8ZW
    my8bhfzyxTee+6ssKhF7G4Ox8OkWz2ab7yTZuG9NPg0dc8PVn9AgdSr5F+dNoIcP
    hKFbit+vPJKqzrEy90eqVmdGtMJ86rOLXkIjo2UiuJiSfTYrbpoQIDdSf7xVT6MG
    IY7eLFHtRZc0fZcxTffIKSoza2RG7r1UlIksrXiBLZcj3wLiUkhrHPFFOzTjT/X/
    fnA4hZsBy8yEl87cuVXzIq+XM860/Hj6SBY2MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835899; bh=rw7Cn86svBAcgVjfIg6
    m8yhgzXwHc32JSBPxRMIIAu4=; b=WK01pZTmRw+Jc4rO9lW0sjbF763ux/MetTN
    qKo25pJyXKDDaDqzadVgOn4b5VCHYhjCsd60BZh/KO4nEkl+ZQ401LQw+0VqdacF
    bphvDDs9O05XxdwCdcTAg+UxGAf7sytM34N7bH/2VONtZ5mt0uafzzyUBURaVRyW
    5Llm9yxcpSNnj45li+N+e2TvO/nQ0VynoDrufoXxepgdOI4fQp8IK4GGUZgQ/6Kf
    fIJPiQSq/9WxlFwPfUiJiuKps0jJ9+mDpeXru9vYkeW2jbKXJMFnoDstj7x2NBWz
    njoWdyqD/XuBDOxV3AQwqDM+Gn92HBiBiYWJYYkWmU4c7r3XJCQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbeB1QiG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:38:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34821 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753084AbeB1QE0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:26 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.926380955@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 197/254] SolutionEngine771x: add Ether TSU resource
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

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit f9a531d6731d74f1e24298d9641c2dc1fef2631b upstream.

After the  Ether platform data is fixed, the driver probe() method would
still fail since the 'struct sh_eth_cpu_data' corresponding  to SH771x
indicates the presence of TSU but the memory resource for it is absent.
Add the missing TSU resource  to both Ether devices and fix the harmless
off-by-one error in the main memory resources, while at it...

Fixes: 4986b996882d ("net: sh_eth: remove the SH_TSU_ADDR")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sh/boards/mach-se/770x/setup.c | 14 ++++++++++++--
 arch/sh/include/mach-se/mach/se.h   |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -123,10 +123,15 @@ static struct sh_eth_plat_data sh_eth_pl
 static struct resource sh_eth0_resources[] = {
 	[0] = {
 		.start = SH_ETH0_BASE,
-		.end = SH_ETH0_BASE + 0x1B8,
+		.end = SH_ETH0_BASE + 0x1B8 - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
+		.start = SH_TSU_BASE,
+		.end = SH_TSU_BASE + 0x200 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[2] = {
 		.start = SH_ETH0_IRQ,
 		.end = SH_ETH0_IRQ,
 		.flags = IORESOURCE_IRQ,
@@ -146,10 +151,15 @@ static struct platform_device sh_eth0_de
 static struct resource sh_eth1_resources[] = {
 	[0] = {
 		.start = SH_ETH1_BASE,
-		.end = SH_ETH1_BASE + 0x1B8,
+		.end = SH_ETH1_BASE + 0x1B8 - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
+		.start = SH_TSU_BASE,
+		.end = SH_TSU_BASE + 0x200 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[2] = {
 		.start = SH_ETH1_IRQ,
 		.end = SH_ETH1_IRQ,
 		.flags = IORESOURCE_IRQ,
--- a/arch/sh/include/mach-se/mach/se.h
+++ b/arch/sh/include/mach-se/mach/se.h
@@ -99,6 +99,7 @@
 /* Base address */
 #define SH_ETH0_BASE 0xA7000000
 #define SH_ETH1_BASE 0xA7000400
+#define SH_TSU_BASE  0xA7000800
 /* PHY ID */
 #if defined(CONFIG_CPU_SUBTYPE_SH7710)
 # define PHY_ID 0x00
