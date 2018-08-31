Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA8EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B9120837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFJy8Xpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B9120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeHaSJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:09:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34560 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbeHaSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:09:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id j25-v6so3451637wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GvibLTos2iRsFWhqzFGfkbbHNao2ZWAAN5J5ThtpGnM=;
        b=WFJy8Xplyb9TbUqRLchk4ERo0o692kPTIDP52h/Dr0gZsDkfdiJ5q/ehxHJK7qCLkM
         49WYPO30QKmoibniH5Cp4ycGiDz8ajUq3RHCLXyu4LbnlQPfh9CPmAEgN9X9mXjV5MsR
         qahfN6x0LDEhtlfKJzUkYhln86LRDeFHibwO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GvibLTos2iRsFWhqzFGfkbbHNao2ZWAAN5J5ThtpGnM=;
        b=pdVQcUKvuMaTYJ5tZ+wncJJYVOcupr/CO3G8PcK4+cRMqwVgs84sEMOJfENOCfA7kr
         Kc/EToGLhy9bUg7VveUxUuDbqz9BPWGrKw2pW1H2oF9DSnbuWx/cxtJH1SK+K+YjLnfc
         j1zO+F1Zvdov/YkWNaVQtatT5Co327WfsGTbbLvR9CHjplUG8eaEr6DULpBt/v39RfrB
         /9jvVx7MltAUm3cq+ZqNqdmtNiQ/zEjIcrLVuFvfpZXEzfLWqRXpnKGVjNY44pY7+UmZ
         M2pXNQSk9IoZdawQFAOHtj3KrLEphNkmtkZj8NW0L/mrnTWxDEjIhDY6rOEEqR4v9BfE
         touA==
X-Gm-Message-State: APzg51CVye8rAfgI+L7Bhf0th/+f4K+NIsvme/mm3pH/axuygQ2FtQR9
        BXvFWVWGmJzPkJG+WmdYSxUbyQ==
X-Google-Smtp-Source: ANB0Vdb7Y56DpK1xHR89SAHKVlnJ35z1gRieRS9zyM+rYv1pZ/ONSvCjQZmGJDXekggx61XuwB9ToA==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr4850377wmo.60.1535724129807;
        Fri, 31 Aug 2018 07:02:09 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm8624513wmb.10.2018.08.31.07.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 07:02:08 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v9 8/8] MAINTAINERS: add a maintainer for the interconnect API
Date:   Fri, 31 Aug 2018 17:01:51 +0300
Message-Id: <20180831140151.13972-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831140151.13972-1-georgi.djakov@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..bdbab6a90c93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7578,6 +7578,16 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTERCONNECT API
+M:	Georgi Djakov <georgi.djakov@linaro.org>
+S:	Maintained
+F:	Documentation/interconnect/
+F:	Documentation/devicetree/bindings/interconnect/
+F:	drivers/interconnect/
+F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-provider.h
+F:	include/linux/interconnect.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
