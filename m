Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F88C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69F721873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyQkgSAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeLSK1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:27:55 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38492 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeLSK1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:27:54 -0500
Received: by mail-wm1-f53.google.com with SMTP id m22so5826702wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pjxO1GldLXmieZGYQgFQQZfzK01NWDc7MPK7rIcj2BU=;
        b=iyQkgSAsyxrHzNCHQZ5VLdzIJXTFovjh/o0cL82n5kABPbrF/tKrnFGrn6WJ7+iCCu
         nYpZiE2UHB5kQOB08jfYjb9pj24hhSCcrevmQDY3zfKqRAOY7qRImwcePmVMZcuKRoR4
         FvKpMFn/zczpqM8DifJeU9YuCvZDYjHT1mMVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pjxO1GldLXmieZGYQgFQQZfzK01NWDc7MPK7rIcj2BU=;
        b=dbriYe8WnAumFi64RLdMf9vqPmdJ5nk1ktCu7dbqi8QEYNnXUyGqISpibvgKc72SZ4
         eLqyJ8HNEAq0ihcnO7uzmp+0okU9mxWFQtsAl/w9+MdXd244YgwFZN/OPwtTIo4HWnwl
         Be+eLH0K/062Tdrm4RtZs8Oq1PRhebP3W6Kl8lJgZE1SkEhwDwxRfno3yO32xKa04Il1
         gfqtWK1geoDtR47HIFA3IcPAxWr1hs/XKolQc7LX4js8UtmmluBjIBXfShvmq8b3mICO
         xqJepvwuRR8icGiNbQ0JQiV/krUBHHf5NIu+d5dl4ozu9Ze3fnx04/BP6jS/g8oi7T2z
         7OOw==
X-Gm-Message-State: AA+aEWaY7PA/xYgjWe+PmM3b95/TuCXv9rX+ie6m7pUGaajT7Sbt/y4S
        JbB6wvdKsnMEkMMtO+66EDWeufPK3N4=
X-Google-Smtp-Source: AFSGD/X6cBdd4FuR60P6oKQlugQK4SpWsikmQHkwc1wUpEnBxcK+6nx004ydUFcErorlTcTiSivyVg==
X-Received: by 2002:a1c:8851:: with SMTP id k78mr6732818wmd.51.1545215272267;
        Wed, 19 Dec 2018 02:27:52 -0800 (PST)
Received: from [192.168.0.40] (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.googlemail.com with ESMTPSA id y185sm3222008wmg.34.2018.12.19.02.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 02:27:51 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL #2] timers for 4.21
Message-ID: <1b5ced98-bcf2-c6f2-82e0-63d85998629f@linaro.org>
Date:   Wed, 19 Dec 2018 11:27:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

one patch felt into the cracks.

 - Add dt-bindings for RDA8810PL SoC (Manivannan Sadhasivam)


Thanks

  -- Daniel


The following changes since commit 7f83a1327962b9b3712866db8cbafbdee239cce4:

  clocksource/drivers/rda: Add clock driver for RDA8810PL SoC
(2018-12-18 22:22:23 +0100)

are available in the Git repository at:

  http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.21

for you to fetch changes up to 2e64d317e197ec390e3914773489fcade7bbbf15:

  dt-bindings: timer: Document RDA8810PL SoC timer (2018-12-19 11:21:50
+0100)

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      dt-bindings: timer: Document RDA8810PL SoC timer

 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt | 20
++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

