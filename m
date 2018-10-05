Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B49C65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D602084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8OeIxic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D602084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeJELLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:11:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43723 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeJELLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:11:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id 80-v6so4121333pgh.10;
        Thu, 04 Oct 2018 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6rXTsHTXEu0ePfav46SJfn/0WRudrcKzA2MYy/8i5Ig=;
        b=M8OeIxicV23kcfKfRr40LQOmdI4hpD/+kDesn8YVAAjltVpo1dI3FqLGaJVHSc4uWP
         nLLrT4Yxi4gx5TPfxzY+4jEjp3pUaLZgD+5YX7BlbFYNwgLgyVjBVIpRkjv7qdJsBTan
         T2gLvI3hIj5EuP8VNsEIu4q4Atzy0mObD9NjJatbIDFI0dE8bTR1wtmVkfoF2+fSVPy4
         DWdA/3dmk+36dDH7kOkO+Z9/FcTo5ResY+lbPkfYrZnZ6Mur1c7ed/DHW03gjIvaR4w/
         dcYwN+3vTawpW4lC8VcH53+mmW53+S3MePTv6hMnhAmwJo1NJxVLozLDYKl7hQ5qhjbF
         hEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6rXTsHTXEu0ePfav46SJfn/0WRudrcKzA2MYy/8i5Ig=;
        b=URb7gfwz12t3FmVr1hCA5/VhhPsWYy/tibwT6rVwBkqQzK6cUd/CHNBgJN3cgaCpUQ
         Ovgutm1mOwcYvgmi+RyFYkZwkzvufzNdIanB3KUWGbfeW1NOYVrDyKrf3S7IN1Vzmlhu
         LYRqc40nLG+bdk96JGuhTgAkK0FvlDGsE+6RY/btTFssCEUC6pmaqCqr7azzxc6tSD7R
         HpyswRoWfAKYtLlu50WY5cXT2YA4o8nJQfUX+kS7oC79FjENmCeo9C3DSwo02HzPJb8z
         AJOq/GikeHfwazx7bAxbPgMqKMl39RHfjtOqrgEHBICiMGshJc/bVIC18FYiNB69PnkO
         9+UQ==
X-Gm-Message-State: ABuFfojG6s6KZQ+i2m1o9hOkcCvU+z25AjxtohgM6lCEENAeu0Au6pRH
        a5FnSg15jdaDrHGpNsQEbG4=
X-Google-Smtp-Source: ACcGV60l4DiJgSXgQsIpQlpzSGrx51ZqCYckt/Rte/iMrTnZBmL5KdiqoUETladn6nlZgQDe8/KQ6g==
X-Received: by 2002:a63:7506:: with SMTP id q6-v6mr8396282pgc.137.1538712870907;
        Thu, 04 Oct 2018 21:14:30 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 21:14:30 -0700 (PDT)
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
Subject: [PATCH 15/16] of: unittest: initialize args before calling of_irq_parse_one()
Date:   Thu,  4 Oct 2018 21:12:46 -0700
Message-Id: <1538712767-30394-16-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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
error and does not set args.np instead of trying to
dereference a random value.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 6d80f474c8f2..b61a33f30a56 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -780,7 +780,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		passed &= !rc;
@@ -801,7 +801,7 @@ static void __init of_unittest_parse_interrupts(void)
 	for (i = 0; i < 4; i++) {
 		bool passed = true;
 
-		args.args_count = 0;
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
@@ -854,6 +854,7 @@ static void __init of_unittest_parse_interrupts_extended(void)
 	for (i = 0; i < 7; i++) {
 		bool passed = true;
 
+		memset(&args, 0, sizeof(args));
 		rc = of_irq_parse_one(np, i, &args);
 
 		/* Test the values from tests-phandle.dtsi */
-- 
Frank Rowand <frank.rowand@sony.com>

