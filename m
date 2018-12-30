Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B75C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF72070D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199822;
	bh=vziKu7c8z2zgfaB+hoFoNqS5iwqit8zqzji4d7EydOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xHcFa8Hz3Hv6GtkSu07Ud64FFB6jIQmZDbaqUccgijOuCCGtT7zkGvSmZxKM3CgLU
	 mn2AO/uINiAXLUTOcSHcV6N3D2YZtTu6MewtVITJBEgeJhSsZgYuPyYVRn+xVaFZMk
	 dGfzqekhIxKO+GmYSyY6x46sfowJSGFMc+3uORu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeL3T44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbeL3T4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:21 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1894321019;
        Sun, 30 Dec 2018 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199780;
        bh=vziKu7c8z2zgfaB+hoFoNqS5iwqit8zqzji4d7EydOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvOjqzeVmV2p/s8dD/+7HY1DYg06zBPT5xrfxH8GUHUHbDDOZ7Zf7eP8fU639IfAf
         4tGQr3R5sCfwrF2+EfpR1YhAO1qe1CB2uba6iOg5SquG6UAD3hPY4sKvCmtZfAQXIx
         D6xYX8r41lFW+coVbT1+5xYQ0lpMpAJzgcRQpFDs=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 06/11] platform/x86: apple-gmux: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:07 +0000
Message-Id: <20181230195612.6657-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver depends on the PCI infrastructure but the dependency has not
been explicitly called out.

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

