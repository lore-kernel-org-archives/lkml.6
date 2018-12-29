Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B71C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 23:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC64620873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nu/dhb5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeL2W74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:59:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35329 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeL2W74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:59:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so10196735wmt.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 14:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=5N/f5vcaTmpjsSnk/k4m4xZpncotdflEREMHTZiJ5x0=;
        b=nu/dhb5nC/ZjdV5uybCZ0PWjLthtniw9F5iKTtfJR+mszMCkDwTRPy8ihdRFIsWxQ1
         9dgCsPYZyqooaiLuaLWCm6H5uH4BfgG9ie5yJnq3nrB4O62L5mtKLWejGutIeCeYNPXU
         TnREzvMn0OfYjhRfSOGk4xyl0QGVnYQnq5oGe80Ms2wgvRK07/3LwBUmGohDdIrT0GNd
         GQMYXDGiA1XxjmSzT6dcQZKb3qQfMx/cZ46TAhXeQCtcd/18JKOPF5zDZX9GM34YpzIZ
         jgoDNfpV3R4N1bqEi2h3sMG3KJd7hEvPL8Qu2ZShLg99zUN/P93v7oTkU1nyS0/AJNCW
         Pc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=5N/f5vcaTmpjsSnk/k4m4xZpncotdflEREMHTZiJ5x0=;
        b=Cx6u30/rE5dQhUentEhMM/C2ENrRJCKuYARK0WGfFZxQ/bLz5gLdwSBwaiqoNzIELn
         YuV+TZfSKksZi6GoKRSoSC7C2Kn5178v/bn/lVAvlOE9Kaum3JIBg9WD+4xojYiXEH+h
         c4+t810Xb3Sfl0Jgv1mxHSvZ0VMtJUqkekpJRe96xN7x0yxmRQUCfgZC0gd6NF4oc1UH
         ZGeqih4q0RZ2qdYxKKbzW99Y58hoNrNADxwzsHZ+6z6p7ExrwqGo6wCTppLwfSrDQRC5
         QIKDn6HqYL4pF3eFAk2NYUkRjW0VtCEKN/Sz+cd4WH8q+3Pe65T1r5maw7jXOP7w71Nx
         UdXg==
X-Gm-Message-State: AA+aEWZMzzzI1rNqLrnV/rZzUPi+kwYk4sZ/MqnZ65Nh6DSc7w6Zuz7G
        wqZnWp1w0u+xUoK/cpt11UYNGnuPPI8=
X-Google-Smtp-Source: AFSGD/UwoHlCDKEPTq1n+pT4Xfj7yOAX7MYA2lSVi+By+ecSi1Z0W4A1aWHlcrEPmUaVt3+HF4LkeA==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr26785393wma.91.1546124394138;
        Sat, 29 Dec 2018 14:59:54 -0800 (PST)
Received: from PhilosophyOfMe ([188.75.152.65])
        by smtp.gmail.com with ESMTPSA id h17sm33346187wrt.59.2018.12.29.14.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Dec 2018 14:59:53 -0800 (PST)
Date:   Sat, 29 Dec 2018 23:59:52 +0100
From:   Petr =?iso-8859-1?Q?Sedl=E1k?= <hugosedlak@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: vt6655: Fix camel case of variable
Message-ID: <20181229225952.GA8447@PhilosophyOfMe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace variable uDelayUnit with u_delay_unit. Issue found by
checkpatch.

Signed-off-by: Petr Sedlák <hugosedlak@gmail.com>
---
 drivers/staging/vt6655/upc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 61b3e568ff9a..384af225336a 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -42,15 +42,15 @@
 #define VNSvOutPortD(dwIOAddress, dwData) \
 	iowrite32((u32)(dwData), dwIOAddress)
 
-#define PCAvDelayByIO(uDelayUnit)				\
+#define PCAvDelayByIO(u_delay_unit)				\
 do {								\
 	unsigned char byData;					\
 	unsigned long ii;					\
 								\
-	if (uDelayUnit <= 50) {					\
-		udelay(uDelayUnit);				\
+	if (u_delay_unit <= 50) {					\
+		udelay(u_delay_unit);				\
 	} else {						\
-		for (ii = 0; ii < (uDelayUnit); ii++)		\
+		for (ii = 0; ii < (u_delay_unit); ii++)		\
 			byData = inb(0x61);			\
 	}							\
 } while (0)
-- 
2.17.1

