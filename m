Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD51C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6CE20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6CE20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeH3VoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:44:15 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:52855 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeH3VoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:44:14 -0400
Received: from [192.168.1.2] (unknown [110.184.153.119])
        by APP-10 (Coremail) with SMTP id tACowAC3vsYWLIhbYUWxBQ--.111S2;
        Fri, 31 Aug 2018 01:40:39 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
To:     Andi Kleen <ak@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <cover.1535459012.git.puwen@hygon.cn>
 <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
 <87mut52cf4.fsf@linux.intel.com>
Message-ID: <65c91fb2-4b57-8ddb-3363-ac6fe69957b9@hygon.cn>
Date:   Fri, 31 Aug 2018 01:40:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87mut52cf4.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAC3vsYWLIhbYUWxBQ--.111S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxtF15Kr4UJr1xCw1Utrb_yoW8Ww1kpa
        1UWr1Fyr4ktrWfAr1xu3y8WFy09ws5Jr48C34YgrW8t3yYvw1q9wnagFyfZ343ArsYgay2
        vrWUXa17t3Z0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj0JPtUUUUU==
X-Originating-IP: [110.184.153.119]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-30 03:35, Andi Kleen wrote:
>Pu Wen <puwen@hygon.cn> writes:
>> Add x86 architecture support for new processor Hygon Dhyana Family 18h.
>> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
>> AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU.
>
>Standard approach would be to move the shared code into a different
>file and call it from both amd.c and hygon.c instead of duplicating.

Hi Andi, Thanks for your feedback.

As Hygon Dhyana arch originate from AMD, we share most arch codes with
AMD. In our first patch v1, we direct reuse AMD's init codes in amd.c,
which can work out a minimal patch. But the code mixture between AMD
and Hygon occur, which might cause problem in long term.

To reduce long term maintaining effort, we reworked the patch and do the
arch code duplication and removed unnecessary old arch support code/family
condition check, which reduce code size to 37%, and give a clear view for
hygon arch initialize flow. For long term, it also remove code modification
interference between AMD and Hygon, make hygon code easy to modify for it's
further products. That's the patch since v2.

We did try the standard approach as you suggested between v1 and v2
internally, and found out it's hard to find a clear version. Because amd.c
has many family checking to support it's multiple family products, which
make the common function strip difficult. Also based on the consideration
of common functions also might interference with each other, we finally
choose the patch v2 style.

It's hard to find a best way between code duplication and code reuse.
Any suggestion please let us know.

Regards,
Pu Wen

