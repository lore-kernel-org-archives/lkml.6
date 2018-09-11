Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9147D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V7P4jhth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9147D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeIKUJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:09:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53322 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbeIKUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:09:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id b19-v6so1387691wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZPZEGbp7HHSQQCHt6FtGOwst0ToGi0wo91bOzTXYgs=;
        b=V7P4jhthk/JfKsoItKz9N4nAIIIiq//iKeAsN0oxjGj+WyhSfsqo2+C/rFgH9TD0pL
         b1Rq7j1kPOTztUo4BWpPl/j2383JHa4gZspafvUN46yciRrKrWmBce7sZyeEw2EwEgJc
         XHDMTzCeoHqjUwpqPLp9pLFHY9YiKUorXx1O2Nlfk+nCg2RkYTRzHOUN8U1TquYsqV04
         1OgmMduZ/kymLOEPQw29vRm/8uTmyQ6eQNnasd9eQV3Y7xjboTq8tdC0D1NXbqr863Gj
         Dq+VIk5TiRbjS8dsFUmt//yHh4hRnlvPNO51M5xP3b7QsB6un01q/o7LlVFmqczUXq/k
         GDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZPZEGbp7HHSQQCHt6FtGOwst0ToGi0wo91bOzTXYgs=;
        b=ma5vwfSwRJa0fSr8GKSsOZYrowGTqOhL6roZSSB+sLbCYy1h1877CLFXYfvkttIH95
         Oy+HbNc2ahjHQSaznEYDEsNcrZSiHS6nAQc906EqtByKWDG1kJ7wXTqj6vuM/p813N7R
         2gm3JyLqKzLZl4nu9L32/ZcxTNJ+jPUG2QdaTtE1eBXy3hFPc10iOFsoycPUA99+Nivz
         Pr0+eO1DYFX2CDPyv9zz9vWKXuLnhFF7q/L4DUZ/IE2BSWWWqYXQQyfzcAHWdW2bRQuj
         4xi4AH8jTcmqXslkebGqpCAxFPa7PWTZ2zdJRpR7e04QRsyHi2Dpt/gPBA3H+EeRN6no
         +YIw==
X-Gm-Message-State: APzg51AHQLqIOK7jeVUpQ4g/t8KZHbto2aaPjiu2Uf6+fmTmpHSoLwGV
        Jz66oCHnfkxkVXSd4gibqBvvjg==
X-Google-Smtp-Source: ANB0VdacCmsaDo7Mtznw5MR3VpXxAsDyoyaBQUtiQ4nW4BRkaADlvSFzoHUy2UEGFgrAlFOKAC0o6g==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr1558179wmd.69.1536678594544;
        Tue, 11 Sep 2018 08:09:54 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id x65-v6sm618625wmg.39.2018.09.11.08.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 08:09:53 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 3/3] MAINTAINERS: Add meson video decoder
Date:   Tue, 11 Sep 2018 17:09:38 +0200
Message-Id: <20180911150938.3844-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911150938.3844-1-mjourdan@baylibre.com>
References: <20180911150938.3844-1-mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the meson video decoder for amlogic SoCs.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c887..ee086fcff146 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9491,6 +9491,14 @@ F:	drivers/media/platform/meson/ao-cec.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
+MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
+M:	Maxime Jourdan <mjourdan@baylibre.com>
+L:	linux-media@lists.freedesktop.org
+L:	linux-amlogic@lists.infradead.org
+S:	Supported
+F:	drivers/media/platform/meson/vdec/
+T:	git git://linuxtv.org/media_tree.git
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
-- 
2.18.0

