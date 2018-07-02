Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6B4244B0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="mtpkdRFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6B4244B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeGBQ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:28:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34109 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeGBQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:28:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so16165157wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MKsy6p8tA1MVGGjKEgjLbg9mT0zCvsdPl5efJmJPJBE=;
        b=mtpkdRFqZRVhKT2aT3Gm23614fUlhBy9N/wkwczr283oWhbz8yrO+Pno8FDlpCI7t1
         8ph3BeUb5tZO0JK8eV4rFjFQ5tcP8CXtWVg85ANdgjmnl0yIOIHkpM7PeUxk+lZtEmhd
         34H6ebQoQ7QiUddGVXBg8NBgO4xgCKpCPz7iuX8ud9NDtGHqwLCMSRVDemzSJoJGJT6l
         LuKVwHo0H/vzCjCOHdP6SPCe7gaVjE9YvLO4980CAzxxBtCObdULsJEoujdhnzaQeFB0
         g9iQP3GNMOtp+0Qstlxvj0gb6fhU5mk+QBkdw1umLMi2c/iFPyDqX2UnsEhqIU1PzjLc
         TNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MKsy6p8tA1MVGGjKEgjLbg9mT0zCvsdPl5efJmJPJBE=;
        b=OpMWl0ApJ+2/3nl7LCgLMfxAc7rJblH9ICsUr2FCNNTLNdF93CV+AEVZLhA86GPIbA
         JB/F3DLWsG5JQ9roZxNzdU3lnYvJE6ByJoCukWh7+Mk17jScxPPcI2Z/s46CD2rvpOZ/
         YuUX7rzOwrfb47Z69534dqeYba0R4YZ7aEc0NLvYL7RcxkCuQ5GdN01/QhAoHWQ1rRiO
         VMFXYQ55o0lHyxAkBAeYeaqtcbON1Wgp23u4HW+ntZ5bAkKciSKMkv5vxhUmkvSV3p0p
         g+UYRd2aQd1LpbPfAitwCv+oqdCwEoQJdvzp2aV7TDmYatIv7PFGFslWtyRiUOyXB2TY
         jqhg==
X-Gm-Message-State: APt69E3aKIN3220uWlAmYdClne7YqzOFHGc6lixJhfrffsfZyslYBZLD
        kusg89QH3UPlFkvpIpOp74xOKA==
X-Google-Smtp-Source: AAOMgpfe6PuoBvxb6cGfX05rug3ZZkqZ1H8KZB4MjKxTNl9XjIBnFWfW5bHohS+gUzlDgIG0o3gYOg==
X-Received: by 2002:adf:8796:: with SMTP id b22-v6mr20724568wrb.92.1530548905788;
        Mon, 02 Jul 2018 09:28:25 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id u7-v6sm8736740wmd.3.2018.07.02.09.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 09:28:25 -0700 (PDT)
