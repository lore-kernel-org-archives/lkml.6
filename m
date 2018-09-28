Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5F2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uRxtcM+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E5F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeI1Uxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:53:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbeI1Uxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:53:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10-v6so6660428wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLz4uUOwRIUo103Q6/07eaxO9t0VzdKnduNZO6uFKMk=;
        b=uRxtcM+BUKPJNqLdijOS1EL6dKBmdgcTO4N82ZAMKJ4ExqrCDpi7xyNHkbrRmF31e4
         Z4TR8Tg+z1zaiQkDdSuYz4becnIFw6kQgLAGXjp4rGoVuYXSwg97502VklULWE03TKJ+
         cY/YEaZ3SubYOBfrFQBL4Pyn1wGIhWx252D14OZL9wVtNe6CbcA30pmlaycEziVy+zzy
         Cd0GTtKg+cu6u2wRuMfgMDGwvJ9pc+xBt88yLJQ5lK0Cf6RSTwNSfwL5uM5fRQ+nxyKa
         ciHv8zwTqv3i56IjkRWDcK6Zg83BdG3YXc4+FcNiv98MsqPsIG60GIG/yAtAIYeHZ/2w
         YHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLz4uUOwRIUo103Q6/07eaxO9t0VzdKnduNZO6uFKMk=;
        b=ZNOmP7d6Ic/7WITfk1dR37yWV/LRqguru7T9yp6BJ4BucIZa6ram6Y/UdCTocoFMuy
         wmyl2QqwKyOwok59S+Lw41uN0nYdGu0NoarXwzQ39GMZMYqa/aSMpYOgw3ggqo1+PltM
         w6oiYfZTXWucPHBtnJjsSziyNmyTdsUZDPhKiE1W4qFlyJojc5LI/JN/pPzLFoBOKNR3
         sV62aE+Ll4wzpKydNVHUbqb5sueJmNTMsIebNc4jW4Mz2vbyO04vQq+EhJbS+YTO6f0N
         e2Pry8fjWogizw497dz5cvoac7jEZr61zCAlDldZ2nZD21VOCFWl7jPdbBkrt/nlu8QV
         iazw==
X-Gm-Message-State: ABuFfoi9ku1LVQs/ICYh5DgnFTRz6sgBx5vWlH5C2CeibjJJkrlf+WVR
        cKHFCONarQ7GYUQZkhZdQC3F7w==
X-Google-Smtp-Source: ACcGV60pMifj2tfuIglnH3NR7X/vVKcyr37fVfBXaKUu+lPEsa42cKGjHPZ8jg4sTMgP3bCDSqi3cg==
X-Received: by 2002:a5d:5501:: with SMTP id b1-v6mr13142892wrv.228.1538144972080;
        Fri, 28 Sep 2018 07:29:32 -0700 (PDT)
Received: from localhost.localdomain (ip-123.net-89-3-157.rev.numericable.fr. [89.3.157.123])
        by smtp.gmail.com with ESMTPSA id w72-v6sm6827477wrc.52.2018.09.28.07.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:29:31 -0700 (PDT)
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
Subject: [PATCH v3 3/3] MAINTAINERS: Add meson video decoder
Date:   Fri, 28 Sep 2018 16:28:16 +0200
Message-Id: <20180928142816.4311-4-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928142816.4311-1-mjourdan@baylibre.com>
References: <20180928142816.4311-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 4ece30f15777..93689a6d95d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9507,6 +9507,14 @@ F:	drivers/media/platform/meson/ao-cec.c
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
2.19.0

