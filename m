Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6094C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2171420843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2171420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeIZT1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:27:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeIZT1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:27:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPosX-1gQPh10NGN-00Mv6Z; Wed, 26 Sep 2018 15:14:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: mdio-bcm-unimac: mark PM functions as __maybe_unused
Date:   Wed, 26 Sep 2018 15:14:10 +0200
Message-Id: <20180926131418.2729391-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:ebT/N5gSq7NmVYkcaKvNGao1kRGVvHjT+/iWvjLtvjpM/dog2t/
 xlzPZvdLCOmOp+DyaNWNfhhCcUkgrEa+bar4umZ2tiGj5Z8rjJx0VbGWGoRrEWaeGTW4fQF
 NArkMW6upOTDm84ju9Hzye3fB2sN7/qziRMvnES7QK+9nBUUQJOGGdWCVWHovnNbbkoiL6J
 ZmzZggZtPv+u9utVb8Rpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2SfNT8LIG1c=:LrGM8b/dxHc8HEqSe8KF6R
 /EVTGPLDrNFCaNJhMHFh8IcfSl+27H072WlXFcMoS2QondStw1yRU4wlvOD9QxsVAdrpI4V28
 dKKp8tNLfQOe5QYhRLXayZG1RZfY3lKDJAqgMburzXs+qjVbJVwSuvNSHWYxr6iqTfr23uuyl
 DsXB1w/zPsyhghI8PJX65uOBAevsBHGWLe5ZZ7QQ69zh3z3RAc6VKJIG4ockLMSQHcmh3esfN
 TqaL1Ca6ZJbXTlhGLd/Q8WhnS9sikP/J470qI3h61JUYO6tXLhuvujvcPAtT/N2yVmzbaT5cz
 rYvvPKK3RghuEY7bjDeA1X4Mau8zLXMEw3i3LFSwsnIUCmqbhAQK4/Lzl9MrK8i4SqBJv6tnw
 c1eZ4S2h7zj/DcNKk1JmLvKuVAw3nhYVXzXkgLLBpCNBo/RwIl7+MOj256KuW0wmiF5HMTzMB
 UP+JbQTUb4as9yfxBsOzoDWYEhylIsyQKUeGfGcN042Ptei15+W3QiRO+YLCx1YWn8Iv/RXs1
 tEVmyS72N8Ls2D2VYkItBwkCOl1uZbJAy28StoLkd/ChAtzXwTk73r55HTbJ4px4OSzYfVC/w
 RbGIuGA6u/1aC0Qopsn1NdIr8ssMO1Sgv+Q8PjWi4cqMUVEkO0uXhEo0BZzJpSXc25KFrfZeX
 fv3pLT/a4ySu2La0XpDPjYIC5Y7pZ3SfzNRUMLx1/6rdMUcwRvumCqTuaHlgnrVz5aYE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added runtime-pm support causes a harmless warning
when CONFIG_PM is disabled:

drivers/net/phy/mdio-bcm-unimac.c:330:12: error: 'unimac_mdio_resume' defined but not used [-Werror=unused-function]
 static int unimac_mdio_resume(struct device *d)
drivers/net/phy/mdio-bcm-unimac.c:321:12: error: 'unimac_mdio_suspend' defined but not used [-Werror=unused-function]
 static int unimac_mdio_suspend(struct device *d)

Marking the functions as __maybe_unused is the easiest workaround
and avoids adding #ifdef checks.

Fixes: b78ac6ecd1b6 ("net: phy: mdio-bcm-unimac: Allow configuring MDIO clock divider")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/phy/mdio-bcm-unimac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-bcm-unimac.c b/drivers/net/phy/mdio-bcm-unimac.c
index 80b9583eaa95..df75efa96a7d 100644
--- a/drivers/net/phy/mdio-bcm-unimac.c
+++ b/drivers/net/phy/mdio-bcm-unimac.c
@@ -318,7 +318,7 @@ static int unimac_mdio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int unimac_mdio_suspend(struct device *d)
+static int __maybe_unused unimac_mdio_suspend(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 
@@ -327,7 +327,7 @@ static int unimac_mdio_suspend(struct device *d)
 	return 0;
 }
 
-static int unimac_mdio_resume(struct device *d)
+static int __maybe_unused unimac_mdio_resume(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
 	int ret;
-- 
2.18.0

