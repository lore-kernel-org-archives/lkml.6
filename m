Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF1C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA1A208D9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA1A208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeJCD4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:56:10 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54671 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbeJCD4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:56:10 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MX0TX-1gDiOh1nFR-00XKuQ; Tue, 02 Oct 2018 23:10:18 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MX0TX-1gDiOh1nFR-00XKuQ; Tue, 02 Oct 2018 23:10:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: lpc18xx_eeprom: remove an unused variable
Date:   Tue,  2 Oct 2018 23:10:01 +0200
Message-Id: <20181002211016.2638186-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:9eeNNS4sVxD8k/SB1tfeRWq70A30cVxotUII8pQXwEsnQR+O6t7
 2kanL8TEtE+uZTeuM20kvlIq9lDP7O3GH652RS9ppgfn+A0wiwP4VcgXzBgUMTv7AcqR2FG
 +0wbXOKarZTI0V5LOejBW+axQaEcnU1HHspNSs6kjhvjwvQr5MYUu9Eh8AN/v9++N96jpzS
 Orsf5AS+D5+qXkxIgmjOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rtI7WyntRVU=:dmMs/vhyRjWCBEhfPaDj46
 8z5+bX9H3dniJyyNC/IILZSOtHoRfR9fucq964y2uQUJmi/7dUoRUR3CFk7pdQ5WJru0wt8Ee
 g8cWwjaS3c8Yd10LJ7aLX/cncNioYtU4ct1Y/1XzMR6D0LYX5lqfsMXWouQOi76One9N/N+2u
 KB+M6iMC6rikrDWrvBN4R83FlbbkTSdkvpyBDiivzqLOPP652z/HB8HW2MEWCSDujvMqmWLwn
 w6s5GQP30rhPm39u97DfvjfPJQfQQxhbM+rAqjRfyckDozwrx+hUCSMpUxfdaa7IzboM4gm+X
 hBDJc6odIkTgL6t7MrQdxkkCt1wp66dxbotiLYX+NCFatcNHa1RgWwtrdfU5VgeYdFXfbIddV
 2TEsTCcuyS2ju8KjXYhFMxygmbu4qcHQ220j2lHVWMncuWuRJ+ARt0+ya6/oEOEjkdGyYpvO8
 HkJS7eDxDgBJFr6QcqSsvyby5KK49Gj866oJzy90XnWI/S7xZpJ7LA+eCHhZVsXv4s/712lSs
 qtt4WPp/Q+6LTgYrhF7CZd02b55tExm1wpCIP1vvaRu5D5I2clXLWUpclEbnj1//gbLs7IVRQ
 OuVSy9u1hmwQ2gfNfaGMcTg+SaeKMGqIbIytBm9MqAZVlt0XZcKcnOCZ4dNZkEzDd7+qmBIF+
 pwGaXk+aUXFMzKMfbyaiWJNF4tScau12O5cum0BshKNyUr3a4bVTDaRtjJvewVB0Sea0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/nvmem/lpc18xx_eeprom.c: In function 'lpc18xx_eeprom_remove':
drivers/nvmem/lpc18xx_eeprom.c:258:6: error: unused variable 'ret' [-Werror=unused-variable]

Fixes: 226014d13fa5 ("nvmem: lpc18xx_eeprom: use devm_nvmem_register()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvmem/lpc18xx_eeprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index b42dbaddb419..66cff1e2147a 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
-	int ret;
 
 	clk_disable_unprepare(eeprom->clk);
 
-- 
2.18.0

