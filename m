Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3393218-1520954324-2-5801893677564141413
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954323; b=deNpP5lj35Fx84psh/PP2VHMDqhcnhRuVUPAbfVrqFR6Q6V
    UvtzOa2aEbmpzr0FplzB5x1YPDkjQKWx+clVbbHmWhffKlGSJEdOptlVzETm6qyc
    EdFXTtSsVjGKO9V4R4Jr/Uta4adwgDbRJWIvKICCRj0JJ7AwJIMtfyLbNZa+jHDo
    J+uODxn9owhjEDIeaDqZffSgFJjfGllo7znWDEVOTh5Iy7u5zBwUpvHSwXKY1cJ+
    /uQluFt6HipM0kGYn3/+a1LuNVXmoq4patzTR/h4cBfTCr3XPYfmzUPNpmZWOqED
    bDiCjbZuM9NMHrQQRlxCRzT4nTsPwwNilsnFGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520954323; bh=FqIGa0Yu4V4lIQiBcJxtxOOvfzBT1pj3L4/J/xQTlQo=; b=F
    6aORBovm0wfTWw4r9VDKR5BrQsTE3f0jqTYKoKk8hF+WzndKMPq+ptuWV8DHGOXi
    N3lD4jcOcGosXmMS9FV6Bvoz2Jdh1PpokW2ufN7aWGyGfWAVopt2kzy2hnuL63pK
    oGa+inUfD801U1SAuLTQ27SP9vd/kubytOTGTc+tvqfuOAEEB7g9a8n/ihUpU3Uz
    4eFKbIUxQkqLN48PBxisPpchUnvimAJ7jAx4ciK2sDy9TNMYDkoSgdBtLKVNiXFB
    13ULLpdrnV267Jm+JVJ8OAcXv7Qx6pihRrCwp69ZZsXUOJK+fSTyaRQbh4WqUeDM
    BGVxu040puLUsKUaCimgw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeCMPSk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:18:40 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49285 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeCMPSj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:18:39 -0400
X-IronPort-AV: E=Sophos;i="5.47,465,1515481200";
   d="scan'208";a="12374810"
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        <Marek.Sieranski@microchip.com>, <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
Date: Tue, 13 Mar 2018 16:20:05 +0100
Message-ID: <20180313152005.21132-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are only 19 PIOB pins having primary names PB0-PB18. Not all of them
have a 'C' function. So the pinctrl property mask ends up being the same as the
other SoC of the at91sam9x5 series.

Reported-by: Marek Sieranski <marek.sieranski@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: <stable@vger.kernel.org> # v3.8+
---
 arch/arm/boot/dts/at91sam9g25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam9g25.dtsi
index a7da0dd0c98f..0898213f3bb2 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -21,7 +21,7 @@
 				atmel,mux-mask = <
 				      /*    A         B          C     */
 				       0xffffffff 0xffe0399f 0xc000001c  /* pioA */
-				       0x0007ffff 0x8000fe3f 0x00000000  /* pioB */
+				       0x0007ffff 0x00047e3f 0x00000000  /* pioB */
 				       0x80000000 0x07c0ffff 0xb83fffff  /* pioC */
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
-- 
2.15.1
