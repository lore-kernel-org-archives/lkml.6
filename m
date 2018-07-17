Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7594AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2940B2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2940B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeGQJTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:19:04 -0400
Received: from mout.perfora.net ([74.208.4.197]:38025 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbeGQJTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:19:04 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MdMM1-1fO5zM0bi7-00IW4H; Tue, 17 Jul 2018 10:46:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        boris.brezillon@bootlin.com, miquel.raynal@bootlin.com
Cc:     dev@lynxeye.de, mirza.krak@gmail.com, benjamin.lindqvist@endian.se,
        krzk@kernel.org, marek.vasut@gmail.com, richard@nod.at,
        digetx@gmail.com, computersforpeace@gmail.com, dwmw2@infradead.org,
        dan.carpenter@oracle.com,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2] mtd: rawnand: tegra: check bounds of die_nr properly
Date:   Tue, 17 Jul 2018 10:46:18 +0200
Message-Id: <20180717084618.25249-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:cwxPbZn/B9YMA3utdimZ5G+gGaG+2hAP57u4ETYDnApc6wrEkOC
 2aGtq0w7IdRMieNlM+h84x/7xpXiYh6ldj3kkHwGIx4k27T5sW4TcEIyL8sKM6he0EewBvf
 SS2M/0jzTZUng6MKft4lGhRp/6kjoWJAVLD3Klg3wadwg9qCBJybkSOWudZ26WWsVcYo1D+
 QW3aQGbkafG7HgXYF59Lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jO9ycJ2SoQg=:xRXk7nSm18P5HMsGwGWoue
 Z0TUcAsm/fhHQnLnIp1J2ozQPaEzrWTXzBjoJ23Lmlj8ZTVKtO6EwJnvsGKejDZpUIUAu/+QD
 Iimvw63w/yYPa9KKpGAQOm8ShhtGNVIY3tiqQ1rEqiUNglGNFU9jlRiTFrn97gZN2Y7zXD5dN
 Hakk9ajIbsshmsGKpbzdnn1ajvcLbNuuo5idipLZKZ69XB7CjgYtHpY+yUgF0/BETEvrGas+w
 txzE3/0Ku3wTIFY+Wpc9z+IslpNRZMFo9TVmaOD9wmo6fBvLpHX9HAr32A01AU20yQc8p/F9Q
 6I9YWZ09TYlvcqBVcekgvX3KornsbBdDPijeq5bfXpZw4YpDpS+7qBgngeuCzIxmQDveYWJMH
 bggoKs54fNTlQ2aPHN8borvbQFhhS0wSbe5IRnZeUtnWW0O7kMcuwfItnZKuZ85LZXMG408xx
 Li+o0FSuOnA8iSqy6HNDgFtlMCj8VCzZh0GSz5kU2+zcu5MihA67xdjzRCGOftXV+eDG3neF6
 vNBTvhPrA53RNmeYYl3UVR9iJ8DBT/EOBs2RAirEJ/a6vd/kEnWXXHTVYflFcot5cx96of1fA
 Km6Fr8aMPRtOu+rF7HYqfU8EVwVZD+vK2evJI1IK8Jin8lD3ot/E8TbVMPfXDehcnmIX9uYX+
 fINsOMqS1uMOHLsh4K0aLLmC2CgZfIu7RkOeq0UZYxvLB1EFO6Kgjl6R76w7ZjsgZ8CI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

The Tegra driver currently only support a single chip select, hence
check boundaries accordingly. This fixes a off by one issue catched
with Smatch:
    drivers/mtd/nand/raw/tegra_nand.c:476 tegra_nand_select_chip()
    warn: array off by one? 'nand->cs[die_nr]'

Also warn in case the stack asks for a chip select we currently do
not support.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Fixed comparison between signed integer die_nr and unsigned ARRAY_SIZE.

 drivers/mtd/nand/raw/tegra_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 9f7de36be893..56c0aa1bc81f 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -468,7 +468,9 @@ static void tegra_nand_select_chip(struct mtd_info *mtd, int die_nr)
 	struct tegra_nand_chip *nand = to_tegra_chip(chip);
 	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
 
-	if (die_nr < 0 || die_nr > 1) {
+	WARN_ON(die_nr >= (int)ARRAY_SIZE(nand->cs));
+
+	if (die_nr < 0 || die_nr > 0) {
 		ctrl->cur_cs = -1;
 		return;
 	}
-- 
2.14.4

