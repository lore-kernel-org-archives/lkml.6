Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB692C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7332D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAvKvohZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7332D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeJELLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37897 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeJELLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so6193289plr.5;
        Thu, 04 Oct 2018 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jnKR2PoeAIKjHuDWgCk3o7QuZS8LEHYAoeREGeLzT+w=;
        b=dAvKvohZsVxx9kvawvTGHS6nMcBizZ2VDXINM1YFkWeD2QgzVzadpwyop5UgZ8Rz3v
         zY3Gg4ktPe0J1ZibO2z4kOMVdLXfKkNJBj90EW4tLSG0Hx6BGHKIfV0FHl29PMm9P1U5
         86CkAL2aus9uL/X9tCoYGqzHarTUDKAj2jxyrswrPrkWaUQL1B5R3HV/H1MFJXAmsDEX
         yOAy5SvcW0UikMQ2CJGV1PtkOTbFeB10RpQqtH755fli7w5IMVvNVpRKhRD93Ecfmgqo
         dE0pi9uYJDUFdaJB9ld6SpzS4Qojxp3q/UpqItLl4zpd6V/oK1viHG4GbNw2KUiuPHg0
         MNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jnKR2PoeAIKjHuDWgCk3o7QuZS8LEHYAoeREGeLzT+w=;
        b=Z+QIT7WGDv1IUPt2uoORC77Y1kli5zd82lIuq/+d33kJJTK2ubapw3uTVdtVUbX8iV
         8adh3vTPxXUc+sDTNgHk3/DzkEuTZ79uQ71AYZaL4TWfs12EM/IdZrtCeTRH3jdk6Kni
         GL53lHc5A2z5yRGiFoONxxwIMgrFCmIIypHg+f00QuMncdFC4bxI5t59R4PzoOeOkMtP
         jFmYhzND+cspdX+YoIVap+0UvqiQrrlLHruSJ2PVj52E6imTeTnSceWIIBwFBqF3M3Ct
         mZbO9JKraUaZbShAmAtbf0UqsurlTGC1GK+OohPAj++erBdAmEZYQAmLqEpBgB/2HUSH
         5MVA==
X-Gm-Message-State: ABuFfohMCxfJWY5WF75z7peNBiUJ+4UmhtpI1Z85GGESeQxvn8GkRILT
        z2jaIkEGiwSlvbK0fvYdLtA=
X-Google-Smtp-Source: ACcGV62qItnQd2CXtT6xk/RzShI4DDV5hJdw17NOq2BjfOvsibaFEpU1DYVLMYQw8bbac0podcCrfA==
X-Received: by 2002:a17:902:261:: with SMTP id 88-v6mr9771113plc.331.1538712872151;
        Thu, 04 Oct 2018 21:14:32 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:31 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 16/16] of: unittest: find overlays[] entry by name instead of index
Date:   Thu,  4 Oct 2018 21:12:47 -0700
Message-Id: <1538712767-30394-17-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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
index b61a33f30a56..4d4ba4ddba9b 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2152,7 +2152,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
-/* order of entries is hard-coded into users of overlays[] */
+/* entries found by name */
 static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999),
 	OVERLAY_INFO(overlay, 0),
@@ -2175,7 +2175,8 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
-	{}
+	/* end marker */
+	{.dtb_begin = NULL, .dtb_end = NULL, .expected_result = 0, .name = NULL}
 };
 
 static struct device_node *overlay_base_root;
@@ -2205,6 +2206,19 @@ void __init unittest_unflatten_overlay_base(void)
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
 
@@ -2252,11 +2266,10 @@ static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
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

