Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3AFC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2620219C8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+evvQxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2620219C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHKEpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:45:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33918 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeHKEpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:45:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so4740462plo.1;
        Fri, 10 Aug 2018 19:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=SKB3mU2M3TnxXODKB2dYqG5Sh5gfnx2BPLIKePnZE2A=;
        b=m+evvQxX/skkJLXWB6bqp6OkgYwH+hLOG5lc6NJjn0pBVJtcHyMsWfmx8S93/2AyxM
         Pp7sF/TO/5BfzS1H2rHpfruLvhiTtOeVfIWyNeUI3lrUyK0pxrohTTmzhssZJXxoquHY
         4aNdGk0YjDL3smo/wIml41k3Vuc1lCaEog5zQFBaSoiib7NH2czPKyBj5tc8gCXpXjpZ
         z8iyIqg2OQNAG8iXA58dciq50ACuU5WEYR6WTCQmqLzxogewHYe6BOeDYHXI+AyNJjsD
         AVf+JjvbL4d0JTxFWVJIYOn/tGa04zbQk1XOu65225U6vcKwjnBQjM2C0e4HwC+YtDv/
         K8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=SKB3mU2M3TnxXODKB2dYqG5Sh5gfnx2BPLIKePnZE2A=;
        b=QKvGArT+6sm9/MGUDGHNmrSNDC5xF0jARHI12lstq0LHoyJHapIBaYy+uLOAHrRXhL
         yD0k9nnluSRaIldfqZfrOHa8lvR73eGPdxWm+ToMlxUuX2sc3kZjMaH8gsTC/58DQpwC
         qq08wFMj6PLNUry/Kdo7/2/9LzdshTUzE5vTxXEZrHdohpfyz3h/39kdjPHB5ULZcWln
         0RhnaKHmy4OaCAzubLczSunJErz87rWYhJFfsK0/Lc47HOjfpCRtndru5tvrJYiTU8vR
         ftlEtJV5uPBjf5v+R5qylQjmFHdG1yiV665tdZH1JIQ4qqNMGs7r8cF/HU2fZlFCvclJ
         W2fg==
X-Gm-Message-State: AOUpUlFMfONL5dCrnY2+fBEy3LVh3nAdwM/sszx5uCA87WCwzhj6jd40
        /SstC4J/rHEQfz6fczhx1kHiCqhS
X-Google-Smtp-Source: AA+uWPy8/T6raLmcku7+241HH4zbVB92cY+TlidQeZYd0yGY+VgWy6azkluAMH7dnD3FWl2M1k0w3w==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr8332534pla.60.1533953594433;
        Fri, 10 Aug 2018 19:13:14 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.51? ([2402:f000:1:1501:200:5efe:a66f:4733])
        by smtp.gmail.com with ESMTPSA id r19-v6sm19431547pgg.39.2018.08.10.19.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 19:13:14 -0700 (PDT)
To:     michael.hennerich@analog.com, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug in
 adp5588_gpio_write()
Message-ID: <93f77ccb-a478-fd72-5012-aeba5b6c8253@gmail.com>
Date:   Sat, 11 Aug 2018 10:13:08 +0800
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

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] schedule_timeout
drivers/media/platform/marvell-ccic/cafe-driver.c, 206: schedule_timeout 
in cafe_smbus_write_data
drivers/media/platform/marvell-ccic/cafe-driver.c, 307: 
cafe_smbus_write_data in cafe_smbus_xfer
drivers/i2c/i2c-core-smbus.c, 541: [FUNC_PTR]cafe_smbus_xfer in 
i2c_smbus_xfer
drivers/i2c/i2c-core-smbus.c, 156: i2c_smbus_xfer in 
i2c_smbus_write_byte_data
drivers/gpio/gpio-adp5588.c, 58: i2c_smbus_write_byte_data in 
adp5588_gpio_write
drivers/gpio/gpio-adp5588.c, 115: adp5588_gpio_write in 
adp5588_gpio_direction_input
drivers/gpio/gpio-adp5588.c, 224: adp5588_gpio_direction_input in 
adp5588_irq_set_type
kernel/irq/manage.c, 686: [FUNC_PTR]adp5588_irq_set_type in 
__irq_set_trigger
kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq

[FUNC] mutex_lock_nested
drivers/i2c/busses/i2c-cht-wc.c, 138: mutex_lock_nested in 
cht_wc_i2c_adap_smbus_xfer
drivers/i2c/i2c-core-smbus.c, 541: [FUNC_PTR]cht_wc_i2c_adap_smbus_xfer 
in i2c_smbus_xfer
drivers/i2c/i2c-core-smbus.c, 156: i2c_smbus_xfer in 
i2c_smbus_write_byte_data
drivers/gpio/gpio-adp5588.c, 58: i2c_smbus_write_byte_data in 
adp5588_gpio_write
drivers/gpio/gpio-adp5588.c, 115: adp5588_gpio_write in 
adp5588_gpio_direction_input
drivers/gpio/gpio-adp5588.c, 224: adp5588_gpio_direction_input in 
adp5588_irq_set_type
kernel/irq/manage.c, 686: [FUNC_PTR]adp5588_irq_set_type in 
__irq_set_trigger
kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq

[FUNC] mutex_lock_nested
drivers/i2c/busses/i2c-i801.c, 828: mutex_lock_nested in i801_access
drivers/i2c/i2c-core-smbus.c, 541: [FUNC_PTR]i801_access in i2c_smbus_xfer
drivers/i2c/i2c-core-smbus.c, 156: i2c_smbus_xfer in 
i2c_smbus_write_byte_data
drivers/gpio/gpio-adp5588.c, 58: i2c_smbus_write_byte_data in 
adp5588_gpio_write
drivers/gpio/gpio-adp5588.c, 115: adp5588_gpio_write in 
adp5588_gpio_direction_input
drivers/gpio/gpio-adp5588.c, 224: adp5588_gpio_direction_input in 
adp5588_irq_set_type
kernel/irq/manage.c, 686: [FUNC_PTR]adp5588_irq_set_type in 
__irq_set_trigger
kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq

Note that [FUNC_PTR] means a function pointer call is used.

I do not find a good way to fix, so I only report.
Maybe adp5588_gpio_direction_input() and adp5588_gpio_write() should not 
be called in adp5588_irq_set_type().
This is found by my static analysis tool (DSAC).


Best wishes,
Jia-Ju Bai
