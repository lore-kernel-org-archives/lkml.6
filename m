Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB40C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3B8208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3B8208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbeHWLvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:51:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeHWLvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ECCC6C7B;
        Thu, 23 Aug 2018 08:23:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 096/217] ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD
Date:   Thu, 23 Aug 2018 09:53:29 +0200
Message-Id: <20180823075509.833352715@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 1b6fe9798af8cb7d80fad5dd30ee1bcd1e0f51eb ]

When booting from MMC/SD in rw mode on DA850 EVM, the system
crashes because the write protect pin should be active high
and not active low. This patch fixes the polarity of the WP pin.

Fixes: bdf0e8364fd3 ("ARM: davinci: da850-evm: use gpio descriptor for mmc pins")
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/board-da850-evm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -773,7 +773,7 @@ static struct gpiod_lookup_table mmc_gpi
 		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
-			    GPIO_ACTIVE_LOW),
+			    GPIO_ACTIVE_HIGH),
 	},
 };
 


