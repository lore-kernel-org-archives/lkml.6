Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E64C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C2E218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="hvE9OSxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfAYJVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:21:23 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25305 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfAYJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:21:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548408064; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=QtobXTNDYL1pjtfvrweeA3fkIVnDZPlHDTwH9ZjkKys4AKpv7Fz6qUVjsUwk0GHnPU4708lLEKRUMwV7S15PxC4pSKlQS9uJ9//t1JVv6gC/eH5e1KtEAaxButWwk9PThG83TwLg6GiF3WXx0D5rcVP6sihzcdHrC07VgaOK7DU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548408064; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=jTkoMdajrXYS2hEMBh76Kpa+zqVt18KUzxUiGreHz8c=; 
        b=aX1MvaZ/mxxwGAldPeHSvG/YfX2MaL2o+GxOBovpiTzChX8ZHsOMcjI2PFnNvNQqzK2jDVrCt1qK6OgzGRgm1dbPhixJ4YQlsWr+XcWNq5g8awkqldKIsSPTQDDgnNCJGv0TviBXTAPKA9dmO+QAJwMI7reXq6Zr13hCshznmo4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=RDZVf5FT8DPbmtzqGOZVSaAaxsxn7NLvtgXdBDYHi7HZhHVXxW5P8T6k+ewIxBvr0AYrGQPM2hFk
    qCxPHFMvbVi87z2Sga7aiQVK4C/GyilB6vYHu2hAeyIFsfCzgvCY  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548408064;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=893;
        bh=jTkoMdajrXYS2hEMBh76Kpa+zqVt18KUzxUiGreHz8c=;
        b=hvE9OSxJJPCIcvfCBFblHDR7F3btuk1/bEb2Bk/OLoFV7hsuNA4mJhM6xsi9ZvTw
        KsNLu5cYrRp6XhLFZK21tSt+5151qCqo9/jJGdPwX1sEBHw82ZXwQRTenW+2i+XAv5o
        oJT/vtS5oQcfc1HrzathXNajc5s66gBpow2macRI=
Received: from localhost.localdomain (182.149.160.17 [182.149.160.17]) by mx.zohomail.com
        with SMTPS id 1548408061678384.9892041717419; Fri, 25 Jan 2019 01:21:01 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, ralf@linux-mips.org,
        jhogan@kernel.org, mark.rutland@arm.com, malat@debian.org,
        ezequiel@collabora.co.uk, ulf.hansson@linaro.org, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH RESEND] DTS: CI20: Fix bugs in ci20's device tree.
Date:   Fri, 25 Jan 2019 17:19:22 +0800
Message-Id: <1548407962-6484-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Schematic, the hardware of ci20 leads to uart3,
but not to uart2. Uart2 is miswritten in the original code.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 50cff3c..4f7b1fa 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -76,7 +76,7 @@
 	status = "okay";
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&pins_uart2>;
+	pinctrl-0 = <&pins_uart3>;
 };
 
 &uart4 {
@@ -196,9 +196,9 @@
 		bias-disable;
 	};
 
-	pins_uart2: uart2 {
-		function = "uart2";
-		groups = "uart2-data", "uart2-hwflow";
+	pins_uart3: uart3 {
+		function = "uart3";
+		groups = "uart3-data", "uart3-hwflow";
 		bias-disable;
 	};
 
-- 
2.7.4


