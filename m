Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46234C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A062084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130153;
	bh=pxibiVcLXQRLnZZd3FhH5nZ2tOsM4o8nALyAS9IXU2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOulSWgqYZWCitPl3JymPEBR+0bDpmfWYdYN4auWAK8Y1KxFCf1JLxmLnLFhtPJrB
	 oEFEXjPZcaD60+ankVlhVYHQIsCtZnvQ4JxDboC4CB4zs47QGZBwcKORERAoF4Amfo
	 E6D930RfJbCQRm5iFiSNgXE9iTfdnV1r5d51ikX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfBYV3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731981AbfBYV3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1FB2084D;
        Mon, 25 Feb 2019 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130148;
        bh=pxibiVcLXQRLnZZd3FhH5nZ2tOsM4o8nALyAS9IXU2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8RdCo5RJHImnS6uGxISgrg04O+Ewn1tDRNvr4YrckHSu23bTphRaldYTp6eNwzFA
         WavfH8WxXoRcehA3A67ZvsHZeBhvDZTSHzrtThD91HqVUd568AHoPkgiy348bFPIc4
         NVZeqw5jbmxZAOD7R3/eup+b5MPzqH085Vn7o/vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 030/183] mfd: at91-usart: Add platform dependency
Date:   Mon, 25 Feb 2019 22:10:03 +0100
Message-Id: <20190225195059.771728023@linuxfoundation.org>
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

[ Upstream commit 628f3dfe4c7b35bbe63ec194ca6da857b00b0083 ]

It doesn't make sense to present option MFD_AT91_USART by default if
not building an AT91 kernel, as the drivers which depend on it are
not available.

Fixes: 7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdce4326c..f461460a2aeb9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -102,6 +102,7 @@ config MFD_AAT2870_CORE
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
+	depends on ARCH_AT91 || COMPILE_TEST
 	help
 	  Select this to get support for AT91 USART IP. This is a wrapper
 	  over at91-usart-serial driver and usart-spi-driver. Only one function
-- 
2.19.1



