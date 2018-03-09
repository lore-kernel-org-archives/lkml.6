Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeCIQNt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:13:49 -0500
Received: from mout.web.de ([212.227.17.12]:59705 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIQNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:13:47 -0500
Subject: [PATCH v2 06/17 2/2] mfd: sm501: Adjust 12 checks for null pointers
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <5271ab9f-3be1-035c-90c1-8faba2e119b8@users.sourceforge.net>
Message-ID: <239db775-b9e6-57f9-23af-9a1a551255e8@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5271ab9f-3be1-035c-90c1-8faba2e119b8@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ShfotqUDQBRIoCNs7C1VFHFqkadySoi9unTtM1D6MajLi2Nh8CT
 kqIBysWyMNb4VJzcEXLHZvRljGJGJX01CONfT8f0DWMZjvKJH/lyU2TjEhKXVr9U/i8GiGm
 A/tsKg0TU8soEeI12xJCVWz51sp1Re6IvoQHpbhHsmXcZ40z8k7LvVNMmGqwsClARM7PokG
 os2dKEKLkhMr3j3v3Irsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gqIOxIms8vM=:pph4yRg8nRl21wwKJNPQ+Z
 6NKK8Cctg+xPhR5ro6uKyTZ7EdhisfjWNdm1CmGzGY4cxC/ubqu5Lh0fx/KEerYk1IaBh546u
 lyObu/dldb1QHQOGLykgn4no5tX4eg8A4/1JwdR1mFqrS/xjk2D5dTGEef+zCWGYpKUkxYjTu
 +ON+XSQ17eAd+zAOBC6AKO0E++LjP1ddNd4syw+F9zhfi5ARbGDhhIQ/QTExe3WplaakBkyZg
 WbFz+2a0w6ycBz5VedjQreaOckLKqYEcjhqGn4//yuMrWV5DcfVRJomOgQdNyIXhFimQQItxy
 QtsAdeQb0FgmhPza5Yc577WC3M6w4ZaN7EVp0dUaTT3+gyL6arRngxC1CKfLdY/4DjztbyFdD
 vTF+nM/JENRDoSIQ/cWd37dy2q2hkHvQH7L4mWJGd+MStBcwGcR3XRlZzYy/tWBD6a+Nr8Cfa
 2wiyO9NwP8iLFXYu99hIU9ipVrNLul0vcGE9/VcjhXkXQSO32CTOJrWWUQyheuwGGFfsGJfj/
 u2yJNzRXuJSPSE0zQhmELo9oBVFx7AXafFrTllZTlMmFhh2bU7o54pjmf3PRct5Q0bG97voqX
 qD1z66M6GH3H/lVzO39VBUo01OiHQE80TRKy3gdUIwbsUogTN8tWadTysL3QW/IWmCuTTMFdy
 j9UgObG2Gu7o3MifLNPND+2kpV+6b5JlA/97WurCFfAxoES/D1W7ODGPhARYv6E8NvEA11/Om
 g3XMov/kUaFuSRtrevz+zr3WvAE/S1ZIP/AEpZuHagIOF1PZB0XTu3yPRlNJt1/NkenLhegKw
 KBWMje0f8yUsrwspi3vV/hGAF84EqIh/uQzLoBYHDt6t56Ll6Q=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 14:20:06 +0100

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/sm501.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 4f4957ea8fa3..55d19fd0994e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1050,13 +1050,13 @@ static int sm501_register_gpio(struct sm501_devdata *sm)
 	spin_lock_init(&gpio->lock);
 
 	gpio->regs_res = request_mem_region(iobase, 0x20, "sm501-gpio");
-	if (gpio->regs_res == NULL) {
+	if (!gpio->regs_res) {
 		dev_err(sm->dev, "gpio: failed to request region\n");
 		return -ENXIO;
 	}
 
 	gpio->regs = ioremap(iobase, 0x20);
-	if (gpio->regs == NULL) {
+	if (!gpio->regs) {
 		dev_err(sm->dev, "gpio: failed to remap registers\n");
 		ret = -ENXIO;
 		goto err_claimed;
@@ -1358,7 +1358,7 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 			sm501_register_gpio(sm);
 	}
 
-	if (pdata && pdata->gpio_i2c != NULL && pdata->gpio_i2c_nr > 0) {
+	if (pdata && pdata->gpio_i2c && pdata->gpio_i2c_nr > 0) {
 		if (!sm501_gpio_isregistered(sm))
 			dev_err(sm->dev, "no gpio available for i2c gpio.\n");
 		else
@@ -1384,7 +1384,7 @@ static int sm501_plat_probe(struct platform_device *dev)
 	int ret;
 
 	sm = kzalloc(sizeof(*sm), GFP_KERNEL);
-	if (sm == NULL) {
+	if (!sm) {
 		ret = -ENOMEM;
 		goto err1;
 	}
@@ -1402,8 +1402,7 @@ static int sm501_plat_probe(struct platform_device *dev)
 
 	sm->io_res = platform_get_resource(dev, IORESOURCE_MEM, 1);
 	sm->mem_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-
-	if (sm->io_res == NULL || sm->mem_res == NULL) {
+	if (!sm->io_res || !sm->mem_res) {
 		dev_err(&dev->dev, "failed to get IO resource\n");
 		ret = -ENOENT;
 		goto err_res;
@@ -1411,8 +1410,7 @@ static int sm501_plat_probe(struct platform_device *dev)
 
 	sm->regs_claim = request_mem_region(sm->io_res->start,
 					    0x100, "sm501");
-
-	if (sm->regs_claim == NULL) {
+	if (!sm->regs_claim) {
 		dev_err(&dev->dev, "cannot claim registers\n");
 		ret = -EBUSY;
 		goto err_res;
@@ -1421,8 +1419,7 @@ static int sm501_plat_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, sm);
 
 	sm->regs = ioremap(sm->io_res->start, resource_size(sm->io_res));
-
-	if (sm->regs == NULL) {
+	if (!sm->regs) {
 		dev_err(&dev->dev, "cannot remap registers\n");
 		ret = -EIO;
 		goto err_claim;
@@ -1448,7 +1445,7 @@ static void sm501_set_power(struct sm501_devdata *sm, int on)
 {
 	struct sm501_platdata *pd = sm->platdata;
 
-	if (pd == NULL)
+	if (!pd)
 		return;
 
 	if (pd->get_power) {
@@ -1573,7 +1570,7 @@ static int sm501_pci_probe(struct pci_dev *dev,
 	int err;
 
 	sm = kzalloc(sizeof(*sm), GFP_KERNEL);
-	if (sm == NULL) {
+	if (!sm) {
 		err = -ENOMEM;
 		goto err1;
 	}
@@ -1624,15 +1621,14 @@ static int sm501_pci_probe(struct pci_dev *dev,
 
 	sm->regs_claim = request_mem_region(sm->io_res->start,
 					    0x100, "sm501");
-	if (sm->regs_claim == NULL) {
+	if (!sm->regs_claim) {
 		dev_err(&dev->dev, "cannot claim registers\n");
 		err= -EBUSY;
 		goto err3;
 	}
 
 	sm->regs = pci_ioremap_bar(dev, 1);
-
-	if (sm->regs == NULL) {
+	if (!sm->regs) {
 		dev_err(&dev->dev, "cannot remap registers\n");
 		err = -EIO;
 		goto err4;
-- 
2.16.2
