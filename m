Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0267C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961402070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865165;
	bh=l9VfB7zPcUJYN/Qshbskyw3o+Sprs6HPyqg1ZlX+Q9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jn44kWRIAYJT4PfbFy6pv+2wTPScRDlJFCK7Hem21kKJPx5O4Uv97J8wNFyFfiQZw
	 z/zbSD9G5oo38tGuwNviasK7vbSzGuHgOqfvs9QmnrYr1q8/FIzOogHe59HuY9fHQI
	 hDXUvsoiHuPArXWvNOQCTJq/vyT/mJfy0xV9ha3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbeLZW7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbeLZW5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:57:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7A521741;
        Wed, 26 Dec 2018 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865021;
        bh=l9VfB7zPcUJYN/Qshbskyw3o+Sprs6HPyqg1ZlX+Q9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbfP/U2eG03FROB92OustO1fezq2DPYnuyqNlAWc5XAJ5VoOTjCI+myzVGT7dyZka
         PVYSpUb4+iwvywoCgFScta9T7CoSibiiCJJQ14uMr/V/fFmoUvVV+BDwl8ZRIdM5QQ
         lCdSrsxrgLS6MMT7JcbOq9NjiS2cdhiLdZvboeM4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 03/21] Input: restore EV_ABS ABS_RESERVED
Date:   Wed, 26 Dec 2018 17:54:41 -0500
Message-Id: <20181226225501.151365-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225501.151365-1-sashal@kernel.org>
References: <20181226225501.151365-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hutterer <peter.hutterer@who-t.net>

[ Upstream commit c201e3808e0e4be9b98d192802085a9f491bd80c ]

ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/input-event-codes.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 87cf351bab03..9e07bf4259e1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -708,6 +708,15 @@
 
 #define ABS_MISC		0x28
 
+/*
+ * 0x2e is reserved and should not be used in input drivers.
+ * It was used by HID as ABS_MISC+6 and userspace needs to detect if
+ * the next ABS_* event is correct or is just ABS_MISC + n.
+ * We define here ABS_RESERVED so userspace can rely on it and detect
+ * the situation described above.
+ */
+#define ABS_RESERVED		0x2e
+
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
 #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
 #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
-- 
2.19.1

