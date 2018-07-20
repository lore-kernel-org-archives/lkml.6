Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11664204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11664204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbeGTPUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:20:14 -0400
Received: from mout.perfora.net ([74.208.4.194]:39215 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733128AbeGTPUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:20:14 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MZF5W-1fSARO3o6e-00Kzjg; Fri, 20 Jul 2018 16:30:47 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Eric Anholt <eric@anholt.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 5/6] ARM: multi_v7_defconfig: enable tegra raw nand driver
Date:   Fri, 20 Jul 2018 16:30:11 +0200
Message-Id: <20180720143012.7740-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:xLcc6lmydSZkbeQuo5gwOYyjyv2TsGwnGQpewixShaOSo7CGc0h
 +9s826xEzX2ALMjGU6ioxX+CzIXqfiTXp0cwV5d6gfntjBgtoIJNCQdF8QJhE955C0NqqAX
 SbG3Tdngk8W3L9gTkJln/c7PhgETVYFsynuHUNdWr1Z5Ev8RKSKQPsPjpO9XdFKn0XJ6T9m
 YiGwKs86DqKa1CJmwuIsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mg5KSyvv6nU=:WW16KW5e1Zrx6li68Aszqx
 n7FULv0vzGrvat/kQMA/QldhHjXJAElzsCe7hHGiZ7GqNn8VdL5DLR1TF4/siYO0gTmjTKVwY
 mS7qLx3nxAqzkhR+/6nVWMNPZ8HIkWAVXAZra8nKU7JAfnuCnkfgSJEzcDGCwK0YUu8yOpcrt
 ZHESbbMgda8IJ91w+UTodG4fcgNT/2fcYdAsCde5V2nwE8TblIWu9RPglA1e9kd1sEz/0cfrS
 fFfLu8s3eQvzoduodskGv+ch/L7G052I02mJ5so3zozH8BZTz0swY/eIYQuYtq3NG0YpH/3Gr
 bMl7VzEbkuH0o9arhUF7TMYJUuw7I1XAKpvPZAbC9hiw4IM9flWZF1Q+yD6A6K3CoAYzvw2Lx
 YduWoSqjbwDw1UgygX3pVqSaXt7N2AgBYff2GHtHYwxGKfOz6lhKWrEa9H3q2a3eJcNSHvFHl
 o2VjhfoLhAQmHOrypooz99q0lYL4KNbruRmtIXFsR6u9bDJXdxKwj48JRsPU24nC//6VvoFBG
 mgEIarYLwuGt4oCWmKUUls8dCDPmFihjtdo6JQpQKA3AIoysLiHqmNlizLTzN4SpYO9R4CHAU
 yd4JrY+XNyn1dsv9sZZ4leHiICJgTGE3p7ypTNSxJjBQwislZj85U3bxAL9JaGbs2Ql78XG3I
 VL+XzmpiELHuF5h6W5lJMpAhL8NiHt58KFq/Vl7EYUMYaKiM0a7KVDmTRCKiT2MXmET0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Now with everything being merged actually enable it.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index beacb02c734b..27a621eaa8dd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -190,6 +190,7 @@ CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
+CONFIG_MTD_NAND_TEGRA=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_MTD_UBI=y
-- 
2.14.4

