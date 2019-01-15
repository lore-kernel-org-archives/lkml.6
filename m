Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660D720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570659;
	bh=jex8VTJxC8m8dTB1SZuTB2K1D84nVEadCXesInUgGw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U/HHjke3iCWw+D1ezJGdXJe5Z0pEOeQ73ml6Rxu1FOh4Ngq6aX+m8rZNMfxfdxU68
	 oF0Xa20qWY33ytydOiSnTX5qECABlLKylh42LLr4oYs6dijYQC5RPDhmqPW/Bd1lMD
	 gRMIuAFSGkCN+uq1K005L+EokBvvY6r9pm815TCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfAOQoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387478AbfAOQoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2462054F;
        Tue, 15 Jan 2019 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570654;
        bh=jex8VTJxC8m8dTB1SZuTB2K1D84nVEadCXesInUgGw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auiIR7VBAI/ZbklS15aR8xRibK6wPeYAaMH0kV8CSziD0HBrMnJKfhRDPV11Xx3G7
         Zjrr1oW9lCoo9Dp6ZtCzalW1CkTotcd+evE5k0PVFqJOlYovSWD3DPZg/BU6vpFmcX
         UcZLYvd3TcUsWALEY1UUdT0TbYGrmcNzEarTzVus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4.20 22/57] ARM: davinci: da830-evm: fix label names in GPIO lookup entries
Date:   Tue, 15 Jan 2019 17:36:03 +0100
Message-Id: <20190115154911.940947918@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit cc557afb4d10cba175fd08d51c557004a229eded upstream.

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-davinci/board-da830-evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -207,9 +207,9 @@ static struct gpiod_lookup_table mmc_gpi
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 1 contains gpio range 32-63 */
-		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA830_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA830_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA830_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_LOW),
 	},
 };


