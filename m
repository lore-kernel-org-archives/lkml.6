Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1573C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6B72183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG/dyuIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfBTFSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35440 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBTFSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:07 -0500
Received: by mail-it1-f195.google.com with SMTP id v72so12693233itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dIFDPsRmcDCgf01ZB/CIIbIBAcGiuy//y2DGhlh4s4U=;
        b=BG/dyuIyZI3G0FBxTAevqHU+81N3dWrY8GaY8KvGJ/rImA9gpdbwkVR4qn4T1c/bHY
         gYCQSZusWk6lt3iZql8kF5eu8jbJLcUDrFgIw1A+MhAJ3D+epoytg9dcPwYmDzthWGIU
         us/X/3jeUJ+wL5bJGIy0+O6MXBJWwjEHC06ikBvIjKcP1WOsaY9AQU9CNQXy9MYdRSJI
         ZH/RUzfI9fOoOzrQ09X/+UiNTswvpAJqLZrBeTNphc7IGGelxbzgpbp2ctvR2V5LCIZl
         B8YdAFpFp0HwWx2PcbgfVgXDN/9gpxIataN0/9acDYBN5AqyAKRuPhRMBOsHBxQXINNg
         c+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIFDPsRmcDCgf01ZB/CIIbIBAcGiuy//y2DGhlh4s4U=;
        b=oT5jYEiPE7EuHRp4OzlYRcVNJhK6oF8zWxsoBBXGuMPy3Fs0zNa61uMa5yfLhzaD+X
         hHAZvmSTqdHPybRQswtpHbEyo+eq36QWlXavLfahvv0ONwBC1JLs2J+nOLWnCs4rg9Nv
         xfY6fRg5AwWU8kXckysQ6uMuhpFTNW1KpS3/70kVcrRiBuS4Ikwm/bZmwqXCGQSRlz1O
         a997KO0286itjUlQFlfPjHWFpDy+X3aAkUfEPluhNdpPwqIPJ/8qIfEcD37A14fqry1m
         2xRRpkUhJHZVkq5rpN06arNJAxltdr+te5uJc9qMLgqIq0BImh3dx0JcJAZJe00oP3M1
         dhug==
X-Gm-Message-State: AHQUAua5q8WU4YQvxCAxdSTcciCsQzp9A3ej9yZOr6fLmhqLiLFeqIEF
        BJtGG6Jv8qwvL/R7HkZOK4M=
X-Google-Smtp-Source: AHgI3IZLbxubofcV9Fi/V3Ht7WsSW7LyCzbOMrerjlMIC73GQLUX321PUQpq2BILx0Y06lBIBf+FPg==
X-Received: by 2002:a5e:da4a:: with SMTP id o10mr18015674iop.226.1550639886879;
        Tue, 19 Feb 2019 21:18:06 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:06 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 01/10] staging: mt7621-mmc: fix unused variable compiler warning
Date:   Tue, 19 Feb 2019 22:17:45 -0700
Message-Id: <20190220051754.12195-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler complains:

    drivers/staging/mt7621-mmc/dbg.c: In function ‘msdc_debug_proc_write’:
    drivers/staging/mt7621-mmc/dbg.c:237:12: warning: unused variable ‘size’ [-Wunused-variable]
      int mode, size;
                ^~~~
    drivers/staging/mt7621-mmc/dbg.c:237:6: warning: unused variable ‘mode’ [-Wunused-variable]
      int mode, size;
          ^~~~

Remove these declarations.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index c7c091fa1da0..69b38c7e3179 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -233,7 +233,6 @@ static ssize_t msdc_debug_proc_write(struct file *file,
 
 	int cmd, p1, p2;
 	int id, zone;
-	int mode, size;
 
 	if (count == 0)
 		return -1;
-- 
2.20.1

