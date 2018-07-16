Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C160206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C160206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbeGPIFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:05:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbeGPIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:05:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1FD0BC03;
        Mon, 16 Jul 2018 07:39:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.17 67/67] ARM: dts: armada-38x: use the new thermal binding
Date:   Mon, 16 Jul 2018 09:35:36 +0200
Message-Id: <20180716073454.729656115@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baruch Siach <baruch@tkos.co.il>

commit 568cc2f07c8ea5f71a0486464bd9703e4671045f upstream.

Commit 2f28e4c24b10e (thermal: armada: Clarify control registers
accesses) introduced the new thermal binding. The new binding extends
the second registers field size to 8. Switch to the new binding to fix
thermal reading values. Without this change the fix for errata #132698
introduced in commit 8c0b888f661 (thermal: armada: Change sensors trim
default value) has no effect.

Cc: stable@vger.kernel.org # v4.16+
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/armada-38x.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -547,7 +547,7 @@
 
 			thermal: thermal@e8078 {
 				compatible = "marvell,armada380-thermal";
-				reg = <0xe4078 0x4>, <0xe4074 0x4>;
+				reg = <0xe4078 0x4>, <0xe4070 0x8>;
 				status = "okay";
 			};
 


