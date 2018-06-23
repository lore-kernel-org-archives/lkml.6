Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83317C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3820524D04
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nEzpnFPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3820524D04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeFWVJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:09:39 -0400
Received: from vern.gendns.com ([206.190.152.46]:36204 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbeFWVJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vY26nF/ZsAPWIe02gCAdfGwnOnNsvR5YRYT1rIzSuDg=; b=nEzpnFPmtb4z7f0IaHGHaBAEH
        UMbZLLpWfzE9qto/qQv7P1wfjTDl13WzUNHFTej9k+3W2Si0iHJxuRrMZLXH+27UpcWyLF6O2wlSG
        psd4mot9//9943WVk8dGYijzmdc4d0yxogF0ZwZ8U6/JXLLxrhmkkmkzssX1RO8bqXvNE6EiBpLCU
        IHuGg89bTbmf701Z2rrmJrpvMNH0TgzZimSLhU/p1AnD3wW1eGSB8U7OFvPqlfaQVaZ99nbS4JFg5
        k0LxlYTQ+Hq5fIjhOpbw0KPYPeJ9u4Q/O5CNke0DgsfRPZ44F5yy/DKdtY8RH3qU61GXFk0FUhjwy
        0fkcUXWGA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51098 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fWpml-00CkwS-PL; Sat, 23 Jun 2018 17:09:32 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] ARM: davinci_all_defconfig: enable PRU remoteproc module
Date:   Sat, 23 Jun 2018 16:08:08 -0500
Message-Id: <20180623210810.21232-7-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enabled the remoteproc module for the PRU on DA8xx-type devices.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a1b6e106b867..1bcc7c6a03ee 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -214,6 +214,8 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_REMOTEPROC=m
 CONFIG_DA8XX_REMOTEPROC=m
+CONFIG_TI_PRU_REMOTEPROC=m
+CONFIG_RPMSG_VIRTIO=m
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
-- 
2.17.1

