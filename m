Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLACK,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A68CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2F23C11
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ethantuttle-com.20150623.gappssmtp.com header.i=@ethantuttle-com.20150623.gappssmtp.com header.b="BOhuyxly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA2F23C11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ethantuttle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934627AbeF0Ojc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:39:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50896 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932907AbeF0Ojb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:39:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id e16-v6so6105301wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ethantuttle-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bsfpno2D3QevUa8ezttkJ1uI/MwnHoq9P5toZ0SEu4Q=;
        b=BOhuyxlySHID/09qYvaIMi62gnjiZJoXJBS/z2pdhRdFlqrtwVnrejBCjMvtU5X34L
         SYy4iAHmN0b5t80jOC42mNb8T41Qa4rQSZYRCuPs3lLVaHjUDTFFzYkURrF6oh+P1Jev
         Yf88mTLUy4oUZFfhY+RwJDWdbFTsgno1ZOFk/ZTlIOUy3yR1ePXcfM1Np5NOcOTbcPjm
         7UHyJTCnqa5bEQJf4lmlF+LEHu5kf9Co0MPBjU2DJH4jFFJ0CukIZSPSKImCk9JVGIUZ
         YLN0a31tuKfTq5KIML8/ekIxx8hSR8QQCsNgp5z2a7fLWNnKtaGoh7H6lYA9PmZfIM6s
         FafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bsfpno2D3QevUa8ezttkJ1uI/MwnHoq9P5toZ0SEu4Q=;
        b=EUmKiG3652DAEydAtkIuyZQXMm2tb+3wMpl5XnpAKMz0UIP0VCOrFDqDpxbZ4OhfOv
         25c/rCqNz9R59LYVE+dWnSCMFPwjnRSgnwrlA9wHTIFsBE8JazgjpWm4hMrZAkxDBS7n
         8nu3ufLklUf6w0TcwxLA6ADduj4PHHt1vBsVV4+rPszS0ez07gTv7V2vDIQYKoJY+4MR
         RC1om51BeOM9mlLcrdG6Y1A8LeEPTHjKiyfoCL+p/lgUTDinSWE+2u2b15nTnH2n6X0/
         GlVWbuJAxcj7gmm+yFXR6NA0Xo7b9767oKLuNSHLPflXsgyNeYVaGt2iczCf6BbltcRt
         8c7w==
X-Gm-Message-State: APt69E2TRHQB+JTQW3w8dua9q756NkJDXA7YYlaSB7DoeXk8fQHDSn4x
        Nm7fV43Ijd3dEbOOTmCJNAqAEYjEK640wbe8XZVKqAKT
X-Google-Smtp-Source: AAOMgpc9r1X1UM2b9C2bMYHX6sxK1EHuL505HMFoOV9kP5p5ZHyW4zH1eBOJHovB3HGrTEz5buAg9O4LtBOSpOpaxy0=
X-Received: by 2002:a1c:25c7:: with SMTP id l190-v6mr5169858wml.138.1530110369858;
 Wed, 27 Jun 2018 07:39:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4519:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 07:39:29
 -0700 (PDT)
X-Originating-IP: [67.169.71.69]
In-Reply-To: <87wouk92dm.fsf@bootlin.com>
References: <20180620043109.1190-1-ethan@ethantuttle.com> <87wouk92dm.fsf@bootlin.com>
From:   Ethan Tuttle <ethan@ethantuttle.com>
Date:   Wed, 27 Jun 2018 07:39:29 -0700
Message-ID: <CACzLR4s7v8sxkvVvv1H2KKJHazfgCBmhAeb2Upa5JRoxTqm5nw@mail.gmail.com>
Subject: Re: [PATCH] ARM: mvebu: declare asm symbols as character arrays in pmsu.c
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory.

On Tue, Jun 26, 2018 at 11:20 PM, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
> Hi Ethan,
>
>  On mar., juin 19 2018, Ethan Tuttle <ethan@ethantuttle.com> wrote:
>
>> With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
>> detect buffer overflows.  If src or dest is declared as a char, attempts to
>> copy more than byte will result in a fortify_panic().
>>
>> Address this problem in mvebu_setup_boot_addr_wa() by declaring
>> mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
>> a couple addressof operators to avoid "arithmetic on pointer to an
>> incomplete type" compiler error.
>>
>> See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
>> not single characters") for a similar fix.
>>
>> Fixes "detected buffer overflow in memcpy" error during init on some mvebu
>> systems (armada-370-xp, armada-375):
>>
>> (fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
>> (mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
>> (mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
>> (do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
>> (kernel_init_freeable) from (kernel_init+0x8/0x114)
>> (kernel_init) from (ret_from_fork+0x14/0x2c)
>>
>> Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
>> Tested-by: Ethan Tuttle <ethan@ethantuttle.com>
>
> Out of curiosity on which platform did you test it?

I found the problem on my Mirabox after a kernel upgrade, and verified the fix
on the Mirabox as well.

I just observed in the code that the panic should also happen on armada-375,
didn't do any testing there.

BTW, just realizing I did not test with CONFIG_FORTIFY_SOURCE off.  But
I imagine it will work.  Let me know if you think that requires testing.

> Applied on mvebu/arm

Excellent!  Thank you.

Ethan

>
> Thanks,
>
> Gregory
>
>
>
>> ---
>>  arch/arm/mach-mvebu/pmsu.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
>> index 27a78c80e5b1..73d5d72dfc3e 100644
>> --- a/arch/arm/mach-mvebu/pmsu.c
>> +++ b/arch/arm/mach-mvebu/pmsu.c
>> @@ -116,8 +116,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>>               PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
>>  }
>>
>> -extern unsigned char mvebu_boot_wa_start;
>> -extern unsigned char mvebu_boot_wa_end;
>> +extern unsigned char mvebu_boot_wa_start[];
>> +extern unsigned char mvebu_boot_wa_end[];
>>
>>  /*
>>   * This function sets up the boot address workaround needed for SMP
>> @@ -130,7 +130,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_target,
>>                            phys_addr_t resume_addr_reg)
>>  {
>>       void __iomem *sram_virt_base;
>> -     u32 code_len = &mvebu_boot_wa_end - &mvebu_boot_wa_start;
>> +     u32 code_len = mvebu_boot_wa_end - mvebu_boot_wa_start;
>>
>>       mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
>>       mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
>> --
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Gregory Clement, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> http://bootlin.com
