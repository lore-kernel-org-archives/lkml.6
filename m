Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418F520866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418F520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeIKSDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:03:21 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:44204 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727287AbeIKSDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:03:20 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAC3uIAuvZdbxzXsCA--.8649S2;
        Tue, 11 Sep 2018 21:03:43 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 08/16] x86/apic: Add Hygon Dhyana support to APIC
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <cover.1536550549.git.puwen@hygon.cn>
 <4f03e734faa5b2b69b0947a156bea29cddcc95ce.1536550550.git.puwen@hygon.cn>
 <20180911101454.GE12094@zn.tnic>
Message-ID: <b8055a18-2002-13b2-3438-7fbb38149837@hygon.cn>
Date:   Tue, 11 Sep 2018 21:03:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911101454.GE12094@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: swCowAC3uIAuvZdbxzXsCA--.8649S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF4rKF1DZw1DJw1xZry7Wrg_yoW3ZrcEgF
        yDCr1DG3yqqay8Zr48GF45Gw43Gan09FW0ya43JF13CFnxArn0ga1fKw4vvryrWayftw42
        yr4rta9Yvw1a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4UJVWxJr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1_M3UUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/11 18:14, Borislav Petkov wrote:
>> @@ -1211,9 +1216,11 @@ void __init sync_Arb_IDs(void)
>>   {
>>   	/*
>>   	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
>> -	 * needed on AMD.
>> +	 * needed on AMD or Hygon.
>>   	 */
>> -	if (modern_apic() || boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +	if (modern_apic() ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> 
> This change is not needed, after the above hunk in modern_apic(), right?

Yes, you are right. Since the Hygon Dhyana CPU always uses modern APIC,
so the function modern_apic will always return true for Hygon Dhyana.
I will remove this change in next version of patch.

> 
> With it removed:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards,
Pu Wen

