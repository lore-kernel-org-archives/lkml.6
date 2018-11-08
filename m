Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC9AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688992086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpPlsVuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688992086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeKIHcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeKIHcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:51 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D382086C;
        Thu,  8 Nov 2018 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714124;
        bh=OvMQhcdbzji0wr+2VnX0qcxKq/Q+yVitU0I0EQPnamc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpPlsVuTKx8cZITXJ+9w5yDw7b3ya9oXpxKgT1/pWPUFgcunlSrdJNMYpurchYNPa
         2/vGtDYVeGiV4MZDUbDUbr+2wZ+tNkuYQY7g5iEVBxK1J6gNsEU/QIOkuspf9ju8ma
         rXTBnUr8QwybLORTqwTyWYt4JV8B873JoyjFnqJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bo Shen <voice.shen@atmel.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 066/144] ARM: at91/dt: sama5d4: fix the timer reg length
Date:   Thu,  8 Nov 2018 13:50:37 -0800
Message-Id: <20181108215059.660520413@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0068b2e1b7f925a818fdc0a5d10ef0ad40f746e7 ]

The second property of reg is the length, so correct it for timer.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 0837c1afd666..24e7b237c048 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -939,7 +939,7 @@
 
 			pit: timer@fc068630 {
 				compatible = "atmel,at91sam9260-pit";
-				reg = <0xfc068630 0xf>;
+				reg = <0xfc068630 0x10>;
 				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
 				clocks = <&h32ck>;
 			};
-- 
2.17.1



