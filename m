Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26999C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCD822513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcnUzaMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCD822513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeKOI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeKOI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:13 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064D22251C;
        Wed, 14 Nov 2018 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234130;
        bh=sAy9HCmOtJcj0jJB1bko3QTmA8w1Ib6MJJ5GOGm2DS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AcnUzaMuTAnhj8ulxTDbmASrR6YxnoK3oytIkaFZ+7WSFcPhY/VMCCktel0Ft28Ge
         BzJc1TEkRpzGN/hpItPX28uaiSRkedusBt99q0/zvKED68fe33cihKpSWiWtMO8y7v
         lnQgVVjGNHSkqu+WArSIxWUyee9I8omWV5g2XlQ0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 07/73] Revert "HID: add NOGET quirk for Eaton Ellipse MAX UPS"
Date:   Wed, 14 Nov 2018 17:21:01 -0500
Message-Id: <20181114222207.98701-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

[ Upstream commit 6298944d8f57f40ee2a3e6dcea1253e78d7a9969 ]

This reverts commit 67ddbb3e6568fb1820b2cc45b00c50702b114801.

67ddbb3e656 ("HID: add NOGET quirk for Eaton Ellipse MAX UPS") was reported
by Laurent Bigonville. It turns out that a later model Laurent got
doesn't need the quirk after all.

My take is that Eaton upgraded their firmwares, so we don't need it
anymore.

The old model was from 2012, so better make sure the new line works
properly by removing the quirk. This allows upower to actually fetch
the current data.

Reported-by: Laurent Bigonville <bigon@bigon.be>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 249d49b6b16c..caafbea94882 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -106,7 +106,6 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MCS, USB_DEVICE_ID_MCS_GAMEPADBLOCK), HID_QUIRK_MULTI_INPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_PRO_2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2), HID_QUIRK_NO_INIT_REPORTS },
-- 
2.17.1

