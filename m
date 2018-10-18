Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C73C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B8A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B8A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeJSASW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:18:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727274AbeJSASW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:18:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9984D5F3932C1;
        Fri, 19 Oct 2018 00:16:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Fri, 19 Oct 2018 00:16:27 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <arm@kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] arm64: defconfig: Enable some IPMI configs
Date:   Fri, 19 Oct 2018 00:17:07 +0800
Message-ID: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 port now runs on servers which use IPMI. This patch enables
relevant core configs to save manually enabling them when testing
mainline.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..fe8c097 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -297,6 +297,9 @@ CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
+CONFIG_IPMI_HANDLER=y
+CONFIG_IPMI_DEVICE_INTERFACE=y
+CONFIG_IPMI_SI=y
 CONFIG_TCG_TPM=y
 CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C_CHARDEV=y
-- 
1.9.1

