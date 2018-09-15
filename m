Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C320ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31A5208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCcvA0R4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31A5208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeIONsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 09:48:20 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41143 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIONsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 09:48:19 -0400
Received: by mail-pl1-f179.google.com with SMTP id b12-v6so5215115plr.8;
        Sat, 15 Sep 2018 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=g9G0LCjIhEqqOgc/LH49pCBf+8Zu5XhNdM9Rks8TeSk=;
        b=jCcvA0R4z7nxEQ4RByqMuVJVi+xmD7AqvqGDtezWMyvUCbCbgIMPqFy3U0RQU5FwjX
         0bAlkapYr38nzjS7ckCCYFfUVCEO6WOUW+dPOW5r1L4zxS4ClxFdxwqVxrWD+n5Hg+s+
         3OZgiUdwwWQeexhH7sMdk3qaxN1HoeK3Mo+4VGmSdT+izH/4/CqxzRzIkqi1x9A8NOCP
         7uhPlCBDGZwhskPYTFJoYP9IuJ1hr5+2bVTRA6N7sXaToFDLQKEy7qBOtIKPTBAytd9O
         wA8WZQCDq47TRy/wRYkysKkdqsbkpaTXOBr7TSxbr63xE+77aX8t0/3MUOWxFEiF21SI
         B29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=g9G0LCjIhEqqOgc/LH49pCBf+8Zu5XhNdM9Rks8TeSk=;
        b=uZcTEYFVadUs0z4MUu6c2vk35KYZpIisoDKIJ0R4zZfPI1RIkAeADDvwkb7LZU7emE
         QX93duMTNYsNuVse/Yf7OV8yxvzhUSJN/BwfQp8w1foKzUZiZzlYVwpaOtHzVfBI+vCA
         uOJTKvDdgScjmhcZ5Djx8J55FWzCtIRy7Tn1c2+6HqxJcGPRr7qYnT6nfHuYfoBH+nDL
         Z9cXKaLedrp6gwfUWOlDVwT6S3gNApEFGFPh2Cd/nAyMGeIAKv5X+4BRE+HuZ1xALfA2
         JKY0nUbZGFO6RFYClvOsfr7hLmDgzdCtDUOkDT/2yRzwetwGdy1ktPsX5wlNKmUiz/tj
         0u9Q==
X-Gm-Message-State: APzg51B8Ueq6p5OxvDaVTBlXjFp8XRopTowJdCqRck3TOw+UGXlqlimP
        CtBJCIlZQuPM3xc1aMj6cM2/Zrbb
X-Google-Smtp-Source: ANB0VdZ/SheRkP7ABMZaTrvUFxeCnq6D47nsOC0/BacVtZpmhyU8U1t3GfjE4eY8sw1t5JglIn8tdQ==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7-v6mr15959894plt.128.1537000209547;
        Sat, 15 Sep 2018 01:30:09 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id b126-v6sm13118115pga.49.2018.09.15.01.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 01:30:09 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] net: wireless: ath9k: Possible sleep-in-atomic-context bugs
To:     ath9k-devel@qca.qualcomm.com, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <9cb1a877-f62b-c70b-d537-6552323de8ae@gmail.com>
Date:   Sat, 15 Sep 2018 16:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My static analysis tool DSAC reports some bugs caused by mutex_lock() in 
ath9k_regwrite_buffer() and ath9k_reg_rmw_buffer().

Here are the related function call paths (from bottom to top) in Linux-4.17:

[FUNC] mutex_lock_nested
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 329:
     mutex_lock_nested in ath9k_regwrite_buffer
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 353:
     ath9k_regwrite_buffer in ath9k_regwrite
drivers/net/wireless/ath/ath9k/mac.c, 146:
     [FUNC_PTR]ath9k_regwrite in ath9k_hw_abort_tx_dma
drivers/net/wireless/ath/ath9k/xmit.c, 1911:
     ath9k_hw_abort_tx_dma in ath_drain_all_txq
drivers/net/wireless/ath/ath9k/main.c, 225:
     ath_drain_all_txq in ath_prepare_reset
drivers/net/wireless/ath/ath9k/main.c, 307:
     ath_prepare_reset in ath_reset_internal
drivers/net/wireless/ath/ath9k/main.c, 295:
     spin_lock_bh in ath_reset_internal

[FUNC] mutex_lock_nested
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 392:
     mutex_lock_nested in ath9k_reg_rmw_buffer
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 509:
     ath9k_reg_rmw_buffer in ath9k_reg_rmw
drivers/net/wireless/ath/ath9k/mac.c, 148:
     [FUNC_PTR]ath9k_reg_rmw in ath9k_hw_abort_tx_dma
drivers/net/wireless/ath/ath9k/xmit.c, 1911:
     ath9k_hw_abort_tx_dma in ath_drain_all_txq
drivers/net/wireless/ath/ath9k/main.c, 225:
     ath_drain_all_txq in ath_prepare_reset
drivers/net/wireless/ath/ath9k/main.c, 307:
     ath_prepare_reset in ath_reset_internal
drivers/net/wireless/ath/ath9k/main.c, 295:
     spin_lock_bh in ath_reset_internal

[FUNC] mutex_lock_nested
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 392:
     mutex_lock_nested in ath9k_reg_rmw_buffer
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 509:
     ath9k_reg_rmw_buffer in ath9k_reg_rmw
drivers/net/wireless/ath/ath9k/hw.c, 2188:
     [FUNC_PTR]ath9k_reg_rmw in ath9k_hw_set_power_awake
drivers/net/wireless/ath/ath9k/hw.c, 2237:
     ath9k_hw_set_power_awake in ath9k_hw_setpower
drivers/net/wireless/ath/ath9k/main.c, 125:
     ath9k_hw_setpower in ath9k_ps_wakeup
drivers/net/wireless/ath/ath9k/main.c, 386:
     ath9k_ps_wakeup in ath9k_tasklet (tasklet handler)

[FUNC] mutex_lock_nested
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 329:
     mutex_lock_nested in ath9k_regwrite_buffer
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 353:
     ath9k_regwrite_buffer in ath9k_regwrite
drivers/net/wireless/ath/ath9k/htc_drv_init.c, 503:
     [FUNC_PTR]ath9k_regwrite in ath9k_reg_rmw
drivers/net/wireless/ath/ath9k/hw.c, 2188:
     [FUNC_PTR]ath9k_reg_rmw in ath9k_hw_set_power_awake
drivers/net/wireless/ath/ath9k/hw.c, 2237:
     ath9k_hw_set_power_awake in ath9k_hw_setpower
drivers/net/wireless/ath/ath9k/main.c, 125:
     ath9k_hw_setpower in ath9k_ps_wakeup
drivers/net/wireless/ath/ath9k/main.c, 386:
     ath9k_ps_wakeup in ath9k_tasklet (tasklet handler)

Note that [FUNC_PTR] means a function pointer call is used.

I am not sure how to well fix these bugs if they are real.


Best wishes,
Jia-Ju Bai
