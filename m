Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE564C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB7B2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1fpCNyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB7B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeH1Msg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:48:36 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:40984 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeH1Msg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:48:36 -0400
Received: by mail-io0-f170.google.com with SMTP id q4-v6so753859iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=kRGWbF5PV5VDlUc4xRxBoDDyYAs513RXkWYqdr5OSQ4=;
        b=B1fpCNyzknO5YHF7ETrKTJlBPaYX0TYcJiHwXtVd1IpD6t+SVWzSDfvf9hvRms/JLJ
         rhqhunl1tiyhDkujTH4hmo+pDy/Z6j2r9wresi6IC4SZSH+YSRJ90vHR1j8blrdRrfW0
         rfWKVyYT8jS2n8aTyWjsCeZxY0xPhiPtrVhKMp1VmJbrwzObS8waNATNM0viaWKp3y43
         RRP5rfvD0ihhaUEf7AQc4KHURydZnHjaASxjlL3qAqBsy22Qo4SsTKPH0Pzuet+SdbTZ
         3leysOvm4maMqH/IWAU35FMjSTiQMXn0NcyThkK4qGZlvC/peHl1Yz9YiGTxVnVez1RX
         ki5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=kRGWbF5PV5VDlUc4xRxBoDDyYAs513RXkWYqdr5OSQ4=;
        b=iEaj6Jia/OQHfxs/QEdioKOTCWt/IGo8zJvp7NLSXtTUUA7CRWyi00H7DMl/lWfAEp
         eqEiTSzM2zzmAcEOCEmklj0qu61ve3Y9CHZmE8EGU2zvRPS7dUkv7OzrXteK3IAi2cnw
         QEI+eeoNrwJMkSEHA8tcGWrXebW6btiWYVBxkzPa/cfa9wqUPqUOm0RBlp0Lm+peYhHy
         F0usH3Jw1ptTNvl2gJlK9W2fFcTd+reyloonjfXca5IvOssZb34bksNROj/4P8JlJ63U
         bbvJLiQYGJGYZWEaMSTlIINz9kqZ8LHT376RHPdvOzFkuTX6OUvo4q6bb4tLRXeovSjy
         9H0A==
X-Gm-Message-State: APzg51B8QBuqttjAtjScd+BBfKn20ycMqDF2NFf0WE/+DATBBSf5vDXf
        glYxzTW+MDmE5r5JfU8VSaNmsobr
X-Google-Smtp-Source: ANB0VdamsR+Er783mK0asmVStioxAtoIgFhmgFwLsiBPV1nnz3CRHWh1D1Gp3jcgvaVMiypPdZMLDQ==
X-Received: by 2002:a6b:3902:: with SMTP id g2-v6mr450140ioa.168.1535446676786;
        Tue, 28 Aug 2018 01:57:56 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.15? ([2402:f000:1:1501:200:5efe:a66f:470f])
        by smtp.gmail.com with ESMTPSA id z13-v6sm255087ioj.51.2018.08.28.01.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 01:57:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] Possible sleep-in-atomic-context bugs involving
 regmap_lock_mutex()
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        songjun.wu@microchip.com, architt@codeaurora.org
Cc:     linux-kernel@vger.kernel.org
Message-ID: <ffbd81ae-fd30-dc57-c3ac-463f7fadb9ac@gmail.com>
Date:   Tue, 28 Aug 2018 16:57:51 +0800
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

Hello,

My static tool DSAC reports many sleep-in-atomic-context bugs involving 
regmap_lock_mutex(), so I wonder whether this function is possible to be 
executed in atomic context.

Here are some example bugs and their call paths in Linux-4.16 (from 
bottom to top, and [FUNC_PTR] means that there is a function pointer call):

[FUNC] mutex_lock_nested
drivers/base/regmap/regmap.c, 468:
     mutex_lock_nested in regmap_lock_mutex
drivers/base/regmap/regmap.c, 2503:
     [FUNC_PTR]regmap_lock_mutex in regmap_read
drivers/clk/clk-aspeed.c, 215:
     regmap_read in aspeed_clk_is_enabled
drivers/clk/clk-aspeed.c, 230:
     aspeed_clk_is_enabled in aspeed_clk_enable
drivers/clk/clk-aspeed.c, 228:
     _raw_spin_lock_irqsave in aspeed_clk_enable

[FUNC] mutex_lock_nested
drivers/base/regmap/regmap.c, 468:
     mutex_lock_nested in regmap_lock_mutex
drivers/base/regmap/regmap.c, 2821:
     [FUNC_PTR]regmap_lock_mutex in regmap_update_bits_base
drivers/clk/clk-aspeed.c, 270:
     regmap_update_bits_base in aspeed_clk_disable
drivers/clk/clk-aspeed.c, 267:
     _raw_spin_lock_irqsave in aspeed_clk_disable

[FUNC] mutex_lock_nested
drivers/base/regmap/regmap.c, 468:
     mutex_lock_nested in regmap_lock_mutex
drivers/base/regmap/regmap.c, 2503:
     [FUNC_PTR]regmap_lock_mutex in regmap_read
drivers/char/ipmi/bt-bmc.c, 385:
     regmap_read in bt_bmc_irq

[FUNC] mutex_lock_nested
drivers/base/regmap/regmap.c, 468:
     mutex_lock_nested in regmap_lock_mutex
drivers/base/regmap/regmap.c, 2821:
     [FUNC_PTR]regmap_lock_mutex in regmap_update_bits_base
drivers/gpu/drm/bridge/synopsys/dw-hdmi.c, 213:
     regmap_update_bits_base in hdmi_modb
drivers/gpu/drm/bridge/synopsys/dw-hdmi.c, 429:
     hdmi_modb in hdmi_set_cts_n
drivers/gpu/drm/bridge/synopsys/dw-hdmi.c, 527:
     hdmi_set_cts_n in hdmi_set_clk_regenerator
drivers/gpu/drm/bridge/synopsys/dw-hdmi.c, 524:
     spin_lock_irq in hdmi_set_clk_regenerator

[FUNC] mutex_lock_nested
drivers/base/regmap/regmap.c, 468:
     mutex_lock_nested in regmap_lock_mutex
drivers/base/regmap/regmap.c, 2503:
     [FUNC_PTR]regmap_lock_mutex in regmap_read
drivers/media/platform/atmel/atmel-isc.c, 1603:
     regmap_read in isc_interrupt (interrupt handler)

I find the code about the assignment of regmap_lock_mutex():
         if ((bus && bus->fast_io) ||
             config->fast_io) {
             spin_lock_init(&map->spinlock);
             map->lock = regmap_lock_spinlock;
             map->unlock = regmap_unlock_spinlock;
             lockdep_set_class_and_name(&map->spinlock,
                            lock_key, lock_name);
         } else {
             mutex_init(&map->mutex);
             map->lock = regmap_lock_mutex;
             map->unlock = regmap_unlock_mutex;
             lockdep_set_class_and_name(&map->mutex,
                            lock_key, lock_name);
         }

But after reading the code, I cannot find the relationship between the 
if condition and atomic context.

I am looking forward to your reply, thanks in advance :)


Best wishes,
Jia-Ju Bai
