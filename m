Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7029BC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29943206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqRQP9rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29943206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIZAiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:38:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40660 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZAiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:38:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so20181376edd.7;
        Tue, 25 Sep 2018 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3wFBhQWiKeTuyjPIW1VjhYuquY68YGKaRhs+QxMpjU=;
        b=nqRQP9rkV6CCTlKQ2NTmEhyadA4J0+ZBegfDBW7LdSJEA2FDOnu9nsymT1GrEtFfnW
         hWIHflhdoigfKN1/dPIffU5DoVTkKEPtKDONnMKgxOZ6/TZ4Wk0iR9jsB3flUbUTvXYZ
         NdmnGzRor4MZg/6TrWB6aTWRc6uMAqbxwhb7O0O9qlaT7zbb7UoRVsnhyjP2JslcQvFv
         2nUDNgupr1R73AQBQHNiabu5RlwKF0kYmu6I/YHh2H+S2zxZ/rbsNAhcBcQG5lpuwhH7
         42RjVRDNs07EPbpoGoLaXLNUriwv9NLPDFMSnDLXGrVCSDwNSz//mCNRV27G/EDE67vg
         dKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3wFBhQWiKeTuyjPIW1VjhYuquY68YGKaRhs+QxMpjU=;
        b=hsSh1NzBZl1Kb4tHl8OCt/kNVZWVFJOGRfl1hklERGmMAHMkJG994w3DmbI/KVF91E
         lRuSfaCWmi7qYlyINjAfBNpgjjQLmDU3NZiRHC8Jzzxc5/+TXSczXFPIhxIoEtPLp06t
         o0YiBf1x8XsomUjinARWdfCT+bWmNLo3WNjgJ1DoLUJwb6iNa4uQYxlPNxT4Kqjd9JAb
         2MYbWK2CWWGKCmg7fY3kZKLi//2h/tdNQfS8QvC6nHn+A3KLHGrWYf8l+p5soVOtca9x
         qd5YdCnds3fFa+GnBQtCEE1An1U9nxg1YDR5Ph/hQ6EGRVl7Gw/pCNjpP2zjyM5QNVG8
         4pKg==
X-Gm-Message-State: ABuFfog134g45VD38RbBxjxpcgDt7HPDjSvRqlBhvGZKee1K9lUDbT+a
        J4OljjOuwZ+nluuu4kv/HjBlc/ov
X-Google-Smtp-Source: ACcGV6399LvXTQq90yk7sO5u5wJ070oYYdb8WsbOh6u7SitLXzDNOCn+O9mpv0K6YehzKMzJJRNscQ==
X-Received: by 2002:a05:6402:1848:: with SMTP id v8mr3448763edy.147.1537900174849;
        Tue, 25 Sep 2018 11:29:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g38-v6sm7834882edc.40.2018.09.25.11.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:29:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list),
        dongsheng.wang@hxt-semitech.com, cphealy@gmail.com,
        clemens.gruber@pqgruber.com, hkallweit1@gmail.com, nbd@nbd.name,
        harini.katakam@xilinx.com
Subject: [PATCH net-next 1/2] net: phy: Stop with excessive soft reset
Date:   Tue, 25 Sep 2018 11:28:45 -0700
Message-Id: <20180925182846.30042-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925182846.30042-1-f.fainelli@gmail.com>
References: <20180925182846.30042-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While consolidating the PHY reset in phy_init_hw() an unconditionaly
BMCR soft-reset I became quite trigger happy with those. This was later
on deactivated for the Generic PHY driver on the premise that a prior
software entity (e.g: bootloader) might have applied workarounds in
commit 0878fff1f42c ("net: phy: Do not perform software reset for
Generic PHY").

Since we have a hook to wire-up a soft_reset callback, just use that and
get rid of the call to genphy_soft_reset() entirely. This speeds up
initialization and link establishment for most PHYs out there that do
not require a reset.

Fixes: 87aa9f9c61ad ("net: phy: consolidate PHY reset in phy_init_hw()")
Tested-by: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Tested-by: Chris Healy <cphealy@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/phy_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index af64a9320fb0..ee676d75fe02 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -880,8 +880,6 @@ int phy_init_hw(struct phy_device *phydev)
 
 	if (phydev->drv->soft_reset)
 		ret = phydev->drv->soft_reset(phydev);
-	else
-		ret = genphy_soft_reset(phydev);
 
 	if (ret < 0)
 		return ret;
-- 
2.17.1

