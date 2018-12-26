Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74559C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C86D21909
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863927;
	bh=sdeUcMNwcsaSd/X05RoskD58rOBf2e5M/xU3Epb8g6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XNGmtk9VZn8kQ3gEqurLvux8Xiln6rYQVgkWexHRteR+zXmaxfhvymQU1qvw1ByVz
	 lafSrAW2wcitDphyfmBLh1NeLOJoytKXN0PPZwBmIF9CL38ezX7kLoPrSkgTm+xHqq
	 TyTRXpuS8lSqAzwWKYdfRd+koXwQaiWyOTLePhEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeLZWiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbeLZWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2702054F;
        Wed, 26 Dec 2018 22:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863915;
        bh=sdeUcMNwcsaSd/X05RoskD58rOBf2e5M/xU3Epb8g6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sG60gd3mpZMiEPv73zoxY35/rThsXXMIuEUFLU4G8ylJYAn8Apyq4mr9hNw3qml3R
         wsPWSDWWR041vn5Jgx/ohRptUfhj/7srweMa1MW/uiznVE/hNSxQOzyhnOsMj+ugX1
         fJopDsFed7nSMJFIYQUqrxd3Y75YgMxG9eUSmWA8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 94/97] qmi_wwan: Add support for Fibocom NL678 series
Date:   Wed, 26 Dec 2018 17:35:54 -0500
Message-Id: <20181226223557.149329-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jörgen Storvist <jorgen.storvist@gmail.com>

[ Upstream commit 7c3db4105ce8d69bcb5c04bfa9acd1e9119af8d5 ]

Added support for Fibocom NL678 series cellular module QMI interface.
Using QMI_QUIRK_SET_DTR required for Qualcomm MDM9x40 series chipsets.

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index c8872dd5ff5e..f5bac5075386 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1265,6 +1265,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
-- 
2.19.1

