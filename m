Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DEDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897B820865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAxVygbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897B820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeKYBUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:20:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44626 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeKYBUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:20:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4172865pgr.11;
        Sat, 24 Nov 2018 06:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dfGYDhIxmZXj+z9Cb6ZJNMC6IRjQk31/2AEmBLRy+gk=;
        b=jAxVygbBJ7V/VPJXj5U01zR4tHxg2636wUnIkawKC/hxPYd6uw1yiH8Rv6WkOWH2ZM
         FblGaM+74aA+EmMP+fYV2rUNtImCmz3mUXTp+I5eRKkBIiwG+IASp1IIruUp5DYpMHMt
         EX4XNBHkb8gA8kU9oW2XcuW9ppsALnWikzvvKQC0ho/INB7UBCNA/ixGb9TpbeLtMoWZ
         +pMHfJWn/rGBE5RsrFdP4OnHZzZUbaXLjbNPB/20gy/KGwhJc9RaY5W5DIh2UnW50pVp
         W+h+of+ivpHvX7f0hdVc0wKHkmP+45VytYqAeQrdDN5OckFjvlv+afEKq6St6lm2cHpA
         A0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dfGYDhIxmZXj+z9Cb6ZJNMC6IRjQk31/2AEmBLRy+gk=;
        b=ZtxwC8kjgRJdkmJ/RnfH8loZIBm1/MkZLjlfZ9erLSLQvTEIm9JZNka7D0dyFZNJAW
         DqJlJCG6na5UKto4oQg/zJqnCqxwYVCL8dYMaBQ/lKayPZKcC0oEiNSVaW3rowOoWOMw
         Ua/kWoUJ7Qxgu6TtymseOGiDXXri7crAKXU2fTXjCkI7KkXdusZ7xpbm5HfrzrfinJb8
         z16vqv0PLue/z42khpNRK8iUZqApPvSG5k8gVcgj/IL2D29kU9j9ZI+4yfI3WjufRT+u
         mgxKDHtaBTaSKAERuRom33StxVbNn4jw1YmRHcW60sqNDKFHOFHlwpFiArKSmLCtkp0F
         hrQw==
X-Gm-Message-State: AA+aEWZYnp1m0YMdQ6oMs6JYtCtnSiH4uXJi9dlgOEkA6uHsSVJijfAI
        nkHQ6yNV2W5N68H4X6+/LTk=
X-Google-Smtp-Source: AFSGD/VCpJzTireQKkTYh74RlAlqeQ44ooDy8uARZgYX6f17Z8DHqvvASE+50obsLwM6U1rUpDaKOw==
X-Received: by 2002:a63:5455:: with SMTP id e21mr18254365pgm.316.1543069901213;
        Sat, 24 Nov 2018 06:31:41 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x3sm40945689pgk.18.2018.11.24.06.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 06:31:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh@kernel.org, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] power/reset: axxia: Convert to using %pOFn instead of device_node.name
Date:   Sat, 24 Nov 2018 09:31:38 -0500
Message-Id: <20181124143138.28999-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/power/reset/axxia-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/axxia-reset.c
index 4e4cd1c8fe50..b16013265142 100644
--- a/drivers/power/reset/axxia-reset.c
+++ b/drivers/power/reset/axxia-reset.c
@@ -65,7 +65,7 @@ static int axxia_reset_probe(struct platform_device *pdev)
 
 	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
 	if (IS_ERR(syscon)) {
-		pr_err("%s: syscon lookup failed\n", dev->of_node->name);
+		pr_err("%pOFn: syscon lookup failed\n", dev->of_node);
 		return PTR_ERR(syscon);
 	}
 
-- 
2.17.0

