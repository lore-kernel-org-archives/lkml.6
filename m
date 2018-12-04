Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B562AC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BABA2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsJazL2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BABA2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeLDL03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeLDK7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E5C214C1;
        Tue,  4 Dec 2018 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921194;
        bh=GYPtE7VQ8FYFNlQ6r52vuG6uLBmvYpOuaFNly8qUSqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsJazL2GA+rkgRlHLSzfO6fCc5kKxZeM6qWbRAxb/J8l6rK1ZhNHbEeRk/v0J/JX5
         wMUqXczYwzxaQy9LF4Pz3vKJxipv37tFfTUG0blQEP1ISQRb2S5bE4Qq0PB0w8WWFr
         tcAoAkLp6D4oiNCVO34svzAA+VR2gh2DqCz4S/7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 082/139] arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou.
Date:   Tue,  4 Dec 2018 11:49:23 +0100
Message-Id: <20181204103653.579792354@linuxfoundation.org>
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

From: Christoph Muellner <christoph.muellner@theobroma-systems.com>

commit c1d91f86a1b4c9c05854d59c6a0abd5d0f75b849 upstream.

This patch fixes the wrong polarity setting for the PCIe host driver's
pre-reset pin for rk3399-puma-haikou. Without this patch link training
will most likely fail.

Fixes: 60fd9f72ce8a ("arm64: dts: rockchip: add Haikou baseboard with RK3399-Q7 SoM")
Cc: stable@vger.kernel.org
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -153,7 +153,7 @@
 };
 
 &pcie0 {
-	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_LOW>;
+	ep-gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_clkreqn_cpm>;


