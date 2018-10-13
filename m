Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0EC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C057C204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqVjDp7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C057C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJMMbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:31:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36908 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeJMMbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:31:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so7155975pfi.4;
        Fri, 12 Oct 2018 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
        b=iqVjDp7qSRCludwpzhZP+T2vAI8HXUGH5Z9VFN/X4D3GMsHivxJLSy2VErbzNb9hpA
         6Cw1/VoT8y7Cvuvz+I0YCGphDsLaWbFGNzLdJgvui22gql3obyQOsLqEKB2TwgDquK1A
         dgMznPoWaz5NzpeYREodOyaJRopS6qCVWAuLJ+KzGJpwIQZWB4+zdPid97XrAkXI6qx6
         7LHVawMRJwSFQSn+Ya2FaQNgcrUhvXmkx+j1ZZDnqYAGug1xzPUFg1wtnwR3QYT+TuSL
         +3Kdksst9QFm7W4Hf4JbZantLprYvW8qWONjBM0Ic3ETvimX0rP7s53aDT8C7HRJxSBG
         W8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
        b=stqEPAgdl925nu3aKLyq3frFn8aG1GayfCX75SpYxZg7JKY6udMe+vxYWo/QVFKxvD
         X2u4tz1bg606Cd63g+umAU5ocvzYO9zt4LMPOwW+DsBhWw+tPutx9vrLu8KI6+CAijVJ
         FRZEH5NiRPgZ1IrFuUD134P0AXd3egNOExMaW4lJ7IEnZMBfkf2PkCjHRQ0dTYIbRMQ8
         e1n32CTE/kgYytGFpYmrvaCJTsHMdX4c0O3qbNEQQBoDpICfdkGH9mdzzyn+eNKBLRX7
         bzzq1BNUGK+iJB4aqjCLJKeTMAFp2sflA+fmAZSiB7U8VKzHkE7hFUbtmPBkILI5+e5c
         79/Q==
X-Gm-Message-State: ABuFfoh/sAS1cH+fbmfla0as9R5Zj+gym0PL9vE79o+ZucohXEzaksyb
        pul/aY4Y/V6eW8BAmURzaBM=
X-Google-Smtp-Source: ACcGV62Bd6RAtLtKnP6cElZw5npSSURIJkel2eVB4JUXUPV5Htp+9aoA5iJdYKliJjPhQ23Yfztxbw==
X-Received: by 2002:a62:1551:: with SMTP id 78-v6mr8879371pfv.178.1539406526080;
        Fri, 12 Oct 2018 21:55:26 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:25 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 17/18] of: unittest: find overlays[] entry by name instead of index
Date:   Fri, 12 Oct 2018 21:53:37 -0700
Message-Id: <1539406418-18162-18-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

