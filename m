Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BB5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29DE218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3WjJxy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBGQBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:01:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35853 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:01:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so331632ljk.3;
        Thu, 07 Feb 2019 08:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0hb7mhIcWYO8Hy4Jq2vMYoJNGGzli3JGrmu0OTJq/SQ=;
        b=r3WjJxy4lzzuiQlMUxIEPJhLCGWFZBYvYbVj6X0Lksog3DyezepPTRWFIfQVncL7+D
         pB8ezzvkrWqQrWmcimkyA60UgeJE+QbKhUWQGTaRXEG44WcAtRLWg8eK5nCk/wnjIWlV
         J/wOhUQFuTzWSARkX2FS3dy4/X4wLPSBbqxczfXDYtud/mAA8r8J+irRV16D7wKuMwef
         N6WBNVQAJ9P94Q9DwJkYfMExSwehtBKhDjOaQZL8w2X6s7+7CWjAXE9cjeSc1GdlE41N
         ZDH59hWhp2EEPsQPqN5EhEXNRiXWaLzvDjCQKs2YsZ96PGV2FpMz2gonitQmrfM4rQq+
         0ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0hb7mhIcWYO8Hy4Jq2vMYoJNGGzli3JGrmu0OTJq/SQ=;
        b=PAvZ/zNSZba0sYuq7WDyzIXcVi3ZBJ4/Pj5m9p8A7eqlVS8rqdymfnq9CrW6AXHKMg
         70EJiB8S4exbA8srtycx70cctP8MMTII8WqqQio+jGcu0C+ZOAAlMsC18K52LUkmAF5F
         f+dPSpdAYEdd7OQsFmckfo7wVe4HNPf35y7+hX2IR0BnESdYbpxdQvw/w7xprq/e7am7
         +x/zkBZVFBm5Eju7UYtZhY6D0+oyqxEFIDi9oSJycnWK4k5FpZ/p2zFoH9mhSmrrayuc
         FkjQQbOlRi/IFDu1r2yOigDcvO0Uy+4MCJL58LrxvAJl4LSYpXvs4ybcY/pixQE459JF
         T66g==
X-Gm-Message-State: AHQUAuZS5A7VJ7u15Kj9z6o6w7JzRlA3SjDBgFmc+vWMQQ0BGz9IIrEL
        +Ch262eNuzTnB/EbML9S9Leui3P2
X-Google-Smtp-Source: AHgI3Iat6j1LBX2eReIgM0VELzJ1NQYzU4kizT//SKpyRqzOYxvhnySzBdrMhbID+Td6ruGmL07I3w==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr10610832ljk.80.1549555307500;
        Thu, 07 Feb 2019 08:01:47 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id d70sm2736193lfe.14.2019.02.07.08.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:01:46 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
 <BYAPR12MB3398350797241F90AE347FB5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a7d62c4-9dcd-08dd-4e3f-877184848daa@gmail.com>
Date:   Thu, 7 Feb 2019 19:01:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3398350797241F90AE347FB5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2019 18:23, Sowjanya Komatineni пишет:
> 
>> It became apparent to me that there is a problem here. The size of dma_buf is 4096 bytes and maximum message length is 4096 too, we have pushed 12 bytes packet_header to the buffer >and now there are 4084 bytes left for the message in the buffer. Hence transfer of 4KB will cause buffer overflow and either crash kernel or corrupt memory. One solution is to just always >push packet_header using PIO, other to reduce max_write_len or increase dma_buf size.
> 
> Yes, This is known to me and I will add separate patch for this to update quirks to take care for t186 and t194 to exclude packet hdr lengths
> There was separate patch when quirks were added and it got merged already from 5.0-rc1 but don’t want to sneak that here. Will send separate patch to take care of this.
> Need to update quirk to exclude packet header
> 

No. This is a bug of this patch, it must be fixed in this patch as well. 

Please include this snippet into the next version of this patch.

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 7921d3e6237d..0ed8162a37e4 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1293,7 +1293,7 @@ static const struct i2c_algorithm tegra_i2c_algo = {
 static const struct i2c_adapter_quirks tegra_i2c_quirks = {
        .flags = I2C_AQ_NO_ZERO_LEN,
        .max_read_len = 4096,
-       .max_write_len = 4096,
+       .max_write_len = 4096 - I2C_PACKET_HEADER_SIZE,
 };
 
 static const struct i2c_adapter_quirks tegra194_i2c_quirks = {
@@ -1545,7 +1545,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
        i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
                                                  "nvidia,tegra20-i2c-dvc");
        i2c_dev->adapter.quirks = i2c_dev->hw->quirks;
-       i2c_dev->dma_buf_size = i2c_dev->adapter.quirks->max_write_len;
+       i2c_dev->dma_buf_size = i2c_dev->adapter.quirks->max_read_len;
        init_completion(&i2c_dev->msg_complete);
        init_completion(&i2c_dev->dma_complete);
        spin_lock_init(&i2c_dev->xfer_lock);
