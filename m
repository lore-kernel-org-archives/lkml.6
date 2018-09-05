Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DC1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9804F20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9804F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeIEPKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:10:03 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:50311 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbeIEPKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:10:03 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowAD3_bWJso9b_xUaBw--.19874S2;
        Wed, 05 Sep 2018 18:40:10 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 09/16] x86/bugs: add lfence mitigation to spectre v2
 and no meltdown for Hygon
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <cover.1535459012.git.puwen@hygon.cn>
 <bf6e0e5403ae96715606366b3b5f817cbdab0dc3.1535459013.git.puwen@hygon.cn>
 <20180905091309.GB2237@zn.tnic>
Message-ID: <ba3ff0cd-1717-f9a4-5583-d71444a87223@hygon.cn>
Date:   Wed, 5 Sep 2018 18:40:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905091309.GB2237@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowAD3_bWJso9b_xUaBw--.19874S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17Wr47XrW7Kry8Aw4xJFb_yoW8ZrWDpF
        y0qFWSyF9rAwsayFZ7XF15Wr4vyr4xJw42kry5ur90va9Yvryvgr1Sgr17WFn5GryxXr4I
        qF4Yqrs8WF1rt37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWxJVW8Jr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b0FxUUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/5 17:13, Borislav Petkov wrote:
>>   static const char *spectre_v2_strings[] = {
>>   	[SPECTRE_V2_NONE]			= "Vulnerable",
>>   	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
>> -	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
>> +	[SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE]	= "Vulnerable: Minimal LFENCE ASM retpoline",
>>   	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
>> -	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
>> +	[SPECTRE_V2_RETPOLINE_LFENCE]		= "Mitigation: Full LFENCE retpoline",
>>   	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
>>   };
> 
> This is user-visible and with all the back'n'forth and backporting
> and the whole security fiasco, I don't want to have another source of
> confusion. You'll have to live with it saying "AMD" in dmesg
....
>> @@ -272,7 +272,7 @@ static const struct {
>>   	{ "off",               SPECTRE_V2_CMD_NONE,              false },
>>   	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
>>   	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
>> -	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
>> +	{ "retpoline,lfence",     SPECTRE_V2_CMD_RETPOLINE_LFENCE,     false },
>>   	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
>>   	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
>>   };
> 
> This even more so. Those are command line strings which we're still
> communicating to people, even. So no, it needs to remain "retpoline,amd"
> on Hygon.
> 
> And then to not confuse people staring at the code either, we can drop
> this change too:
> 
> -     SPECTRE_V2_CMD_RETPOLINE_AMD,
> +     SPECTRE_V2_CMD_RETPOLINE_LFENCE,
> 
> Which leaves this patch only with the addition of the vendor tests. The
> other stuff you can drop.

That's reasonable. To avoid the confusion, will only leave the vendor
testing for Hygon and drop the other changes, which also minimize the
code modification.

-- 
Regards,
Pu Wen

