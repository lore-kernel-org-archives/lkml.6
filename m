Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD702C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993EE20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbgBvjPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993EE20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLAELH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:11:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41079 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeLAELG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:11:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so2748897pgh.8;
        Fri, 30 Nov 2018 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FWzhM03uYnHiq2nu1Eky14sF5M9A3gH3fnQ+8xdoFqg=;
        b=pbgBvjPWPdl1DxK7DRs04FcqUTGNT4T3J9FyVbokxS5D4EpOeQGjr013CVd6pi+sWX
         i5JQCaVZk4KxnGjWTIGfFeazvDGcERx8xDZQomn6TtejNDOGeYpNbaOMGEcfgkDiNezG
         KtNg43LNkkimq6uqUjxocSKZFuO+H2JM0Om9UDZbgyKbouryawvYJdMoHHOBT6/wtGh7
         NwWdreEaTvIZFManA7A5QsN795PkKbtaDVCJ+tQ58DgG/sDWpC+gfOangH4bJ4gB+6mL
         roKcV3Sk3OxtfCnoluQnOS2edTv9Qgclq6dxc5NLIK/twPQzdfIWf5FbTjokSAAr7lrE
         KxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FWzhM03uYnHiq2nu1Eky14sF5M9A3gH3fnQ+8xdoFqg=;
        b=As8Siqb8U9UFo2f62G2IWFotSGOtx9rln9YPH8B/aWAk4j/P5r9uNuATfQWWus4M7c
         zkmsZf5Hezye3Mq7FOZKQ25XdDqplnEHqJpBl0dQ/pyEvpEXWiHibSR8BIcb5vYfHjZv
         yZ9/q52tQ5/NKr83NgEmCmGlaeFkKobx0OLRO3BPK4J8OqL6iJgeuo4gA5QDe/WHqFQh
         HQbaMC66sUjku11gD2Bo1TmZ7rHcXGsB9cqNzA7Q+MBJX4hWxNYh6jlMx40wLn2FRIak
         Qyzk9sbtqRHVsjesWC3zIL1WkPaXqBqiCZRBbR3PDvpRkdlIT2XgmHcjelwKGcH175xR
         eGlA==
X-Gm-Message-State: AA+aEWajljw40YfU3jeFAZFqB8y6TTRpZgNf8TDtmSB7nBeFYIWkZcCM
        qgw8pGcsb7bBRb+qYFPsFQg=
X-Google-Smtp-Source: AFSGD/UnOrZcd8G8+Ya+kGp/W1PslEfwn+ZyG8Hg56BZdgVzCeIJfPp9xN5GdySKaCV9vMtRu18b+g==
X-Received: by 2002:a62:3305:: with SMTP id z5mr6485766pfz.112.1543597270563;
        Fri, 30 Nov 2018 09:01:10 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v70sm9556025pfa.152.2018.11.30.09.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:01:09 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ACPI, APEI, EINJ: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 30 Nov 2018 12:01:06 -0500
Message-Id: <20181130170106.4031-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/acpi/apei/einj.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index b38737c83a24..fcccbfdbdd1a 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -607,17 +607,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int available_error_type_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, available_error_type_show, NULL);
-}
-
-static const struct file_operations available_error_type_fops = {
-	.open		= available_error_type_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
 static int error_type_get(void *data, u64 *val)
 {
-- 
2.17.0

