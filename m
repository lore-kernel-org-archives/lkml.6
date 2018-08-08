Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DEE2168B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmyPj7zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DEE2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeHHCrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:47:12 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45270 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHHCrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:47:12 -0400
Received: by mail-qt0-f195.google.com with SMTP id y5-v6so526211qti.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jdzoqHVAJ1x84A1hTLM0GokNLGoHRhiC67MF1dQ0wZM=;
        b=OmyPj7zmxnekhkFTYt7vfjoY7axKQb6FfYxQkgM4KQX6+34J3jMIsz1ChpSBeziZNV
         +NSKmkQDc4cxWMAd9uxQ1PeWYy9ym12PAXJtbfebZuAcPsqyO/cZ5gmSiCvmxOQhlPlh
         pFgDnMvnE8jxA9pef1KzC7oap96KSjywfUs967nz/TO1x5QR851AWHezb3f9LX4Temmd
         qlvX6UkIGWUEMzctiYGp4a3NyE2ORv+nnWmXVzDAgBZAWLfqqmUJEnmfNRiKbEChQNnn
         tyfidSLcstO2APJK0V/wjHPpcAnhkIr53MuWJeLJsiARnXIFmx6fjgsqXYnM/ARnzX85
         uXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jdzoqHVAJ1x84A1hTLM0GokNLGoHRhiC67MF1dQ0wZM=;
        b=CFEpJO0bZWYU3fb6QVIUavyM0aUlsamaf9R56J2sPaUTp0Kumk99fqazxdlniKjiKn
         BRClHTBENZotMFBflRhhbbqolmyR4GvXiyDN100BXLLBK0IIVis13vUnRQZU0gWtfTJD
         dMndBL/n1pjm8iwfHBn1cm+/7TRbexh/che4BPSdXteRhAkq8uK81sNFK53sFQENM0Dm
         fUelOV+IcRalj6sKza+rZGuTWNgNcLNI0gqRy+kCMapvVG5ef3KyinAKhqrNKwlCtUOt
         MYVbKRjLruC/prnVdNvnlIMXGyzLiAlU8TrXQJTSld1rkvne7c6bsrkZsQLzFr3+RPgK
         UxaQ==
X-Gm-Message-State: AOUpUlH3l1hCavem3Gvw9FKsMSuxlamCqtocfuMv+pbspy3ISGndI97P
        Zj4t0xiNYX3ocoirqR33Mdw=
X-Google-Smtp-Source: AA+uWPzVzZBURF5WyRWAp8Mp7wmWTbCKCMkF0Vupfxm1WndJp/SXpvMuLDGZGBGysHdQLAstC7EJkA==
X-Received: by 2002:a0c:c18f:: with SMTP id n15-v6mr568057qvh.209.1533688214170;
        Tue, 07 Aug 2018 17:30:14 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id m13-v6sm1278586qtn.54.2018.08.07.17.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:30:13 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:30:10 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] staging: fbtft: Replaces custom debug macro with
 dev_dbg().
Message-ID: <8de0b9b85209f4b4a3c8f0f84188a0ee0964bf44.1533686201.git.leobras.c@gmail.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes custom macro to dev_dbg to avoid parameter multiple usage and use of typeof().

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 2b2988d2f73e..0699c164b0d4 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -407,22 +407,15 @@ module_exit(fbtft_driver_module_exit)
 #define DEBUG_REQUEST_GPIOS_MATCH	BIT(30)
 #define DEBUG_VERIFY_GPIOS		BIT(31)
 
-#define fbtft_init_dbg(dev, format, arg...)                  \
-do {                                                         \
-	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
-		dev_info(dev, format, ##arg);                \
-} while (0)
+#define fbtft_init_dbg(dev, format, arg...)				\
+	dev_dbg(dev, format, ##arg)
 
-#define fbtft_par_dbg(level, par, format, arg...)            \
-do {                                                         \
-	if (unlikely(par->debug & level))                    \
-		dev_info(par->info->device, format, ##arg);  \
-} while (0)
+#define fbtft_par_dbg(level, par, format, arg...)			\
+	dev_dbg(par->info->device, format, ##arg)
 
 #define fbtft_par_dbg_hex(level, par, dev, type, buf, num, format, arg...) \
 do {                                                                       \
-	if (unlikely((par)->debug & (level)))                                  \
+	if (unlikely((par)->debug & (level)))                              \
 		fbtft_dbg_hex(dev, sizeof(type), buf,\
 			      (num) * sizeof(type), format, ##arg); \
 } while (0)
-- 
2.18.0

