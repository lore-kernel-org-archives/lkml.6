Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE19C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1F3218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452651;
	bh=JZnnp2wQfy+XsAm9luwqnZmGZbtwD0CvgOdsY7dYY8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yg3iRpAA26BVSE9myyG19kodB0uM2tidF5RbeJ/jgQ1ODQuCC2tY8NaRNUgI5GXvt
	 BKhNrJhpnlzKZuvPjLufUIytWaL/fDOVNd/WbOJj76Bwg1gGvNYhtFk8PMYUmf87Ko
	 k7iY+h4x7aQthtOiCcGhWUxixsRAsprZM2UfKhc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfABSKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfABSKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:10:48 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC96B218D3;
        Wed,  2 Jan 2019 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452647;
        bh=JZnnp2wQfy+XsAm9luwqnZmGZbtwD0CvgOdsY7dYY8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPzTxWCucfkxaMboJru4ZkZiLxQLy1sPze/lppnuJD5TTVP/ugGimWv+z2hiOV7sC
         KpUnazFEy8mvugwxhOKyBTD6Hob1pRrZguwCguNdUGqdPVIOF1owBhdjpcOx4qbDjM
         3ylfaMgam8Cd8d1r8KKFVbeBSpTcsYFqx0DNSkD0=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 06/11] platform/x86: apple-gmux: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:33 +0000
Message-Id: <20190102181038.4418-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190102181038.4418-1-okaya@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
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
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7afb96cb1cd6..89f4b86244a7 100644
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

