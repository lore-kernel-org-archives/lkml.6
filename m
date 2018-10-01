Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E4FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415442084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw54o+Vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415442084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJAKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:46:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51973 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeJAKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:46:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id y25-v6so7207740wmi.1;
        Sun, 30 Sep 2018 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxvxRhzBSW3OpIu6fxiyxSczFpWCTdYpSZ94St748CQ=;
        b=Dw54o+VzJzS4O/QqHhZIOJ6Qe3UNw8NgrQbRACzMGu1y6a+UcPE61cHG6D0zwy04W2
         jkCuCdwu7ZqoD5XDmjHD0BN04Z+1CSR0LTX8lX80uv9W/jJnjGtf1Burb7TZrUzx8UVq
         z2pHNC27ANwHJUmcbjlPRy3yN6YeIB8roZBhhSccLPWrrYbtTQ8eYh+a2HCs4PKfoSnU
         egK61IXE7aw1rKNUkctyqDIywlK60EpeeIAzGbnbqMrLvAoXqYzltfgkXUDLWTbz+4MZ
         AIPFoJWIcXmWK4v5v521tgGcPYUD4tMHsMlrLSFCnvqpk0Parf6iSsVPznY8cqqVHN9v
         uLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxvxRhzBSW3OpIu6fxiyxSczFpWCTdYpSZ94St748CQ=;
        b=d6V779azmIh+JBpkvWuHjnMaVS1Z2rK75hrI+iIyh3zu6MTYHUpYyNOxHa8CUMkGtx
         BzuNWdjLwJuFBoyjW+qt08eOYP2MgS6FPxQ/y3VJv81/8WPKbmKyizI+/Jzgs8LTAHBl
         yrZXZgXl+AhwxMw0eAspEH9Vn7bntRTiLH8xRRAhf+X+pmMm/SjMGUQCVTCimroiHfKb
         vClZcZP/TooLpaDE4QYY6VKPhFLR2kK0VDdTSjyKmp6oxkW7YarUQ69f0+JdQI2+sX4t
         a80/KFo6c9Q0uVn3iaZU2poatWG5To0R1dTH6eTRlnd418qrxn9iM2D1BEiMv34E+2ZV
         rDZg==
X-Gm-Message-State: ABuFfoi3U1rbrqINgw5BQcFsVLa5CtLgbAu5vH+iLXDLMkFAj6C4CvYi
        ZnlImxRGunzzzWqhD60+osXWDiwlIOpcqA==
X-Google-Smtp-Source: ACcGV63X+cfbHgrYiYLUycm4iRSjrgDdf53ihUgpmKaAZzsfxKppZzTuKnxDdvHpUHrvz1Fwybs76A==
X-Received: by 2002:a1c:cc8:: with SMTP id 191-v6mr340906wmm.55.1538367038169;
        Sun, 30 Sep 2018 21:10:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 20-v6sm11072372wml.10.2018.09.30.21.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 21:10:37 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dpaa_eth: Remove useless declaration
Date:   Sun, 30 Sep 2018 21:10:29 -0700
Message-Id: <20181001041029.2334-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2734:34: warning:
tentative array definition assumed to have one element
static const struct of_device_id dpaa_match[];
                                 ^
1 warning generated.

Turns out that since this driver was introduced in commit 9ad1a3749333
("dpaa_eth: add support for DPAA Ethernet"), this declaration has been
unused. Remove it to silence the warning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 84843de25c7b..6e0f47f2c8a3 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2731,8 +2731,6 @@ static int dpaa_ingress_cgr_init(struct dpaa_priv *priv)
 	return err;
 }
 
-static const struct of_device_id dpaa_match[];
-
 static inline u16 dpaa_get_headroom(struct dpaa_buffer_layout *bl)
 {
 	u16 headroom;
-- 
2.19.0

