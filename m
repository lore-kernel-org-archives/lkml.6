Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C922AC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8FF20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VHfkPfSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8FF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeILGDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:03:39 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:27852 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbeILGDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:03:38 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8C11URj032350;
        Wed, 12 Sep 2018 10:01:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8C11URj032350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536714091;
        bh=QeR2jC6phsbZ9/XJLedlSyKoqInOa+fbx6qHHIKcQD0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VHfkPfSecVyxBrIPgN/YXgFKPn8I2TmleTc5K6JmUzCPuliH0Roc3dLuVTP8IgU9W
         T0YzueTLISyNzjNBlSutW2N2yBoqocXMMmql+xMamb6xzHdSt2HGMMv4OLOvh3JAtW
         AylL3+ctGVtU3xr3ZwhnD9u7NqPUIw7JWVeR7tHin2hQxvxi4Af44SyeiO9EvdxRuX
         81Z76OnCOEuYB+3bIKzFbEDF4ZIqo6uZxzTzW9QBLWoHBaZsnFp48wOSKmVv/pRBNp
         oTX1SLk/jV6EAVHcl45NE7ffeE0aTcZDuik7wLkaEtXoExPm7N6X1/Ij75tDTmL3u1
         D7nnEosa5toiA==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id c12-v6so219515uan.3;
        Tue, 11 Sep 2018 18:01:31 -0700 (PDT)
X-Gm-Message-State: APzg51DNw2rFQFbC4JQa+EeTM4UgclIEdFhfGp58l0HlrSzjr4+Teo3t
        3qQUJBtQyH15g5Hi44T1o5vHGOpGxNvtuk0jVKQ=
X-Google-Smtp-Source: ANB0VdZED+0Yg6z4iR9GdtGePE1mGIlRUNsQvEcDjpbMSkmZhswenYcTWSoxlNKvnuu30n/JnaUWpGCeBbjenmeGLCY=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr10050495uah.135.1536714090023;
 Tue, 11 Sep 2018 18:01:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 18:00:49
 -0700 (PDT)
In-Reply-To: <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Sep 2018 10:00:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
Message-ID: <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
>>
>> There is nothing arch specific about building dtb files other than their
>> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
>> The dependencies and supported targets are all slightly different.
>> Also, a cross-compiler for each arch is needed, but really the host
>> compiler preprocessor is perfectly fine for building dtbs. Move the
>> build rules to a common location and remove the arch specific ones. This
>> is done in a single step to avoid warnings about overriding rules.
>>
>> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
>> These pull in several dependencies some of which need a target compiler
>> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
>> All that is really needed is dtc, so adjust the dependencies to only be
>> dtc.
>>
>> This change enables support 'dtbs_install' on some arches which were
>> missing the target.
>
> [...]
>
>> @@ -1215,6 +1215,33 @@ kselftest-merge:
>>                 $(srctree)/tools/testing/selftests/*/config
>>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>>
>> +# ---------------------------------------------------------------------------
>> +# Devicetree files
>> +
>> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
>> +dtstree := arch/$(SRCARCH)/boot/dts
>> +endif
>> +
>> +ifdef CONFIG_OF_EARLY_FLATTREE
>
> This can be true when dtstree is unset. So this line should be this
> instead to fix the 0-day reported error:
>
> ifneq ($(dtstree),)
>
>> +
>> +%.dtb : scripts_dtc
>> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>> +
>> +PHONY += dtbs dtbs_install
>> +dtbs: scripts_dtc
>> +       $(Q)$(MAKE) $(build)=$(dtstree)
>> +
>> +dtbs_install: dtbs
>> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
>> +
>> +all: dtbs
>> +
>> +endif


Ah, right.
Even x86 can enable OF and OF_UNITTEST.



Another solution might be,
guard it by 'depends on ARCH_SUPPORTS_OF'.



This is actually what ACPI does.

menuconfig ACPI
        bool "ACPI (Advanced Configuration and Power Interface) Support"
        depends on ARCH_SUPPORTS_ACPI
         ...





-- 
Best Regards
Masahiro Yamada
