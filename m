Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14026C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C902183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216876;
	bh=+Q1oL2xk9mMqTf0xLa6BZ8wTk8dp5L1ZtL21rb6E9HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EW/L7fz39IwueqEvRK5HMjZqTieJun8GZdHeJSYlmFLn0m6Rqfhy2NARfGFIfjtaj
	 08R192YeFd3C/q5rmgRrgkCgTZmZ4bSqosZ0WqM5pYzxmh9VfeV2LyOBuSFNiawT8p
	 toF68ZUyn0df7DeSXTns0jcT7vyCtd8YmJZ3CQgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfAKO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388399AbfAKO1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:27:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 509002133F;
        Fri, 11 Jan 2019 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216871;
        bh=+Q1oL2xk9mMqTf0xLa6BZ8wTk8dp5L1ZtL21rb6E9HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGUHWtBxQL++SQVHqJ2PKvTW8SatVKgxDO5vqpOfxrXNto0LqPpmDQu5qH2hHeRES
         eD3yPl85mNFT5spNGYKbBudIuNhNlVuhdmqAbsHCTYMnI8hbOtvq19tx9D5b8LYufa
         KBKACLgZh5gV2xF4rNMw/CJFE1OV9Gy1OGp8LTpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/63] Input: restore EV_ABS ABS_RESERVED
Date:   Fri, 11 Jan 2019 15:14:08 +0100
Message-Id: <20190111131047.112682505@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 3af60ee69053..b584868e1b26 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -739,6 +739,15 @@
 
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



