Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BE2C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63780207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027160;
	bh=vM6ctrz3EQEi/4T/AhANsMUB3MsbpZq5JuumUH5bo1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d5KNVBs67FeNa/Vzjz5eOJGoFwz13ptcIoQ+Ro20CcEyUJDJgvvQPvf9PC70s502G
	 iWDC+oTdrPFr13+7BfG+CqR+ap4pbubShRbT0dWbgC38VHSe4PE92xg9UAGr5KPQNc
	 Zh2RgB5DGh2Gz2575QUxfrpQgKi/V366Omdoh4Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbfBMDF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbfBMCdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF57222C9;
        Wed, 13 Feb 2019 02:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025229;
        bh=vM6ctrz3EQEi/4T/AhANsMUB3MsbpZq5JuumUH5bo1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcLK8MzoucY6cv2dht4ADMGO2H8fMfAib0CWvWMUyZ3xDhGXDdqk2oeZ7cUkDpjEW
         O4sXXxtiPvCkqeKcPMw50S9MqylmtIG2tXrHOxVGFMbamEdJe7YqmEoZvz2L75cRkp
         meBoUJqtHSxcH3vwHF6OsW4S+2Apdg0pBeuQ5BZ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 012/105] mfd: at91-usart: Add platform dependency
Date:   Tue, 12 Feb 2019 21:32:03 -0500
Message-Id: <20190213023336.19019-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>

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
index 8c5dfdce4326..f461460a2aeb 100644
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

