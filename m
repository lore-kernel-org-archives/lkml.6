Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520452108-2-15713423912972681891
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452108; b=J6LDmhsdAEB80xIA5Cdmk5P8nN0h+6da1Ntq9js2v3ubRK8
    NruO4Piz5Ck6YTsTUeqZI+vX2kFENpnMPJ4dWG54pV9A0zJufvh+VTT4VX7xZ93e
    yLZ8fkgLBvMziaRcwS4NjBH+u/KZDDt/VZuwo/8Zea3XjkgKNn8FjabbJnNdQrYV
    RuoJquPyfHSSahaESEtwdc4XHqNMstV78vDEENfxTZclDyZEyLPiSI2tWO48VbZD
    SH6bT5yUi4DXPRQCZDu+ydX4wnA6HUXND8j3r70AB27DIJwdSEVJ+zda5idByUfD
    7xTv6/FcBMMLDecM0P8jJHCyGwvqVFgZvlUBH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452108; bh=D3VIgVNN9BAR3Q6eVPFSRops0M
    Ia1ayyWPcWCtHGjyI=; b=ZB2tWE+Rf5GllijfEgTPy+rpKhHksSi/geeXAp7xPE
    Rrmdj6aXEpyn6W0jOB1gbONq1uB7df7OURE/HA4HhLPPrbV8tXAidTC6OeiBCxDv
    wb+gV9fY/Z3B3O2YiRwDPO5WEeCn6s6SAWKpnAkaw9W9mc9MBE4Hb+pDSmnwegwP
    nX0OZZbx7rxelQX6Mf/L4Z+38StBhkYul0e6STaTZ3Z06v6KxVZuRRzFGon3oGbZ
    ctbghQ1aHklreVmodXHR6aJLqT9iaidR/UcVYguAgdY6tKdRMQlCao7UtDOqUSub
    ZIk53a8OfxneTiVSMLdLMn4J0bnBa7dqKilg+A8L+w6Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965927AbeCGTsY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:48:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965925AbeCGTsW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:48:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Schultz <d.schultz@phytec.de>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.14 093/110] ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som
Date: Wed,  7 Mar 2018 11:39:16 -0800
Message-Id: <20180307191051.759431763@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Daniel Schultz <d.schultz@phytec.de>

commit 5ce0bad4ccd04c8a989e94d3c89e4e796ac22e48 upstream.

Rockchip recommends to run the CPU cores only with operations points of
1.6 GHz or lower.

Removed the cpu0 node with too high operation points and use the default
values instead.

Fixes: 903d31e34628 ("ARM: dts: rockchip: Add support for phyCORE-RK3288 SoM")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/rk3288-phycore-som.dtsi |   20 --------------------
 1 file changed, 20 deletions(-)

--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -110,26 +110,6 @@
 	};
 };
 
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-	operating-points = <
-		/* KHz    uV */
-		1800000	1400000
-		1608000	1350000
-		1512000 1300000
-		1416000 1200000
-		1200000 1100000
-		1008000 1050000
-		 816000 1000000
-		 696000  950000
-		 600000  900000
-		 408000  900000
-		 312000  900000
-		 216000  900000
-		 126000  900000
-	>;
-};
-
 &emmc {
 	status = "okay";
 	bus-width = <8>;