Date:   Mon, 2 Jul 2018 18:26:49 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>
Subject: Re: [RFC net-next 08/15] net: lora: sx1276: Add debugfs
Message-ID: <20180702162649.GC2737@nanopsycho.orion>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-9-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180701110804.32415-9-afaerber@suse.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jul 01, 2018 at 01:07:57PM CEST, afaerber@suse.de wrote:
>Allow some interactive inspection at runtime via debugfs.
>
>Signed-off-by: Andreas Färber <afaerber@suse.de>
>---
> drivers/net/lora/sx1276.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 132 insertions(+)
>
>diff --git a/drivers/net/lora/sx1276.c b/drivers/net/lora/sx1276.c
>index d6732111247a..1072019cfcc1 100644
>--- a/drivers/net/lora/sx1276.c
>+++ b/drivers/net/lora/sx1276.c
>@@ -5,6 +5,7 @@
>  * Copyright (c) 2016-2018 Andreas Färber
>  */
> 
>+#include <linux/debugfs.h>
> #include <linux/delay.h>
> #include <linux/lora.h>
> #include <linux/module.h>
>@@ -61,6 +62,8 @@ struct sx1276_priv {
> 
> 	struct workqueue_struct *wq;
> 	struct work_struct tx_work;
>+
>+	struct dentry *debugfs;
> };
> 
> static int sx1276_read_single(struct spi_device *spi, u8 reg, u8 *val)
>@@ -416,6 +419,128 @@ static const struct net_device_ops sx1276_netdev_ops =  {
> 	.ndo_start_xmit = sx1276_loradev_start_xmit,
> };
> 
>+static ssize_t sx1276_freq_read(struct file *file, char __user *user_buf,
>+				 size_t count, loff_t *ppos)
>+{
>+	struct net_device *netdev = file->private_data;
>+	struct sx1276_priv *priv = netdev_priv(netdev);
>+	struct spi_device *spi = priv->spi;
>+	ssize_t size;
>+	char *buf;
>+	int ret;
>+	u8 msb, mid, lsb;
>+	u32 freq_xosc;
>+	unsigned long long frf;
>+
>+	ret = of_property_read_u32(spi->dev.of_node, "clock-frequency", &freq_xosc);
>+	if (ret)
>+		return 0;
>+
>+	mutex_lock(&priv->spi_lock);
>+
>+	ret = sx1276_read_single(spi, REG_FRF_MSB, &msb);
>+	if (!ret)
>+		ret = sx1276_read_single(spi, REG_FRF_MID, &mid);
>+	if (!ret)
>+		ret = sx1276_read_single(spi, REG_FRF_LSB, &lsb);
>+
>+	mutex_unlock(&priv->spi_lock);
>+
>+	if (ret)
>+		return 0;
>+
>+	frf = freq_xosc;
>+	frf *= ((ulong)msb << 16) | ((ulong)mid << 8) | lsb;
>+	frf /= (1 << 19);
>+
>+	buf = kasprintf(GFP_KERNEL, "%llu\n", frf);
>+	if (!buf)
>+		return 0;
>+
>+	size = simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
>+	kfree(buf);
>+
>+	return size;
>+}
>+
>+static const struct file_operations sx1276_freq_fops = {
>+	.owner = THIS_MODULE,
>+	.open = simple_open,
>+	.read = sx1276_freq_read,
>+};
>+
>+static ssize_t sx1276_state_read(struct file *file, char __user *user_buf,
>+				 size_t count, loff_t *ppos)
>+{
>+	struct net_device *netdev = file->private_data;
>+	struct sx1276_priv *priv = netdev_priv(netdev);
>+	struct spi_device *spi = priv->spi;
>+	ssize_t size;
>+	char *buf;
>+	int len = 0;
>+	int ret;
>+	u8 val;
>+	bool lora_mode = true;
>+	const int max_len = 4096;
>+
>+	buf = kzalloc(max_len, GFP_KERNEL);
>+	if (!buf)
>+		return 0;
>+
>+	mutex_lock(&priv->spi_lock);
>+
>+	ret = sx1276_read_single(spi, REG_OPMODE, &val);
>+	if (!ret) {
>+		len += snprintf(buf + len, max_len - len, "RegOpMode = 0x%02x\n", val);
>+		lora_mode = (val & REG_OPMODE_LONG_RANGE_MODE) != 0;
>+	}
>+
>+	ret = sx1276_read_single(spi, REG_FRF_MSB, &val);
>+	if (!ret)
>+		len += snprintf(buf + len, max_len - len, "RegFrMsb = 0x%02x\n", val);
>+	ret = sx1276_read_single(spi, REG_FRF_MID, &val);
>+	if (!ret)
>+		len += snprintf(buf + len, max_len - len, "RegFrMid = 0x%02x\n", val);
>+	ret = sx1276_read_single(spi, REG_FRF_LSB, &val);
>+	if (!ret)
>+		len += snprintf(buf + len, max_len - len, "RegFrLsb = 0x%02x\n", val);
>+
>+	ret = sx1276_read_single(spi, REG_PA_CONFIG, &val);
>+	if (!ret)
>+		len += snprintf(buf + len, max_len - len, "RegPaConfig = 0x%02x\n", val);
>+
>+	if (lora_mode) {
>+		ret = sx1276_read_single(spi, LORA_REG_IRQ_FLAGS_MASK, &val);
>+		if (!ret)
>+			len += snprintf(buf + len, max_len - len, "RegIrqFlagsMask = 0x%02x\n", val);
>+
>+		ret = sx1276_read_single(spi, LORA_REG_IRQ_FLAGS, &val);
>+		if (!ret)
>+			len += snprintf(buf + len, max_len - len, "RegIrqFlags = 0x%02x\n", val);
>+
>+		ret = sx1276_read_single(spi, LORA_REG_SYNC_WORD, &val);
>+		if (!ret)
>+			len += snprintf(buf + len, max_len - len, "RegSyncWord = 0x%02x\n", val);
>+	}
>+
>+	ret = sx1276_read_single(spi, REG_PA_DAC, &val);
>+	if (!ret)
>+		len += snprintf(buf + len, max_len - len, "RegPaDac = 0x%02x\n", val);
>+
>+	mutex_unlock(&priv->spi_lock);
>+
>+	size = simple_read_from_buffer(user_buf, count, ppos, buf, len);
>+	kfree(buf);
>+
>+	return size;
>+}
>+
>+static const struct file_operations sx1276_state_fops = {
>+	.owner = THIS_MODULE,
>+	.open = simple_open,
>+	.read = sx1276_state_read,
>+};
>+
> static int sx1276_probe(struct spi_device *spi)
> {
> 	struct net_device *netdev;
>@@ -566,6 +691,10 @@ static int sx1276_probe(struct spi_device *spi)
> 		return ret;
> 	}
> 
>+	priv->debugfs = debugfs_create_dir(dev_name(&spi->dev), NULL);
>+	debugfs_create_file("state", S_IRUGO, priv->debugfs, netdev, &sx1276_state_fops);
>+	debugfs_create_file("frequency", S_IRUGO, priv->debugfs, netdev, &sx1276_freq_fops);

Hmm. These look like useful information not only for debugging. I think
it would be worth to expose these via some standard uapi. Like generic
netlink, similar to nl80211


>+
> 	dev_info(&spi->dev, "SX1276 module probed (SX%d)", model);
> 
> 	return 0;
>@@ -574,6 +703,9 @@ static int sx1276_probe(struct spi_device *spi)
> static int sx1276_remove(struct spi_device *spi)
> {
> 	struct net_device *netdev = spi_get_drvdata(spi);
>+	struct sx1276_priv *priv = netdev_priv(netdev);
>+
>+	debugfs_remove_recursive(priv->debugfs);
> 
> 	unregister_loradev(netdev);
> 	free_loradev(netdev);
>-- 
>2.16.4
>
