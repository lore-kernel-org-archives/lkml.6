Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0982C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA92086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqQqI49v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FA92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeKIPrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:47:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45758 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKIPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:47:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so435559pll.12;
        Thu, 08 Nov 2018 22:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zm7IxG6IbjO3cKRTTQfNVO/WR/d8v3zooZUasHWCL4g=;
        b=gqQqI49vN94bvNkd7FpBY3kORWZlQUzbITgm7o+maoTt+06+l4ycXirnJ+zhF55PD/
         5QFnOqQZfBEg95/CgtE0+BhTabxq4OhiHgl+QvBEe+iwC+yfDlQpHn7dBRThd8t4rNVq
         xhduOclJ33sRUcwpJKrRcBb1PHGWrS9sWOP6+4zXUa39ZVxOQIjFdaaHqEeeTteAY/Zl
         aLGyypdRe9cwGR/ftdeF5RHB7mOQoe5Da2JDjh78tFZqjPcfaV2K+JyEpHkq/ZpYrzhY
         TdgqCqifGaCwEbH2/yMifZDQmUDV6jccSnOckHlsqpV6YGoIbUSDhl8T71Dj5qUfnAnr
         ilog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zm7IxG6IbjO3cKRTTQfNVO/WR/d8v3zooZUasHWCL4g=;
        b=YympFQl1DUHBj8x+PaTox/mSJeTVJk3sFvAGvpjS9NTrs5vUkr7TYvkogvNruSPRLb
         ZDZZN2Nkki9WjmqMuzQLhhfkVu6hMK/uESVqMXrOceDS0uCSdvVxtvrzdmjC4EGOvCW4
         grLnc5OJWpcF5cHjbN6mIsSyiRmXR3q1Hi1Cdm58Yvhl/6LaomnOO5fZZoE39yB1I1zk
         0YKw4A7FhXKl9NYk+hLfZinbXJpJgazPltmGC27JZrOuq3Ovgc84QDdBo6OXdXgZtz/G
         FhetL2poEyAWGUTI1o/iX/nRScwZTt0gHZ0a3oNBeM4yK6BKUkHX/ZIgqkNgsM9JJT2A
         H0lA==
X-Gm-Message-State: AGRZ1gK3KJQ2UwjJebE7JAsjvnjyI8kcxXNKkO3EV1Rv7P8jFoWlyDlf
        5jmGcXwFeo38xyEL43XbL7Y=
X-Google-Smtp-Source: AJdET5cLQiD9zO6YdVFSPzVtdxVZmXvuSAyKuht8dWgrP1THZUhnkbtFLyPD4FWwGZFjB54wKOnI8g==
X-Received: by 2002:a17:902:703:: with SMTP id 3-v6mr7714478pli.38.1541743683662;
        Thu, 08 Nov 2018 22:08:03 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:08:03 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v7 16/17] of: unittest: find overlays[] entry by name instead of index
Date:   Thu,  8 Nov 2018 22:06:04 -0800
Message-Id: <1541743565-23163-17-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

One accessor of overlays[] was using a hard coded index value to
find the correct array entry instead of searching for the entry
containing the correct name.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index d625a91a7f60..fe01c5869b0f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2192,7 +2192,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
-/* order of entries is hard-coded into users of overlays[] */
+/* entries found by name */
 static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999),
 	OVERLAY_INFO(overlay, 0),
@@ -2215,7 +2215,8 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
-	{}
+	/* end marker */
+	{.dtb_begin = NULL, .dtb_end = NULL, .expected_result = 0, .name = NULL}
 };
 
 static struct device_node *overlay_base_root;
@@ -2245,6 +2246,19 @@ void __init unittest_unflatten_overlay_base(void)
 	u32 data_size;
 	void *new_fdt;
 	u32 size;
+	int found = 0;
+	const char *overlay_name = "overlay_base";
+
+	for (info = overlays; info && info->name; info++) {
+		if (!strcmp(overlay_name, info->name)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		pr_err("no overlay data for %s\n", overlay_name);
+		return;
+	}
 
 	info = &overlays[0];
 
@@ -2292,11 +2306,10 @@ static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
 {
 	struct overlay_info *info;
 	int found = 0;
-	int k;
 	int ret;
 	u32 size;
 
-	for (k = 0, info = overlays; info && info->name; info++, k++) {
+	for (info = overlays; info && info->name; info++) {
 		if (!strcmp(overlay_name, info->name)) {
 			found = 1;
 			break;
-- 
Frank Rowand <frank.rowand@sony.com>

