Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46489ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0762083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azwHXwmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0762083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeIOOIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 10:08:50 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:44691 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 10:08:49 -0400
Received: by mail-pl1-f179.google.com with SMTP id ba4-v6so5225501plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=QBcWNMZ/g0U+WnI0vV1BLmIFs8dPS5KKo3z3gYe1fcg=;
        b=azwHXwmbIdPNLt5GMkMAJwQqFf+NljuXhzs+EyTCxtbiV4W6+l88yLkHZErLcmFLe1
         xoyii6TL4d/GCJWSqFh5MkGpSdPCvTEqkuLUvxYOWDND/BoTv28rc4AB2G4cUuOsUVRx
         0SM3BK6YhtKZe53K8Ssd/E6u7wDufcKfI4nfkzX1zxbU1SnMzwJEtA91cOJVfnS8V9Rd
         wl+f/fd2LAuEv/CeIayxoRpKlaDyie9swYao0giA2W2QpIxV9CfRjsCER2xkH5ueyYae
         s6TofPZnXaJ+oCmMhVYirJCZfeC65zWiLi0f0l/zePGrJBcUK4NryU3RxUGrhGfaatOD
         TZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=QBcWNMZ/g0U+WnI0vV1BLmIFs8dPS5KKo3z3gYe1fcg=;
        b=ORarOS5Vprim7+wmSLQkHKhFR07anUtlBAgZ0H3leNaG8fd5S9L7PtJ2w5CXqEcHeo
         T7VmivUcUQRy6xAL861VKjWhAcvUx9lM548E5U7ggK2wXaLw2BUPm/CGtQ4yKjEYJAsk
         Zlw8ILJoxRDBkpfIsruj31FyNLsoSQDl028kt6nSMUoqGlMaS3SZ5YNxUxyquZ9+LUrb
         h/l+6uhGmpUUNRN4jFFu1cSOY/K/lEdUzr8KF7zqIGkow2yvQdMxg9Jct69O39Elu+rr
         7brgb0w/6ACxPN+D+YrRwUixVuoaB+jxo0M7cYzhiYoe1FI0Sp/76JpO+ZO6RmAZANsd
         spWA==
X-Gm-Message-State: APzg51BqPu3JY3vsoHjVanPy/dJNfEq+diTxbAtNDrUJEdWQ86jXlXUH
        OnPUuqi46MGzOWDdHUJ6rqeGpqZm
X-Google-Smtp-Source: ANB0VdbvAH3vatXveLCinbc/GAuo0SL9gtNZ3ku1L1aqbyQIv9VugRVCrx/d9W0hnSJjjxgkp85gug==
X-Received: by 2002:a17:902:b60b:: with SMTP id b11-v6mr15296369pls.301.1537001436627;
        Sat, 15 Sep 2018 01:50:36 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id l3-v6sm11130390pff.8.2018.09.15.01.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 01:50:36 -0700 (PDT)
To:     lee.jones@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] mfd: ezx-pcap: Possible sleep-in-atomic-context bugs in
 pcap_adc_irq()
Message-ID: <f83a444a-1943-6c8c-5cd4-88e2acb17fa6@gmail.com>
Date:   Sat, 15 Sep 2018 16:50:31 +0800
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

The driver may sleep in an interrupt handler.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] mutex_lock_nested
drivers/mfd/ezx-pcap.c, 272:
     mutex_lock_nested in pcap_adc_irq (interrupt handler)

[FUNC] mutex_lock_nested
drivers/mfd/ezx-pcap.c, 100:
     mutex_lock_nested in ezx_pcap_read
drivers/mfd/ezx-pcap.c, 281:
     ezx_pcap_read in pcap_adc_irq (interrupt handler)

[FUNC] mutex_lock_nested
drivers/mfd/ezx-pcap.c, 85:
     mutex_lock_nested in ezx_pcap_write
drivers/mfd/ezx-pcap.c, 285:
     ezx_pcap_write in pcap_adc_irq (interrupt handler)

[FUNC] mutex_lock_nested
drivers/mfd/ezx-pcap.c, 244:
     mutex_lock_nested in pcap_adc_trigger
drivers/mfd/ezx-pcap.c, 299:
     pcap_adc_trigger in pcap_adc_irq (interrupt handler)

These bugs are found by my static analysis tool DSAC.


Best wishes,
Jia-Ju Bai
