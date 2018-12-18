Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68171C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DB721873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151221;
	bh=QmH90L4YYXjeheZTJKWgWWswWOix5yj+tQh/32gNglA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyGP3BX2Xy2KIdYJ7FIuek7tT7IiFr7Oa8wCnf8trL/GwkGygOYSf1RVG0mrhHbFg
	 T948Sv6xKbnE79/KtApoBq3LOT14Ks4gVN2abt+re1dVyBZrXCjDExy8cYCKwzqBY2
	 V+5+n3JScmKs0+cDivvNAGzk++wbxLIw/5D71M2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeLRQkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeLRQkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD09218A4;
        Tue, 18 Dec 2018 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151212;
        bh=QmH90L4YYXjeheZTJKWgWWswWOix5yj+tQh/32gNglA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLYsXlLYui7vcDjthiimfGQcMrJgSWYjWiafZTgpZvoiUMBrhkEB2szjuAy/425dq
         /nCdPDtSfLYF+Nm91T7UPcKxHfp1pRCjw1/QVTuGR+oi4yav2I3GwxAWj93+6XnDl2
         HZEDudcjjsVqvc8fJYBbYACVyWGybexVxjvBGzJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 03/44] staging: olpc_dcon: add a missing dependency
Date:   Tue, 18 Dec 2018 17:39:15 +0100
Message-Id: <20181218163927.496565094@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 33f49571d75024b1044cd02689ad2bdb4924cc80 upstream.

  WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
    Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
    Selected by [y]:
    - FB_OLPC_DCON [=y] && STAGING [=y] && X86 [=y] && OLPC [=y] && FB [=y]
                        && I2C [=y] && (GPIO_CS5535 [=n] || GPIO_CS5535 [=n]=n)

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/olpc_dcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index c91a56f77bcb..192cc8d0853f 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -2,6 +2,7 @@ config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
 	depends on OLPC && FB
 	depends on I2C
+	depends on BACKLIGHT_LCD_SUPPORT
 	depends on (GPIO_CS5535 || GPIO_CS5535=n)
 	select BACKLIGHT_CLASS_DEVICE
 	help
-- 
2.19.1



