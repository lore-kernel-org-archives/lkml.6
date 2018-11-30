Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C35C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93A720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwfmIAFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93A720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeLAESA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:18:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35751 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeLAER7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:17:59 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so10313072itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 09:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssFdWs6bxUUibq3eHbp6t6yHleTrE6fqthmd1fbb+Os=;
        b=MwfmIAFiFoUXy+y47GKAMUn/O3XekcQfDHNCs06cIQHKKRTpTctz2zcj+KyXw2Zk3U
         amK/yQyArwdQoV13q/NzY2aM0Gaz394slrszYQdTOvF4Rk5qY3FpP/ZcdFNYgcY1svsV
         XeQLFujsb/Pay4YubZ6cJZ46unFHYhRM7YtAeJ5+7am7bOLuONTYkWraKPHPYQFgsSS6
         iLD9efpLeInixEgZdoGwsgg+SAOvSBPQYncUBblZvbWCAAELRdv9X7M94t0K0ipmNzHG
         eMaJGWA4Zn8HmsMH3lwgpufvJe1NX1413rN72lunNyJOMg3eVyJpHA4EmPaoEfaMgBxQ
         Jhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssFdWs6bxUUibq3eHbp6t6yHleTrE6fqthmd1fbb+Os=;
        b=ia20o34mUa7/dEVdMMExqojt7yqEAZkC8+hQHuBi8Iok425a58L8XqUjMsKgSkNs14
         jkEGI+PbQIErv853ZTW81PQmLqdav9BM7IYcnxS0L6AnuswHkeCYIHdhyLe8slH9aHD1
         q2RJSZUwQjTkm/yUGB0LnGPUFY8Y5hvRqg1P5dBMz1m/gaWXHWlPpVXHqtpbjGzSmCFn
         Mmj6OSuMBLabYXZUh5c36xnDFEsDyuYYnUhjr1O6Ay/nfEEGGnuIWzrG+kDyjAqxGLYJ
         tVcjWLi7KJtGcT506ap6TmxcQ/JUNrOR199tMGBWz/2FduX8RaMAYITOgA7onOxejpLJ
         bD/w==
X-Gm-Message-State: AA+aEWZUuRoBTgeUPqIkGrhT4eMdZ0DDOlLpzujtKJBkVf+DceINuXOl
        glLSxK+ijUcLYTCXz9SCr7OrujG2
X-Google-Smtp-Source: AFSGD/UPhgsaHTvDXJxXIbFuHPb0jLrV9wXf42yJ/hRmMbPy+2kBr2ClDRJU+OKyncmXplHw0lRqeQ==
X-Received: by 2002:a24:a3c7:: with SMTP id p190mr5520267ite.39.1543597681900;
        Fri, 30 Nov 2018 09:08:01 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id u26sm2143387iob.31.2018.11.30.09.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:08:01 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bus: imx-weim: support multiple address ranges per child node
Date:   Fri, 30 Nov 2018 12:07:53 -0500
Message-Id: <20181130170754.346-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130170754.346-1-TheSven73@googlemail.com>
References: <20181130170754.346-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <TheSven73@googlemail.com>

Ensure that timing values for the child node are applied to
all chip selects in the child's address ranges.

Note that this does not support multiple timing settings per
child; this can be added in the future if required.

Example:
&weim {
	acme@0 {
		compatible = "acme,whatever";
		reg = <0 0 0x100>, <0 0x400000 0x800>,
				<1 0x400000 0x800>;
		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
				0x00000000 0xa0000240 0x00000000>;
	};
};

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/bus/imx-weim.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index f01308172de9..24f22285395d 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -46,6 +46,7 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
 };
 
 #define MAX_CS_REGS_COUNT	6
+#define OF_REG_SIZE		3
 
 static const struct of_device_id weim_id_table[] = {
 	/* i.MX1/21 */
@@ -115,27 +116,40 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 				    const struct imx_weim_devtype *devtype)
 {
 	u32 cs_idx, value[MAX_CS_REGS_COUNT];
-	int i, ret;
+	int i, ret, reg_idx, num_regs;
 
 	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
 		return -EINVAL;
 
-	/* get the CS index from this child node's "reg" property. */
-	ret = of_property_read_u32(np, "reg", &cs_idx);
+	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
+					 value, devtype->cs_regs_count);
 	if (ret)
 		return ret;
 
-	if (cs_idx >= devtype->cs_count)
+	/*
+	 * the child node's "reg" property may contain multiple address ranges,
+	 * extract the chip select for each.
+	 */
+	num_regs = of_property_count_elems_of_size(np, "reg", OF_REG_SIZE);
+	if (num_regs < 0)
+		return num_regs;
+	if (!num_regs)
 		return -EINVAL;
+	for (reg_idx = 0; reg_idx < num_regs; reg_idx++) {
+		/* get the CS index from this child node's "reg" property. */
+		ret = of_property_read_u32_index(np, "reg",
+					reg_idx*OF_REG_SIZE, &cs_idx);
+		if (ret)
+			break;
 
-	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
-					 value, devtype->cs_regs_count);
-	if (ret)
-		return ret;
+		if (cs_idx >= devtype->cs_count)
+			return -EINVAL;
 
-	/* set the timing for WEIM */
-	for (i = 0; i < devtype->cs_regs_count; i++)
-		writel(value[i], base + cs_idx * devtype->cs_stride + i * 4);
+		/* set the timing for WEIM */
+		for (i = 0; i < devtype->cs_regs_count; i++)
+			writel(value[i],
+				base + cs_idx * devtype->cs_stride + i * 4);
+	}
 
 	return 0;
 }
-- 
2.17.1

