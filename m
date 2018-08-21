Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECFE208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECFE208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeHUOYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 10:24:31 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:58407 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeHUOYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 10:24:31 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAB3XR248Xtb2uHsAg--.4257S2;
        Tue, 21 Aug 2018 19:04:25 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        mchehab@kernel.org, mikhail.jin@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
Message-ID: <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
Date:   Tue, 21 Aug 2018 19:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821081331.GC24940@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: swCowAB3XR248Xtb2uHsAg--.4257S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW5Gr48ZF47GFy7XF47urg_yoW8Xw4kpr
        WDJr1S9r1kWF15Gw1vkw1UuFyrC3s7JFW3C345K3s5A3Z8ZF95Wry7t3yxur90kr95Ar42
        yayvg3yUGa4YyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUz2-eUUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-21 16:13, Borislav Petkov wrote:
>On Mon, Aug 20, 2018 at 12:14:58AM +0800, Pu Wen wrote:
...
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 18aeabb..3cefb25 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -211,7 +211,8 @@ static int __set_scrub_rate(struct amd64_pvt 
*pvt, u32 new_bw, u32 min_rate)
>>
>>  scrubval = scrubrates[i].scrubval;
>>
>> -	if (pvt->fam == 0x17) {
>> +	if (pvt->fam == 0x17 ||
>> +	   (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18)) {
>
>Didn't we say that AMD won't do family 0x18 so you don't need the 
vendor check?

Hi Boris:

Based on the feedback from Paolo Bonzini:
"if the x86 maintainers prefer to have a new X86_VENDOR_*
constant, I'd just ignore the fact that AMD will skip family 18h, and
introduce vendor checks along the lines below. This has the advantage
that it's not an issue if AMD ends up _not_ skipping family 18h."
http://lkml.iu.edu/hypermail/linux/kernel/1807.3/06042.html

and the suggestions from Michael Jin:
"The condition case for family 18h and vendor Hygon looks better
because it is more clear."
http://lkml.iu.edu/hypermail/linux/kernel/1808.1/03232.html

we reworked the patch.

Sure, JV will negotiate with AMD and make sure only JV use family 18h and
AMD won't use family 0x18h, which will make the patch tight and clear.

What's the best way to adapt for EDAC driver?
* To simplify the code based on AMD won't do family 0x18 and remove
   vendor checking.
* Or add vendor checking in codes?

Thanks,
Pu Wen

