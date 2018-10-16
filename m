Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34871C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E72208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNWp6OTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E72208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJPK1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36643 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeJPK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so10214355plt.3;
        Mon, 15 Oct 2018 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
        b=cNWp6OTIr9yNPrhjf6nUHyWFwdqYPcsARgDVtqR1LXavRAKnv2rzoWqg4PF9vRV0qS
         6Cnk6gYyBHX33GKTwjHdNxQ4/tsbdEqeL6wpX/rqj+idxmRYRl6jaCzwuAVpmF+zdOud
         qTaXMvEZHnwuFCvAcbWDdZK4pwD58c4awu+Rfu/pX/Axalpak0FVnEzIIZ7EaOA3Lyb1
         97K2wdGV+1t3LFURiNuJA35R3T1lkNXFXUpb8tcZ3/CY1GkPeipx/ODf9Dr2w0SArTqJ
         qKMO6eJWRRDXykH7M6iTnVPleDItYDTI2bSo9Juh22lPEYKGb5EzGQq2RZeQIvjbZIvH
         QYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
        b=CyIgZeE673ulbUaEj+QPaL6Kez+RDFtLhdHlVxK2eNC8QUhb0KUgj13KuL82XXDiBv
         xTNpZ75QVi0oR6uh6W4gLXzo7kVygU08szWosi+YlOO0CH+Rn5tg5VTy8w0tJJkXONLj
         bgaJ4EmLXS2IHElNp7F0BI3r1GqiYbtrbbWJxZQFbhZ1S+DMurNXtG1cDZtpMBeUOCOt
         RT5L3+Zw15J1i/JrmYB8WtGKDPsU5nQ4hnXKzDlhjCibNKtn40F9wAm2oJjI12gztyzn
         Oa+gBLZpGg1Lv0cNs9FivdI4k8GI+KpGnDV8jKWQ5p1DQPFngarAxRz0UAQcme8IDhf9
         BQBg==
X-Gm-Message-State: ABuFfojX/eDAPlFSs6q3yoQS3trpu6TSSYBJ8/gHBXuwBKYkaROuFfhI
        JklVyvXIYMv2JKC+k/GF1tQ=
X-Google-Smtp-Source: ACcGV60Nfmmqbpzyw/70EkH3YYM6S3SkEI8I/6UhrD9vPf0vQ86RliJfFLgwooPXLM9IMHyjqz/QUA==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr19578346pls.217.1539657572500;
        Mon, 15 Oct 2018 19:39:32 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:32 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 17/18] of: unittest: find overlays[] entry by name instead of index
Date:   Mon, 15 Oct 2018 19:37:37 -0700
Message-Id: <1539657458-24401-18-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

One accessor of overlays[] was using a hard coded index value to
find the correct array entry instead of searching for the entry
containing the correct name.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 1c2bd8503095..785985bdbfa6 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2178,7 +2178,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
-/* order of entries is hard-coded into users of overlays[] */
+/* entries found by name */
 static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999),
 	OVERLAY_INFO(overlay, 0),
@@ -2201,7 +2201,8 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
-	{}
+	/* end marker */
+	{.dtb_begin = NULL, .dtb_end = NULL, .expected_result = 0, .name = NULL}
 };
 
 static struct device_node *overlay_base_root;
@@ -2231,6 +2232,19 @@ void __init unittest_unflatten_overlay_base(void)
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
 
@@ -2278,11 +2292,10 @@ static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
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

