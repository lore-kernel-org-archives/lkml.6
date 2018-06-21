Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D738C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9764208B7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BY3jTZJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9764208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeFUHiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:38:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39000 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754384AbeFUHhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:37:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so2019780wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rjpY3jf6dyNELzucLqZKmEbF+4d8cHbiFvTao+E9Rzk=;
        b=BY3jTZJDROJTX5ddS8XvWoM/grdDGSMrr52ma1z+K8vPigsCTYr6PAMfv76eZoIzpi
         81/dhAU5rn+9G5EVdI1chRx1SpywAN5h5n2g2dYUdDJbl9Q4sGIXvtZt++Rqxiy4pWuS
         8SU1SYeB0uQuJ1dgeLmg9kJIiOTx1ri/dX8402+4Vrp/q1Vbcuw2RQOm47omO6dB13Z4
         HVqRSiw6iKFfUzVSwyfIZd0rBQbQ3ekbNTE/DdiNw/oWJKAGdqUQo9jyD/FOD/vPzgf9
         Ful3k5I+oiCYWtvJUI44uhGJ4Y/ulJZZbj/z7ed3A4IuHu/wNUFoI14+YajxeFXIfene
         MlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rjpY3jf6dyNELzucLqZKmEbF+4d8cHbiFvTao+E9Rzk=;
        b=TqjSVV4lj8VT9R9Knf4JFEpquYxdUSx/JO6+cuv1KK8xvSFVl7cU3Du7rdtysV25pO
         Fhd9PYvTXoXYrQ0f0+TQWnwK5YkrwwdehqgxGrU9vq+m+thgTYiOR2Ilppj+FUqlgPUV
         kuHLUEHzQFUGotFrk1seFyZLHTtUivDjFvqr1p/CxNpOgmJvIdogJZb0bXRlnj4kAF6R
         AG1QbTPIRVoI45zVjAz1JHBuie0N/MLjSvVf+dDTBrxLo9r/1sIpYDxtHO3OJty17r3c
         pq/dR9SBOm64HCN0LSEbgPnlitTQ9Gx1OA5ZLE2yDz9vip++Ip2ys3V1pwg8V9HvAmta
         Mo2Q==
X-Gm-Message-State: APt69E3C5piw5pfAFy7S7T0W66K14cI99AC8ooPhsLiCQTdu57k9he7d
        WGKfglBiwNt2leilJHo3WFuuh6SYmNs=
X-Google-Smtp-Source: ADUXVKJAg/lY1LiN9zDnnIu1N1P7YOOXSWqrqG256kBl+ZKorvcKngLAvqcsRuwWwwYsz9AdHSgKeg==
X-Received: by 2002:adf:9663:: with SMTP id c32-v6mr21717365wra.89.1529566633363;
        Thu, 21 Jun 2018 00:37:13 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l7-v6sm767635wmh.1.2018.06.21.00.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 00:37:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 1/4] remoteproc/davinci: use the reset framework
Date:   Thu, 21 Jun 2018 09:37:03 +0200
Message-Id: <20180621073706.22812-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621073706.22812-1-brgl@bgdev.pl>
References: <20180621073706.22812-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch to using the reset framework instead of handcoded reset routines
we used so far.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/remoteproc/da8xx_remoteproc.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b668e32996e2..76c06b70a1c6 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -20,8 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 
-#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
-
 #include "remoteproc_internal.h"
 
 static char *da8xx_fw_name;
@@ -72,6 +71,7 @@ struct da8xx_rproc {
 	struct da8xx_rproc_mem *mem;
 	int num_mems;
 	struct clk *dsp_clk;
+	struct reset_control *dsp_reset;
 	void (*ack_fxn)(struct irq_data *data);
 	struct irq_data *irq_data;
 	void __iomem *chipsig;
@@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
 	struct device *dev = rproc->dev.parent;
 	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
 	struct clk *dsp_clk = drproc->dsp_clk;
+	struct reset_control *dsp_reset = drproc->dsp_reset;
 	int ret;
 
 	/* hw requires the start (boot) address be on 1KB boundary */
@@ -155,7 +156,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
 		return ret;
 	}
 
-	davinci_clk_reset_deassert(dsp_clk);
+	ret = reset_control_deassert(dsp_reset);
+	if (ret) {
+		dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
+		clk_disable_unprepare(dsp_clk);
+		return ret;
+	}
 
 	return 0;
 }
@@ -163,8 +169,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
 static int da8xx_rproc_stop(struct rproc *rproc)
 {
 	struct da8xx_rproc *drproc = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	int ret;
+
+	ret = reset_control_assert(drproc->dsp_reset);
+	if (ret) {
+		dev_err(dev, "reset_control_assert() failed: %d\n", ret);
+		return ret;
+	}
 
-	davinci_clk_reset_assert(drproc->dsp_clk);
 	clk_disable_unprepare(drproc->dsp_clk);
 
 	return 0;
@@ -232,6 +245,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	struct resource *bootreg_res;
 	struct resource *chipsig_res;
 	struct clk *dsp_clk;
+	struct reset_control *dsp_reset;
 	void __iomem *chipsig;
 	void __iomem *bootreg;
 	int irq;
@@ -268,6 +282,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 		return PTR_ERR(dsp_clk);
 	}
 
+	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(dsp_reset)) {
+		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
+			dev_err(dev, "unable to get reset control: %ld\n",
+				PTR_ERR(dsp_reset));
+
+		return PTR_ERR(dsp_reset);
+	}
+
 	if (dev->of_node) {
 		ret = of_reserved_mem_device_init(dev);
 		if (ret) {
@@ -287,6 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	drproc = rproc->priv;
 	drproc->rproc = rproc;
 	drproc->dsp_clk = dsp_clk;
+	drproc->dsp_reset = dsp_reset;
 	rproc->has_iommu = false;
 
 	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
@@ -309,7 +333,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
 	 * held in reset at the time it is called.
 	 */
-	ret = davinci_clk_reset_assert(drproc->dsp_clk);
+	ret = reset_control_assert(dsp_reset);
 	if (ret)
 		goto free_rproc;
 
-- 
2.17.1

