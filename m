Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6548EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298852171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DICXpjMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeLZRXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:23:50 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:42640 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeLZRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:23:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 3C2FB627
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 17:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FzZPmXaU6q4L for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 11:23:48 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 18358622
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 11:23:48 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id p66so19061804itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 09:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cKuAwCrMopKiPtBT4AB68pUeNWF03+YxAieToGNYJZk=;
        b=DICXpjMBv3HKQg5aiON1l1RELc/lBwgH0RnesIgqLh3yw44EA/E5oWoV/RzJvhcOhj
         gGI9ARjluDmy7scC/laPUctGI9QxHjUp6czJ/q+guFmyDnpO0ArB+QnSPqgJAihI+k3s
         y853nXjH0LjKBWdJ7+jIa0YoyQ7VzEGiPR9LEUI5d+5nuO4jmNyrvBggPoFJgmx/xbkc
         ZjaAARYljax6BgNZALE9nrJFwrSE7OHfagnqvRZZmlBTf0NaECo+M2v2Qr+Qdup8k/ct
         lauj6RGOUkzeNkokzY9zkWiLJoYUOPeXgxzAx6EHs4N2OOvTqmwc6LvkVw4rVez5FUUh
         /LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cKuAwCrMopKiPtBT4AB68pUeNWF03+YxAieToGNYJZk=;
        b=T271dDUS0l1LpH5nLofUSo7wJdAGmE+1NJvWSl0V/iv87AlCj1m5TkRtdQyCZuMWrQ
         22KwcWPmPBYoJYvKHkupngJJpbaNW9zTk3nP1TMGwbXnyAb3omCBfi2RC0icrSyX/sIq
         tFtoRXK7W4tfYB4r2h24wADR4gI+8wGM2kUP8ttVT34w9Y7AgAYs6Xh43ljg9CCJtB2Y
         7W6/vgMzne4niXxG4cwOAr2MxPWj870sKsZI5PhreOQFJ31/ePudsWd6wgTbTAErs0Hf
         BEBFa2uMxq1ES8Uu4TYDJO9SF62tLS9YYt1rHOgsAat5Ac5e/jRarOFEmTYlynImcjKm
         Rj6Q==
X-Gm-Message-State: AA+aEWZEvLS/CowjHp4/cbD/mxRm37aQhD4XHP/RfrNDKia5Uthv/OGs
        kqlOLxirkm8ovh78wWXktPikblFX4AtKO/fZyBQUYJgAK1NIOAIuyHBceYA6NP537l2whQVUy9V
        QhAZU30QHh6YrENPyPXna3BozdN8/
X-Received: by 2002:a05:660c:11c6:: with SMTP id p6mr12940019itm.75.1545845027518;
        Wed, 26 Dec 2018 09:23:47 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XEbFjjsUrxKczDxl6AkwFTbnbTTr7i6HuQ2UVkidJH7qTh+REk4kD8kWyeWQyo/pCYOq5a7g==
X-Received: by 2002:a05:660c:11c6:: with SMTP id p6mr12940007itm.75.1545845027284;
        Wed, 26 Dec 2018 09:23:47 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id w7sm8501958ita.29.2018.12.26.09.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 09:23:46 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Buesch <m@bues.ch>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] char: hw_random: Fix missing check during driver release
Date:   Wed, 26 Dec 2018 11:23:31 -0600
Message-Id: <20181226172332.6365-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devres_release can return -ENOENT if the device is not freed. The fix
throws a warning consistent with other invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/char/hw_random/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 95be7228f327..582d983fa93f 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -578,7 +578,11 @@ EXPORT_SYMBOL_GPL(devm_hwrng_register);
 
 void devm_hwrng_unregister(struct device *dev, struct hwrng *rng)
 {
-	devres_release(dev, devm_hwrng_release, devm_hwrng_match, rng);
+	int rc;
+
+	rc = devres_release(dev, devm_hwrng_release, devm_hwrng_match, rng);
+	if (rc)
+		WARN_ON(rc);
 }
 EXPORT_SYMBOL_GPL(devm_hwrng_unregister);
 
-- 
2.17.1

