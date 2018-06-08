Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id em33NEqXGlsRHAAAmS7hNA
	; Fri, 08 Jun 2018 14:48:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B91E8608BF; Fri,  8 Jun 2018 14:48:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 34202608BA;
	Fri,  8 Jun 2018 14:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34202608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeFHOsk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:48:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeFHOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:48:38 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MXjQA-1fnvcr3nNu-00WVrN; Fri, 08 Jun 2018 16:48:36 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: cros_ec: remove unused __remove function
Date: Fri,  8 Jun 2018 16:48:06 +0200
Message-Id: <20180608144834.3003465-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:I8b5PuilMYRZuVS6qnhdQDSK3oqAhID8M/AIRdrdB9ntEw0k/gf
 2ND6uSajIgDqNlqzkVLjrL4zAHrBPPcyBJONXhIdkTeFJtyQIx5YvTQiBYgXOfIOdeqLynS
 YL+4KEuHBmBFryr6ibXdpgJ5m9jp5AT4oXQ5TA0uBIcu7rGvQSvgP9+VT60NIH8rAMygk3r
 FfBgO2G0QEzxADPc5DLMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mWuIeL4qvME=:9xrF5I8OEuTV3Z/tz7dPcZ
 axyRixxTYM1Vl81DiovBTMJ+Xo34DUvWCyvp15XdijEHzqwnSjzfC8Qz38I++wCDemzja0NDV
 a3DbMysOzPjXaFDeGnx/YM+DCwviDeq/kyowTt/fQbAildJP7DMp130YDCaEfywh6/WD4FPsD
 LO+u7xGuOj+z3l2rmiog1KHIS2xVo70awjISL5dlAsfkS5WRX18+faCREdW6YM3xIaOuKbFnb
 zExmSPqP+TVUTEj9loLDTFY9nMGjUZ5pPrus7vfuD6TCJQfOar8vCyz+8EIS2n23WjRaWJdtX
 57s1S+Ac+Wrx34tqasAU3Z2YqGUr2p3wXERHRONAAB8gy1Mrr5tNjpEhq5HWhVY4GWi9YQUj5
 bBONb9KCj16vBXmCFj/zotSue+dCJUaXLpzg0n//POpw966OBmF7ebaTvTRHB32wDGhkUOvi/
 zZ4fayZOCODGMvsvmccAjqoeAbgz+z1lZsBgIBZN+uC/NE1t8KD17eE68qfYmweFjdmUQmlA8
 rnHy+nnt5JKJdPBRUckdb+yuAf/U8Gy6jhQzDC61qfxsCIqehYJ0E42w2e5EXdNfY+XUfspW8
 gMUdNDbB5qqJLvfZsHgR9vdB5HSqSTi2KW7yvfvhc29u8z8hC22+bDNZkv6AodnZpOidnAxRE
 DuP8O4aDnOJ/VyDR5yfnQqHWgblBafxs/OrBjDFjb2+wP7QgP9BxeQP/M40Brw/Zif3k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is no longer called, so we get a harmless
warning until it is removed as well:

drivers/mfd/cros_ec_dev.c:265:13: error: '__remove' defined but not used [-Werror=unused-function]

Fixes: 3aa2177e4787 ("mfd: cros_ec: Use devm_kzalloc for private data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/cros_ec_dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index dfc9f131aabe..4199cdd4ff89 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -262,8 +262,6 @@ static const struct file_operations fops = {
 #endif
 };
 
-static void __remove(struct device *dev) { }
-
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
-- 
2.9.0
