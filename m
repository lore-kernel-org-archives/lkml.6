Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541CB20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541CB20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeH3WGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:06:24 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:58701 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727471AbeH3WGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:06:24 -0400
Received: from [192.168.1.2] (unknown [110.184.153.119])
        by APP-10 (Coremail) with SMTP id tACowAD3wu1KMYhbjPWyBQ--.206S2;
        Fri, 31 Aug 2018 02:02:51 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <cover.1535459012.git.puwen@hygon.cn>
 <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
 <20180830123559.GF20005@nazgul.tnic>
Message-ID: <c22c3058-6a0b-f043-0263-e9767a54c2f2@hygon.cn>
Date:   Fri, 31 Aug 2018 02:02:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830123559.GF20005@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAD3wu1KMYhbjPWyBQ--.206S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw13WFy8WrWkWrWUAr13Arb_yoW3Arc_Z3
        WDG39Yk3W8JFWxta4xArnIyrW2vas5ZF40qw1fta4jq3sxta93ZFWrGa4kWr1UGrZ7uFyq
        vr9YqrnI93yUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU56c_DUUUUU==
X-Originating-IP: [110.184.153.119]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-30 20:35, Borislav Petkov wrote:
>> +HYGON PROCESSOR SUPPORT
>> +M:	Pu Wen <puwen@hygon.cn>
>> +L:	linux-arch@vger.kernel.org
>
>This is probably the wrong ML. You either have your own or use lkml,
>I'd say.

That's all right, I'll use linux-kernel@vger.kernel.org instead.

>> +++ b/arch/x86/kernel/cpu/hygon.c
>> @@ -0,0 +1,408 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Hygon Processor Support for Linux
>> + *
>> + * Copyright (c) Chengdu Haiguang IC Design Co., Ltd.
>> + *
>> + * Author: 2018 Pu Wen <puwen@hygon.cn>
>
>Year goes with the copyright.

OK, will change it as below: (in next version of patches)
+ * Copyright (c) 2018 Chengdu Haiguang IC Design Co., Ltd.
+ * Author: Pu Wen <puwen@hygon.cn>

Thanks,
Pu Wen

>Otherwise looks ok.

