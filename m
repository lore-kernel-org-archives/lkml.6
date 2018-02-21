Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1429242-1519215571-2-14021044777633663977
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519215570; b=dlANVvBnLPrn+O9aoTxAXFoD5+deNtL0TeOWF70RZAkVrDR
    InVfqDrotEdN0XV+pRyHLrFogx+JAKy8Hm1LAWuyanHBf3veq+IhCVwxstWh6700
    c9UqtBvqtfqJbIDqWqpX6hxHPhgwr0zC65KYYoWjY9Kj1j5Jih4IYMn0ZcDAiUAx
    AxL99kvLFN6gH5ssVCOeePhG0KgBIDwaMRJduGP5N308Q4JVWFq295LEacE9dD+f
    IBgW7Tvi0AO114zVKyTUsg2p8waClZVyBFoerHUPtu42dsPXavlH3kKQKQAhRYW9
    dL7Kl0dsuwgiFWSoc4yVFQlBmlhDAaSNKkh31oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519215570; bh=L2gVYueJaCwQNjImt0QfOwTjTF
    7OFs/MFfOR9OnhYIw=; b=gkk+kJuJ5ZIOGjiacLe5jVYO/pgOzAdzwGWnxrb6ir
    V4VB/lXVJGdVpmA+pa5UkdQxeZHDVdrQJ0/qCi2tEtrl+85AuD0YFkA9UNwVV/xE
    KnFxcm/WMn202rz9za+c60Dzt6+hoMuGuaPjl7r1/8fQVZuyA/uho7PMnpt/ws48
    dw9sAs/4mdU7yKZ9vl1XmYc6H2cX5tmG1y0AF5gTb+BzwNP3hTSRH0OHqyXzYouQ
    gA6vsiatUZBzJj+OQyb5ercT0cx0qxDajlEl8fAZ6jWF8LJdcOt8QHp+egW0w2C3
    Aa2FVxg9yi3PyjXldXjo6ZyMmlBdFCQxvMGdCXzMmQGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeBUMTZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:19:25 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeBUMTY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:19:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: orion: fix orion_ge00_switch_board_info initialization
Date: Wed, 21 Feb 2018 13:18:49 +0100
Message-Id: <20180221121856.3241260-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:fPuXkq1hJemKhbeIgThKNxCeS4quaAGXP9vFigkhsPqe6uPwyew
 EU7R8uNvPtgcjI7LIR2uezbXNjUjvhi7MmUYyjsaxHKjZFB1RsDpeKqDtkWYkDRhTJsB9Ow
 wug90hyTuH7edvt2tSubgv9upV7dMmgXNp5VsN0tMFz1020HdgNOBs7o1hO+yj2nIcnA4Hs
 tL4Yg1CIBXHSFHl7rv11w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5J5rFrpbhgs=:pB64Zn/2C0W8fp8AXI44uB
 Bc0F5vJHbzhO2L/T7bB4ZwXYerPzO0AJx6gI9Cia0IO4DuRy5jYWUT3rd8Tmj4+zPEfElA/1F
 mJXPqm/u7sqfWX2kN/0PdCRUiaqnsK3WQxcZLT+LyiTX8TUEtVqcYcr+foFuaMq2x/uVSp9Pp
 RHNfQ280GsZe4mf5+jGL+fSkAweBluFEia3v0qfRI9Ut7ArtgElUtF/5+as1xA21KSrD/aiAq
 7/Ba0ufLA1Ba9uagDf13JjjqH+8V4sEzRCp1KZz7S4xcF/RJ7AFBh1A7j0bag8CwKcQM8bOe1
 Kf9vEEqW8yzVsHCyVwgdXlCfJM9dELAaLSUOIcwxKvn/98VotrVEVw7pq/RGdvaU2fklWbs5n
 A3WA0+GH7FjrZWMMZ4NqgXqG8xvCCbBSoGQGUw0yO+JahEDQmtJFI+DvoStWgTr8GANHhJwgu
 0kHmePyNj3XY8fqAmadJsioQ+xx1JsrxWFf+x6L3ZW8q3c9wlDx6cjLjhF/GJ6nfrrJnfop/t
 jqOF8mdWPykvt/vTkh5lKA2gwaBjF6mtj/ES3N4JBL5csABWiNPvudh+DuHy1FLZxOGrpuQ5U
 OaRbMq4XeiAG8FPdTw/JFILPcpACfWdbI8//QbldNPnwgEECCu0PIusJiKVzblP5Hf9v4MsF+
 Yp9lgNLoRrkCFDk1/Tj/Dwjqaie/oyZ/gJFeIocI65Lq2oZCyoxzBjPNnN0ra/oy1t49gPxuI
 bdvnuxPbGNVFyCNDkordZL8cXPEasl6V94H9HA==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A section type mismatch warning shows up when building with LTO,
since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
const itself:

include/linux/of.h: In function 'spear_setup_of_timer':
arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
 static const struct of_device_id timer_of_match[] __initconst = {
                                  ^
arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
 static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
                                ^

As pointed out by Andrew Lunn, it should in fact be 'const' but not
'__initconst' because the string is never copied but may be accessed
after the init sections are freed. To fix that, I get rid of the
extra symbol and rewrite the initialization in a simpler way that
assigns both the bus_id and modalias statically.

I spotted another theoretical bug in the same place, where d->netdev[i]
may be an out of bounds access, this can be fixed by moving the device
assignment into the loop.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: complete rewrite
---
 arch/arm/plat-orion/common.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index aff6994950ba..a2399fd66e97 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -472,28 +472,27 @@ void __init orion_ge11_init(struct mv643xx_eth_platform_data *eth_data,
 /*****************************************************************************
  * Ethernet switch
  ****************************************************************************/
-static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
-static __initdata struct mdio_board_info
-		  orion_ge00_switch_board_info;
+static __initdata struct mdio_board_info orion_ge00_switch_board_info = {
+	.bus_id   = "orion-mii",
+	.modalias = "mv88e6085",
+};
 
 void __init orion_ge00_switch_init(struct dsa_chip_data *d)
 {
-	struct mdio_board_info *bd;
 	unsigned int i;
 
 	if (!IS_BUILTIN(CONFIG_PHYLIB))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(d->port_names); i++)
-		if (!strcmp(d->port_names[i], "cpu"))
+	for (i = 0; i < ARRAY_SIZE(d->port_names); i++) {
+		if (!strcmp(d->port_names[i], "cpu")) {
+			d->netdev[i] = &orion_ge00.dev;
 			break;
+		}
+	}
 
-	bd = &orion_ge00_switch_board_info;
-	bd->bus_id = orion_ge00_mvmdio_bus_name;
-	bd->mdio_addr = d->sw_addr;
-	d->netdev[i] = &orion_ge00.dev;
-	strcpy(bd->modalias, "mv88e6085");
-	bd->platform_data = d;
+	orion_ge00_switch_board_info.mdio_addr = d->sw_addr;
+	orion_ge00_switch_board_info.platform_data = d;
 
 	mdiobus_register_board_info(&orion_ge00_switch_board_info, 1);
 }
-- 
2.9.0
