Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414108-2-1110082445529129478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414108; b=bWGtGz/7qbFyY/a1kKi1QNIw6KwU4QwnkNFqR1QojJANwBH
    mRcaF0Hn6t/A+btApX8zYs0ndqeE5mEpdJ5IMHsM2i9jMUGRcDXMRiTYDXLvWC52
    80edWyee8MafaYuoUIC2DFkucXdkqioDCa6qLfHG6pCEbauhk7MoTtfsbe8aEkcM
    q2YTBdE0hndDUzTAKC+ZAzsXajj6OVqpvbLdrhRLm4Sx+SLACCEGrrj8r1foXsXu
    wMgWyUC8VcsZtDvY0mAae+tFFAcPng6sf4cRUP+6S2ZBAo4JzD0aHNsB/g+OX8Ms
    0yss2NaweguiOwjRTTk+PVm7hJE8kHMbiX314wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414108; bh=B1wm/atW/DO7Q3lVRTz7CUFCao
    tFwGk+MSFlYF7t6FA=; b=DE7BbUxzUQV4Sq3P7LUsNs2HDCWM05N7LmwR5LdWPp
    TVgZyu9YA8HsRdA2CsUhZfCWDHS3ezPSGnwjL2zR7vMj8SkbnmWlkwi5kAzWGzMW
    AxbOYmknucUi4p1I8TRAOOW6UEzuo1CoqgNwgzkZuHTiJC4xQnDanIJNG29WNcPa
    nrlbggLLJfCVrNAo2QUwxbr1U+c+9wyS83QgnpsMLnH0RfB0FLHigjorf+QTStOY
    dxg6Xj1HXrZjfI+aJPvwjveNPLUiLVZ50RJTGexmIH3KLUuLZrjkMdpMp3UVIx2z
    K4UNsrlNpw/5Gk4gLioCoeRhJgDDQwh2THaAP0ReJjqw==
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
        id S935094AbeBWSwL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935093AbeBWSwJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 064/159] ARM: dts: logicpd-som-lv: Fix gpmc addresses for NAND and enet
Date: Fri, 23 Feb 2018 19:26:12 +0100
Message-Id: <20180223170751.336332085@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Adam Ford <aford173@gmail.com>


[ Upstream commit 3c18bbf3d11d2005da08b57ff26f44ff1c2b12d0 ]

This patch fixes and issue where the NAND and GPMC based ethernet
controller stopped working.  This also updates the GPMC settings
to be consistent with the Logic PD Torpedo development from the
commit listed above.

Fixes: 44e4716499b8 ("ARM: dts: omap3: Fix NAND device nodes")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
