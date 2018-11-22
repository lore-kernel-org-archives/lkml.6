Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A03C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D0E20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="NQBADYNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLyj8fyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D0E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404732AbeKVRM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:12:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43355 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732955AbeKVRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:12:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 57A5021F6E;
        Thu, 22 Nov 2018 01:34:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=7YaYxM3zwhxAd
        S2G9qdRSd9LLkUOArdQ0uT0AOMl/P4=; b=NQBADYNuq66+bizkD+PsogwK//5XK
        XaplCH/ogqORUBAT9y0qZlWB1Z1B7O1jc9W8ZAdUnJPaTEqQaZuN5fOqTnBQQYSM
        dVHW7DHW+UJ8ymg20oxgeG5D1uyu9YzafPFw6kzRbJmasmdvBSOjvIqyy7sch7KO
        nthmqYIb/v8aEUVoJd/w2vmQNfjkh5/x/Jm4J32HZD7oD9ryO1CP9lq1CHsHnbVD
        p6caGlG7muwekiKVf/70+o2u89jqz5IJ9mbUBhq2jCG4BB5ZM0JODi37OV6BRCyO
        qyvyB+TMvxZzLVrIZPRv++dQTOLJTAL1cv/9t45XwldVUr+Fogxl9S3iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7YaYxM3zwhxAdS2G9qdRSd9LLkUOArdQ0uT0AOMl/P4=; b=VLyj8fyk
        VN91hNwrmLJMwubdd2dCw+HpDJttioQp2ZUPoofEzO8AL0TUk1PwXeqIdMvPdpaM
        ZsKsouRfLyfkXNVlYXuJBT/FjPVEaNIatUv4Q2S8f/UwxMsKsi5hCOw2lyGoGk7N
        uf6oar+cwT0A9KKBz2H7WDeJAykWUG+JvxcDAte2a0iOTzopsSX3S9t5jq/YMuhX
        2BzxBl/s8Eh8VQ0vGE4Oj9/J9LDA6JatJ8IpyOEP5qOHYtfBnt6jDOzFQSFtU93j
        JWxm89pWGUYhQzQYORrK0dy961+aXkb0FI85ufV+uzA1qUsWiE75vzbPSRL45g4o
        QV383Qt2H5CfTQ==
X-ME-Sender: <xms:EE72W0fH92gVD5qqkQ7AeooBL4zenfrUjvatUSnLtO_IXy7rm9xwbA>
X-ME-Proxy: <xmx:EE72W3vEImvLen2tmC-CZ8DtNCuACdVViOb233kp0EENvWborMB4KQ>
    <xmx:EE72Wyvdd7KEw7yAZX59NGpgJ8nZ_Z0y1w2zc8MDqrPv7-sc1sapmQ>
    <xmx:EE72WwNpiniB7WWtNZAE3SRlyAKBTDfti28ZYiVDNFGCOHUUpb93Mw>
    <xmx:EE72W8eHqmAXiGTroHFU6Qn9b6ssS7vupqXKO_MUU4Y1W95VfnHwqw>
    <xmx:EE72W_kwJ37joUbQl042aURm5TAZKFalzZ84rQatCTUAhIhgpzt6Yg>
    <xmx:EE72W3t891S9oTz0qo1MaVogocuEFlGRQfvzda5GO_nDBMauwu9zQg>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A6E5102EE;
        Thu, 22 Nov 2018 01:34:53 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/8] HID: core: store the collections as a basic tree
Date:   Thu, 22 Nov 2018 16:34:03 +1000
Message-Id: <20181122063409.15816-3-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each collection parsed, store a pointer to the parent collection
(if any). This makes it a lot easier to look up which collection(s)
any given item is part of

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-core.c | 4 ++++
 include/linux/hid.h    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5bec9244c45b..43d488a45120 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -172,6 +172,8 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 	collection->type = type;
 	collection->usage = usage;
 	collection->level = parser->collection_stack_ptr - 1;
+	collection->parent = parser->active_collection;
+	parser->active_collection = collection;
 
 	if (type == HID_COLLECTION_APPLICATION)
 		parser->device->maxapplication++;
@@ -190,6 +192,8 @@ static int close_collection(struct hid_parser *parser)
 		return -EINVAL;
 	}
 	parser->collection_stack_ptr--;
+	if (parser->active_collection)
+		parser->active_collection = parser->active_collection->parent;
 	return 0;
 }
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a355d61940f2..fdfda898656c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -427,6 +427,7 @@ struct hid_local {
  */
 
 struct hid_collection {
+	struct hid_collection *parent;
 	unsigned type;
 	unsigned usage;
 	unsigned level;
@@ -650,6 +651,7 @@ struct hid_parser {
 	unsigned int         *collection_stack;
 	unsigned int          collection_stack_ptr;
 	unsigned int          collection_stack_size;
+	struct hid_collection *active_collection;
 	struct hid_device    *device;
 	unsigned int          scan_flags;
 };
-- 
2.19.1

