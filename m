Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F271BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F41214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864423;
	bh=fgaF1F+1YGWc1y22w4w2xl9fROQIpCNBZ98qkmrE5PM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ifdB8vbmQ2W6Hthw0V48q094UEf6LlpuKYmuZejUWQmLwXSGeIu7n2GfnKWcAkYz7
	 k24I0vddx4RDqIZIzoffNP70L4qv0EklpD400oTbx60MsYNUDArQSjmDH1xJ3l09Rx
	 pOq3Su3w12BisRTxRogh4M6bk+M5IhcnOWJ3hync=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeLZWrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbeLZWkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2EF20651;
        Wed, 26 Dec 2018 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864005;
        bh=fgaF1F+1YGWc1y22w4w2xl9fROQIpCNBZ98qkmrE5PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2KrlIVsk9rHpCepRM+6gQTq/bUTjgZgS9TnfIsaKhd7FVUqQKX1uqXx+phnyBzPD
         eF3x7pj7tLfkJAMH4GcpjE7nl4hCO9+qfwXiEJz/gIgdKatxsozXGrcOlyC+U12NVl
         E770P8JYQvsJhrKWCU92c+7LGh0J2ya//GvY2heM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/59] Input: restore EV_ABS ABS_RESERVED
Date:   Wed, 26 Dec 2018 17:37:47 -0500
Message-Id: <20181226223839.150262-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
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
index f4058bd4c373..61769d4b7dba 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -742,6 +742,15 @@
 
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

