Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0857C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A266208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPieJrv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A266208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeH0WLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:49 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40710 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:48 -0400
Received: by mail-pf1-f202.google.com with SMTP id p22-v6so10267166pfj.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QycuV7Z0qoxdNV4ujiT/ksDFrQ4kyTqiiyI9/nuk1hk=;
        b=aPieJrv2+CwsqMMOqmR+PBgiKjfuY1P3izBZyZYYxuLnCb3G76tgbNTuHx8pDFl24K
         jnSQ+k2EBv8qbsbq2EsXAxFn6TVt9NSc9PVPqAF4Bf+DlF1nQV4uJg9kmkknEqclIlnU
         UI0u6YaagL3wJC9mxOYcJ7AGBlPh7OaceUB6vTpuJlj6CDFyFOfGg8a4SsTWNXtBZctv
         BTAWKYsQqp8wGfe5YwnV1tqxCoEZ8XU1R4BRhMvMWhikMwzIOA56AfUrsE8qypb7xNAD
         1/N7v+tAnb+iylTbRr/t7KhBUK4A7i/zTdKc+pk1A/lrTX54dkLEzMzBUjaWK5oxgMa1
         TZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QycuV7Z0qoxdNV4ujiT/ksDFrQ4kyTqiiyI9/nuk1hk=;
        b=dcHCHJm53WPoaXGyM3yp+sLmgzV5I9SoF2OxmWL4I3WAaa5B0lnPxx2f7S+wIVhZYC
         I3U4n5VVTCCiX9cgZlgVCpZOIAXYCaLpkmmS4PxlQxdp49mR2zK74fYDstzm2zYkaS9T
         KaEJcnE0kgGLbX242yz4I/69iaAdTikybh5bCF7XFc+ZrsVOThcJ1Dgm7F3e4friX9yo
         D6apWazmlhobNoVaE1n7QkuFI6SUANK6hHPaF50ZlC0oz15VHEECW/8g1+bhgfIscBGy
         TgLvwpM7qgGSOQp9Zbe40wur9W/KaFmrQA/9X97nWabA4WrtLhMJEAVsFlIlAjhhVHVB
         DONg==
X-Gm-Message-State: APzg51ASbpxFn2RB1cTN7t8qzBrSJGZls+Rftubx5KzvGr26VKZk1vs9
        bDO9jNNGzclG7+6LEPsv9wl5AfNG
X-Google-Smtp-Source: ANB0VdYqDpkrXlbAKZZUtaaFqt5ImKRJ4mptw+EcZzUd1nRyz/vGszImPIxArL7eN/Dnd2J2Ghq+/LUB
X-Received: by 2002:a65:655a:: with SMTP id a26-v6mr3317875pgw.15.1535394246564;
 Mon, 27 Aug 2018 11:24:06 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:06 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-11-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 11/20] platform: goldfish: pipe: Replace two code blocks with
 a function call
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Two function calls look cleaner because the function introduces
takes case of all bit shifting and casting.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 3d28a9be5722..e3c09ff7867a 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -776,6 +776,14 @@ static struct miscdevice goldfish_pipe_miscdev = {
 	.fops = &goldfish_pipe_fops,
 };
 
+static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
+{
+	const unsigned long paddr = __pa(addr);
+
+	writel(upper_32_bits(paddr), porth);
+	writel(lower_32_bits(paddr), portl);
+}
+
 static int goldfish_pipe_device_init(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
@@ -816,22 +824,17 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 	}
 
 	/* Send the buffer addresses to the host */
-	{
-		u64 paddr = __pa(&dev->buffers->signalled_pipe_buffers);
-
-		writel((u32)(unsigned long)(paddr >> 32),
-			dev->base + PIPE_REG_SIGNAL_BUFFER_HIGH);
-		writel((u32)(unsigned long)paddr,
-			dev->base + PIPE_REG_SIGNAL_BUFFER);
-		writel((u32)MAX_SIGNALLED_PIPES,
-			dev->base + PIPE_REG_SIGNAL_BUFFER_COUNT);
-
-		paddr = __pa(&dev->buffers->open_command_params);
-		writel((u32)(unsigned long)(paddr >> 32),
-			dev->base + PIPE_REG_OPEN_BUFFER_HIGH);
-		writel((u32)(unsigned long)paddr,
-			dev->base + PIPE_REG_OPEN_BUFFER);
-	}
+	write_pa_addr(&dev->buffers->signalled_pipe_buffers,
+		      dev->base + PIPE_REG_SIGNAL_BUFFER,
+		      dev->base + PIPE_REG_SIGNAL_BUFFER_HIGH);
+
+	writel((u32)MAX_SIGNALLED_PIPES,
+	       dev->base + PIPE_REG_SIGNAL_BUFFER_COUNT);
+
+	write_pa_addr(&dev->buffers->open_command_params,
+		      dev->base + PIPE_REG_OPEN_BUFFER,
+		      dev->base + PIPE_REG_OPEN_BUFFER_HIGH);
+
 	return 0;
 }
 
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

