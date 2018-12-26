Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263D3214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864656;
	bh=MQc64kaluLItWSsuH2whTZfPOM6BtEaMtqFQxpBWE2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NBuxdqV1C/vo58BdW9tObWz+XmKIv0qaIvmK9ZDEDcP2E1+VXRjY+HnlwfYfyQnW2
	 Qdhld797abWGg9liLMrdPigUzUADD9k292Mbae1M++/5YKnfHe8CEplHYQe4JJFtV4
	 lVXb/GxUP5KjVLKfd+eS1/wm7DX19x9ODLHM5SN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeLZWuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:50:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbeLZWhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0797620651;
        Wed, 26 Dec 2018 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863836;
        bh=MQc64kaluLItWSsuH2whTZfPOM6BtEaMtqFQxpBWE2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnQ0gosb/uogWUata+YUD1MyQesgOapLnOgx3Q7gef6R8dC3wWWu3Ifneipe4Tf0B
         x/RCkoHNc3ebDMDHM8YdCQHhogWZbtwjHG1L8AakdVffX7qR0l+OGp4/eJa0FxqP5J
         kmm/13Z4+Y2Kx9kOgMY9+eXB0UWHEa8IxT85QSjs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 51/97] qmi_wwan: Added support for Fibocom NL668 series
Date:   Wed, 26 Dec 2018 17:35:11 -0500
Message-Id: <20181226223557.149329-51-sashal@kernel.org>
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

[ Upstream commit 110a1cc28bc383adb4885eff27e18c61ddebffb4 ]

Added support for Fibocom NL668 series QMI interface.
Using QMI_QUIRK_SET_DTR required for Qualcomm MDM9x07 chipsets.

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 72a55b6b4211..dada68f279bc 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1117,6 +1117,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 5)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd191, 4)},	/* Wistron NeWeb D19Q1 */
+	{QMI_QUIRK_SET_DTR(0x1508, 0x1001, 4)},	/* Fibocom NL668 series */
 	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
 	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
 	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */
-- 
2.19.1

