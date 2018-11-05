Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F53C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1E22081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPK0Ev+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1E22081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeKFAoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:44:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36159 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeKFAoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:44:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id j22-v6so4597253pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K19uD4tTmktdTCNiVUetW7j3oZO9kDRsfskAsJj93Mo=;
        b=RPK0Ev+tRxhCY1SwiRjzFrbKWLQZOzn5WQ5A//LFwZ458Qz4YlVjfL/O4Ivwi/1GGy
         VqnexWSyurG/5ypy782zNsVxBxcH4azofdY/WX5UASDL1K168tAlZ/qiD21r/gByNWmK
         toMU2tukqxBd0WFQiwegb4dHU9YHKd8zLCOvZfn+36MNfaimkTtaSefsUYwBEvbEA6Ge
         wfnfpVozgKBBexOoeftcbV2WTK3QDLS4IHJrA46i58j00ceZZH4qjic6qaKAlaqqWmU3
         oazapn7FQZtg/c2cT16uE2OYNDbi5dLqBcDLaktDoPVNcfPhOnhTo4yNEv8UIh3tOg7w
         uZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K19uD4tTmktdTCNiVUetW7j3oZO9kDRsfskAsJj93Mo=;
        b=o1MZJRc7rSOnULdm6VaRA3shOi4ebVCoUre/PC+OU0E+2v6dWikPBK/HQ9r538JINx
         AnP2DVleQuQ0eYFo5upUK8hYilPlgHh7anrT/RGUuwJSQhDFDm+TPjFJkykssjWNQHxg
         QI72w+x5exMNwsz+8B4/G1F6rmiCqIPwFB0fp0b8t0TuMb3IUa5zNLkNMpeyvdOWctvr
         GMN7ABGgXJJWTjg0cKhNCOzIU0NHO7hQlZMnEoO9JpGeMnfGSzYRa/+69yo6SEKSG5hu
         gGqOzKODBjZX/qcERxqXqhegWbdthRxsXrcKGFw0Pd6QhgN6eGSvroAN+3u6wnFTevF3
         9/4g==
X-Gm-Message-State: AGRZ1gLEPzNjwuiyRcUC0Q5OgTpOGlf5gUwmHZ4bbTEJNE6cUa65spFT
        Te0DZFKeuzzVuJczG9PzxMw=
X-Google-Smtp-Source: AJdET5fnsHKAYwOYIXvryjaq3Z666dmMhgx0TA+nTkkuc706IyMZwaM9NyjW51ND12qJZKbAV4mYbw==
X-Received: by 2002:a62:6a88:: with SMTP id f130-v6mr7173889pfc.98.1541431443033;
        Mon, 05 Nov 2018 07:24:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 5-v6sm8136549pfg.141.2018.11.05.07.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 07:24:01 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] staging: vt6655: fix small typo
Date:   Mon,  5 Nov 2018 10:23:58 -0500
Message-Id: <20181105152358.6695-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling mistakes of "Calculate"

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v2:
-add changelog
---
 drivers/staging/vt6655/baseband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index f0b163473426..b5ba0c76fb43 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -13,7 +13,7 @@
  *
  * Functions:
  *      BBuGetFrameTime        - Calculate data frame transmitting time
- *      BBvCaculateParameter   - Caculate PhyLength, PhyService and Phy Signal
+ *      BBvCalculateParameter   - Calculate PhyLength, PhyService and Phy Signal
  *                               parameter for baseband Tx
  *      BBbReadEmbedded         - Embedded read baseband register via MAC
  *      BBbWriteEmbedded        - Embedded write baseband register via MAC
-- 
2.17.0

