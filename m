Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E46CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCF82177B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="csF9Jj/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLYT5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 14:57:10 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57398 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeLYT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 14:57:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id D1CBBB1C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ncfx8giN13IU for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 13:57:08 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id A5A899EB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:57:08 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id p21so16797322itb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 11:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4j9+iKNJ8s8Atk43E6W22afZdFKgiCQCrarKCTLLx2U=;
        b=csF9Jj/7OOUwV4hj5i7DaPXTnR2vtYi1mwCZIslMfU7d0KheTkWjLgEhopTmfF1M1K
         y9dmwZqHn/xRuZ6ku4F7Ww0xTPgKl3bn1vRm91zmYSR1L1Rx7byYprwJfRGS1LsvQtp0
         Y6O+c2I77j/FgQxcg8j/kgG4eI2cqurZQNj1kcfMhcQgqYsBQObiCKhzvmvHhpbqu9x9
         jIGiriUBsCGHYWpt6/7GyspFQbLnDN+FVuJziPlGO6C0toNf2Yu9DjnkyZnOMnLyByGa
         U5cTBN1Kh1jM0NHcuw2XCQ3hpZrJcGM6lGT7aEps4GK6bWoNXuQmXcuNYRxxRU+5EBbl
         rcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4j9+iKNJ8s8Atk43E6W22afZdFKgiCQCrarKCTLLx2U=;
        b=GnfqsggPYXrhbP8ug9mUx+ffohEYY56vokpJXEFw2CeHkDU033h1TG97S1WuR1lGny
         KTtEccZr8kGhvh86T3UWWvgzZ04w+x1E32nCIEB8IDGIuPT7CBzpXKmImgy9Uv2qLiW9
         IaH7EqIMP11Wh/J34FHdu2EjG0nJJpjIm7B9DLqQ2FgXu0roI9uy1rk0HmwlbEiiI/9U
         gaJn5n9a/1WTCR6W9U8PouS/Z/2oYRi7j2QR1WI0HOJT4NS3sPVov+pnXDvXXYTJEUkv
         xq8/AQFjVCeVgReiviUDV1wVIFmcDsV9hKvsYfkJVGj7w0WlkRgR9E7yEz0hrKgqtwn+
         Ylug==
X-Gm-Message-State: AJcUukdJxcDuQx4O3He9qWyyhQk+p9rrX58AB5RK1yAWsgB6rRASDrHd
        tv5+O4KppANkUmdKP/Ekw1s/BGBygG0nDMmuZ5URZL4cDeTBAZa9UTV2/B7NkYi7F7s0SzL7C48
        Ibpo0MRJnsd04MZZAGZ4te4Lzgzsg
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr9776636iok.144.1545767827793;
        Tue, 25 Dec 2018 11:57:07 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7vluLCp7C7vcRQxK+NcD0t1sWSsJOm8Qq1TE6IIG4dScS+etAMbNphm/TDaM+we8iSFRKXTA==
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr9776625iok.144.1545767827556;
        Tue, 25 Dec 2018 11:57:07 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id d128sm16530360iof.37.2018.12.25.11.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 11:57:06 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwtracing: stm: avoid a double-fetch case when fetching policy id
Date:   Tue, 25 Dec 2018 13:56:37 -0600
Message-Id: <20181225195637.69304-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"size" is fetched from user space and security checked. The fix avoids
fetching it again. Since "size" is no longer used after the second
fetch in the current code, so let's just skip copying "size" in the
second fetch.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hwtracing/stm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 93ce3aa740a9..55df1d374c57 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -752,7 +752,8 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	if (!id)
 		return -ENOMEM;
 
-	if (copy_from_user(id, arg, size)) {
+	if (copy_from_user(id + sizeof(size),
+				arg + sizeof(size), size - sizeof(size))) {
 		ret = -EFAULT;
 		goto err_free;
 	}
-- 
2.17.2 (Apple Git-113)

