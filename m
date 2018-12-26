Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A54B2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863842;
	bh=hp9jAGPZUSWiQej2vOe9VhfudiwkF5Ym8O2aE5wHQkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ert8QqJpf9KazSLteMJHNQZnc0xAe/FmOCj61px16ujDpMqHLQCW5jrHpQEIi8v9M
	 hH03QjogLI2vemnY4yhiCuvlEyFe4UAwnwQgDnGF2JiLvE7PIu59nTTsX51VmWVzEm
	 EYmvIlIbPDMcoJ3NR2KsmA5Pp4qLn4GReLfzJ8+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeLZWhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbeLZWhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE0A21901;
        Wed, 26 Dec 2018 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863837;
        bh=hp9jAGPZUSWiQej2vOe9VhfudiwkF5Ym8O2aE5wHQkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcU0fDv8DZZgOWky1nF6sXIFXwgXL3C9hPfOOxJONTO1HzKawiqfUtq+anBGaEbOH
         umIMNcyBxQoAS7w7vNjGMNS7MIshC5qzmFhSTyNoHZ+xiLFv1vkE+wlMQpWP4IG5Rl
         9dzduRgra5Sno0N4itCJXa2sR/rS0Idz7+tXLMfs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 52/97] qmi_wwan: Added support for Telit LN940 series
Date:   Wed, 26 Dec 2018 17:35:12 -0500
Message-Id: <20181226223557.149329-52-sashal@kernel.org>
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

[ Upstream commit 1986af16e8ed355822600c24b3d2f0be46b573df ]

Added support for the Telit LN940 series cellular modules QMI interface.
QMI_QUIRK_SET_DTR quirk requied for Qualcomm MDM9x40 chipset.

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index dada68f279bc..c8872dd5ff5e 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1230,6 +1230,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1201, 2)},	/* Telit LE920, LE920A4 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
-- 
2.19.1

