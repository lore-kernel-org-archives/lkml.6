Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D008C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A884217BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A884217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbeHMTBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:01:39 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:46695 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbeHMTBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:01:39 -0400
Received: from [192.168.1.7] (unknown [110.184.152.220])
        by APP-10 (Coremail) with SMTP id tACowAAnLsZTr3FbrkQBAQ--.8350S2;
        Tue, 14 Aug 2018 00:18:28 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
To:     Michael Jin <mikhail.jin@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
References: <cover.1533989492.git.puwen@hygon.cn>
 <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
 <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Message-ID: <49bec5ba-3a54-a9ee-f965-5f361e9711d2@hygon.cn>
Date:   Tue, 14 Aug 2018 00:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAAnLsZTr3FbrkQBAQ--.8350S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5Xw45tr13KFWUWF45ZFb_yoW5ZF43pr
        W5JF4j9rn7JasxJryvvr4UXFyrCw4kJFZrCrsxK3WFqFZ8ZFyrW345tF4fuFyUAF93J3y2
        vayrWw47Ga1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Cb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUb18UUUUU=
X-Originating-IP: [110.184.152.220]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/12 3:56, Michael Jin wrote:
> On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 18aeabb..fb81354 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>>
>>          scrubval = scrubrates[i].scrubval;
>>
>> -       if (pvt->fam == 0x17) {
>> +       if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
>>                  __f17h_set_scrubval(pvt, scrubval);
> 
> Separating the vendor check as an "else if (pvt->vendor ==
> X86_VENDOR_HYGON)" block would make architectural changes (future
> hygon models, i.e. 19h, 20h, etc) less confusing.

Your suggestion is reasonable, but that might make the branch a little
complicated.If we explicitly testing Hygon family in condition case,
will that be ok?
+    if (pvt->fam == 0x17 ||
+       (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18))

> 
>> +                       amd64_read_pci_cfg(pvt->F6,
>> +                               F17H_SCR_BASE_ADDR, &scrubval);
>> +                       if (scrubval & BIT(0)) {
>> +                               amd64_read_pci_cfg(pvt->F6,
> 
> The new lines after "amd64_read_pci_cfg(pvt->F6," can be removed.

To fix the warning "line over 80 characters" reported by running the
checking script checkpatch.pl, I added the new line.
But your sugesstion is reasonable, remove the new line will make the
codes much easier to read.

>> @@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>>                  else
>>                          pvt->dram_type = MEM_DDR4;
>>                  return;
>> +       case 0x18:
>> +               if (pvt->vendor == X86_VENDOR_HYGON) {
> 
> This vendor checking is not necessary as there are no other known
> family 18h processors.
> 
> 
>>          switch (pvt->fam) {
>> @@ -3192,6 +3227,13 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>>                  pvt->ops        = &family_types[F17_CPUS].ops;
>>                  break;
>>
>> +       case 0x18:
>> +               if (pvt->vendor == X86_VENDOR_HYGON) {
>> +                       fam_type        = &family_types[HYGON_F18_CPUS];
>> +                       pvt->ops        = &family_types[HYGON_F18_CPUS].ops;
>> +                       break;
>> +               }
> 
> There is a missing second 'break' statement after the "if (pvt->vendor
> == X86_VENDOR_HYGON)" block for case 0x18, see case 0x15 and case 0x16
> for comparison.

The missed second 'break' is on purpose. Thinking that if BIOS report
a vendor AMD and family 18h processor(which is not in case now),
the code will fall through and print out "Unsupported family".

> 
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index 2ab4d61..f7adc47 100644
>> +       case 0x18:
>> +               if (c->x86_vendor == X86_VENDOR_HYGON) {
>> +                       xec_mask = 0x3f;
>> +                       if (!boot_cpu_has(X86_FEATURE_SMCA)) {
>> +                               pr_warn("Decoding supported only on Scalable MCA processors.\n");
>> +                               goto err_out;
>> +                       }
>> +                       break;
>> +               }
> 
> The 'break' statement could be moved outside of the "if (c->x86_vendor
> == X86_VENDOR_HYGON)" block, this is to allow case 0x18 to reach the
> 'break' statement if the vendor is not X86_VENDOR_HYGON.

For the same reason as previous, if the vendor is not X86_VENDOR_HYGON,
it's not a valid vendor by now, and should fall through to the default
case and print out error message.

Thanks,
Pu Wen

