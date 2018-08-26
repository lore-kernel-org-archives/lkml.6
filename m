Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530A42172A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAcHRhOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530A42172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbeH0CaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:30:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42428 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeH0CaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:30:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id r10-v6so9172129edp.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bxQpE1rYnIjd7LxEYMdqwS/Lh+BSuKS3XBBYHo66Q3U=;
        b=SAcHRhOKbI2ZTHLfHzWz8T6dPHh121DP+4xXvvN6H/VySYwRrPBeBHDXNE4+piEih8
         NC/oJtSxXUz8K11YghuHiWOe9QyXzPskVJYYNaPlS+LwXpYV8M79xmgZd8S5OY7rgZ5G
         ZZCsvW/9tsKX1eY1lb/pOWmQ7SWFcxYUzI489LTV9YSFnsqKu8B9l0X+t+P/UlFzQE4E
         d0ccevAHLt91FbqEBaMKpqBjf8Yw8t+3rPUk4bXTb5bz+wjJqKCI6qwncj6mTx7xR74l
         l9Y8QofsYRNqvTPfg6wK03BO5MJUzknnL7rcfofJhtt/ElN2eCtQqzsoc6mj8656SLyK
         Ap0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bxQpE1rYnIjd7LxEYMdqwS/Lh+BSuKS3XBBYHo66Q3U=;
        b=lgI6siiokPlq0MYL8wrMOt1yLnQSEjY4qjI9XrBpHDcl2XkzDxk1LM0/DPBiDj6jxB
         V3Jc7qG7iMinkI8vze9neoTa2lousrbgzWJxHjsKiuoDvv1W0n3n6ttnblBYTdnSFd7g
         mDoZWiu9FBXb4TDFp7oLoDmUBL12wpluG3Gei4cQ4+CscSK7iWcztbpJ3EL8H5KZxWHZ
         0gxyJz/q0lQOGOGxw1auZtet3gEYKWy1ONP6OlYZFzipuVjj05kxWuYtHRLyYmFlB9fV
         YemYY6SZ/E5WNyjR+enOHDM3V28aQvV5VQna8rYoN4nTwsNVZ7Mwxd6vm0YvlU2Blg6g
         d8gQ==
X-Gm-Message-State: APzg51Av3JuGqjoN/nnRTIH6YlWnp6LTjKeOvE1xXb1nnFmgqxNJ9nrv
        HL60t0eResBi1U+TnNSmW+k9e7/A
X-Google-Smtp-Source: ANB0VdbabrCMn89gE/qlO9wa/Qc6jaH95zWrSGqBtp3V1kKjb+GVcU5bFZ47En7KGX1OEkSSCepGAg==
X-Received: by 2002:a50:e249:: with SMTP id o9-v6mr14088651edl.253.1535323562996;
        Sun, 26 Aug 2018 15:46:02 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id a33-v6sm5519165eda.2.2018.08.26.15.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:46:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 6/6] staging:rtl8192u: Add SPDX-License-Identifier tag - Style
Date:   Sun, 26 Aug 2018 23:45:33 +0100
Message-Id: <20180826224533.16020-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826224533.16020-1-johnfwhitmore@gmail.com>
References: <20180826224533.16020-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing SPDX-License-Identifier tag to clear the checkpatch
issue. This is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.h b/drivers/staging/rtl8192u/r8190_rtl8256.h
index c943a367d9e4..9ea67f86f911 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.h
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *	 This is part of the rtl8180-sa2400 driver
  *	 released under the GPL (See file COPYING for details).
-- 
2.18.0

