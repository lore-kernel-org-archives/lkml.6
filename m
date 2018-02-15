Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710276-2-4478747791139940514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710276; b=FBawZQXclx3UpwntUTIFKJny6kts06pYogmAxT9nH5RzIjF
    n+lMypn1wgqn+V9gXNotCtzBPFvrKzp+0zs2ETnslJa4En16SywbAXh0fHQDouu1
    Ma+WgORYrZGcxaFEgnFd+z+8Knb7WJScw4BSIPtBDW8yGCZgm3c/7THcP4sHArf7
    STGivZKv1F3CzVyeyTzu/yPKvQFhCwD4SeW23y0q25jd0meUYRY2ru6sedI+njAA
    icIH6rE0M7/nKcUpd3E6Ko+RnshTVQm2KOgdFd7tdmEPVwxf14y6YBRBkAl6jKKm
    dMW0QBJA1uB17a2X/pYrNqIVzdZtLTn6Lkk3mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710276; bh=Hl4GYYsRe9f7hD+CeZ5yH8mxiG
    hf9sKWw8xZ+Eos+uA=; b=qklyG3jxOJlubWdZiVAqtm+XbFfoKpLzxSp92L+3Rj
    ngNcQt+3aGRpnMgrAwjP3M6YAU/P2xU558bv9Lg0Uo3E8tY/DKmwodjKIUMIxpRH
    fSHzNRnqMPxPSfWAVhCiQzv8nAEw6VAgpx6teStwXVgK+Awtv4ntySkyQAL+r3Ls
    Ekdk1YHLqXtSDWjTeUAd+IvZI/ANPw2ndbEWOczQsP47NWIW+kf4bS4Gp4dnAWdc
    1fBE9pchlrUf/nnYtwOj4WrzJAeu7tcpmiw6ODx9WdH1op3mBvYSJvbBk86JxaSA
    f08laB2wqrrO6NxcawBYNcQ5nI8wnj7NcuTWzMjULLdw==
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
        id S1424854AbeBOPrQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424796AbeBOPrP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yan Markman <ymarkman@marvell.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4.15 188/202] arm64: dts: marvell: add Ethernet aliases
Date: Thu, 15 Feb 2018 16:18:08 +0100
Message-Id: <20180215151722.615450697@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan Markman <ymarkman@marvell.com>

commit 474c5885582c4a79c21bcf01ed98f98c935f1f4a upstream.

This patch adds Ethernet aliases in the Marvell Armada 7040 DB, 8040 DB
and 8040 mcbin device trees so that the bootloader setup the MAC
addresses correctly.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Antoine: commit message, small fixes]
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts    |    6 ++++++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts    |    7 +++++++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |    6 ++++++
 3 files changed, 19 insertions(+)

--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -61,6 +61,12 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	aliases {
+		ethernet0 = &cpm_eth0;
+		ethernet1 = &cpm_eth1;
+		ethernet2 = &cpm_eth2;
+	};
+
 	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3h0-vbus";
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -61,6 +61,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	aliases {
+		ethernet0 = &cpm_eth0;
+		ethernet1 = &cpm_eth2;
+		ethernet2 = &cps_eth0;
+		ethernet3 = &cps_eth1;
+	};
+
 	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "cpm-usb3h0-vbus";
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -62,6 +62,12 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	aliases {
+		ethernet0 = &cpm_eth0;
+		ethernet1 = &cps_eth0;
+		ethernet2 = &cps_eth1;
+	};
+
 	/* Regulator labels correspond with schematics */
 	v_3_3: regulator-3-3v {
 		compatible = "regulator-fixed";
