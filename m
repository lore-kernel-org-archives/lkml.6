Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575816256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BF420857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BF420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbeG3STi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:19:38 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:51474 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731906AbeG3STh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:19:37 -0400
Received: from [192.168.1.7] (unknown [110.184.155.251])
        by APP-10 (Coremail) with SMTP id tACowABHTdUjQF9bpvHwEQ--.5799S2;
        Tue, 31 Jul 2018 00:43:16 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v2 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
To:     Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com,
        hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com,
        rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        mchehab@kernel.org, trenn@suse.com, shuah@kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kvm@vger.kernel.org
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-17-git-send-email-puwen@hygon.cn>
 <b24739e8-0833-8509-0850-815758accaee@redhat.com>
Message-ID: <c8f53708-bd57-fb41-8300-115ac5083094@hygon.cn>
Date:   Tue, 31 Jul 2018 00:43:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b24739e8-0833-8509-0850-815758accaee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowABHTdUjQF9bpvHwEQ--.5799S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fCFW5Cw1rurWrtFy5Arb_yoW8Ar1xpF
        WUJFs0gr1kGF9xCr97Gr4xXr4fZFZ5JFWDGwnaka15AFZxZ3Wrua48ta1rAry7Cr9Y93WI
        yay5X3yxG3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07j1wZ7UUUUU=
X-Originating-IP: [110.184.155.251]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-29 07:42, Paolo Bonzini wrote:
>On 23/07/2018 15:20, Pu Wen wrote:
>>  scrubval = scrubrates[i].scrubval;
>>
>> -	if (pvt->fam == 0x17) {
>> +	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
>>  __f17h_set_scrubval(pvt, scrubval);
>>  } else if (pvt->fam == 0x15 && pvt->model == 0x60) {
>>  f15h_select_dct(pvt, 0);
>
>This, and many other occurrences in this file, should in my opinion
>avoid testing family 18h without also checking for Hygon as a vendor.
>You probably need to add a vendor field to struct amd64_pvt and
>initialize it in per_family_init.

Thanks for the suggestion.

As AMD and Hygon will negotiate the usage of CPU family number
to make sure the unique of family numbers in both company's processors.
As Hygon will use family 18h for Dhyana, AMD will not use family 18h
and jump to family 19h for new product. So if family number if 18h,
processor should be Hygon Dhyana. Based on this assumption, we created
this patch set.

To keep consistency, surely can modify the patchset as suggested, but
will introduce some additional vendor checking codes.

If the vendor field is added to amd64_pvt, and check the vendor in 0x18
codes, then the codes may like:
-	if (pvt->fam == 0x17) {
+	if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {

switch cases will be modified similar to:
+	case 0x18:
+		if(pvt->vendor == X86_VENDOR_HYGON) {
+			fam_type	= &family_types[HYGON_F18_CPUS];
+			pvt->ops	= &family_types[HYGON_F18_CPUS].ops;
+			break;
+		}
+

and:
	case 0x17:
+	case 0x18:
+		/* Family 18h is only for Hygon now */
+		if(pvt->fam == 0x18 && pvt->vendor == X86_VENDOR_AMD)
+			break;
+
		Do something here both for AMD 17h and Hygon 18h...

Any suggestions for that?

Thanks,
Pu Wen

