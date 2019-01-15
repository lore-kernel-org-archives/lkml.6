Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D2D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571164;
	bh=GLDKx2CDSc6z6n767VLgvpPRebkOio+jelEtvMy27io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ggjrg2P3KRuFFcgiIaA2dXnh49+lTjqPh+KkOxhi+mlBkNwAsRHPwfstGEWcpo2P/
	 MTmPoXccBL/YItsf02Qz1T05GC+yN9LfF1xsHTeS8XWbRXWqJ8ZPCT6WyZy2urMP/X
	 HzDXXbl3iTS1mKSGCw8Vueysy7mJstyfwZ6FHwPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfAOQwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387487AbfAOQoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD0C20645;
        Tue, 15 Jan 2019 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570651;
        bh=GLDKx2CDSc6z6n767VLgvpPRebkOio+jelEtvMy27io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2wMGwVYJg30fPkbLNFTg4MytyyWsJNw509w7fYVIGGCngfnc79LEUw7Ovw4hLG+RK
         we3fJJDMdAztORFCunjYeUcBMHL2GZr5Nr/8VSavDKSKq+CvL8k1CXU2AEd/IoIN7W
         0MqWBxxIl5qnWUXhg4KjJFu13OvqUJRii3p6J3To=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4.20 21/57] ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
Date:   Tue, 15 Jan 2019 17:36:02 +0100
Message-Id: <20190115154911.880534537@linuxfoundation.org>
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

commit 7f1015b29d9b9eb1cd3c038d6c30d698c6d7782e upstream.

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-davinci/board-dm644x-evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -638,9 +638,9 @@ static struct i2c_board_info __initdata
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SDA_PIN, "sda",
+		GPIO_LOOKUP("davinci_gpio", DM644X_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SCL_PIN, "scl",
+		GPIO_LOOKUP("davinci_gpio", DM644X_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };


