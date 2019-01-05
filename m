Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDE0C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9609B21871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682812;
	bh=2kWUUx6hz8nGHTaHIK0eLEjxVeM50eUbYrP1sY0vOQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XEm2QjxhUhx+DW3MYRsiAUOm39btbv6eDuxvYbnb34zrB5cWsto5PGjeOd3ujcELj
	 kJ2jGv9Oz2jeTm9BtUghGMTfll1K7aIaQu3rv0khkV+8tfMGFGhe+Efkh3DL9s0HjU
	 bbjffHYFUTAlaijSSXY7Va+nnRqXkl1GwOzCK2N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfAEKGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfAEKGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:16 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26EC208E3;
        Sat,  5 Jan 2019 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682775;
        bh=2kWUUx6hz8nGHTaHIK0eLEjxVeM50eUbYrP1sY0vOQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/4SDTZFjztDVq/4y1/uHnEhCYWM9oUUYZb4q+icVX44/KKlw96VutRFBHmz1TL4K
         yvnAVA6O+EXOc0LK+mt9OGQUg/dKoJb0FP8JjZXZT9eQRjJVwFd3Q66rm/dqGWpG1i
         CSBABRCnmiAey+D8zqbGc4VUdG3rk2jll1CR8M8Q=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/11] platform/x86: apple-gmux: Make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:06:01 +0000
Message-Id: <20190105100606.6673-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190105100606.6673-1-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. This driver depends on the PCI infrastructure but
the dependency has not been explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7afb96cb1cd6..5e2109c54c7c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1135,7 +1135,7 @@ config SAMSUNG_Q10
 
 config APPLE_GMUX
 	tristate "Apple Gmux Driver"
-	depends on ACPI
+	depends on ACPI && PCI
 	depends on PNP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
-- 
2.19.0

