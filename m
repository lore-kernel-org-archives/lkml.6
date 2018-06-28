Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3911EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E16273CE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E16273CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965716AbeF1NHz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:07:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47954 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965616AbeF1NHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:07:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B0AE20A36; Thu, 28 Jun 2018 15:07:45 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1C6342082B;
        Thu, 28 Jun 2018 15:07:45 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ethan Tuttle <ethan@ethantuttle.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] ARM: mvebu: declare asm symbols as character arrays in pmsu.c
References: <20180620043109.1190-1-ethan@ethantuttle.com>
        <87wouk92dm.fsf@bootlin.com>
        <CACzLR4s7v8sxkvVvv1H2KKJHazfgCBmhAeb2Upa5JRoxTqm5nw@mail.gmail.com>
Date:   Thu, 28 Jun 2018 15:07:45 +0200
In-Reply-To: <CACzLR4s7v8sxkvVvv1H2KKJHazfgCBmhAeb2Upa5JRoxTqm5nw@mail.gmail.com>
        (Ethan Tuttle's message of "Wed, 27 Jun 2018 07:39:29 -0700")
Message-ID: <8736x76ov2.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ethan,
 
 On mer., juin 27 2018, Ethan Tuttle <ethan@ethantuttle.com> wrote:

> Hi Gregory.
>
> On Tue, Jun 26, 2018 at 11:20 PM, Gregory CLEMENT
> <gregory.clement@bootlin.com> wrote:
>> Hi Ethan,
>>
>>  On mar., juin 19 2018, Ethan Tuttle <ethan@ethantuttle.com> wrote:
>>
>>> With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
>>> detect buffer overflows.  If src or dest is declared as a char, attempts to
>>> copy more than byte will result in a fortify_panic().
>>>
>>> Address this problem in mvebu_setup_boot_addr_wa() by declaring
>>> mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
>>> a couple addressof operators to avoid "arithmetic on pointer to an
>>> incomplete type" compiler error.
>>>
>>> See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
>>> not single characters") for a similar fix.
>>>
>>> Fixes "detected buffer overflow in memcpy" error during init on some mvebu
>>> systems (armada-370-xp, armada-375):
>>>
>>> (fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
>>> (mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
>>> (mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
>>> (do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
>>> (kernel_init_freeable) from (kernel_init+0x8/0x114)
>>> (kernel_init) from (ret_from_fork+0x14/0x2c)
>>>
>>> Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
>>> Tested-by: Ethan Tuttle <ethan@ethantuttle.com>
>>
>> Out of curiosity on which platform did you test it?
>
> I found the problem on my Mirabox after a kernel upgrade, and verified the fix
> on the Mirabox as well.
>
> I just observed in the code that the panic should also happen on armada-375,
> didn't do any testing there.
>
> BTW, just realizing I did not test with CONFIG_FORTIFY_SOURCE off.  But
> I imagine it will work.  Let me know if you think that requires
> testing.

No it's OK, thanks for extra information.

Gregory

>
>> Applied on mvebu/arm
>
> Excellent!  Thank you.
>
> Ethan
>
>>
>> Thanks,
>>
>> Gregory
>>
>>
>>
>>> ---
>>>  arch/arm/mach-mvebu/pmsu.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
>>> index 27a78c80e5b1..73d5d72dfc3e 100644
>>> --- a/arch/arm/mach-mvebu/pmsu.c
>>> +++ b/arch/arm/mach-mvebu/pmsu.c
>>> @@ -116,8 +116,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>>>               PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
>>>  }
>>>
>>> -extern unsigned char mvebu_boot_wa_start;
>>> -extern unsigned char mvebu_boot_wa_end;
>>> +extern unsigned char mvebu_boot_wa_start[];
>>> +extern unsigned char mvebu_boot_wa_end[];
>>>
>>>  /*
>>>   * This function sets up the boot address workaround needed for SMP
>>> @@ -130,7 +130,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
>>>                            phys_addr_t resume_addr_reg)
>>>  {
>>>       void __iomem *sram_virt_base;
>>> -     u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
>>> +     u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
>>>
>>>       mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
>>>       mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
>>> --
>>> 2.17.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> --
>> Gregory Clement, Bootlin (formerly Free Electrons)
>> Embedded Linux and Kernel engineering
>> http://bootlin.com

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
