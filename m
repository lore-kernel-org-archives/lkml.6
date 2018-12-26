Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE28C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3B22087F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865333;
	bh=Qngf2Hh7lIc4YqkBtCoIHgxChlKS1+msWiB8ZiEA9c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f3i1tFZfhwgR2cL+TxHcrnJ16H2Ih6fRCl+T5ZayNWsGNCDbBGb2sHKLWiIOMRpgh
	 XhuZ9RGw06pyWPwuYi/WMOf4u4kLY/EFpoTySKJj4/VgPjSuKnE2ZzYl9FVe6D8Xqz
	 cUZLI2PbgEuj0ByovNovQqPQ2umKk2i2mA/spVNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbeLZXCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbeLZWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB5A21902;
        Wed, 26 Dec 2018 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863774;
        bh=Qngf2Hh7lIc4YqkBtCoIHgxChlKS1+msWiB8ZiEA9c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbCQhRFgW3hdED7KolQb3OfJzBc3Ni+7xxSERlTDIsceldfNcfbUh4sXd/zXY72EI
         nKNzpAAtgW3dzBxPfNN+aIdB7w4+1uC0L6glEfe7jJsHKmaNrQyTzqlng1esnePYRK
         h/R+aIA/ImQTnBsw42PY6ea+NLYeseyxzkxzCgN4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/97] Input: restore EV_ABS ABS_RESERVED
Date:   Wed, 26 Dec 2018 17:34:31 -0500
Message-Id: <20181226223557.149329-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index 53fbae27b280..61a5799b440b 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -744,6 +744,15 @@
 
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

