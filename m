Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5CCC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC3F20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtKeeZVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC3F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJSGvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:51:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35521 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeJSGve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8-v6so14982603plb.2;
        Thu, 18 Oct 2018 15:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
        b=EtKeeZVBk+FI0AK+AIQKX9hJ7lWddKg5ePWCoufuY1uIzioLYEKrk2sAOi9YDPyZ9f
         Nsvof3fYSpBcji78c9eH8sieJRDhYIHLwY510rCSKE8DOttguXPTtDUiwausPKaMmnyn
         1ZnYyyrCcvZLaMmtK5NGG/FJe6zhqlDZn6bIdp+HrAwj1KtLIKQhhRWe615YHsDypiu2
         3qmDHsF78zpfLJP0RVOn9PFt+AHPWb6bee7dXkg2fAe23hR6NigEsxI+CSGS2xbziBy6
         I2/NZxKZ+H4opUEyaX8GoVujQCRn01tqRHTkefpGs66lhh+IhiTviEbNgO2fRmkQxYvs
         5DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
        b=B9zckA5qcD14E0G8J4VWJkmKM4/xqyLsfFB/O5onuQ4eh+KKwkPWXNdcUKHkiVDyYU
         LQYEY9FIAxsHBY+DLBWX1qmxztkEUr89dSgo3cvU0c5xlL+kbJvJVQ77XUaJwMkPiweD
         R3gixCptlhmRH/MNjSrnmaFZRGlFQU/mYobVZfbs1PAXJnpDVvJW8rMRIznvItRjtAsl
         Pij540C1qIupcRNYUHExVCsIiHE04FRWxINLxKLZSzvdAQ7zPOAO/MpC1/gOPsd5z9Bg
         7QEjUg4VJlW4p3/uwKuCU5MlOwM/yoUn8HeNLDCa10r5BUrXfqZg6fqOtjHSJ/FRAh0Z
         ZjGg==
X-Gm-Message-State: ABuFfoi1769PtLcL18fzuM7XmMSlCew1Fbjo1BSKYTEGmuD67yGD7Wmk
        YIYyx0nCTKLUac4Hel18OSY=
X-Google-Smtp-Source: ACcGV62CSxrRI0KmafYvfiu/kVZDeqOLWCMbM2JNGkQpe2G3kHGkPG/NMzey2SeVUcG2UeijApsIeA==
X-Received: by 2002:a17:902:4c85:: with SMTP id b5-v6mr22056163ple.126.1539902904676;
        Thu, 18 Oct 2018 15:48:24 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:24 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 17/18] of: unittest: find overlays[] entry by name instead of index
Date:   Thu, 18 Oct 2018 15:46:35 -0700
Message-Id: <1539902796-8382-18-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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

