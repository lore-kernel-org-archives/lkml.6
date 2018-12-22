Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A231C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41002054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500930;
	bh=ays2BIPAThs1S45JLJPq9qcJew2zq8oRiWsojgZqaUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t0tpdpGS0v+UJua3iZiqUi6QXcXe+CqvF7kPSfvD/MBu/OnxwvUwFtGES5pnqg5Db
	 3OnrgGwCDQvTl94uOe0GKrVvWIaGq6FEise1l33Kh9gHf9HS81ZzFVFblRWHdXgR/s
	 nss35BaK6c/X4+Q5DpEnOTgI3/H3oRwSAzVFar4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392749AbeLVRsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389866AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.9.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733B3219D4;
        Sat, 22 Dec 2018 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545469652;
        bh=ays2BIPAThs1S45JLJPq9qcJew2zq8oRiWsojgZqaUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w70tJFDeswS6/18xBenmY9e2e+QBJO98GXJfBGDM7net0k7QstTdOacZEe18UfWe9
         8YPb25ori4Uj4hbjqeWnuZuDnavgnkfI1qwkcYYd+wMzUlyUSatn000wnsjlAQ+FSI
         8ZTyXqNBDfe9ZM/1e4y6Wz1ARp0xry/nTFCLyh24=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/11] apple-gmux: Make PCI dependency explicit
Date:   Sat, 22 Dec 2018 09:07:15 +0000
Message-Id: <20181222090720.19234-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver depends on the PCI infrastructure but the dependency has not
been explicitly called out.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b36ea14b41ad..86b75fa55dbc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
 config APPLE_GMUX
 	tristate "Apple Gmux Driver"
 	depends on ACPI
+	depends on PCI
 	depends on PNP
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE
-- 
2.19.0

