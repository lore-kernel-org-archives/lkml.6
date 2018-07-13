Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EF720882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny7DbnTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EF720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeGOJPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:15:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34539 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeGOJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:15:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so6395146pgv.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 01:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jXGkI3EamuP3pm4Rp0/7ObfckUP6X067r4qG5nb9lYM=;
        b=Ny7DbnTKOvSTExlKmSdL3Lh0o5535GIdXAcWKgq/TJHYy4XWRCPtTGf5iggTXomuU4
         Wy8WbXEEwBUSpytwNYUDb9OA4j8hYPzgY2u+sTUbTjNBnxJHmnBDANG0C2DRMguduCfE
         IiPp1il0VRwU+JsDf3yqf7pWbTpJfa+/LjhuSyGb5saTjtA10/y1BUVSpndh2YTkH3Bp
         /M1fK4cpshe8IHGJOTvs1+ZsL5VCsqPjjCN5gAIfA+jSSn89kZANqbwr6HHHgG4Z+pEb
         x5moImIqYQwW+6NBFeXlNf4ryEmLZ401N5JjfNf9X4QydYtpZ3FzNAoHAQyGqxjM6LkU
         HMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jXGkI3EamuP3pm4Rp0/7ObfckUP6X067r4qG5nb9lYM=;
        b=GcmoenMMy32QMMDI3rzVwh4SpTIvvqwbjBhJH9XR0ZDn4CviUtmHv+aSwIZ2UPogCK
         uJexwCoyUQ6DhFyY8O8GAgba93AUWiNU+jfnQl5jLZvmLmsmqRG7M3gxs/VDHQBFSdbw
         29AxUn2Yt8trMyllsolCPkCTUxmHLshg3OSypeHvkZ7LtCl/va8Yy12YfwknhlnD+TLI
         t3denvXTnhK5/1p2AIJOUzro9naWUjd+GgUAYu+XCRz9AZVgm5omUvQg4JLj1KNMa6kX
         3ZTK65TyI9/H2FNnqMfNMa4cOA3b34czOo0aSSdaP5XJPvUp8jBzXnsU5czuCm41p2aK
         egPQ==
X-Gm-Message-State: AOUpUlF07eKc6TPDZH0RE/d3DVcYFYY99xofpMBUeHaLq1qwkQhzcmtV
        NE0Fv3hstyNqyZ3E7/s/gZA=
X-Google-Smtp-Source: AAOMgpdCFAS6IQzJSvceOeu0DlXtmVxRQOzuDSifZ9oRc2QetvZ03BdH7tJwGnmTRS2wXQGgqCVEJw==
X-Received: by 2002:a62:4083:: with SMTP id f3-v6mr13668109pfd.229.1531644776947;
        Sun, 15 Jul 2018 01:52:56 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.14])
        by smtp.gmail.com with ESMTPSA id j21-v6sm44007494pfn.121.2018.07.15.01.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 01:52:56 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de
Subject: [PATCH] ks7010_sdio:Fix checkpatch out of memory warning
Date:   Fri, 13 Jul 2018 21:36:36 +0530
Message-Id: <20180713160636.8017-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Patch fixes checkpatch warning "Possible unnecessary 'out of memory'
	message"

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a11ee1c..972b01a0257d 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -957,10 +957,8 @@ static int send_stop_request(struct sdio_func *func)
 	card = sdio_get_drvdata(func);
 
 	pp = kzalloc(hif_align_size(sizeof(*pp)), GFP_KERNEL);
-	if (!pp) {
-		netdev_err(card->priv->net_dev, "allocate memory failed..\n");
+	if (!pp)
 		return -ENOMEM;
-	}
 
 	size = sizeof(*pp) - sizeof(pp->header.size);
 	pp->header.size = cpu_to_le16((uint16_t)size);
-- 
2.17.1

