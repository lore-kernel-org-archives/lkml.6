Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EB7C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9584F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJfDGKUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9584F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeG0FLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:11:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41096 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeG0FLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:11:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so1719955ply.8;
        Thu, 26 Jul 2018 20:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WoCYEQ4/93geepmV3eG3C0h/RgQuGzZsmsCCY/grRXs=;
        b=EJfDGKUqMLo61dsBsCup/Kv0hW6Z5/cvajjhxdSm7jV7e7XeGpeJlQGHAgxXOIY2Ea
         Gr90QVJy67aVfxwCrYU49Syn8Uzy24kQAoApK4L3mtKkiILldnega505KtvyXfd4cd/x
         VRJtqlw3b1vAEwt8NMeMZo01R/K3Wvn9eIBY1FWZ/9a0xowKKdvqtQO5NotAPyncBHTh
         4sW4xvTzf2/9wp9OtyjlzLj6k/6HUO9uAWIzwdBd3TvlBCIr/IrumoysLFM2zFNLebZ4
         DnMZH5qx0t4DkS7Jwvo8l/6jS7U6IHXa5VHs+2gWhn1b0chUhR4aIVM4lo5atDAYszem
         uASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WoCYEQ4/93geepmV3eG3C0h/RgQuGzZsmsCCY/grRXs=;
        b=Blx9Sb3ym/Xt3JhkkxcuVFhqopqInKDEZynEVjdVncP/+H/S3g6D593AQZaRCVYnaw
         37yOg1Goysaysk7yGJ+kjuQHBMSHIL28dxNeFxoccoB9wuNsupK5fd6NcIrsJpohv/Zc
         1XoB0rgIGClQLNO7QJCz11OY9g45BKaK/oF9btTmYCXX4Y+wWA9GgKn5gC6aL6kPVg+l
         Wn7e1t9dvajZyjIe9tqMhdsH4KA42eFiNhgoiNQHta4+0ps0o6QF+gSP+EB6USBXIf9H
         mp9lYkHGdyYengcKHOXz/mEphfKBzyIM6G+hsRsxFAD2IMw9FwcZoMdGdzJxRb6+WVnN
         8C4Q==
X-Gm-Message-State: AOUpUlGEaHoKOXV5C68xBbGAXpc554yYUso6oWJDn6UL4MysFRSOi/yS
        jkrmb2mHA2abgSJeG9kdYGUUVg2j
X-Google-Smtp-Source: AAOMgpfXlm1xYxpTv5HBdHxXYbHViVlED6YhgKpY60Bv855/lFRf/O3g/LOOfv+zvy37X9woi99D3g==
X-Received: by 2002:a17:902:7b97:: with SMTP id w23-v6mr4509516pll.66.1532663474046;
        Thu, 26 Jul 2018 20:51:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id u9-v6sm9824748pfi.104.2018.07.26.20.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:51:13 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     ionut@badula.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: adaptec: Replace mdelay() with msleep() in starfire_init_one()
Date:   Fri, 27 Jul 2018 11:51:06 +0800
Message-Id: <20180727035106.5185-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

starfire_init_one() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/adaptec/starfire.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index 3872ab96b80a..097467f44b0d 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -802,7 +802,7 @@ static int starfire_init_one(struct pci_dev *pdev,
 		int mii_status;
 		for (phy = 0; phy < 32 && phy_idx < PHY_CNT; phy++) {
 			mdio_write(dev, phy, MII_BMCR, BMCR_RESET);
-			mdelay(100);
+			msleep(100);
 			boguscnt = 1000;
 			while (--boguscnt > 0)
 				if ((mdio_read(dev, phy, MII_BMCR) & BMCR_RESET) == 0)
-- 
2.17.0

