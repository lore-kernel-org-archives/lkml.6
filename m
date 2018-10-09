Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC55C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A752150B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D65JMCY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A752150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJIVp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:45:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39512 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJIVp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:45:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so1884470edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OU6nvOBiKIrqrgu5oHrM9OiOA3cUW3XFg5GvQhU8YAI=;
        b=D65JMCY9JkOYNB/7paWG3Tz63GGFrlNjZiWW6rOYHzzNSo1i/a08nOspre7QFzqACP
         4D+uYtoR7csuUrhOFWmbA9YNZicubsDG629fBGVAjmMNvGK1sFDSyfBIXZrx4P+j2SHa
         s2UW+Zk54cKQUkkgm1i4+JBAUXpHPQoQrKAr10s2grKQpTqCBm+HbNhxUsLEWQ9J0Lrd
         4yMqv46fDaEJlKcyMx3Rlf40uKDNJr7KYpbOsWbAbwYYPTNPPITKcj9n6OK99VuyCsaT
         xQ+9mHy+LkpKRtgfJlLTkc6znYlwxMPyU0xBh9+E0qcX137SGfYIbu7xKb9vu/jMtwdo
         PGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OU6nvOBiKIrqrgu5oHrM9OiOA3cUW3XFg5GvQhU8YAI=;
        b=fi23a5LYHzyiYqHAPl3e9j+bLNXB0Hk8TuoZzBUOPjmZAzkHf0nIJxC91v4Q/qEcVQ
         TPZzhyuLtj/s978UlFX4gUkIkzKW2CpwOmjD3dJSwNbU6ca++I8IBtyrMDKRAvFr/2Bg
         Zy+zx0PTYvDV1MoJejlk6wFlt/W5IZNZMG5An6eao22fN8IZmhGd0xT7Fj0N8ALfgNqV
         86bmkTqnYuPgD53EMEvKn1LY8kYcSYcjHrhvtFJiKIrZtznrc2UkhPbfGkjyVZG0UYif
         Nk3Yi0g8a7YbkNnNC9ulDouHKLt0J00bbIi6NsI+0WUfkEWPhj1y3j5gZUHJHD1AUQQ9
         9TRw==
X-Gm-Message-State: ABuFfog0KrghWuUKZ6Q4zEB2KhOhzBantfWmRf2ieqPsSEhWaCJaRvoK
        3ETOTUVcr3Tbe6XPuwBQl+j3nZST0fM=
X-Google-Smtp-Source: ACcGV600ssnW/8MnKkyMaZII3ofdjDzlAwfmM2evgOsJpXBb4HkzJ93KX1tYex3h6Ea5SsjopLM4gg==
X-Received: by 2002:a50:9fed:: with SMTP id c100-v6mr34916106edf.77.1539095293192;
        Tue, 09 Oct 2018 07:28:13 -0700 (PDT)
Received: from jinpu-GA-870A-USB3.pb.local ([2001:1438:4010:254c:1e6f:65ff:fed4:d10])
        by smtp.googlemail.com with ESMTPSA id x18-v6sm4559005edd.50.2018.10.09.07.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 07:28:12 -0700 (PDT)
From:   Jack Wang <xjtuwjp@gmail.com>
X-Google-Original-From: Jack Wang <jinpuwang@gmail.com>
To:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        florian-ewald.mueller@profitbricks.com,
        linux-kernel@vger.kernel.org
Cc:     Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH] lib: memcmp optimization
Date:   Tue,  9 Oct 2018 16:28:11 +0200
Message-Id: <1539095291-9926-1-git-send-email-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian-Ewald Mueller <florian-ewald.mueller@profitbricks.com>

During testing, I have configured 128 md/raid1's and, while under
heavy IO, I started a check on each of them
(echo check > /sys/block/mdx/md/sync_action).

The CPU utilization went through the ceiling and when looking for
the cause (with 'perf top'). I've discovered that ~50% of the time
was spend in memcmp() called from process_checks().

With this patch applied, it drops to 4% - 10%.

Signed-off-by: Florian-Ewald Mueller <florian-ewald.mueller@profitbricks.com>
[jwang: reformat the commit message]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 lib/string.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 2c0900a5d51a..932ef9af2baa 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -852,7 +852,7 @@ EXPORT_SYMBOL(memmove);
  * @count: The size of the area.
  */
 #undef memcmp
-__visible int memcmp(const void *cs, const void *ct, size_t count)
+static inline int __memcmp(const void *cs, const void *ct, size_t count)
 {
 	const unsigned char *su1, *su2;
 	int res = 0;
@@ -862,6 +862,20 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
 			break;
 	return res;
 }
+__visible int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const uint64_t *l1p = cs;
+	const uint64_t *l2p = ct;
+
+	while (count >= sizeof(*l1p)) {
+		if (*l1p != *l2p)
+			return __memcmp(l1p, l2p, sizeof(*l1p));
+		count -= sizeof(*l1p);
+		++l1p;
+		++l2p;
+	}
+	return __memcmp(l1p, l2p, count);
+}
 EXPORT_SYMBOL(memcmp);
 #endif
 
-- 
2.7.4

