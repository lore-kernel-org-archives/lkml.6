Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFC5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3E4214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DfYlp8MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfAIIOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:14:38 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:41536 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfAIIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:14:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 834B19A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 08:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XVnvRY1_UKzn for <linux-kernel@vger.kernel.org>;
        Wed,  9 Jan 2019 02:14:36 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 5074F9AE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 02:14:36 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id p66so5607935itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 00:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fNt8Kff9m4HsbyBSVFbFoOGUz6h/lhoF4IEozS1nTcM=;
        b=DfYlp8MH7xl3/9asZeC5mUBQn8YXRPZvJJ+mxLdWl3iL9TFUNIP7YyCFNvzQom4jJ4
         QdABfXs3E68EbN+JePlZx+u46JPAKkcB3EgIOKs+yCaIcnKm3WugiK1/yXpdNrxiQrUk
         VDw3SysBdsxwzPjxib4vmv6ulR/df8YKgJ0LmDBK4/prATiH2Gsw7u7o/LQgsDzMAFpB
         hLz8mt6BCXX0Fu55Ju5Ai6GR/16W6rHux1tVhe2an9bxJ05ejAhVeH5IcBZ6dwvRKx/5
         RAoOiUZjKK/WDkpAqyL/ez3QwJf8wVXYKzEHLrgzfsQCcfzwoVWA9LiKDORW/vW2Smc8
         jOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fNt8Kff9m4HsbyBSVFbFoOGUz6h/lhoF4IEozS1nTcM=;
        b=ArMG2D4TU504dxMH5RwLY0vZ3l7YoC2LW/W3ELfvs2XmLck7vLOjw/ooPIirmBEZkT
         MdIJi9X/NQ+8Ss04H2wJQMroMAG8U2lUfrCe99dQhrmdRY7GiwUluXB0QCGjsr66nfAz
         /gQHfoUZrsXfrRjSfQnJeHNj3XH70sUlk5dTgOHNvoD6AViAPdlYUvI+KcGk8lQHFVIZ
         JZq24BR/oI0EXJUqGqeeiiik0fot/fvdf54TtWRph+Nek+iKloS5rYkDywnmBxU3KUxP
         IDMFoKY5LUwULX12dpwZT3o2k/VCPWtCVohlGRHMd1WBI4AtfMPNYYLWCOSH3ET21Hsm
         qGIA==
X-Gm-Message-State: AJcUukc6ZFxoXYeVppT+3ojtm6Wy7pXezlEYIaGktJu+LUDXR4bILS0l
        jhYTZPgkwab9cepbNn6gf8jxDUrzSmbw7SkDTGOBtC8/g0mHPJxMNP6ESDkeEBrVC+3ITCwpAX+
        XR/HHEUkia8RlWp8F6kMIIeaq5P9G
X-Received: by 2002:a6b:7e04:: with SMTP id i4mr3006341iom.116.1547021675901;
        Wed, 09 Jan 2019 00:14:35 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6Kr2Wiv+2RRTqsYkYfmPTX+Hjc3jAXtmi09OltBWY7PS+Gxl+PCoXBZ8R6SUrw95Ft+SC8UA==
X-Received: by 2002:a6b:7e04:: with SMTP id i4mr3006333iom.116.1547021675586;
        Wed, 09 Jan 2019 00:14:35 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id m81sm6599109itb.43.2019.01.09.00.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 00:14:34 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] acpi: fix a potential inconsistency caused by double-fetch
Date:   Wed,  9 Jan 2019 02:14:23 -0600
Message-Id: <20190109081423.10781-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181225214633.69973-1-kjlu@umn.edu>
References: <20181225214633.69973-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"user_buf->length" is in user space, and copied in twice. The second
copy is after it passes the security check. If a user program races to
change user_buf->length in user space, the data fetched in the second
copy may invalidate the security check. The fix avoids the double-fetch
issue by using the value passing the security check.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/acpi/custom_method.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index 4451877f83b6..f10ee0519033 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -26,17 +26,16 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	static u32 max_size;
 	static u32 uncopied_bytes;
 
-	struct acpi_table_header table;
 	acpi_status status;
 
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
 		if (count <= sizeof(struct acpi_table_header))
 			return -EINVAL;
-		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
+		if (get_user(max_size,
+					&((struct acpi_table_header *)user_buf)->length))
 			return -EFAULT;
-		uncopied_bytes = max_size = table.length;
+		uncopied_bytes = max_size;
 		buf = kzalloc(max_size, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -57,6 +56,9 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		return -EFAULT;
 	}
 
+	/* Ensure table length is not changed in the second copy */
+	((struct acpi_table_header *)(buf + (*ppos)))->length = max_size;
+
 	uncopied_bytes -= count;
 	*ppos += count;
 
-- 
2.17.1

