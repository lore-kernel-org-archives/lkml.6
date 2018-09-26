Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DCEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277F920684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277F920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIZTSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:18:33 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZTSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:18:33 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M6YEz-1g76Mm1W6j-006uFm; Wed, 26 Sep 2018 15:05:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: omap1: add nand_chip declaration
Date:   Wed, 26 Sep 2018 15:04:38 +0200
Message-Id: <20180926130458.2406549-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:m5iUF1QnVkusghXWgP4SqCCellrpwKLxVclQJ9DBo7UN+pqJT+H
 u2OnBUP29prUHouYz0Z4G8YvYiYL4PP4pOAvzzeieaJKfZ00Vwrik26hdxhM7O0gWD7xu60
 AtbTOswXyzzgirz63jaG3Osb3ImUq+/xxktvZo50vq39xLVmTO3Vog+7rH7/ogpvwxnde2p
 TFXgSlNSp3pJsXwLynSww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HUlBE//1IRk=:Hx9TyCIzXs3DMv9Fk1HIYH
 lVuUMPycA1c3OwO9ea08jlYq8kgtWqXJ9vUBc0/gl7/g60cX5KKxw0VDkkQX5JbAfo6zgtdZa
 3AoUTNyy6n0NZ+KQ0EcOUx9SmR21ceVcfoe51YHT2yLFF96Nwm8A1B66oVfApnrJcpo+7E3Ci
 bZPcYQo5ZL1e4L96d0a3U9Eb2C+2BjkdrawWT/K44LgGIS86YXHLWBRdQVHpEiU4S4zWe9X2s
 P0DWLGiLvvITaRjbtnO2qjLvIiid7NxMN3VRPqAQUbtkpqYinSOHMBR3lj7FsVC3EyPr30MU9
 BGs6PCXr3ga7ei6HtZYpLyP+NfPZ6u+TglY/cfPvRyWCkEwpjyJhg7lMPUO3Tpgy63auTAsHU
 SFDzTDuP8hm1pgnzQ7Wb0KG6Hr6MvXV6BGmKn4tqPXS2Tzz2LVjUZGfksN+lj42X4P1WNdR0n
 GINkyAGikL1Fee84iQtj9JqEjNqmdBXagBxVcYLsKRpvfgVrEpM0XJxoAPoP/xu6AfSpvuDpe
 sKUvgBLSPyGNpMRbehU2JXh/bOrOUYumhcl43eV7aLXQ/Q2cSN5PRB/HUQIqHjcNNWZu07Trs
 Cv0P3WEc7fAKR6Di09FtIpBvtXFafcxdJhAM7U7zwaQjvRQPeewq5dU3CJxN7yw/BdK4dLqML
 PxdIgewNH+6GD3XZY7woKpcbwEqh5dSDKg47PlSMa0m/50ZF5yIoOb0dWnT+mcEH1fD8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent MTD changes caused a minor build regression on OMAP1:

In file included from arch/arm/mach-omap1/devices.c:31:
arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 11b87a4c84d4..82f2c065040a 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -82,6 +82,7 @@ void omap1_restart(enum reboot_mode, const char *);
 
 extern void __init omap_check_revision(void);
 
+struct nand_chip;
 extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
 			       unsigned int ctrl);
 
-- 
2.18.0

