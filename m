Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeDFJxl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:53:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50303 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeDFJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:53:39 -0400
X-Google-Smtp-Source: AIpwx4+bdneCKzuByWckOjjl7t/hbXGmYbv6gZFtyTfKObvUO13rnc16uPYLogkfyp4gCFICIVNbaQ==
To: akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        keescook@chromium.org, lauraa@codeaurora.org, viresh.kumar@linaro.org,
        nicolas.pitre@linaro.org, thomas.lendacky@amd.com
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: A question of sleeping with interrupts are disabled in start_kernel()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1eb16c24-ef3b-2962-d216-57f66321035e@gmail.com>
Date: Fri, 6 Apr 2018 17:53:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question of the call path init/main.c:
init/main.c: start_kernel() ->
kernel/events/core.c: perf_pmu_register() ->
kernel/events/core.c: perf_event_init() ->
kernel/events/core.c: pmu_dev_alloc()

In this call path, start_kernel() calls local_irq_disable() to disable 
the interrupt;
perf_pmu_register() calls mutex_lock() and idr_alloc(GFP_KERNEL), and 
they can sleep;
pmu_dev_alloc() calls kzalloc(GFP_KERNEL), and it can sleep.

In my opinion, this code may sleep with interrupts are disabled.
I wonder why this code is okay?


Best wishes,
Jia-Ju Bai
