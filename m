Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD61C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EA8208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EA8208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeHWLjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:39:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbeHWLjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:39:36 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9798AC9E;
        Thu, 23 Aug 2018 08:11:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 101/130] ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller
Date:   Thu, 23 Aug 2018 09:53:37 +0200
Message-Id: <20180823074933.656270426@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 923847413f7316b5ced3491769b3fefa6c56a79a ]

The AM3517 has a different OTG controller location than the OMAP3,
which is included from omap3.dtsi.  This results in a hwmod error.
Since the AM3517 has a different OTG controller address, this patch
disabes one that is isn't available.

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am3517.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -74,6 +74,11 @@
 	};
 };
 
+/* Table Table 5-79 of the TRM shows 480ab000 is reserved */
+&usb_otg_hs {
+	status = "disabled";
+};
+
 &iva {
 	status = "disabled";
 };


