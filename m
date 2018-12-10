Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F094C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77EC2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77EC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeLJUpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:45:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeLJUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:45:02 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFbeI-1gfq6040Du-00HAcc; Mon, 10 Dec 2018 21:44:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hns3: prevent building without CONFIG_INET
Date:   Mon, 10 Dec 2018 21:44:34 +0100
Message-Id: <20181210204448.2338398-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HFZfsUDVuEdn+77CMeihAJDstW+d1Ot/4Kx1tzW4n8vleACepiW
 ShVkt+bg6utSevcCfoNLfWJjKp5kJ/0wHA+RjjUchkT4b1OIVMk7Wza+S4lC3RqFE2Xprw5
 c3fPXmgsgSegoqGMuJBMB/W6gLr9MbiNOOB41z2ccNrmWxQr+PKJbi0bHtGGGFqJIH8oEE/
 J2g2iu6+Uts4wAN6CD1Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ZTUG9v6qxE=:CEYaqfsSlmt7McBc8gXlf5
 Sxuk9vM+uEUYxmMQd3LLA8pUB0lQo1fpc+mdSo8w1Z154kNVUG0IVAO5k8L6a2XaeJKFOwgHU
 SRavPlQUt8eHAOQv6xcAd6n2QVpiY2LmDy9Nh36BBNln+MkDl+nfJw9MVgXWHaOY3J4jenYxY
 MouLj/nD/z6JbIWlVweXulGQ3GYiFuC41343/8ib411JSLPbVRjLTuJIxZA9g948Xr39LP+Wl
 M/gPEAJKzIfKCkQOEujrlLJ9JMKdgRWdDbJBCfK/DgrJieeajm0axUw+et5jVFQygCbwXdd13
 9F9JLj6RDhL5RnDCTqY3vFNAQyVhTFe/8/FqsNLX/B25F7TOBbBrGQ7j58KjL3QedAC+mAI/1
 /kX7OGIJ6ey1Bq9m/lfUDFP6fKU3TUvRZMpqJjX4gYChNqbMJOo0EB+UGrXboKNuTJFGMHhFg
 Zh65SthwoxJsRjMA7xgNasbo28hyh5D5KGcpzEZPzrlUDckjEBEygxkNrqLP3s+3FXksoQt60
 m1ZLmkJ9JJdaN1Q2dqeWOJtghsivbx4/uwSw4pi/WCjKQ3LDpvWh0LXxsv0vHfkrVZjGYrrw4
 yItrmagDk3aG3g3EwV91ppXt1j3uE6SdW1K1K73mjl5e+TTRaNw7LlMueCC3kLm1HLgXyDazs
 /DuoFhZ1zYti9jj6sa0m2A7z/oGmHR46JTKEfZ9TFp/dPE46Xbk//bH9ZXjKt0lVVR81Vp0vS
 FOGf+BmDv3ui8GULyEvJPab4aoNT/vsIMPJCqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now get a link failure when CONFIG_INET is disabled, since
tcp_gro_complete is unavailable:

drivers/net/ethernet/hisilicon/hns3/hns3_enet.o: In function `hns3_set_gro_param':
hns3_enet.c:(.text+0x230c): undefined reference to `tcp_gro_complete'

Add an explicit CONFIG_INET dependency here to avoid the broken
configuration.

Fixes: a6d53b97a2e7 ("net: hns3: Adds GRO params to SKB for the stack")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 25152715396b..fee4664c9189 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -118,6 +118,7 @@ config HNS3_ENET
 	tristate "Hisilicon HNS3 Ethernet Device Support"
 	default m
 	depends on 64BIT && PCI
+	depends on INET
 	---help---
 	  This selects the Ethernet Driver for Hisilicon Network Subsystem 3 for hip08
 	  family of SoCs. This module depends upon HNAE3 driver to access the HNAE3
-- 
2.20.0

