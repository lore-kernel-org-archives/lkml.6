Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411DAECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF1120856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EHtJuWoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF1120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbeGRQtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53394 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbeGRQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so3349541wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EirWCWel/w1jaSio88cM+pYKnpg1qeQaHBKU4yixNfc=;
        b=EHtJuWoO8ddLvvPcVimKtHq6H8FCzhnH+7pzF5jw6GaqcXYVULCbQvQoyIn5ASUyEm
         f7zDWC1QrVN92CcoQW57/gEo0uIRrlNSgjl6n0hRexuov7WOocKC1Fsi4g+s+ZOL5n9T
         x1FeKQIU2dJuVrK86D0Gf+TK6S3Kpq2bWh4NpwmZDQV5+5d1FzUiLYZo83fVWqi1Oaf0
         zqmmGgn7yTu/xMdApC0AIDaBQn8k+pSar5skAgB4lzqTgdlFxQLdNLfldfINYhgp/ZWZ
         WhuqQUdLp5TRmP+6JAOU/I6o2o+NfvgObBZVHLDVsc4URiyW8BtTsdT7rfDrKzcsKdj4
         NTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EirWCWel/w1jaSio88cM+pYKnpg1qeQaHBKU4yixNfc=;
        b=CbgQqG5E8JJWhev1tc/dgpWYs+Jl8mUEJTgWNIvIW6z0GaFVMpHmqwnrCQ7M9NqF4i
         c1oEpOGjCN4arkZ7wsPieQ0zu+1PgzebIOyrfp8rMuqI+EULlRYcOnw2t6NQBT24goCW
         V5hczlkkhNG8Z86TARG18ga5+/501d/5+stHBJ1wDBD+IOFxJON/zZqYFDLgJn0hk7TR
         U4klzVlR6d81jEzC0o8+05sjyn1Qgmk6pmsqywQeWTor86SgzZ9FXxCsgVQkZ6k8bAZI
         aFk3brZ5Pl3aTgZ0LXko8UoXlF7RMbiCp5lxho5H5Pj1V6SkyL4eAI6siBPpLj46DaxQ
         BZJQ==
X-Gm-Message-State: AOUpUlHizdjujv1vDmboqRxQqh37Z2X0xAQKBTAObC0NqYJzn6fURrU+
        pe9aIaDVdNSC1bYbdkFlSGB8gA==
X-Google-Smtp-Source: AAOMgpewbp5hFl5y/IcWNm7naKQjwy1bkB0Rq1kdgYVfhvYPX6gC55U0SsVOv5KPlyS0WjNzpFYBDQ==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr1923561wmh.34.1531930246398;
        Wed, 18 Jul 2018 09:10:46 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v185-v6sm2847803wme.30.2018.07.18.09.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:10:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/5] net: fortify eth_platform_get_mac_address()
Date:   Wed, 18 Jul 2018 18:10:33 +0200
Message-Id: <20180718161035.7005-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718161035.7005-1-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We'll soon have more sources from which to read the MAC address in this
routine. Make sure the address is correct before returning it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/ethernet/eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 2a2173324d9e..6b64586fd2af 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -544,7 +544,7 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
 			from = "arch callback";
 	}
 
-	if (!addr)
+	if (!addr || !is_valid_ether_addr(addr))
 		return -ENODEV;
 
 	dev_info(dev, "read MAC address from %s\n", from);
-- 
2.17.1

