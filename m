Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74063C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204A221A8F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp+jg6VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204A221A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHKEgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:36:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45182 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeHKEgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:36:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so4714841pll.12;
        Fri, 10 Aug 2018 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=m4oJQ3Klb6EHwpB4flm8l7xyZNv0Bc5AeSJmEn3eVB4=;
        b=hp+jg6VREaiGlLDeMhGRiwFovGK2+YHPfh808bNx4duZEPgfINANxd9xtBdXDf+eEE
         bw93w94Hh9TqX6/r2GPpmTR5mZDtvLN8yLH8EyOhwCLJXQvRu5dRhl0v9JON/1e/dhda
         T8M/UUEjoKJ9kHPw9ZkrtZba49du/FvZY2XoY/lieEk05OrWKs8FGFGeB5GO8adXZZ8L
         BU3/qptPcyCnXAn19jUhNaTVLtqSUzRt2MFCDlU8YTqK2QVMWUvwCJO1xVmnUxY1E0QY
         mLAc2HrxhIenjzbpVU8RTjKmiiBVB759RD4Edof7DuvwnztmQUYqFHZSuKHF27IhOXme
         h01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=m4oJQ3Klb6EHwpB4flm8l7xyZNv0Bc5AeSJmEn3eVB4=;
        b=qbcQQsLy1d6XjdIy0U6R0mV5nJgvlm3vcgoNmpdt3SZc3DCK2g3NjhGP6tP0uyIAT7
         eZieH3WWoFsD85bLOWbThwrVctYT8JR6ttHC8DAt7jpL6iM4TUUc67ZB+Z2ij+n0Rf+r
         7CRdac1oOsODbtDa/bc2KbEcgtji0AiwuGEaKBKYG7cAPING1P4h3hJW4HCsEZ2fdo2M
         YsC7J4AccNQVTjFpKvnz7R0ax2BBqEnPpGjWZIw8d9RL4pafi7fCdb3xG5uo0VrYKXPo
         OeK4QZWHniMSU4PwA/IRdXs1SgEEJIJeEKdeNiS6+QIn3JyVJ4QBZk9aK6AUkAYzQizv
         bePA==
X-Gm-Message-State: AOUpUlHxiCM5iwy1onNB4C0NRt0i1Fmac+RRM9/Tjh/Xe5bPHNs1uIat
        H/vTZ+QDHfZfnOfsLmUwPhOIS65I
X-Google-Smtp-Source: AA+uWPydZbDptkvWCO7dbQ85LbJ6QHpJBmQvJIsSxdIV2e7v6o8frfUTLeAP79UPkF3BwaTm3yaWLw==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38-v6mr8283202plg.107.1533953035615;
        Fri, 10 Aug 2018 19:03:55 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.51? ([2402:f000:1:1501:200:5efe:a66f:4733])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34385603pfe.42.2018.08.10.19.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 19:03:55 -0700 (PDT)
To:     michael.hennerich@analog.com, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug in
 adp5588_gpio_direction_input()
Message-ID: <f741be3e-bc4d-9ea3-a2a7-d05fdc9cef5e@gmail.com>
Date:   Sat, 11 Aug 2018 10:03:49 +0800
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

[FUNC] mutex_lock_nested
drivers/gpio/gpio-adp5588.c, 113: mutex_lock_nested in 
adp5588_gpio_direction_input
drivers/gpio/gpio-adp5588.c, 224: adp5588_gpio_direction_input in 
adp5588_irq_set_type
kernel/irq/manage.c, 686: [FUNC_PTR]adp5588_irq_set_type in 
__irq_set_trigger
kernel/irq/manage.c, 1350: __irq_set_trigger in __setup_irq
kernel/irq/manage.c, 1238: _raw_spin_lock_irqsave in __setup_irq

Note that [FUNC_PTR] means a function pointer call is used.

I do not find a good way to fix, so I only report.
This is found by my static analysis tool (DSAC).


Best wishes,
Jia-Ju Bai
