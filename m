Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356BAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD5F20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA/Dsuiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfBFNS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:18:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33977 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfBFNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:18:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id v14-v6so3209951ljv.1;
        Wed, 06 Feb 2019 05:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c+IE8Yz4vmq2TOpJoyl6QgxO1q5p0wtdsDhb+U6O/4M=;
        b=uA/DsuiuFHstDk6LjG/2n2Gac+TaqepdVWD7sbbhKXCwfaMm4PjWtTyTR2QjtgqAqW
         UqOJmah+XJVDplGbgnJRi4yPpQXtFGPquy+jjc2Cuuj2zNNlMubu9CGuOHGLbQBrecWO
         adqz7BTq6pdfW6daR6SOYMkhBKZXwFsgQTprKWV3De4ehgxHL1PLVEoif0W3mYGlB+ym
         5jGyERp4ZYmNk+fS9phMmTKGRORQBASKci7YrQmaIxNV1t+5P3bEw2BakbuvILmAG0qV
         xq0FYz+QS4meMj2KH663YzZwTAWI2dAcsuygusphjQfigL92KuNd9oNgClXBeJkNHGxl
         pWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c+IE8Yz4vmq2TOpJoyl6QgxO1q5p0wtdsDhb+U6O/4M=;
        b=H0y07ThKmsy6o3SETv5l2xhGpcuYWbcAldVbYxvsJCX5zt3pNK4V/f8nPlONzhAhsw
         TM6a40W1suQK8pHWVEa/lRbF+ia7c+v/vGvOtJx98lplEF3peOw2ZLIM8WgWq6zVy5zM
         bVEt1uI+JhjglWataDYX4QHkvjVNyHJvwbceVZw7Ip2AlTycXjaLBx7eGxQF8bI3bM1m
         QAXi9ZFA/fIuz+Dj67XoqJJjs2ZdbBCCepVcH0wcX8F5kSSNomZh3MZiAB0vKRHdhivk
         a8N1LNT/dF8mgAzz52jpnszvgGh0Py9nVikXSTSANcSjLxs3RkpdSPL6HRsUmVOpK2K1
         XERg==
X-Gm-Message-State: AHQUAua7snt5IWm8dZch7CRVTjZNOFYD04bQVMlQZJxPR0zSToJgvhOy
        ACuOUxxxuT7lQrE9whOpI2KRTsv+
X-Google-Smtp-Source: AHgI3Ibtk8sAnwL+UAlZp/6nml3bQqIXBfzq9y2jQgzHa1FTqQgd3jOBXhSq3WU7a7BBGSaqA1/Mhg==
X-Received: by 2002:a2e:8894:: with SMTP id k20-v6mr1954888lji.138.1549459103362;
        Wed, 06 Feb 2019 05:18:23 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id z17sm4037024lfh.9.2019.02.06.05.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:18:22 -0800 (PST)
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
Date:   Wed, 6 Feb 2019 16:18:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206131310.GK21676@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 16:13, Thierry Reding пишет:

[snip]

>> That's odd because it suggests that DMA actually completed, but the
>> message didn't.
>>
>> I'm not sure I understand how that could happen.
>>
>> What's also weird above is that there doesn't seem to be a DMA that
>> is started for that particular message. Or is the timeout message a
>> response to the prior transfer (length 10)? Seems like that should
>> not be possible because we get the "transfer complete" message.
> 
> Wait, those are actually different instances of the I2C controller, so
> the relevant log entries are these:
> 
> 	[    0.945445] tegra-i2c 7000d000.i2c: starting DMA for length: 16
> 	[    0.945456] tegra-i2c 7000d000.i2c: unmasked irq: 0c
> 	...
> 	[    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out
> 
> And these don't happen if you use higher burst sizes or before the DMA
> series?

I tried to enforce DMA without changing bursts:

----------
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c538ed5f8e2c..5d1c54ce7800 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -6,6 +6,8 @@
  * Author: Colin Cross <ccross@android.com>
  */
 
+#define DEBUG
+
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -1046,8 +1048,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
                xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
 
        xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
-       i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
-                                   i2c_dev->dma_buf;
+       i2c_dev->is_curr_dma_xfer = !!i2c_dev->dma_buf;
        tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
        dma = i2c_dev->is_curr_dma_xfer;
----------

Here is the log with this change:

[    0.760796] tegra_rtc 7000e000.rtc: registered as rtc1
[    0.760850] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
[    0.761050] i2c /dev entries driver
[    0.918928] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.918940] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919040] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919050] tegra-i2c 7000c000.i2c: starting DMA for length: 8
[    0.919059] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919322] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919335] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.919343] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.919440] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.919448] tegra-i2c 7000c000.i2c: starting DMA for length: 112
[    0.919456] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.922818] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.922829] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware V1.0.AA Objects: 18
[    0.922886] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.922895] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.922993] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.923002] tegra-i2c 7000c000.i2c: starting DMA for length: 224
[    0.923011] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.933253] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
[    0.933287] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    0.933297] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.933478] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    0.933487] tegra-i2c 7000c000.i2c: starting DMA for length: 12
[    0.933496] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    0.945120] tegra-i2c 7000d000.i2c: starting DMA for length: 16
[    0.945130] tegra-i2c 7000d000.i2c: unmasked irq: 0c
[    1.038917] tegra-i2c 7000c000.i2c: DMA transfer timeout
[    1.038982] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer failed (-110)
[    1.039000] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    1.039006] atmel_mxt_ts 0-004c: Failed to read T44 and T5 (-110)
[    1.039009] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.039148] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.039157] tegra-i2c 7000c000.i2c: starting DMA for length: 4
[    1.039166] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.039304] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.039340] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    1.039349] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.039535] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.039544] tegra-i2c 7000c000.i2c: starting DMA for length: 12
[    1.039552] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.040055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.040083] tegra-i2c 7000c000.i2c: starting DMA for length: 16
[    1.040092] tegra-i2c 7000c000.i2c: unmasked irq: 0c
[    1.040301] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
[    1.048934] tegra-i2c 7000d000.i2c: i2c transfer timed out
