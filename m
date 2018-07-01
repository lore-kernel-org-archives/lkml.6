Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE0EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058A32558C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058A32558C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933933AbeGARHA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:07:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031607AbeGAQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:42:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A554BAA6;
        Sun,  1 Jul 2018 16:42:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Guinot <simon.guinot@sequanux.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.17 122/220] MIPS: pb44: Fix i2c-gpio GPIO descriptor table
Date:   Sun,  1 Jul 2018 18:22:26 +0200
Message-Id: <20180701160913.445786757@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 326345f995a83e326fa2e01d54bfa9a6a307bd4d upstream.

I used bad names in my clumsiness when rewriting many board
files to use GPIO descriptors instead of platform data. A few
had the platform_device ID set to -1 which would indeed give
the device name "i2c-gpio".

But several had it set to >=0 which gives the names
"i2c-gpio.0", "i2c-gpio.1" ...

Fix the one affected board in the MIPS tree. Sorry.

Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Reported-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.15+
Patchwork: https://patchwork.linux-mips.org/patch/19387/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/mach-pb44.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -34,7 +34,7 @@
 #define PB44_KEYS_DEBOUNCE_INTERVAL	(3 * PB44_KEYS_POLL_INTERVAL)
 
 static struct gpiod_lookup_table pb44_i2c_gpiod_table = {
-	.dev_id = "i2c-gpio",
+	.dev_id = "i2c-gpio.0",
 	.table = {
 		GPIO_LOOKUP_IDX("ath79-gpio", PB44_GPIO_I2C_SDA,
 				NULL, 0, GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),


