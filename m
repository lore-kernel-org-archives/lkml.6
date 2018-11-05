Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3228C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928722081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uamofHmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928722081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbeKFArb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:47:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33271 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbeKFAra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:47:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so1001164pfk.0;
        Mon, 05 Nov 2018 07:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cW/aLXOwyBpDyXo/7JT8z7O8HOv4Q66hATfzdpFXsv0=;
        b=uamofHmWNylMh9AfrLZbXcwVesy8gBT09C83yN00T0hu1uHopBeJI/snX+FgeCIx6e
         Iryt/e6JxxCjc3Ga88XaClGcAxAUpvOvQ7qvZu8EMnuk4QyqA8uOSLFJA17cZnA1Fmhq
         hn8LJDoiossYyVvpv417pxS9r6AsiqhOGx2qa3aCp1jZHPRnQFsWM55UnQcsu0nN91rf
         gDyAdumjlZaKSI9E4f0Qol0JhBKFr1XAt2K07+7sHxISkXF2SJi3OS5qZIi2gzvu5pS0
         XHCiemHo7LN3htyuVe8OYfcp+ZKHh/VrxbxIGjq5SJjkqdE/CZdBpIhTeqDpTpNiv3du
         N26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cW/aLXOwyBpDyXo/7JT8z7O8HOv4Q66hATfzdpFXsv0=;
        b=MUzWWcY4zrAu3q0KTYEx8zsg/yFZELaPsOUL5Cv8b6s1oQcYyBbudN8q36ealdkCoC
         wcRKTDyO4nyDQaWAq718SPciCaFiCURBwgM+5JOdHt2G8f+wH3Lqj4gCIsXJ2teQgR35
         vtKWCfV7rfQyTeg8k3QktaHk4KiGEif/BMjos4MCwI8I44eY/SLGaL5J63tqYsJwKNa5
         JMOl3Ptx4r6kQtvqVWsIJVrVfaXHqf0T0Z6hL+05qaz4ANDU3dYV6q4UFvoF4tvA/DEF
         bRghUoSerzhZuj/nUHovY+9OP9cWsai3CJWSluLyExYKLgi5AwtYlCkd7MR4zmw8NyK3
         +K4g==
X-Gm-Message-State: AGRZ1gIJnB6MJCNGbkiR9oA489obHFcOxahfKcguY+un+ftmmvigOIvw
        N4KkHA1jU02DWUxVaFMQxaU=
X-Google-Smtp-Source: AJdET5f7riUAWGmhBD/fmNmJQE+/R2glkKRlc/6eAlEnBDiIQl/PSZ6Os0iuMBJo4uNU8lSmhY1Msg==
X-Received: by 2002:a63:4745:: with SMTP id w5mr20971062pgk.377.1541431636362;
        Mon, 05 Nov 2018 07:27:16 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 07:27:15 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v6 18/18] of: unittest: initialize args before calling of_*parse_*()
Date:   Mon,  5 Nov 2018 07:25:15 -0800
Message-Id: <1541431515-25197-19-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Callers of of_irq_parse_one() blindly use the pointer args.np
without checking whether of_irq_parse_one() had an error and
thus did not set the value of args.np.  Initialize args to
zero so that using the format "%pOF" to show the value of
args.np will show "(null)" when of_irq_parse_one() has an
error.  This prevents the dereference of a random value.

Make the same fix for callers of of_parse_phandle_with_args()
and of_parse_phandle_with_args_map().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index fe01c5869b0f..9a10a48eb6a1 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -379,6 +379,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	for (i = 0; i < 8; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_parse_phandle_with_args(np, "phandle-list",
 						"#phandle-cells", i, &args);
 
@@ -432,6 +433,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	}
 
 	/* Check for missing list property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-missing",
 					"#phandle-cells", 0, &args);
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
@@ -440,6 +442,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
 
 	/* Check for missing cells property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list",
 					"#phandle-cells-missing", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -448,6 +451,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for bad phandle in list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-phandle",
 					"#phandle-cells", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -456,6 +460,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for incorrectly formed argument list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-args",
 					"#phandle-cells", 1, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -506,6 +511,7 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	for (i = 0; i < 8; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_parse_phandle_with_args_map(np, "phandle-list",
 						    "phandle", i, &args);
 
@@ -563,21 +569,25 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	}
 
 	/* Check for missing list property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-missing",
 					    "phandle", 0, &args);
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
 
 	/* Check for missing cells,map,mask property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list",
 					    "phandle-missing", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for bad phandle in list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
 					    "phandle", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for incorrectly formed argument list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-args",
 					    "phandle", 1, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -787,7 +797,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		passed &= !rc;
@@ -808,7 +818,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
@@ -864,6 +874,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
 	for (i = 0; i < 7; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
-- 
Frank Rowand <frank.rowand@sony.com>

