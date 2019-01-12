Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E597A2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dqFFOt0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfALFcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 00:32:55 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:54812 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfALFcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 00:32:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 17942DB8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 05:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HHKB-1aRUI1O for <linux-kernel@vger.kernel.org>;
        Fri, 11 Jan 2019 23:32:52 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E1154DB1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 23:32:52 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id o205so3587081itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 21:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MqUYBfZHq5DIii1EHKfXy06HQTMznE4WGCEMyyzi+HA=;
        b=dqFFOt0L7+eQGjVAvluf1lA+QkXkFS+N+jr5bpwAiBRsbmyBV9Ufbhs1LePuWwExLF
         5MNTaIlwAft6dONB1NSwV3UXuqCy7CGRnrPW4nF0UuztPWgH1C4vNA6L60SIVuviOjJn
         b1e4mMdpGXHN0vYdaMGnCOC9zE+khstx9JtWYxQJlMOwLtP6IQPKt2DNZPwAfh4aWUl4
         8GAQgCpd3FqwyEZJrpJ1IjZl3vDK/43k6srvuxhcvObEB+W1nHBWNq/kwvuUQIszMcfC
         GOAC8I4EXhJ73ziHCsTIt7EjOhuJupAIUJ3L5MJi1RaX8CK6siMzw24ciXbRy+fi+GaJ
         cp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MqUYBfZHq5DIii1EHKfXy06HQTMznE4WGCEMyyzi+HA=;
        b=UNLxbPh4Bq08tgJi3M7/1mTmkc4jPPnLbBYGGrPazxpqTjawij2TwvhkWtaqLL4Y85
         ZYlKw8M9U7vwEDyeocRWCzcSE+T/pYyYnosR1VPgUmqgKCNiW6HrwtE3U5GdMAE27WZ3
         d7JlrV/vjvFmDioiS69LwQnXQGTjD1ut46n7EpQdTOn/riADHj5LrjotEGL578D5iafA
         V6ziVixxKESDl18vAxrNNlUlEY5+9jzKQiRSlkme8jtolfJ+fieoSHhXrSXx4mFvl2Ad
         CAqvNpq2gyPYr1sphrwey/TCw4pxto1VmEXjXks5EhZidhx6574JHKYaYgbKhzxVorgB
         uKJA==
X-Gm-Message-State: AJcUukex2kmOFnj4nsGG9R+VP91sbh3g5GbwgDYlGNYYpMfqrRm7tUVb
        DuKnZNUmkAOW+4kh7NnQlep0Hq0US1n6dmB+s3H9E83fsTUSfPDAcU9TrDy4lFlniUS5wSxLlOD
        JXW7RIcf8tiTJTliIp3Q/C/SYx7Ft
X-Received: by 2002:a6b:cc07:: with SMTP id c7mr10578609iog.136.1547271172491;
        Fri, 11 Jan 2019 21:32:52 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5LJUXIvqhT3gqSck75EfMV3sy9WIBji8nDuf7BFPqQXMSYd4LjO7/u40YbmKI0y7iH4X4PNw==
X-Received: by 2002:a6b:cc07:: with SMTP id c7mr10578597iog.136.1547271172193;
        Fri, 11 Jan 2019 21:32:52 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id p19sm1956524itp.13.2019.01.11.21.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 21:32:51 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] target: fix a missing check of match_int
Date:   Fri, 11 Jan 2019 23:31:59 -0600
Message-Id: <20190112053159.99406-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <5C38F72B.5000203@redhat.com>
References: <5C38F72B.5000203@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When match_int fails, "arg" is left uninitialized and may contain random
value, thus should not be used.
The fix checks if match_int fails, and if so, returns its error code.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/target/target_core_rd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
index a6e8106abd6f..3b7657b2f2f1 100644
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -559,6 +559,7 @@ static ssize_t rd_set_configfs_dev_params(struct se_device *dev,
 	char *orig, *ptr, *opts;
 	substring_t args[MAX_OPT_ARGS];
 	int arg, token;
+	int ret;
 
 	opts = kstrdup(page, GFP_KERNEL);
 	if (!opts)
@@ -573,14 +574,24 @@ static ssize_t rd_set_configfs_dev_params(struct se_device *dev,
 		token = match_token(ptr, tokens, args);
 		switch (token) {
 		case Opt_rd_pages:
-			match_int(args, &arg);
+			ret = match_int(args, &arg);
+			if (ret) {
+				kfree(orig);
+				return ret;
+			}
+
 			rd_dev->rd_page_count = arg;
 			pr_debug("RAMDISK: Referencing Page"
 				" Count: %u\n", rd_dev->rd_page_count);
 			rd_dev->rd_flags |= RDF_HAS_PAGE_COUNT;
 			break;
 		case Opt_rd_nullio:
-			match_int(args, &arg);
+			ret = match_int(args, &arg);
+			if (ret) {
+				kfree(orig);
+				return ret;
+			}
+
 			if (arg != 1)
 				break;
 
-- 
2.17.2 (Apple Git-113)

