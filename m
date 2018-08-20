Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135A3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA8E2172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNaPTdwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA8E2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHUAzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:55:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38289 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:55:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id i7-v6so2441818lfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6W0P52EAcGilRXYojwcSyj8nFtjmU04fBIXHBvFHfj8=;
        b=aNaPTdwSfgHpB3QHrtYZJGHvfY64pgcoLVeKf02nN87S+Lcf+zW2pETX9WWdsUzNG8
         orYrl8gCHgU2DuKDseW0pxGlDFABE4+uYgi/Ch08x0bYGLHoFbWRvS+sdZ/+iTF4L8Ns
         XKEAAHabtJ3OFt31GKY89Wd8syEkqcnMusNua/W+vh8Bb5zpy2IhhJPRPMy722mxr70l
         kFIMOX5nMvUwri8N1l4oZqlKD3F0lblwBrj3hrMgjZj4aU+fO5pmCIeOy+ckLwzhyji8
         LN+4Oi6kzftelf/s5a0CUZBEL1yCQAfjgIYv+HQX0V/DoWLvd23SY3AVGCPWYpO5VTmY
         swxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6W0P52EAcGilRXYojwcSyj8nFtjmU04fBIXHBvFHfj8=;
        b=QCCSTwtKE7wlX++achNaoaOIb1ClYZesXXUK7vZ9Yx+ukU2klSdRFnpmoJdTGe8+by
         1+dke/NC8c1aoNPuKm7ZtiZGAHq7FKPxAfNt96JK4uoqU0xf6j4qKHVjRtSNb83ayJ4E
         M9NtxWiqz1w0KmL7SjijWt1N2bs8BxAu7dRj+epy2RHehVJl3EchN405fO0607fBWczB
         bf1xtuIWM2RCpPdQgzDmnO6BO1rOrMJuGWxboprqTR0W1UXSEwb05zQqHRUN0IEJ+LiL
         CHFaqtLkfc5gum1jxgeVvf8sg7HDhBSL5pVUNLNZd6yb/WlpKtGfGy46b+MSbvl3YHyZ
         zNWQ==
X-Gm-Message-State: AOUpUlGtytwjOOtqWnyOY4+BnN7UJ4Q3Jp7IUXRI/9ftWwO8B2411K5X
        MeWqwzuZKvHAi+jHuQW3vFI=
X-Google-Smtp-Source: AA+uWPzANS4LO8tS0geGMj7Vyvesb8UU52Nf2flMSyNS4mP3Ds1uGVSW23UkYJbWzUmq58cPlrn/2Q==
X-Received: by 2002:a19:cd8c:: with SMTP id d134-v6mr26646542lfg.41.1534801098871;
        Mon, 20 Aug 2018 14:38:18 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o72-v6sm1417868lfg.31.2018.08.20.14.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 14:38:18 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4 1/3] mtd: rawnand: ams-delta: show parent device in sysfs
Date:   Mon, 20 Aug 2018 23:39:02 +0200
Message-Id: <20180820213904.13475-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820213904.13475-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820213904.13475-1-jmkrzyszt@gmail.com>
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

