Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C0C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AEC21736
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfq68KFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfA0OzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:55:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32948 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0OzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:55:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so6151757pgu.0;
        Sun, 27 Jan 2019 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:reply-to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pUs45UZZcbeJkGFcL5qafGmL0koavUNJSoBKAP1s2OM=;
        b=Hfq68KFGCliIE8P7vBapIcjv8vVo09k11EGkn7ZLiai6b+8nN92VzPvZxZjon/6VMC
         dfa5wPS/PxZGY85xE8PVzXv6TQyxxCUjVN7I4fGeQJVi0gOnqASut1ql5mZ0JAWEpDcL
         +K/gY82SVMxH1orY8OKRj3DSf2QplcM5/gNEa/jGXAzbvkgzK6a4HB3KA+yDnG17h4CV
         aXajkgCTBdLcpzqyC621KU6h7/nhcle6Xv5cBdWR2puClzD6Bb+1WsomiOX1l/mIJ5XI
         5RE48/CdBQtFhBxUjwvSRzlWtCvzcinnBAYLmeMnRET386KBhHdp/XmzwtZBPjLSXR+e
         AcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:reply-to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=pUs45UZZcbeJkGFcL5qafGmL0koavUNJSoBKAP1s2OM=;
        b=cHtk8ojeI6CpNyaoWtG1CNYT1J93sNRuPJZUFUeDYraWtaflMZAlLQDB+jWd3JzvUW
         u53mk030WcpprFoRqXYMoovSvHdnV7StYDOpkk+omJwZyDWn+720GkE5YiEOyJ1/H5z3
         hM/ufMlmzAZvz63nR+0MGS3/PZGQetrMARyyqJ3cFFKqT7wfuYaWrd1qnNO2THuBZApt
         vVlx05MV6FDO95qqIny6DfBx4uFCVcTneWU72zrfc7YHGAWzEcw9LmCZLUC+duIgNbhy
         XBcd/ghVN6EEu0r7LYqR5RMei7nnnfJpJykNOrEV0g6NW+9qiseiXN7aetZzLgKDAL7F
         HBPA==
X-Gm-Message-State: AJcUukdajXBsLfUnoK7aJO0IuurMU1nI+6eEuDWXYPQ/YXGzBOLvPe8g
        GmozijMpdf5vSV6p4ug3OLA=
X-Google-Smtp-Source: ALg8bN65NdT+EhdkCx/oi8+qFArhDQBQzk0BxNMF+evB/PQf6/NjJqEGj8lEBZwIwCgF5bqcKWqR9g==
X-Received: by 2002:a62:1542:: with SMTP id 63mr18616656pfv.230.1548600905193;
        Sun, 27 Jan 2019 06:55:05 -0800 (PST)
Received: from [192.168.1.82] (host86-147-83-227.range86-147.btcentralplus.com. [86.147.83.227])
        by smtp.gmail.com with ESMTPSA id j6sm53369940pfg.126.2019.01.27.06.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 06:55:04 -0800 (PST)
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-tegra@vger.kernel.org, Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Reply-To: 20190123065620.22250-2-markz@nvidia.com
From:   Billy Laws <blaws05@gmail.com>
Subject: Re: [2/2] mfd: max77620: Add low battery monitor support
Message-ID: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
Date:   Sun, 27 Jan 2019 14:54:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 >This patch adds PMIC configurations for low-battery
 >monitoring by handling max77620 register CNFGGLBL1.
 >
It might be an idea to add lbhyst configuration here and support using
custom lbdac values to specify a different cutoff point.

See: https://datasheetspdf.com/pdf-file/924230/Maxim/MAX8698C/1  pg 46
 >Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
 >Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
 >Signed-off-by: Mark Zhang <markz@nvidia.com>
 >---
 > drivers/mfd/max77620.c | 57 +++++++++++++++++++++++++++++++++++++++++-
 > 1 file changed, 56 insertions(+), 1 deletion(-)
 >
 >diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
 >index f58143103185..9e50d145afd8 100644
 >--- a/drivers/mfd/max77620.c
 >+++ b/drivers/mfd/max77620.c
 >@@ -474,6 +474,57 @@ static int 
max77620_init_backup_battery_charging(struct max77620_chip *chip)
 >  return ret;
 > }
 >
 >+static int max77620_init_low_battery_monitor(struct max77620_chip *chip)
 >+{
 >+ struct device *dev = chip->dev;
 >+ struct device_node *np;
 >+ bool pval;
 >+ u8 mask = 0;
 >+ u8 val = 0;
 >+ int ret;
 >+
 >+ np = of_get_child_by_name(dev->of_node, "low-battery-monitor");
 >+ if (!np) {
 >+ dev_info(dev, "Low battery monitoring support disabled\n");
 >+ return 0;
 >+ }
 >+
 >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-enable");
 >+ if (pval) {
 >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
 >+ val |= MAX77620_CNFGGLBL1_LBDAC_EN;
 >+ }
 >+
 >+ pval = of_property_read_bool(np, "maxim,low-battery-dac-disable");
 >+ if (pval)
 >+ mask |= MAX77620_CNFGGLBL1_LBDAC_EN;
 >+
 >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-enable");
 >+ if (pval) {
 >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
 >+ val |= MAX77620_CNFGGLBL1_MPPLD;
 >+ }
 >+
 >+ pval = of_property_read_bool(np, "maxim,low-battery-shutdown-disable");
 >+ if (pval)
 >+ mask |= MAX77620_CNFGGLBL1_MPPLD;
 >+
 >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-enable");
 >+ if (pval) {
 >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
 >+ val |= MAX77620_CNFGGLBL1_LBRSTEN;
 >+ }
 >+
 >+ pval = of_property_read_bool(np, "maxim,low-battery-reset-disable");
 >+ if (pval)
 >+ mask |= MAX77620_CNFGGLBL1_LBRSTEN;
 >+
 >+ ret = regmap_update_bits(chip->rmap, MAX77620_REG_CNFGGLBL1, mask, val);
 >+ if (ret < 0)
 >+ dev_err(dev, "Reg CNFGGLBL1 update failed: %d\n", ret);
 >+ return ret;
 >+}
 >+
 > static int max77620_read_es_version(struct max77620_chip *chip)
 > {
 >  unsigned int val;
 >@@ -563,7 +614,11 @@ static int max77620_probe(struct i2c_client *client,
 >  if (ret < 0)
 >  return ret;
 >
 >- ret =  devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
 >+ ret = max77620_init_low_battery_monitor(chip);
 >+ if (ret < 0)
 >+ return ret;
 >+
 >+ ret = devm_mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE,
 >      mfd_cells, n_mfd_cells, NULL, 0,
 >      regmap_irq_get_domain(chip->top_irq_data));
 >  if (ret < 0) {
