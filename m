Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D1FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DD523EA1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DD523EA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeGENb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:31:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51950 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753194AbeGENbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:31:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9564A1A0158;
        Thu,  5 Jul 2018 15:31:51 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5CB7A1A0014;
        Thu,  5 Jul 2018 15:31:51 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id BBA4D40A59;
        Thu,  5 Jul 2018 06:31:50 -0700 (MST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-fed1964-102.ea.freescale.net [10.171.82.97])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w65DVm8n003571;
        Thu, 5 Jul 2018 06:31:48 -0700
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] docs: kernel-parameters.txt: document xhci-hcd.quirks parameter
Date:   Thu,  5 Jul 2018 16:31:42 +0300
Message-Id: <20180705133142.18844-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This parameter introduced several years ago in the XHCI host controller
driver was somehow left undocumented. Add a few lines in the kernel
parameters text.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ddf7aa1e45e7..31c9b76058a7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4855,3 +4855,8 @@
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
+
+	xhci-hcd.quirks		[USB,KNL]
+			A hex value specifying bitmask with supplemental xhci
+			host controller quirks. Meaning of each bit can be
+			consulted in header drivers/usb/host/xhci.h.
-- 
2.17.1

