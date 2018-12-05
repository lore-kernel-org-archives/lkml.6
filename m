Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21119C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54402081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="mQTx0HGG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kbfDlyq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54402081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLEAnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:43:37 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52729 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726715AbeLEAm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:42:57 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D9CAAF53;
        Tue,  4 Dec 2018 19:42:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=k0SRJk9N+O36M
        b6BBb8a+KFCArA/YJkSqsoiZZ63uUo=; b=mQTx0HGG38qmF8JpsSklhhOZ8yghv
        zLgaQfcCXHdONW7ZyA9zaEqlA5CGE4RlnVBx9zrmBOG483QsPtMbUd8G/5Pmgtl7
        pR2PHk2c/dSATOwseZOEsblPz6rWeJ2TQYRJC4bOSdSyVaMmuQ5XvQJ87RKW6lMk
        GcCm04s8XbfenGRX44uoT3feZLOiK6KVp/KGFzvpXQ47cafjPCPQBUc6Ps4A7bxf
        IL3hOBwZFZXFN3es2ntOqSoA0wqWIlnSNW5JiICtOHlAzaIpspWx0MxslsyPkltp
        ZFlOBEzng0eDhLqEG9P5w4YB5qgskAMZUXYPHZq03vUV6B0R5Ji8/0pdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=k0SRJk9N+O36Mb6BBb8a+KFCArA/YJkSqsoiZZ63uUo=; b=kbfDlyq8
        O5bcKWogQ2ttWIQQ72S47C0JNp+U4k802xRO4/iNlvznGmvusSbi+LtY2MxERtex
        lKwF+VSUZK4NL9wVqyj0Gh7stgAA0MjBji2XYfFSMiuD3LFsf7o+x89AOZSI3uOx
        kZMdcwqbCn5sEIKWWsx9i7eSrTAlBRCdMO31xjm3r9O2bbDYxabO7N0GOLl2Kjtw
        UXkKS91w0t4poYM+VYrXznjjrfIWoJD0zd7PYxaiWBHPiGFNcY4EI82HWp1zJbYd
        axnGuNYLrLZTf/j35T5emuDrzfz1YZGAvsfSaRmYyFwCkscDxoJTXrIlwMrfiCw2
        ZsX3JFg/5j6jPQ==
X-ME-Sender: <xms:Dx8HXHfOhWAjwtcwWEoWJfUMw0eFaSIvAuElKca6zSLk6KgMGRla1Q>
X-ME-Proxy: <xmx:Dx8HXCz7gDeCk835sYoHOG5LwzzJzYI8jttusiMbUYwGR-VroCKpUA>
    <xmx:Dx8HXPyV6_kD7HtxCTLWoWeiZi4swjj8Gjpyxy1YYHieZ8tqh0rWig>
    <xmx:Dx8HXM_Sd5PRPOVH4RFjuEfeyUAaBg2JjlqtFC3FsshR5eqbvIxU1w>
    <xmx:Dx8HXKjOl4-IXelPP1AC3gYZIq-Hk9tMrTu8h0APJwiR0Antx8b_8w>
    <xmx:Dx8HXHUnrgEEarPmcjoStniAcgiUmH6rwjiTOjnfC_mCSEzimZ-XLg>
    <xmx:Dx8HXHuxWYZkpa_SHJDE7cu_APhQEGDn62LG48sfeHMSXpjsDPTBWg>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70194E4750;
        Tue,  4 Dec 2018 19:42:52 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 2/8] HID: core: store the collections as a basic tree
Date:   Wed,  5 Dec 2018 10:42:22 +1000
Message-Id: <20181205004228.10714-3-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
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
No changes since v1

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
2.19.2

