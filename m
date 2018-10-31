Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53272C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E8C20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E8C20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeJaQk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:40:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbeJaQk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:40:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71AD0308403E;
        Wed, 31 Oct 2018 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D083960F87;
        Wed, 31 Oct 2018 07:43:07 +0000 (UTC)
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com,
        tglx@linutronix.de, Kazuhito Hagio <khagio@redhat.com>
References: <20181029095738.GB20101@zn.tnic>
 <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic> <20181030092314.GC14493@MiWiFi-R3L-srv>
 <dcbc925f-6935-6a34-fde1-7aa1ea378891@redhat.com>
 <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <e735e1d8-ec07-4de7-858e-7fc4ae711db7@redhat.com>
Date:   Wed, 31 Oct 2018 15:43:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 31 Oct 2018 07:43:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月31日 10:47, Dave Young 写道:
> Add Kazu, the makedumpfile maintainer in cc.
> 
> On 10/31/18 at 10:26am, lijiang wrote:
>> 在 2018年10月30日 17:23, Baoquan He 写道:
>>>
>>> Hi Boris, DaveY and Lianbo,
>>>
>>> On 10/30/18 at 10:15am, Borislav Petkov wrote:
>>>> On Tue, Oct 30, 2018 at 01:09:00PM +0800, Dave Young wrote:
>>>>> It is not the content, I think it is a good catch from Boris, it would
>>>>> be good to document the exported things in somewhere eg.
>>>>> Documentation/kdump/vmcoreinfo.txt
>>>
>>> For the vmcoreinfo variables document, I personally think it might be
>>> not necessary. The reason is that all the old varialbles are exported
>>> with the name of themselves. We know what they are or what they
>>> represent since they are all kernel symbols or macro. Only this me_mask,
>>> it's a local variable and store the value of sme_me_mask for now, may
>>> store more info later like Petr mentioned, and also will store the memory
>>> encryption information of TME (which is intel's transparent memory encryption).
>>> We can add code comment around to tell these.
>>>
>> Thank you, everyone.
>>
>> I personally agree with Baoquan's opinion. What do you think about? Boris and other reviewer?
>>
>> If the vmcoreinfo document is necessary, would you like to help me to provide an outline?
>> I can try my best to write the document.
> 
> It is true like what Baoquan said, these information are mainly used by
> makedumpfile tool for creating a filtered vmcore.  But these vmcoreinfo
> hide in a lot of different code paths:
> kernel/crash_core.c,  printk code, arch code etc. 
> 
> It is a mist only a few kdump people know them, documenting them will help
> people to understand and review. It will also be clearer instead of
> digging into code?
> 
> The document can briefly explain what is vmcoreinfo, why we need it, and
> some background info.  Then list the exported values with some
> classifying by core kernel, arch related,  string or number etc.  For
> most of them like Baoquan said no need more explanation, but add
> explanations for something if needed like this sme mask.
> 
> But I think this can be done separately instead of blocking this patch.
For this patch, i think that it had been reached an agreement. So i will
update my patch log and post v2 if there is no objection.

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..ca9bdf46b8e7 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -352,10 +352,23 @@ void machine_kexec(struct kimage *image)
 
 void arch_crash_save_vmcoreinfo(void)
 {
+       u64 sme_mask = sme_me_mask;
+
        VMCOREINFO_NUMBER(phys_base);
        VMCOREINFO_SYMBOL(init_top_pgt);
        vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
                        pgtable_l5_enabled());
+       /*
+        * Currently, the local variable 'sme_mask' stores the value of
+        * sme_me_mask(bit 47), and also write the value of sme_mask to
+        * the vmcoreinfo.
+        * If need, the bit(sme_mask) might be redefined in the future.
+        * For example:
+        * [ misc          ][ enc bit  ][ other misc SME info       ]
+        * 0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
+        * 63   59   55   51   47   43   39   35   31   27   ... 3
+        */
+       VMCOREINFO_NUMBER(sme_mask);
 
 #ifdef CONFIG_NUMA
        VMCOREINFO_SYMBOL(node_data);

> Maybe Kazu knows more about it, so I would like to ask Kazu about his opinion
> and if he want to do it.
> Ok, thank you, Dave Young.

About the vmcoreinfo document issue, once make a decision, i will try my best to
do this based on your outline.

Regards,
Lianbo

>>
>> Anyway, we should make a choice.
>>
>> Regards,
>> Lianbo
>>
>>> Personal opinion.
>>>
>>> Thanks
>>> Baoquan
>>>
> 
> Thanks
> Dave
> 
