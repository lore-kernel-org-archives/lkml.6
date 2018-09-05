Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD42C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8A020857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8A020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeIEMhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:37:43 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:57038 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbeIEMhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:37:43 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowABna1_6jo9bwL7sBw--.19840S2;
        Wed, 05 Sep 2018 16:08:27 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 08/16] x86/apic: add modern APIC support for Hygon
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <cover.1535459012.git.puwen@hygon.cn>
 <969a367a0b2d58f3e68bc6f97b6e8238e2390991.1535459013.git.puwen@hygon.cn>
 <20180904183301.GN32615@zn.tnic>
Message-ID: <cc7c152f-596a-79fe-6082-c4d5ce1b770f@hygon.cn>
Date:   Wed, 5 Sep 2018 16:08:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904183301.GN32615@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowABna1_6jo9bwL7sBw--.19840S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF47Wry8Gr17tr1kWryDZFb_yoW3XFc_Wr
        1DAr4Dtw4DAFyFqFsxGr4YqwsrJa1Yk3yvgry8ArW7Ar43ZFyrGF97tFZrJr97ta1fAr42
        kr4akrsIyws2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/5 2:33, Borislav Petkov wrote:
> On Wed, Aug 29, 2018 at 08:44:30PM +0800, Pu Wen wrote:
...
>> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
>> +	     boot_cpu_data.x86 >= 0xf) ||
>> +	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>>   		return 1;
> 
> Those compound conditionals are not nice to read. Just add yours
> underneath:
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> 	    boot_cpu_data.x86 >= 0xf)
> 		return 1;
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> 		return 1;
> 
> Do that where applicable and where it makes sense, syntax-wise to have a
> separate vendor == HYGON check in the other patches too.

That's OK, will check other patches and split the compound conditionals
where it's possible.

-- 
Thanks,
Pu Wen

