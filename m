Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF42A21850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130219;
	bh=Jrf+LgU6njWbIc8kAxMPw7YF03BpvVlUAee+zqWusxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vApN0eU3C9tQ+9uM9vq67ROzHPFJXCFwmvMjAkF6q8ZLvSun70xInGBk0QeUDcR92
	 o7lSUtzdJ8J6TPiTU8fFRNo5LxIIO0OelGJZDYLj/MjLP9QeOKXXSWy7HXpDfxfApX
	 y7cVHXKUlr9gvpWZGvBPUmd1nQsOvhznVDmuMHKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfBYVaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732094AbfBYVaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B07D217F5;
        Mon, 25 Feb 2019 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130208;
        bh=Jrf+LgU6njWbIc8kAxMPw7YF03BpvVlUAee+zqWusxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJt5EtEKsQ9V4NXsiQWzDEifonEVPhR2wK/9BgT190RZtQq87pVTgNlNFBPYfgbQq
         gLcBGdHO5oUZp8oAfgNUJbJQvcqxcwds1bFRKpd9HLIN3e8XQiRexRgEqcEG+s19V2
         Qc+Ttu5q9YegjsZmpYvTUxiAuUCjGkepZnEjXAc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Cook <mcook@mackal.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 047/183] hwmon: (nct6775) Fix chip ID for NCT6798D
Date:   Mon, 25 Feb 2019 22:10:20 +0100
Message-Id: <20190225195102.503570173@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

[ Upstream commit 264142bc70ec039e26d8f3b46a717e8037f59ca0 ]

The chip ID is 0xd42[8-f], not 0xd45[8-f].

Fixes: 0599682b826f ("hwmon: (nct6775) Add support for NCT6798D")
Reported-by: Michael Cook <mcook@mackal.net>
Cc: Michael Cook <mcook@mackal.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index c3040079b1cb6..8f91e366866f3 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -44,8 +44,8 @@
  * nct6796d    14      7       7       2+6    0xd420 0xc1    0x5ca3
  * nct6797d    14      7       7       2+6    0xd450 0xc1    0x5ca3
  *                                           (0xd451)
- * nct6798d    14      7       7       2+6    0xd458 0xc1    0x5ca3
- *                                           (0xd459)
+ * nct6798d    14      7       7       2+6    0xd428 0xc1    0x5ca3
+ *                                           (0xd429)
  *
  * #temp lists the number of monitored temperature sources (first value) plus
  * the number of directly connectable temperature sensors (second value).
@@ -138,7 +138,7 @@ MODULE_PARM_DESC(fan_debounce, "Enable debouncing for fan RPM signal");
 #define SIO_NCT6795_ID		0xd350
 #define SIO_NCT6796_ID		0xd420
 #define SIO_NCT6797_ID		0xd450
-#define SIO_NCT6798_ID		0xd458
+#define SIO_NCT6798_ID		0xd428
 #define SIO_ID_MASK		0xFFF8
 
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
-- 
2.19.1



