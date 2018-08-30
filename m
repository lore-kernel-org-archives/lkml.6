Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F48BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37EC20666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAuylNTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37EC20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeH3GeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:34:16 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42995 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeH3GeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:34:16 -0400
Received: by mail-pl1-f172.google.com with SMTP id g23-v6so3148906plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Z4O3Qhoi3Pe01JyBn9UfPfGKRt/zc5D5nP2l8U59PgM=;
        b=hAuylNTaqd7RmGSyYZZpPzBnNkNDVdp4zmrzFdfbl0gaE9u0hAVwbwmnE6uUbtHbsL
         qYUEaB7FylwdFfRbVQGBGKJrbalR9cUtgRIhcEUOWckmu5he4wSn25D3GH0rwskipyj+
         0BC6yiXCMnf7aBlnpoMuHwgdI0QnSln0i2MhvRbcy29mqW1wlyJ6xbFNHaJR3+ffsaXH
         63qcEPSI5l2GDTJKLyV70aK+OGyFJtJ25Z7rsJtOQnO+fRg9sG3DgirChqrH8d3Aa6ZJ
         rtptoogXR1OUeM1l684qyovOCoAl34LrZH58WaibPo2lm/vJiYZIOxQwZb1S5K2A25U+
         n7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Z4O3Qhoi3Pe01JyBn9UfPfGKRt/zc5D5nP2l8U59PgM=;
        b=br8RDAxerzPRCSRwJYTqU1/6X9QKkn7gGuxClGEafjSxgGXyU+DNkf9FiF+pMcyyS1
         g2UXUQAykqZckLAcx7cZQ9mBz73Pxn+xEj96cJGjSH8A9kVtkdCoBvbG9K56I38SC0Ds
         MvjaqOw11iZJzX/DL2ooD2194Rch9NXc14I6ICnwwQgj7K2zHfoorBmxYTS9p1e465Ng
         yzpk0iRRUWo+nAsGnu2EV4+WFus1aGwHJeltaweLQZLMoxXZnvptW1xNvybRO4eQvNoO
         hWGKk5O7L03Qe2ugcnK2/dWG70qLbF8M++uMceMQmc+AZGpPCu1DBc1ResIzmsEfk+gA
         +NZw==
X-Gm-Message-State: APzg51D+LUetaFyAdzDf4mVOY0T8VySdcnBJcrtcPRXM+ytq/tImaps7
        DCF7djlj0DKTpD8qDN2X77t8viwY
X-Google-Smtp-Source: ANB0VdYiLbxJdxzuFYvUsUk1WCR0AcYkpWh51DVqosPR0relNy640WN4jN7PZ055/cm1bsLGMiFoXA==
X-Received: by 2002:a17:902:a9ca:: with SMTP id b10-v6mr8176588plr.198.1535596465518;
        Wed, 29 Aug 2018 19:34:25 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.15? ([2402:f000:1:1501:200:5efe:a66f:470f])
        by smtp.gmail.com with ESMTPSA id 1-v6sm9220229pfm.145.2018.08.29.19.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 19:34:24 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        David Howells <dhowells@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linus.walleij@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] [Resend] Possible sleep-in-atomic-context bugs involving
 regmap_lock_mutex()
Message-ID: <9bcef57b-1a5c-cd16-8e44-932ef3be08cb@gmail.com>
Date:   Thu, 30 Aug 2018 10:34:20 +0800
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
I think assigning regmap_lock_mutex() to map->lock may be not proper.

I also find some similar previously reported problems about 
regmap_lock_mutex():
https://lists.launchpad.net/kernel-packages/msg187700.html
https://community.nxp.com/thread/432071

I am not sure whether my analysis and results are right.
Could someone please give me explanation?

Thanks in advance :)


Best wishes,
Jia-Ju Bai

