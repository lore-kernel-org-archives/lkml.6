Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA050C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76140217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsn/CgGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfBFQHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:07:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46829 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:07:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so5711018lfc.13;
        Wed, 06 Feb 2019 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rujl7kw6twe6IHDOqyal91pzUIV1BTP3REMjoYm6+U=;
        b=Gsn/CgGzvQmfOaW5jcm2HkZkvrTjBxgHHZTwH5z6fVhabe2hF+Nk8SfrSBWwD0Wxl1
         t4cfMDtMJO8FdmQ9ofPKc1koTrT3aUIu9Vf1LTME6jy3fKUgWqXHfUTqL7cAaNEXLuSv
         TPtc3p/CKwdi+2ojHK/hxn7u5D7JNGC7US2sJ+qapHifmGcfQpCcO0sGk0gLgdg9/VzO
         GIKZqK2Aa5VHqebNGW7cZIAgm5V2U0aatBjG8bKLn8Yp5175Wjb5xMd7Ins/S45g4XM5
         7BHzAeXiscSi67E2ONsdUTxkQihn4uuDwDu4+vauQYF8e2EgH8sevcl5BXoGuSIzUDJ5
         zFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rujl7kw6twe6IHDOqyal91pzUIV1BTP3REMjoYm6+U=;
        b=gjMEbIuQIwr2ZoEI8iTRJ0lQhisgi9y7bkaif1HDU3hUILm25cFpzQqHTDdm4EmDaX
         mr8cLrS7D89aswCUuJld7gIUiDABuPSSoS61Mmgt8TPlhLW5lHt2L1gNAMHdwz8oxNjX
         YPEZ1sZvjKNlX9bNlB73Fzxm4jxIokgcUrRXg4qZLRIavxcaD9PhCvU8BTk5ye8taukZ
         I1TtSkJ335WZIjccnlQsa5XnP8G/zjpUYgGh1QexcMJva5dHRKXNkwicJHcNuG5PZ7B4
         vmnq/6+NYDU81X/sydBc48bs629CyBThdk3hc9BwIrXaT6DVeRuf/hgqJwfiq0q8uv8c
         DNUA==
X-Gm-Message-State: AHQUAuZahFEOBXnyqGAOmv+dxUGHUF51Bcw2VMXrHc8CCMMNLCSYz6mC
        EAhdMpYeTDUARYYVT/B5UIbIpA1N
X-Google-Smtp-Source: AHgI3IaTql2leOa+5fgQ1QW3JZhl0TINeFgK8cKKgR0SlJYXRjinqaWWrze9APhUUs7xC1K/KCOFKQ==
X-Received: by 2002:a19:760a:: with SMTP id c10mr7039748lff.53.1549469241693;
        Wed, 06 Feb 2019 08:07:21 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id s9-v6sm3805737lja.12.2019.02.06.08.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:07:21 -0800 (PST)
Subject: Re: [PATCH V13 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
 <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
 <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33988DCC1F4997AAF2112447C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9c6524ec-b40b-5b0f-eb70-f9ce2c426fd9@gmail.com>
Date:   Wed, 6 Feb 2019 19:07:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33988DCC1F4997AAF2112447C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 18:55, Sowjanya Komatineni пишет:
> 
> 
>>> Two ";;" at the end.
>>>
>>>
>>>
>>> Good news: DVC I2C works now and tps6586x probes fine! :) Bad news: 
>>> atmel-touch still has same problems as in V12 :(
>>>
>>> DMA-only V13: http://dpaste.com/0XJ1Z8G.txt
>>
>> Strangely, there are many transactions to touch and all of them are good except DMA timeout only when reading T44 and T5 atmel_mxt_ts 0-004c: Failed to read T44 and T5 (-110)
> 
> [    0.923138] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> [    0.923148] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.923337] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> [    0.923347] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> [    0.923355] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> [    0.935048] tegra-i2c 7000d000.i2c: starting DMA for length: 16
> [    0.935058] tegra-i2c 7000d000.i2c: unmasked irq: 0c
> [    1.028750] tegra-i2c 7000c000.i2c: DMA transfer timeout
> [    1.028816] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer failed (-110)
> 
> Looking into timestamps and transactions, DMA timeouts after start of DMA for I2C1 to touch during this transaction.
> While it is waiting for I2C1 DMA transfer, lots of DVC transactions happened thru DMA which are successful
> 
> What is the I2C1 speed?

400KHz

> Also incase if device is running slow for some reason, probably timeout was not enough as this patch series changes timeout with base 100mS + msg transfer time based on transfer size.
> Can you give quick try with increased timeout incase if device is running slow?
> 

Tried to increase the timeout to 1 second, doesn't help.

What helped again is the I2C HW resetting after each transfer. Likely that means that HW isn't programmed correctly, please carefully check every bit.

DMA-only + I2C HW reset: http://dpaste.com/26AQXFM.txt

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index a9391c3646b6..e0a569b69572 100644
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
@@ -1044,8 +1046,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
                xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
 
        xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
-       i2c_dev->is_curr_dma_xfer = (xfer_size > I2C_PIO_MODE_MAX_LEN) &&
-                                   i2c_dev->dma_buf;
+       i2c_dev->is_curr_dma_xfer = !!i2c_dev->dma_buf;
        tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
        dma = i2c_dev->is_curr_dma_xfer;
 
@@ -1203,10 +1204,10 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
                i2c_dev->msg_err);
 
        i2c_dev->is_curr_dma_xfer = false;
+       tegra_i2c_init(i2c_dev, true);
        if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
                return 0;
 
-       tegra_i2c_init(i2c_dev, true);
        /* start recovery upon arbitration loss in single master mode */
        if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
                if (!i2c_dev->is_multimaster_mode)
