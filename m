Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519414082-2-16654483400545227800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414082; b=RdAVN3rhPdMMD4s6GVAatpFAPxDbjLqa970/jhc4PFArKmU
    TlKQ68dED9xMXO8L3uap7DK/KAXGG42yUIceffTXOuBdk/4xcx6HltZRJgNSb+7r
    lRcY2me2+mTHGyHlmDB1H4xZJvRfJTYDx7JGj70LFrnjlbVv+bVm0rKzq2FrQNbZ
    Q+MxSw8Hzt8szvUdDlS/fcUX3WPNt2dTRV5njM8h9gnfBH4N+IWMr/befmaj6crl
    qRyrp6tvOaGv6b+fStmiXU2hIKWotb07PCZ4c74f78zyANNodWmY3L93tR4SJ3iD
    Ub7LXd7aes7LS/xudfmylP9PrHB4MQRY/hTf13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414082; bh=tgdFYmR4duYv6z2/yg8ljQnOk6
    qX+IffvTkQ7pyRq2c=; b=D40Nnost+sEy+JsaoWsEKGCzxmTSfkehP6nEQLcSC7
    yql5TO6u0qnTFzYF6+Zqk0c5NtGTW44sXFv2H+daFArXhSZL1d+EjvWAriVEVkzZ
    q4Sc4qlG72XnUxRjPV2MwDw/TGUUrScHAlp5jaqfugAUACvp/ARs2/UAmAHxU5Bu
    YlDzRwpqTSKddlB4K5IpAtI6qVSUYpEZQ+haskylMNNLme4BF/q01MANvoHb0tdu
    +Zef7lPfVjcGBQD2iF8VKrW/Us9Myi+DIAv4+exUdEZYED+7ON9V3a0Z4ATSOQQF
    pYjRlfD7esnCVBZReRUqj20SQAzK9+q6PyCtPHWDC3PQ==
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
        id S934856AbeBWSwR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935075AbeBWSwP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 066/159] ARM: dts: am4372: Correct the interrupts_properties of McASP
Date: Fri, 23 Feb 2018 19:26:14 +0100
Message-Id: <20180223170751.566126629@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am4372.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -927,7 +927,8 @@
 			reg = <0x48038000 0x2000>,
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <80>, <81>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 8 2>,
@@ -941,7 +942,8 @@
 			reg = <0x4803C000 0x2000>,
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <82>, <83>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 10 2>,
