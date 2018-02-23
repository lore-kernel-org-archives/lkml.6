Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415495-2-18186952910886946524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415494; b=fQWh6XJrSl+WJAFq9jaze9BbsbY9s7C+TjmSeQUvhs3/kk5
    get0aTHlYTQIJpX0xXHu7qDOWXm8C8coEKgSndhPkZ2nIDWS8x1fwRRS8F2wDmDO
    e69eFQLDsZSpYC44voy7XdMRAogEpMYGJNB4su8daU6alRu8xT1jxdA3IP6oMKwP
    UKngKUeUJPHEqKwfsq5WVnTG2/ZXo3PSXzBPVy2ubX9736OGfz59OWLmoeIXON9D
    XV1yTngioIhs2yMxd+NeEMhqRasY/1gpO2C7N+LqvztjSgKO46SJ67A3bHnHq/Fg
    3/tv1vnNTY7AYQmvsMwP4HCXas3qoDCz7YGgj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415494; bh=ccBUWS3P2qob/0VDKQDN+kWu7l
    B0Uz4Ws/XhSE+FSfE=; b=qLi14qbCsedFxGkjCC+ylJPJz51s/JQpOop5ZbAwAf
    jqQUJGIwCqqQz/AJ8kuWAyOEnCU/8KrDkqXVO9rYIWB3JShGCSZyWKauQKd+lsex
    m80q5gUxgKMTvr+5dHs1tb2e19PQl8xbBXy9y2U+ZDaHYJ2DU4/X3G2lrIM0yceq
    eLzivRlw+SNc5nJS7EIsPbL5pJFWoH135euqCmPVR0rRthHyS11wgy0qSN/jdn5C
    bEvaKz7SNd063gndNIQw42qkOBY6fFT6ca/aTERhD+MTqV1o3n8oGaIZsUjbhiWw
    iO1+LLwGSwlI6gZ8X8wBLE4ITb6IHK387NotGQ01j9Rg==
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
        id S1754631AbeBWTvS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:51:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43532 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933616AbeBWSp7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 046/145] ARM: dts: logicpd-som-lv: Fix gpmc addresses for NAND and enet
Date: Fri, 23 Feb 2018 19:25:52 +0100
Message-Id: <20180223170730.878613057@linuxfoundation.org>
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

From: Adam Ford <aford173@gmail.com>


[ Upstream commit 3c18bbf3d11d2005da08b57ff26f44ff1c2b12d0 ]

This patch fixes and issue where the NAND and GPMC based ethernet
controller stopped working.  This also updates the GPMC settings
to be consistent with the Logic PD Torpedo development from the
commit listed above.

Fixes: 44e4716499b8 ("ARM: dts: omap3: Fix NAND device nodes")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts |    3 ++-
 arch/arm/boot/dts/logicpd-som-lv.dtsi            |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts
@@ -72,7 +72,8 @@
 };
 
 &gpmc {
-	ranges = <1 0 0x08000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
+	ranges = <0 0 0x30000000 0x1000000	/* CS0: 16MB for NAND */
+		  1 0 0x2c000000 0x1000000>;	/* CS1: 16MB for LAN9221 */
 
 	ethernet@gpmc {
 		pinctrl-names = "default";
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -37,7 +37,7 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x1000000>;	/* CS0: 16MB for NAND */
+	ranges = <0 0 0x30000000 0x1000000>;	/* CS0: 16MB for NAND */
 
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
