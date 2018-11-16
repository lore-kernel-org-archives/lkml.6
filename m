Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4289C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF462086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWhO7j8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF462086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbeKQJD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:03:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41644 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:03:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so908219plm.8;
        Fri, 16 Nov 2018 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=xa7mMwilfARzNlzgBshZrLuLhTmZAU6FLzH06agvJF0=;
        b=pWhO7j8lshrUTTsoIXqfiRcfWRcVjYemY6CB23DWYNUKul6JwjHPxhhzYxOFZHWvDq
         UWBKEC+EW5Bo8gtX7UCzxrhJz5G2TUaslN1GcXjJ1XlxQK6NcdZvtJoJ6uNpb+bA1yFq
         M1QgnN6QV35bz8unapINX//xRiq8w2KytXjlpaxG7/fjt64yNuDtMXqlPdOBja5naxGA
         j3Dt+0rty+GRUgb/x4k6AQosJTAuyLTW98G2XIOdpq7Dk8DhYdr+fdo9oDUCceWjkqLJ
         KUg+hHdyjlTcjKJwHCMXMrL1mX7rIvkCWENNrZ03foY1oxztbMbPu9Ki25D+7ho3wN90
         366g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=xa7mMwilfARzNlzgBshZrLuLhTmZAU6FLzH06agvJF0=;
        b=NQYtpSoYcVL+5KLezL56qGu/3NkGmifBcuIbaeaTpXNeO0cRz/pXfZNflNVOVX//pZ
         l4J3Ve7yZY9WODEFpOAyhM3lRIdnUpZ8lJHAiLseNDt9aOXKnsyiKVmwWIeGwIkxuCfl
         Qb3cg9pxDlKD94E8VvPA7+oYe8gJOs3kG6LZiBcoBdrFNuc2nX8qoqMPBorHcIpJQgfQ
         XwzRWY/UkZ0cEXvLerO25kPuQGbVufU/j5uSWtBPh0NqPDHFyDo51ZBounD8/CHqhi4+
         Dib776OKwF1Opb+q9Fs97pMwrB/R+yxH0AxhmmCmGKselwcj2V8ONZ1Pqgiuj8QaD/+8
         iDXg==
X-Gm-Message-State: AGRZ1gK0bU7dWqzmsNvkaS+jKC/yxOdhZhBz3di86/vNf1GHiNW+pRE5
        pVn8DFUK6TdWXlmkl7BQAhY=
X-Google-Smtp-Source: AJdET5eRT/xt0lA0riteQjBPIZFI9UpvfR1OOE3qpm4zOVqrJ9rSAgI/j+HihLKsaybwpIahHc/dsw==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13-v6mr12936705plr.74.1542408553213;
        Fri, 16 Nov 2018 14:49:13 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id 27-v6sm45417607pfm.36.2018.11.16.14.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:49:12 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] Staging: iio: adt7316: Set the data field
Date:   Sat, 17 Nov 2018 04:19:07 +0530
Message-Id: <20181116224907.24376-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adt7316_i2c_read function nowhere sets the data field.
It is necessary to have an appropriate value for it.
Hence, assign the value stored in 'ret' variable to data field.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index f66dd3ebbab1..856bcfa60c6c 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -35,6 +35,8 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
 		return ret;
 	}
 
+	*data = ret;
+
 	return 0;
 }
 
-- 
2.17.1

