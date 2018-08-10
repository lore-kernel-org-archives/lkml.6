Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6332C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDE5223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brEzJvUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDE5223FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeHJQhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:37:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34094 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeHJQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:37:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so4473001pgv.1;
        Fri, 10 Aug 2018 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=l4exPuIDCDA8W0UtmqmVlHNqmSWc21B/e7TaXzFXwdU=;
        b=brEzJvUTw5cL0/adpiCv2tt32ig3+t7RM+6R2oiLoOw/FXVwOKGBhWTdznQiOJ0qAW
         LRTTsNZxj62Z/cIQ+dlQ7N9ELh71ak64qIAr/auZRpylm5QxUwFeGM+5HpUaWX8oQOlu
         Da3hy1KzMHJcJNxxL/HaLzhgFicdK/6y8LQ9EreAHgmcp4A4YB7cJgG62qt0LlR16t1S
         QsL1llKQKld+aQkYGY5rRkNY+n7p9GtG4nQgDufHyawTQCes5k48hPwRs/t2+/VzQ/2B
         2vsFTBibOIl7NUxMvqHL48xQeLxkFMQIrygXPi/PX4yy2yR17+nO+liN/TA55PTXEwvx
         Wk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=l4exPuIDCDA8W0UtmqmVlHNqmSWc21B/e7TaXzFXwdU=;
        b=B06gJmT+MvIlesNSlGtwXIycMw2X095EqNoGv2QxjERdHLPNGwWxAjx06ndU5cLhku
         5NVgTa9Hydxa1nYZrPiYof1kOXni1VBLtg4vBXmrcmbQsnA3a8MUjdVv/LBzeN57eId6
         +Ju2LU05Jzk1hkAPYn8biYvG98rqypAJeSfqkI7jftbRD2w4EMlIvLIOOrsZJrsSOxuy
         MSm0XWUKC9rzfuECxbsCdTsOtVUAJYDiuldTM73NlE7KVdSMlihVTm1jUrhEHZywVS5c
         VG7hf4BW4u19lO++GJ/YKfr7AmWxzmD5PmmerxNmuLwYnmSQumXdI3S5G24V4aTAk6on
         I9ng==
X-Gm-Message-State: AOUpUlGaYyrZzwgbfPj+t4G+hWZ/0MoSBCkPRqKGQFhy9DrN/j5OxhfM
        G+lS0zyBnMPphDW90PqRIsCKCazj
X-Google-Smtp-Source: AA+uWPzw32WsbncVh/QVidqiu+vpvrpdokY5eTI61iNi45Jci8tmw3PPXpqNfLnmgVtzogClkIulNw==
X-Received: by 2002:a62:83ca:: with SMTP id h193-v6mr7220187pfe.79.1533910048590;
        Fri, 10 Aug 2018 07:07:28 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.51? ([2402:f000:1:1501:200:5efe:a66f:4733])
        by smtp.gmail.com with ESMTPSA id w72-v6sm18168279pfa.26.2018.08.10.07.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:07:28 -0700 (PDT)
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] bpf: syscall: a possible sleep-in-atomic-context bug in
 map_update_elem()
Message-ID: <65830741-bf35-4d32-e365-c32fc17c25cb@gmail.com>
Date:   Fri, 10 Aug 2018 22:07:23 +0800
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

The kernel may sleep with holding a rcu read lock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kmalloc(GFP_KERNEL)
kernel/kthread.c, 283: kmalloc in __kthread_create_on_node
kernel/kthread.c, 365: __kthread_create_on_node in kthread_create_on_node
kernel/bpf/cpumap.c, 368: kthread_create_on_node in __cpu_map_entry_alloc
kernel/bpf/cpumap.c, 490: __cpu_map_entry_alloc in cpu_map_update_elem
kernel/bpf/syscall.c, 724: [FUNC_PTR]cpu_map_update_elem in map_update_elem
kernel/bpf/syscall.c, 723: rcu_read_lock in map_update_elem

Note that [FUNC_PTR] means a function pointer call is used.

I do not find a good way to fix it, so I only report.
This is found by my static analysis tool (DSAC).


Best wishes,
Jia-Ju Bai
