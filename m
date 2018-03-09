Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeCIQh1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:37:27 -0500
Received: from mout.web.de ([217.72.192.78]:60113 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbeCIQhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:37:21 -0500
Subject: [PATCH v2 12/17 2/4] mfd: tps65910: Delete an unnecessary variable
 initialisation in four functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Message-ID: <f28c7c19-ece1-87c2-6304-6226015bbdd1@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a00bda19-c38c-6733-31e7-7e1c44eb6c6b@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3loau3s8C9MesbwuicQR+CT0wKLi0AUZnF7yu0eYHDZZFsJjpFU
 htvXlzxZ9uqMCtDpL4s/WOAgxEnSmtF3LlTJorzTLjOGKtZZvNPITY75gPjt0GE1MYVh120
 nK8JnehimOTXo2z+vvans069sP0/aJaphssZz2/KkGIZLlZbqxahijKCdzUCtqu3A3m4M1D
 65Gsh3z5Bx1mnTPDQejcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q+Dm6yg11aI=:fpfkNcg3tpngpApnrQSi0r
 C7BEjBMQSVebvsTlKAfbRfOokXQeftJHBtSDbRRNGl9FqIAIqU+UcJpE7lM9oCNypbNvjUtoM
 GtYRSoFUZKNdnpnu9WzyX7bEBejGlmZIeTBRkBCdeP85GPptTOarShJ2xuxE6v68lve7izBDX
 4JVN+ToNPnvuMfFQyWM9A+7vVLmejDO7lVO4uoNXStW/Oe5bea1wTR5MLii3V4xedx1srKSld
 gN1mkgIRDausJbBSypz/tchFj+EDF28WA+W7mdPYqlrQtnTHIwlzhHacbiORz7C5UORn1jx97
 h2OLvmSHUlIAIT5k3snIn8teS+MPiHZj/67QmJLdmd+a2Qo63tlBxsMxdR4iY5puanMXqzppc
 bC+8SizSXJeQbJs/0fSm5ID95MFs/2mRHzJaGdqeO8BhS33RY8+YeSNr1W1MOaDP+BBmOOd5E
 VCH+oOVQmMKW4Whc755vlDqSjdQEhjTYNNulE0cdJEubEAEF9dffOVFS5gnpm6RW/lva5fXXc
 MyaTHc7ApsOlTP15ayXDcqCUMzaP1KkhNphvdybdFksvw46UJtPVPq8tegFGiEcIB7hboJ+FM
 QckaAUYbWHr1RvgJFj/Qs5zJlpH/PjBkNF7ortuGeyHit/ZT80u/BL2r9UKIwuufzn12D/Yeg
 oMV/n8YsxgHDixYFC7n4oAu1zgnxoevRl+iC/0Kx0U968N/y/FMUeNdrc856EHppMjqK1mskR
 sd5Lj+++OFfEzK6jhRv/TQlEDiLjnx3sJJRkq9WISzo5F1yvMZuC8Gd+y37BLE8DPcOHs1e4H
 8BcqDalC0tzI8X8HkiKEHiqVtLxzhAT4ne311OWfSqETos0XOY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 09:06:14 +0100

The local variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/tps65910.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 555bd394efc3..80ea1474c654 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -229,7 +229,7 @@ static struct regmap_irq_chip tps65910_irq_chip = {
 static int tps65910_irq_init(struct tps65910 *tps65910, int irq,
 		    struct tps65910_platform_data *pdata)
 {
-	int ret = 0;
+	int ret;
 	static struct regmap_irq_chip *tps6591x_irqs_chip;
 
 	if (!irq) {
@@ -313,7 +313,7 @@ static int tps65910_sleepinit(struct tps65910 *tps65910,
 		struct tps65910_board *pmic_pdata)
 {
 	struct device *dev = NULL;
-	int ret = 0;
+	int ret;
 
 	dev = tps65910->dev;
 
@@ -383,7 +383,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 	struct tps65910_board *board_info;
 	unsigned int prop;
 	const struct of_device_id *match;
-	int ret = 0;
+	int ret;
 
 	match = of_match_device(tps65910_of_match, &client->dev);
 	if (!match) {
@@ -460,7 +460,7 @@ static int tps65910_i2c_probe(struct i2c_client *i2c,
 	struct tps65910_board *of_pmic_plat_data = NULL;
 	struct tps65910_platform_data *init_data;
 	unsigned long chip_id = id->driver_data;
-	int ret = 0;
+	int ret;
 
 	pmic_plat_data = dev_get_platdata(&i2c->dev);
 
-- 
2.16.2
