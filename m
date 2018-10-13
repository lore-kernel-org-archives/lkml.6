Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95336C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52425204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBE0enLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52425204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJMMbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:31:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38627 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeJMMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:31:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id f29-v6so7166015pff.5;
        Fri, 12 Oct 2018 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c4g80DvyuudoX+LPD+xlMBYx8TzUWy649W9bh+/3Apk=;
        b=EBE0enLFfZS00Q4vrKlNiFa455XytYgOWZqS/oM4Ln9QGgwPT/7BO13cvxIOpS/czO
         jBq/WJJoqKV3FDKdOsuk2RKrPh+jn9AbcxrBExEQFwEmUYWtnFQzBNjFHGwMH2i9j4IH
         hgeVskYmNiL5O7ayDrweoVr0Jb5VkNBwJjzl3u6H1b1YmX1P5pfPs48SV8beLyvcj2ex
         ijwDIm7+ruP8bA/mMsmmuvhm8ci47KyEdW8pgrMw0nU1btPZ5u7hhl4ZK9qs2vRLHvsP
         /aJxslL8DLNitvpH45H/jpRAOpLsNufpKrsBMnxyLZfycpJ3s6vjTDZwNhCGz45bTq4L
         gJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c4g80DvyuudoX+LPD+xlMBYx8TzUWy649W9bh+/3Apk=;
        b=A+RnhOEEYLjSWxqufAQ3gpfGmxhdHtIp4pRdH8LQ5Xro98dMY6OYX8N7mJLCwQACyZ
         /3dV1MLrBCvvnFWL2YZi01OKpJmLPb/gSw/xpieA1dOP/gj2t5oF1RDdHdndIyCls1P+
         0+LMB86Hw4t0YwNgKRgqjt5cEBcKU/ENzb+z/mdo3JAESQWdnb5PHuXRL1vyCRdfZxiX
         ewms19ca3EvlBWjXVY+Fx+5RTst/7TlgS4Yx1kyqXXxSW7BEDIqi1D181YLdOISPKfpq
         DXAXN+0pTrW794Y57nUFFRCj1ORhS8/8ulCU+qcuVt1kARdmR1mEUBmyV2V07Q/xm4aX
         r3hQ==
X-Gm-Message-State: ABuFfoih6SAprG4bC8rfZPFIzdxECajB8Hg9F0kFN5ljNo4Xy7URch0c
        6vSgihJX5kcIuwNpeErHMXQ=
X-Google-Smtp-Source: ACcGV63+XntGfxxxUG3x6CDkSZ6opwjM9Ve/81S/R175COQs/W+AWHCB8Rw/XJ3wl4fLwlWDYNwnXA==
X-Received: by 2002:a65:528b:: with SMTP id y11-v6mr8134116pgp.269.1539406527279;
        Fri, 12 Oct 2018 21:55:27 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:26 -0700 (PDT)
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
Subject: [PATCH v2 18/18] of: unittest: initialize args before calling of_*parse_*()
Date:   Fri, 12 Oct 2018 21:53:38 -0700
Message-Id: <1539406418-18162-19-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since v1:
   - add same fix for of_parse_phandle_with_args()
   - add same fix for of_parse_phandle_with_args_map()

 drivers/of/unittest.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 785985bdbfa6..5f4db23e4752 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -375,6 +375,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	for (i = 0; i < 8; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_parse_phandle_with_args(np, "phandle-list",
 						"#phandle-cells", i, &args);
 
@@ -428,6 +429,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	}
 
 	/* Check for missing list property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-missing",
 					"#phandle-cells", 0, &args);
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
@@ -436,6 +438,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
 
 	/* Check for missing cells property */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list",
 					"#phandle-cells-missing", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -444,6 +447,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for bad phandle in list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-phandle",
 					"#phandle-cells", 0, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -452,6 +456,7 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for incorrectly formed argument list */
+	memset(&args, 0, sizeof(args));
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-args",
 					"#phandle-cells", 1, &args);
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
@@ -502,6 +507,7 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	for (i = 0; i < 8; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_parse_phandle_with_args_map(np, "phandle-list",
 						    "phandle", i, &args);
 
@@ -559,21 +565,25 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
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
@@ -780,7 +790,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		passed &= !rc;
@@ -801,7 +811,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
@@ -854,6 +864,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
 	for (i = 0; i < 7; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
-- 
Frank Rowand <frank.rowand@sony.com>

