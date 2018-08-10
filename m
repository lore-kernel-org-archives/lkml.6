Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C869DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A46B2199B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SLn18Ml8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A46B2199B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHJX0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:26:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43850 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbeHJX0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:26:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so5041916pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xuuT/4BF9f3AeSVos19+NOTrupqgcJHeEaQDlGhabHI=;
        b=SLn18Ml8dykZOpzCoq6zSaTcUihmAFQatfmQNlwGPx0jEGtu8CSyCsbDXInr5r9Hjr
         +FOI8L3ZzHQoxZXEZeaziTIyyzEnxXeL6UJaEn60YWJnt90hGcXXYWBiVWsaJStptRhK
         9OvBpO79JzQGZOsoIrOnbAFGacNEgtW6dHd8paVtPk9l7jhG2pwQif8Dj43XoeQ0Vvkd
         7pT0Se2O3XLWSQ9WBqq7pksF1K6bCi35ppZ7NcUBD17nvXgcotf3SeTR/F5+0r8L1+vk
         Sf3XwYt1YZW77t+hCBlsBglZnaQXEWkoLLlPj3GSZ6r8MXz4GaTmdXApqIj63qIHHaZj
         dH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xuuT/4BF9f3AeSVos19+NOTrupqgcJHeEaQDlGhabHI=;
        b=kp8RDgUAPFw/TqoSnadWRpgFdPxtQ8cdWchTX7VVWGYroSoU1knLpFN8GzDHBC/uAV
         TEr86cHy/stSGHjHhn0a4gk92vEenAY5QqKdvtlaMsJNr0+fnfBOsgcn/eUsXv79k29H
         4MNWQEBaV3+U80ORB62J0Uo3K68wRnRXGCB2+vLvWBiknQvasDO5zp+nSW3kYm+cJl3o
         bH7/7FVcl/qYnkhZNPPp1DEu7Jksxe2JB9EtSF/71sxF9f2IDT3cMlfwNs5rehx9D8h7
         61uYSvWEiSws5Lb/+vuPjmsXK8omWQqiLDl4kq/XtNHvffiVqtLlvJXGRKGeOjKKhPqn
         jpYQ==
X-Gm-Message-State: AOUpUlGI/rJUZI1aZuEKIBO/DOZPwh8acwJKhiEtMnkY0uWZtcLkigE+
        qdOsvvkgIORcppMPidRD4U2RQQ==
X-Google-Smtp-Source: AA+uWPzsqnOGKjmEUMziRZQZQ5Qb6endX3/vzq6so0TkT34KaXW8dD0aQ8JjY2LBYnSYxr139CGvqw==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr8566058pfe.28.1533934513113;
        Fri, 10 Aug 2018 13:55:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p26-v6sm22632248pfi.183.2018.08.10.13.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 13:55:12 -0700 (PDT)
Date:   Fri, 10 Aug 2018 13:55:12 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 13:40:00 PDT (-0700)
Subject:     Re: [RFC] RISC-V: Fix !CONFIG_SMP compilation error
In-Reply-To: <b77401db-2bd5-3290-86b3-b173b06f964d@wdc.com>
CC:     linux-riscv@lists.infradead.org, alankao@andestech.com,
        sols@sifive.com, peterz@infradead.org, nickhu@andestech.com,
        acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-b76eb7de-3d75-4daf-b57c-f29060adfd07@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 11:31:08 PDT (-0700), atish.patra@wdc.com wrote:
> On 8/6/18 4:17 PM, Atish Patra wrote:
>> Enabling both CONFIG_PERF_EVENTS without !CONFIG_SMP
>> generates following compilation error.
>>
>> arch/riscv/include/asm/perf_event.h:80:2: error: expected
>> specifier-qualifier-list before 'irqreturn_t'
>>
>>    irqreturn_t (*handle_irq)(int irq_num, void *dev);
>>    ^~~~~~~~~~~
>>
>> Include interrupt.h in proper place to avoid compilation
>> error.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/include/asm/perf_event.h | 1 +
>>   arch/riscv/kernel/perf_event.c      | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
>> index 0e638a0c..aefbfaa6 100644
>> --- a/arch/riscv/include/asm/perf_event.h
>> +++ b/arch/riscv/include/asm/perf_event.h
>> @@ -10,6 +10,7 @@
>>
>>   #include <linux/perf_event.h>
>>   #include <linux/ptrace.h>
>> +#include <linux/interrupt.h>
>>
>>   #define RISCV_BASE_COUNTERS	2
>>
>> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
>> index b0e10c4e..a243fae1 100644
>> --- a/arch/riscv/kernel/perf_event.c
>> +++ b/arch/riscv/kernel/perf_event.c
>> @@ -27,7 +27,6 @@
>>   #include <linux/mutex.h>
>>   #include <linux/bitmap.h>
>>   #include <linux/irq.h>
>> -#include <linux/interrupt.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/atomic.h>
>>   #include <linux/of.h>
>>
> ping ?

Sorry about this, it got dropped.  This looks fine and fixes the bug, so I've 
gone and put it on for-next.

Thanks!
