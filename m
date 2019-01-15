Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C380C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BED20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571177;
	bh=D5IFOR2kSZ8boYDe5b997ToPPaF5SYNdI6JIHFd1U3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqxTqd7a7KxH0KjlSXxg9UkKH1/sVWfQwG0OK8ZqersrTz6+t9hvfXD776NNV8YFQ
	 AtVqfJnCAAa9/hQa50Aw7uvpb8BX0TjRZlqSuiEN6oIdQeE+LbUWooYU2JXvABPCcz
	 tBWlK26q8L4u0KQdaq2u+TUwSqQljfHXggRsAgzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbfAOQoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387440AbfAOQoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086062054F;
        Tue, 15 Jan 2019 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570640;
        bh=D5IFOR2kSZ8boYDe5b997ToPPaF5SYNdI6JIHFd1U3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gr+1vyjlm14AvFQQdiOGu+JQqT513L5tBwpERpT0WnomY6K9lAfbuv3z7viXuDu2
         cHbZC3gZ4rgwb7Yl6trfp5t0fhOgTrNaPO9oqYi3DB8oJZHcQGp3R+JK9Mnxvy6k5/
         Cj9PFUCCRgRz+nHXva63eFxkuZaHU93P3twUipuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4.20 18/57] ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
Date:   Tue, 15 Jan 2019 17:35:59 +0100
Message-Id: <20190115154911.726130765@linuxfoundation.org>
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

commit 94777ed3b644a1af09843f729b2a3f25794bed0f upstream.

Since commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") the gpiochip label no longer has an ID
suffix. Update the GPIO lookup entries.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-davinci/board-dm355-evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -117,9 +117,9 @@ static struct platform_device davinci_na
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
 	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SDA_PIN, "sda",
+		GPIO_LOOKUP("davinci_gpio", DM355_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SCL_PIN, "scl",
+		GPIO_LOOKUP("davinci_gpio", DM355_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };


