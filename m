Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2247758-1526982273-2-3486852970823991456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526982272; b=PyygC9ryFCKqaKc5RG5G3JTwKWsCuGHM5CmEwMZWZKt4mIZmGH
    rJ+b4AySZ7BqrcB9eX77uJLtXYsJ940gmbcZ3jfljosC5hPIwcBLObf1RgP1hz6L
    LuGwu4ehGKRJGVMe2pZDxjYQqY7pkEemL0Fg4MUmlsDJ6a8NcGBRTDB0yocJDd7y
    jl0IbhXOVmAByoKB+n4H7Hc8y6LstdTQRWEMc2GZxmxLCx9py2wmxDXDmte9u8P7
    slqCzDy8i/X8xgn9SKkDKlE9JuicH1PvE14JVjhBvnhniYLCmunCW492NOokIoeH
    TD9X7FCTBncv/3Ul0Art1UFGPRSOqlbc/JKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526982272; bh=
    MIkEnGen7ggg2TVNiBLdJEkSmo2tbj2jcHGGx4jmpCA=; b=AAvGpBHd3BwcIoaW
    4hsxAftUnZ77s9LxpsfECaRFIsSVuS4MG/ZIF5fKL0yqiad4Ox1r3MxhIQ88zBX1
    FVsTzHC6uz6QKWUfos7EmZCbmlVhEN7eqOxPc+4piqDfYIJG3xiUOG6jkbypYO0t
    vTz288vvpb5/zdNOWyb5nprE4k1dsisZhL+z1wlKdTaV7jFwGmGy+CQBRFJkQ/43
    4JwICPln5MxykrWb7lowJ37TB2yjPjsYdO+yOJyCqzM0JhHCxkgnENSlKvY4kDsg
    IfDfC+hzleZJp7/4t/W4x/CBqdWQazsdTJ1CmDc43Vq1oGvvmT1w7X4DP0cZ5R17
    V++UNg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB+M7Kiwg6+khBCzRVEzUCa02ZfdWGa9UJ9u0rVtO1itRD5xizOh+up0rUWAByxrgbl85k01Gnr7symgE8YDyzuF5dVpsS3DdcUUGqFFSPevyfac+PNP
    LnyC0Oo25Vepz7420MAMuK/m8yLKyCKfRXeoaTdeaR3HV8hWbxhGXySQ+rhIGY5/AmodGJfPqYg9kR9BrJZnKJP+889Bdn0sXGcvuaNmCRyx2wplBVpFcHDu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=P-IC7800AAAA:8 a=126wNyQWnPzrTZcEuUcA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeEVJk6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 05:40:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49671 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbeEVJk5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 05:40:57 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Haim Boot <hayim@marvell.com>, Hanna Hawa <hannah@marvell.com>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 02/16] arm64: dts: marvell: fix CP110 ICU node size
Date: Tue, 22 May 2018 11:40:28 +0200
Message-Id: <20180522094042.24770-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
specification).

Fixes: 6ef84a827c37 ("arm64: dts: marvell: enable GICP and ICU on Armada 7K/8K")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 48cad7919efa..9fa41c54f69c 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -146,7 +146,7 @@
 
 		CP110_LABEL(icu): interrupt-controller@1e0000 {
 			compatible = "marvell,cp110-icu";
-			reg = <0x1e0000 0x10>;
+			reg = <0x1e0000 0x440>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			msi-parent = <&gicp>;
-- 
2.14.1
