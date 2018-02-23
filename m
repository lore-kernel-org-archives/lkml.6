Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418984-2-17409852827683499436
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
    t=1519418983; b=dSeEowPRY1/rpWoQdguwBA20i+HY+N/XENyISpSGl4y3L8i
    5IkxQ8UrBw0ao+A5Z3HmjAUJg94kCUuwdNHmN63KJtQWots/QNznGdok0gV5vI5Q
    LO3jEgIBoCirBxjnZpP/e8Dl0PZqk1UnpmK4I69aZY4GqwJCV0mEpBI5/wuvtWSQ
    5iTdxKBx9MdcWZjoN/sJs3DIQ1ep4c6hPyYf2ufhBaGRNTVuNcipSzLfq6YUMH49
    uercXgDWgdgdsJEawvDJkyLIBEWnCcLWo2BOz4uxnxZTkfX9X7bZcRnFjvDWX/K6
    veHbp2WOB1+BmmXPV8isGrLtF78FTKLlEVz8VLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418983; bh=YFI0CxUHKXS2WyLj2iVcO7oOKq
    lN+tZy/uBq5upPUGo=; b=D0+KUHdWmryd7irltwScrZnZ2zhbEpugZlBWFABbRZ
    Pm3b9NM18yIhmYAWV8z2mbdfRU3XWcblZpjjOVMttYqG9dssm9ehzNasSPSX9NoU
    YuT4MiqKOQhjQ5ONVeRIp/p1hAU7RsluoUvyGc/u1IFF5h6Cr/p5Wp3gBldkziXb
    aRNyqNOsK95WE+/9So0QDXtHfmAY9H6f3Y0sFiuu5O2Nj1iiiCzswhBa7ugQRc7K
    gk/UO2b6TGYg6MU3RIwdTPf9xxIpBA+GpH+uOkmC1V4f+HpsgRbr7WmYPovTeGQd
    Z2t1w4pEvzJDnzltM16EFcvuvyfuiRVfp0LwkJ1UnYmg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeBWUt1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:49:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeBWSb0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 37/58] ARM: dts: am4372: Correct the interrupts_properties of McASP
Date: Fri, 23 Feb 2018 19:26:36 +0100
Message-Id: <20180223170212.628267539@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit 627395a6f8091c0aa18f49dca7df59ba3ec147ef ]

Fixes the following warnings:

arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property):
interrupts size is (8), expected multiple of 12 in
/ocp@44000000/mcasp@48038000

arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property):
interrupts size is (8), expected multiple of 12 in
/ocp@44000000/mcasp@4803C000

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am4372.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -702,7 +702,8 @@
 			reg = <0x48038000 0x2000>,
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <80>, <81>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 8>,
@@ -716,7 +717,8 @@
 			reg = <0x4803C000 0x2000>,
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <82>, <83>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 10>,
