Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8281BC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AFF21709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqimPGdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AFF21709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeHNBSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:18:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46683 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbeHNBSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:18:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so13811329ljj.13;
        Mon, 13 Aug 2018 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6W0P52EAcGilRXYojwcSyj8nFtjmU04fBIXHBvFHfj8=;
        b=aqimPGdZuTLxFndzYNxVd24jETvtQP0QpScjaW9Uc42FCJOmSHSe0PI/Dr3YDYPCl8
         UBpwjJnvPc8TCcRz4PcjSB49e692GAcO0pEVywiCg/cVfFhQc9ePv2RA+o8cN+sZzB+M
         tNN7TNcwau2t8PKxd3obXARgwWCNkfNPtL5ywDheJLdt5T2AlN5tOrzv31QpwzJkq6ut
         +4kItkLrUpvMOUd6NHlWmI9fcE3TrSbqwMFUXSqEi0MW8inEKPErpDT0Kkl7Vb07XhDL
         DkfJzISV+rNB663Adl9RtjdBByORfeKc+MTfGU02f+3eo7HtYrXXFzSRUwiZWbLvm9jY
         LfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6W0P52EAcGilRXYojwcSyj8nFtjmU04fBIXHBvFHfj8=;
        b=gzhwskPlO9eczvC/9pVyHQlY8FlVnHqtyunlTj+tS3k7QtjKbSHZRZogDw+b114lF4
         wZAvy7dI4RX6gG4bpqeThe57e7gLi1RuLB9p6bNENfcQceWOAjY/MWY6JbzoChVaZolI
         oi80ch2A+PNQ+0NOng90dXyq53vMT73g7DLqKCm3ODYEAYIn6KB9Cus0OwZIxzaEIo+B
         owaWtlrcVwNu4BR9X21ZBzFSjGzoBxvQgmmX8gIrsxSHUIt/i38dE1tMCk7Bzp4tzAOl
         6cpe8egacVgQ+x3LZHs/igH6d6Wi37Yl9xvAOmrlhYd6HFtxPyI1w8cfj0IpPzCdHD/f
         tiqQ==
X-Gm-Message-State: AOUpUlEKpsTdLRkFNr4DdZySj1lmJP16f6H8XIbYDej9OVHgrXvflWIc
        rzLo+QsQO1bxsC7e0J4rC7eWGKiF1GuUTA==
X-Google-Smtp-Source: AA+uWPzKLXtTdBazwq8WvAiVwUMDvBBsq+GPbp5/rtLb1cBD2xJ1s42rL3Q0MgsaIh2l0kGQjBccAA==
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr8208272ljk.111.1534199678368;
        Mon, 13 Aug 2018 15:34:38 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f136-v6sm3572702lfe.71.2018.08.13.15.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:34:37 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 1/7] mtd: rawnand: ams-delta: show parent device in sysfs
Date:   Tue, 14 Aug 2018 00:34:42 +0200
Message-Id: <20180813223448.21316-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where parent device symlinks aren't shown in sysfs.

While at it, make use of the default owner set by mtdcore.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 2a8872ebd14a..af313c620264 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -162,7 +162,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	}
 
 	ams_delta_mtd = nand_to_mtd(this);
-	ams_delta_mtd->owner = THIS_MODULE;
+	ams_delta_mtd->dev.parent = &pdev->dev;
 
 	/*
 	 * Don't try to request the memory region from here,
-- 
2.16.4

