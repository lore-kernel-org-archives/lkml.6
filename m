Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B5FECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE50221532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="geA+9ktR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE50221532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeITRCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:02:03 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35838 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732512AbeITRCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:02:03 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3632B24E118D;
        Thu, 20 Sep 2018 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537442344; bh=gtyK7PMu7OKdM/7YHxDclayT9/KGYwF+X3bhZPF3E/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geA+9ktRlrNKqMVrllVlx3x80hhdpvitb27PZ734h8zpOqk6OM/YqzqdpzuiqqBlL
         4wteZrqzf+T2w2ij2ztY1jRkha2A+uu3lE1xZ0bWQt/fr8AltDAqBVCtqBcSCAcrKc
         LY6wtlC1wtkwNZk4KNtbFZTMhZZMAPWCLSNnqkk7yl0uj0iXSoGTY4DiuuDdOMYzM5
         eKhzp2OSEHobWCz07RgI/V1fKyJbkCXS6tY3HFS/oOhEXlsUgKuXAbTnnfGgrptUDO
         HVSnTk56+ioo5QkOt8CFF9aGiIqjDP/QmRCzG3k1m8KJC0h4uzvln2A3RH9MXHvYEw
         maTBBBLV9045w==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id D3F5256DA;
        Thu, 20 Sep 2018 04:19:03 -0700 (PDT)
Received: from de02dwemt291.internal.synopsys.com (de02dwemt291.internal.synopsys.com [10.225.18.65])
        by de02.synopsys.com (Postfix) with ESMTP id 106BC3E4A9;
        Thu, 20 Sep 2018 13:19:03 +0200 (CEST)
Received: from de02dwemt291.internal.synopsys.com (localhost [127.0.0.1])
        by de02dwemt291.internal.synopsys.com (8.14.4/8.12.3) with ESMTP id w8KBJ2Eq028429;
        Thu, 20 Sep 2018 13:19:03 +0200
Received: (from lolivei@localhost)
        by de02dwemt291.internal.synopsys.com (8.14.4/8.14.4/Submit) id w8KBJ1Bg028428;
        Thu, 20 Sep 2018 13:19:01 +0200
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joao.Pinto@synopsys.com, festevam@gmail.com,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
Subject: [V2, 1/5] media: platform: Add a DesignWare folder to have Synopsys drivers
Date:   Thu, 20 Sep 2018 13:16:39 +0200
Message-Id: <20180920111648.27000-2-lolivei@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180920111648.27000-1-lolivei@synopsys.com>
References: <20180920111648.27000-1-lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has the intention of make the patch series more clear by creating
a dwc folder.

Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
---
Changelog
v2:
- Fix Kbuild error with no Makefile present

 drivers/media/platform/Kconfig      | 1 +
 drivers/media/platform/Makefile     | 3 +++
 drivers/media/platform/dwc/Kconfig  | 0
 drivers/media/platform/dwc/Makefile | 0
 4 files changed, 4 insertions(+)
 create mode 100644 drivers/media/platform/dwc/Kconfig
 create mode 100644 drivers/media/platform/dwc/Makefile

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f627587..f627a27 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -137,6 +137,7 @@ source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 source "drivers/media/platform/rcar-vin/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
+source "drivers/media/platform/dwc/Kconfig"
 
 config VIDEO_TI_CAL
 	tristate "TI CAL (Camera Adaptation Layer) driver"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 6ab6200..def2f33 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -98,3 +98,6 @@ obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 obj-y					+= meson/
 
 obj-y					+= cros-ec-cec/
+
+obj-y					+= dwc/
+
diff --git a/drivers/media/platform/dwc/Kconfig b/drivers/media/platform/dwc/Kconfig
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/media/platform/dwc/Makefile b/drivers/media/platform/dwc/Makefile
new file mode 100644
index 0000000..e69de29
-- 
2.9.3

