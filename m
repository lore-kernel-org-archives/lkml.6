Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BC7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1742A21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/zpQUee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbeLUH26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:28:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43342 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbeLUH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:28:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so2174651pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gLncRQDqHmxUdhFTr2RsS7etXwotl+OVbY0VpVjusw=;
        b=R/zpQUeeXzqYonVs+MZC8e2Ypat9sAihgBNDUiu/bPz5l2/DNzZUSu1m0y+dXYIsF9
         bcGfK57b4V9324uh+mq5fRzqH3SlTK9WLNmRDRzQb3d6NGm+aqIOHn3ybgJxfv0HxZql
         kevwGQ/PuegYHPpjF6TtpaRcP6fAH6VrNDxAxnsffnoVeGx8/tx1OCBr3Y6jG5WI+ZWh
         ZaUN3Fcj1ErgPQpAFM8Rl+B/Fms5szsfSFHz6NWa9/6f4fMY6j78TuHQUogHZxOssiP1
         JcNjr+CJuh7aj22ctWtDysjKfMnqgPvwwlH4nhGaoxCnxRmz0iopu+sytq0nVD5lEmjm
         /SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gLncRQDqHmxUdhFTr2RsS7etXwotl+OVbY0VpVjusw=;
        b=j1E8fWTwxUFz/3kpKgkL1Jfi6zhrE2D9w7eoXJR+UTGnG4H0gKeHaPhMQcGz22eZ2k
         KFRDjhKjw/gg7q9fMHFL7p0KhUV+YyvAd6en3ym0OueGl1SfqJCQUVM3E2yYOEHZbHJm
         gi0InHMliI3gLVhVKfUHppyeS7l+ZsyVXJttVltAASiexV1SElx9F72fQbbZImhuT5q5
         We3gB4/8KqvXa2j8iecxBIXX+VOzCfcTblc+caAPdbsfn5LiNDZjOvpoxHfFwg+0+hPb
         +MJjPntN/HBGXMo2aA+EelF17dYdoyQQcYpCLYbCp9GVzg3cb99QyzeVBBouJ74j3tMN
         5wOg==
X-Gm-Message-State: AJcUukdwa9F9VGYUHOQZW5D8YzrV2OhLO7cyV2zDa015kutd3lWJs7mB
        o/qmyQNddErPvhsfQf6wR8ADZEHo
X-Google-Smtp-Source: ALg8bN7k2Eo74pzj8QFvHCpgw+0OyRjRAwNZwzqtY1XN3JindWMzEInBnG10VkGiwSlFsD/Kpm7xzg==
X-Received: by 2002:a63:d547:: with SMTP id v7mr1308741pgi.339.1545377332158;
        Thu, 20 Dec 2018 23:28:52 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f20sm27688275pfn.177.2018.12.20.23.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:28:51 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/5] ihex: Share code between ihex_validate_fw() and ihex_next_binrec()
Date:   Thu, 20 Dec 2018 23:28:37 -0800
Message-Id: <20181221072841.30199-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221072841.30199-1-andrew.smirnov@gmail.com>
References: <20181221072841.30199-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert both ihex_validate_fw() and ihex_next_binrec() to use a helper
function to calculate next record offest. This way we only have one
place implementing next record offset calculation logic. No functional
change intended.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 include/linux/ihex.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/ihex.h b/include/linux/ihex.h
index 75c194391869..9c701521176b 100644
--- a/include/linux/ihex.h
+++ b/include/linux/ihex.h
@@ -23,29 +23,34 @@ struct ihex_binrec {
 
 /* Find the next record, taking into account the 4-byte alignment */
 static inline const struct ihex_binrec *
-ihex_next_binrec(const struct ihex_binrec *rec)
+__ihex_next_binrec(const struct ihex_binrec *rec)
 {
 	int next = ((be16_to_cpu(rec->len) + 5) & ~3) - 2;
 	rec = (void *)&rec->data[next];
 
+	return rec;
+}
+
+static inline const struct ihex_binrec *
+ihex_next_binrec(const struct ihex_binrec *rec)
+{
+	rec = __ihex_next_binrec(rec);
+
 	return be16_to_cpu(rec->len) ? rec : NULL;
 }
 
 /* Check that ihex_next_binrec() won't take us off the end of the image... */
 static inline int ihex_validate_fw(const struct firmware *fw)
 {
-	const struct ihex_binrec *rec;
-	size_t ofs = 0;
+	const struct ihex_binrec *end, *rec;
 
-	while (ofs <= fw->size - sizeof(*rec)) {
-		rec = (void *)&fw->data[ofs];
+	rec = (const void *)fw->data;
+	end = (const void *)&fw->data[fw->size - sizeof(*end)];
 
+	for (; rec <= end; rec = __ihex_next_binrec(rec)) {
 		/* Zero length marks end of records */
 		if (!be16_to_cpu(rec->len))
 			return 0;
-
-		/* Point to next record... */
-		ofs += (sizeof(*rec) + be16_to_cpu(rec->len) + 3) & ~3;
 	}
 	return -EINVAL;
 }
-- 
2.19.1

