Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962A9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6392020645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570648;
	bh=M2WWHjefLuwZFbmIGM8bGkM7sbekG/o+nBMhZEKx5CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sHaJZ2UEQlGvqWvOrRDkSdDzG3JDm7nNcrUVW5fjTCs5AGIqNBz60esZIWv+038Xv
	 37n6uXq9O8Cl7wwVtHvy7S79Kxh5lV1jLOLgPY92eJrCt1agihtKMPes+nv7ZBmjsl
	 VYtJS0E6ewOHQf1g3Zl2SRPYwqJfErDxP1UH3IV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfAOQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387457AbfAOQoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E6D2054F;
        Tue, 15 Jan 2019 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570643;
        bh=M2WWHjefLuwZFbmIGM8bGkM7sbekG/o+nBMhZEKx5CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXAm8uZKgXesr43dbDbyipVxLt4KJd2kSVCGx+uMahDb04URbXWVi3SgJ53viC9a/
         J1nwqEQr+bsGO8NdAdsWvBTfnlQfwDc2tF+G77KtGPQ9cSEGHSkUP6Sv0g6NWLxkXc
         oO8fWg8u1uzEgcu1PxM4qcNho7AUnAZMXyHOqwwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4.20 19/57] ARM: davinci: da850-evm: fix label names in GPIO lookup entries
Date:   Tue, 15 Jan 2019 17:36:00 +0100
Message-Id: <20190115154911.772038862@linuxfoundation.org>
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

commit c3f08cceb6a59f328f1c847b002729d1584c7a32 upstream.

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-davinci/board-da850-evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -780,9 +780,9 @@ static struct gpiod_lookup_table mmc_gpi
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* gpio chip 2 contains gpio range 64-95 */
-		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_CD_PIN, "cd",
+		GPIO_LOOKUP("davinci_gpio", DA850_MMCSD_CD_PIN, "cd",
 			    GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.0", DA850_MMCSD_WP_PIN, "wp",
+		GPIO_LOOKUP("davinci_gpio", DA850_MMCSD_WP_PIN, "wp",
 			    GPIO_ACTIVE_HIGH),
 	},
 };


