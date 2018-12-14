Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE1DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BAF206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbeLNWMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:12:52 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731080AbeLNWMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:12:52 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N3sye-1hXhFg13ei-00zm3J; Fri, 14 Dec 2018 23:12:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joel Stanley <joel@jms.id.au>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] [stable-4.19] i2c: aspeed: fix build warning
Date:   Fri, 14 Dec 2018 23:10:10 +0100
Message-Id: <20181214221023.3878670-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UkDh7AG484n7mftoFIvINl/KQAshkFrxhFrTWJuknl6fAci4RsD
 r2sYU/EayygD4/EPUGi7OUGgeEz8n2p/M+Tl6MGhPwME2fZB/wFT5SuwNsriCqXSOdTEcWW
 jp6L6hj5ezeETo5Wg1oJ1f7cUqzp7K8vXjVFXzRnaDopCPsED3a61Kzok8i7h1gei2g7Xcm
 6GiXNpZ+un4kJECeNifyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6IHFjg9tjAo=:4lnIT+guTjNYoSjojKvvus
 FlNJlSRsw3A5h2E+krCs1Y0XYo9DChsirZBJbWsMmoG5YsETyQHhkCmbiQeTmr6+xzwg5A/4B
 FPoqRvcabPtLPb58dYyKOibH795LjlUipGPkWZeYXHABTXJZKgGoeFLX5B16+Tql9XKbIjLFl
 momG+Hehdo2gDB2A/vXzhQTkiAben4xOeyMWUmuB4AMERW//gQwno2YQvrLqH9vfvnbnOuTmu
 6WSjKAQkGtve5fk8YL19Ph+i3M9prBYhiyFl9vUJxMhAxegZgbYBCO1AbPa6SE/DVuTDCrc5U
 uAtZHA1IVEFZ9JooL23QL+7lk3T7/A/ctts5fwOpbwgqs/CJIR1q8h8HlhdWDKBQPN+r7IOFz
 aFb4LJ89wA642EJ4v8XwJPi1d6bWnLKPEet+WwPgqeNt2Cbwc+VfVqFAZgOTxVqD2GJDN8zBB
 wv45HwnuqBDq5bYRWSPb2HLY0gdZQun36S9NnlRaWKw+Qx5TQO8u3kcR3TkhPgmH8pRqV0Nzk
 +ikjw8aytriWZPc6trGNFKL6vpOb9eAaHlj7kPqY7W9sXssLvf/T28aXrPdO7raNmQBnxG136
 MmiDflf2CRgQXJ3ERaNAuxTDumq3/lDxPmPsaaRgNQrOD3o3Lp666q6kosuu/pWd6wv4/QToB
 MjKqgvuW6XAl/aBQXVIntSvQVDI+SFzIUhZfDbk4x9NMrk/bOR+Vel1iMyv9P9JDdjkxCMMEk
 PKJXsZ46yhupIVqyULyg9DD3h2CRlZOaK71I/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
properly") reworked the interrupt handling and fixed a warning in the process:

drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_bus_irq':
drivers/i2c/busses/i2c-aspeed.c:567:1: error: label 'out' defined but not used [-Werror=unused-label]

The warning is still present in v4.19.8 and can be fixed either by applying
that original patch, or by adding a simple #ifdef.

Here, I choose the second simpler option as the original patch seems too
invasive for a stable backport.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index a4f956c6d567..a19fbff16861 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -555,7 +555,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	spin_lock(&bus->lock);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	if (aspeed_i2c_slave_irq(bus)) {
+	if (IS_ENABLED(CONFIG_I2C_SLAVE) && aspeed_i2c_slave_irq(bus)) {
 		dev_dbg(bus->dev, "irq handled by slave.\n");
 		ret = true;
 		goto out;
@@ -564,7 +564,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 
 	ret = aspeed_i2c_master_irq(bus);
 
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
 out:
+#endif
 	spin_unlock(&bus->lock);
 	return ret ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
2.20.0

