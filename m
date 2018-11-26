Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4586C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED7221479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="twHlXNF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED7221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeKZV5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbeKZV5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650542146F;
        Mon, 26 Nov 2018 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230226;
        bh=4IhSwrfwQa3//kMynvnj3pOZ1R2pDYex3wA/8u8NSDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twHlXNF3lJALXeDs/LjIBKUh8hOMazETc+6wArgvyr6GC9uwyw9Jp3K3XemcXC5oX
         Cm3H+KrHHiwLZsHjogjv4+fmW77JUI7jUEId3j8ojkPtpapC8o3IAlbUhbKNxYZ8je
         NmeQWgyBI62Sk6++y7J8fH7j8fzCBbz5NGIblaG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/118] ARM: dts: fsl: Fix improperly quoted stdout-path values
Date:   Mon, 26 Nov 2018 11:50:50 +0100
Message-Id: <20181126105103.059777366@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1af6ab3bac8458fc2e92ad7bb97b62de4a1fddef ]

A quoted label reference doesn't expand to the node path and is taken as
a literal string. Dropping the quotes can fix this unless the baudrate
string is appended in which case we have to use the alias.

At least on VF610, the problem was masked by setting the console in
bootargs. Use the alias syntax with baudrate parameter so we can drop
setting the console in bootargs.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx53-ppd.dts       | 2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index cdb90bee7b4a..f202396e3f2a 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -55,7 +55,7 @@
 	};
 
 	chosen {
-		stdout-path = "&uart1:115200n8";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@70000000 {
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
index 41ec66a96990..ca6249558760 100644
--- a/arch/arm/boot/dts/vf610m4-colibri.dts
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -50,8 +50,8 @@
 	compatible = "fsl,vf610m4";
 
 	chosen {
-		bootargs = "console=ttyLP2,115200 clk_ignore_unused init=/linuxrc rw";
-		stdout-path = "&uart2";
+		bootargs = "clk_ignore_unused init=/linuxrc rw";
+		stdout-path = "serial2:115200";
 	};
 
 	memory@8c000000 {
-- 
2.17.1



