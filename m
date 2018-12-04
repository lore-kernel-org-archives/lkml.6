Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A815C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22EB214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5h1PJKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22EB214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeLDLAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbeLDLAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCAF2087F;
        Tue,  4 Dec 2018 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921202;
        bh=t2u5912p50J3onoDK7x+EAbdosNPqvaZEiZ6Xd9ICWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5h1PJKfj9D6MV97z47/LJfrE9x3ZMYRTq3wFXZZNSG9FsGTnQLvZn8GLoXSrvT+4
         dp0YrAo9AFqH6A8KaDxrOI7lNBAOcC/f1R1dmyq5dO/34aFh42hKykO8C/1Ksvg+WV
         2WrV1vYWR5owtPUv+4OABbPGjFvytnQr16dRDntc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heikki Lindholm <holin@iki.fi>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 121/139] ARM: dts: rockchip: Remove @0 from the veyron memory node
Date:   Tue,  4 Dec 2018 11:50:02 +0100
Message-Id: <20181204103655.660683439@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko@sntech.de>

commit 672e60b72bbe7aace88721db55b380b6a51fb8f9 upstream.

The Coreboot version on veyron ChromeOS devices seems to ignore
memory@0 nodes when updating the available memory and instead
inserts another memory node without the address.

This leads to 4GB systems only ever be using 2GB as the memory@0
node takes precedence. So remove the @0 for veyron devices.

Fixes: 0b639b815f15 ("ARM: dts: rockchip: Add missing unit name to memory nodes in rk3288 boards")
Cc: stable@vger.kernel.org
Reported-by: Heikki Lindholm <holin@iki.fi>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/rk3288-veyron.dtsi |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -10,7 +10,11 @@
 #include "rk3288.dtsi"
 
 / {
-	memory@0 {
+	/*
+	 * The default coreboot on veyron devices ignores memory@0 nodes
+	 * and would instead create another memory node.
+	 */
+	memory {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};


