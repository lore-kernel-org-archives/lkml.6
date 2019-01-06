Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09758C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF48320868
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="g3tEGNwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfAFR0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:26:35 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:42560 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAFR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:26:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id EDC25BF6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 17:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oB7Jy9cUHQvP for <linux-kernel@vger.kernel.org>;
        Sun,  6 Jan 2019 11:26:33 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id BAA98C00
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 11:26:33 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id m128so6360701itd.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gtFUsguOXXYG03CyZpLhVgn8XcYBG/mO0ybq+IcPfPs=;
        b=g3tEGNwEGyqiiB/xNzSZTpIHgjpPo4OqbIa8I9W4Rz4m+xVsxL8h53BmQhmECoR9Am
         Xbvzg7LznIhN2ozuwrnVF3xh7y+W6Yg9w6vZS2HTvvRGq8Zv04svbpQxgF9Hfv6yfgeb
         VO5wMoZ2eEGgb9jm4n1ISrJ9Ami8edvNAhvn3oxHe1wrgwWtErL6PlL1kZT0gAhEuwFp
         hIXEnjrB9HRF4RgDZ1pno1hiRHULqi/puJkIngVh5A8DhGiNaS1BVTHQxcJBRw+s9UEe
         +hd6z3nRKo3aCGmvQCrWqklnZXATbdOAU5PV6mohqhweSzCqa0F9jAwXXzWUXTND4dh7
         jSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gtFUsguOXXYG03CyZpLhVgn8XcYBG/mO0ybq+IcPfPs=;
        b=BkHKyZM6Z9Pz+Dbb/qdcvQ/tC9TyCfEAGYGQKwDl19dzQc0rJowArQ9KV29Sy12gf+
         tbIcp+ZjtnClCRjZMSFs79RUfAGrpf0m80UyI5K2ISql2DCPoY0PLZqcThkRbA4mo4jW
         JAG5WHghggOryiVTumYoyjXh/iJmotJdJdyxwutMaAKCHmtYmpq/fRALpLa4Gm7wMT/y
         ddwLd7K4Yzl0EMruffd9GptP1iUx78Skuw7rspFhsVIxJ/k92HObk89IkkAoeuJWu8yw
         Tdj0tSKGR7lt4UptqR5U0BjX7KWx9CZTZTsWMgKp86WvqsPZuRDADZgg7gbzavtY6z1z
         Xfgg==
X-Gm-Message-State: AJcUukdyiBEGR1mT6+31+tNiv5fFzTuvM9xd68Eu8jpbdjUNXTdH5otO
        KW53XwvRLOTWqHgn8FVvz04zmF1WXiR+9RdM7CIHTizG044ySnU0DHdADRNifV9/QeI3Hs856+k
        J4t3TXZh4QJfg6tbDHaaI6OR5MUzZ
X-Received: by 2002:a24:4d05:: with SMTP id l5mr5756462itb.147.1546795593328;
        Sun, 06 Jan 2019 09:26:33 -0800 (PST)
X-Google-Smtp-Source: ALg8bN48Rhpo0Ce2FdSBMWmFnXscSS6SNzTTaCIIP/Iy6RAZLKweETD4YC1RxSXPPavLu7et2u8KQw==
X-Received: by 2002:a24:4d05:: with SMTP id l5mr5756457itb.147.1546795593108;
        Sun, 06 Jan 2019 09:26:33 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id r9sm5852167iom.44.2019.01.06.09.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:26:32 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, Michael Buesch <m@bues.ch>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] hwrng: core: Fix missing check during driver release
Date:   Sun,  6 Jan 2019 11:26:12 -0600
Message-Id: <20190106172613.10913-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devres_release can return -ENOENT if the device is not freed. The fix
throws a warning consistent with other invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/char/hw_random/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 95be7228f327..1b05da40626a 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -578,7 +578,8 @@ EXPORT_SYMBOL_GPL(devm_hwrng_register);
 
 void devm_hwrng_unregister(struct device *dev, struct hwrng *rng)
 {
-	devres_release(dev, devm_hwrng_release, devm_hwrng_match, rng);
+	WARN_ON(devres_release(dev, devm_hwrng_release,
+				devm_hwrng_match, rng));
 }
 EXPORT_SYMBOL_GPL(devm_hwrng_unregister);
 
-- 
2.17.1

