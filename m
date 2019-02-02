Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF8C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4761A2086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFnZnquK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfBBPfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:35:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44475 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfBBPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:35:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so1492711plq.11;
        Sat, 02 Feb 2019 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i+8jI5pZ3mphWIKTKaKwmvYw0NYZKkQsYYXgMN1f3D0=;
        b=fFnZnquKbJ5/vUdTlXydU0q2tt/8yg8hvBgOCYbOHU4MetixW+PcJQooYYVlgyrWj+
         xC3hA8jt/Pwq3LBUEfcK5m0BQR7O3tBSl4T3zRo3nMXurlizxi19Qx6cJ2f4s1QtwJhf
         +Az2oa4kiQzrB9GNbhnQERMI/G+wnc1XWc0fXxwRvIAoEgCyci4V6DIdBXW0WYfGbNr0
         JQHmPKDhmB0hFcqV/vl5LI8D9ESOd7ws7ebQp3D4hOBXR8QASq3K7TRgOFCOOJ1T9IUZ
         2McD/41gw+j6Zr1VYlPd6Yro6RlYBGVD0dDrBYIzq5SRDX7tBoWMynI38Y2ondoWIH7y
         NPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i+8jI5pZ3mphWIKTKaKwmvYw0NYZKkQsYYXgMN1f3D0=;
        b=Psn4kQPfUomvEygMipNXe3BKcHjAY9S01Tn3odF8ije+zHDIHJLsVoj6KMH53QxQfy
         QDjbF23rAnqPHQB2zJK8K/Kmh3yiqQ0dagwee5ZuAyWjxBPehMapcbx3zAmaaBRMb5BW
         if42DIq2fGfkAih/XYqYacxhlDZY2Q/Ge2RzIDWtVHtTXt7rGhVMkvvJJt/JN6uL+j2K
         Bp9ynkNUzsI7W9IP3Jx/PFeH20c6wl/ur6gLgSLHfWn8O04SMH6I7+WgpynbNmi67iGE
         s62cW/4kIi5xzCulUCHwfiIbOiGSu2ULzN9LukOJUNZfYDflnjs15BqOeRLciCnfvedG
         pXjg==
X-Gm-Message-State: AJcUukdCGJM7ZafnE5WkGyKcuPJH1D0IqziTYJgGGwviafmE4L62WTZX
        ixKvkokr/NIsB4sES4U2Cjfp8SSoNaw=
X-Google-Smtp-Source: ALg8bN4pXIinoa+sh5hHDF+zMnhUmqbPgSrE1sLJG85MeRWifda4QAIZ0kvZIVaDr3oFqFelQa1RkA==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr45937501plb.125.1549121719283;
        Sat, 02 Feb 2019 07:35:19 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:35:18 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next v5 01/12] selftests: add missing include unistd
Date:   Sat,  2 Feb 2019 07:34:43 -0800
Message-Id: <20190202153454.7121-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling rxtimestamp.c generates error messages due to
non-existing declaration for write() library call.

Add missing unistd.h include to provide the declaration and
silence the error.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/networking/timestamping/rxtimestamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/networking/timestamping/rxtimestamp.c b/tools/testing/selftests/networking/timestamping/rxtimestamp.c
index dd4162fc0419..6dee9e636a95 100644
--- a/tools/testing/selftests/networking/timestamping/rxtimestamp.c
+++ b/tools/testing/selftests/networking/timestamping/rxtimestamp.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 
 #include <sys/time.h>
 #include <sys/socket.h>
-- 
2.17.1

