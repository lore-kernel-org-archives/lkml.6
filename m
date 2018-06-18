Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE4C5CFC2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DEB20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DEB20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966686AbeFRI2p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:28:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935746AbeFRI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:28:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C5F1CD7;
        Mon, 18 Jun 2018 08:28:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 273/279] platform/x86: DELL_WMI use depends on instead of select for DELL_SMBIOS
Date:   Mon, 18 Jun 2018 10:14:18 +0200
Message-Id: <20180618080619.968779286@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darren Hart <dvhart@infradead.org>

[ Upstream commit 54940fa60ad3728c592f62dadb558165495a6938 ]

If DELL_WMI "select"s DELL_SMBIOS, the DELL_SMBIOS dependencies are
ignored and it is still possible to end up with unmet direct
dependencies.

Change the select to a depends on.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -168,8 +168,8 @@ config DELL_WMI
 	depends on DMI
 	depends on INPUT
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on DELL_SMBIOS
 	select DELL_WMI_DESCRIPTOR
-	select DELL_SMBIOS
 	select INPUT_SPARSEKMAP
 	---help---
 	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.


