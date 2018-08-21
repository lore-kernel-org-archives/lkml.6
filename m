Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B13C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30E6214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUBHFbXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30E6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeHUQzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:55:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36855 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbeHUQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:55:05 -0400
Received: by mail-io0-f195.google.com with SMTP id m4-v6so15397294iop.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=owYj+wA6q6BW0VEPf/GnEXcBMz3KtF7dsCOFP2/Hm2Q=;
        b=QUBHFbXKSpna98TR9hyEoqh5MpJNdmKKNPyIF8K2fdKOxsjs8W7XuO16iAsVOs+ZF9
         nrFSfQ1Dommph53NdMVr8SmLeuj1GENc5QlPsPP3F7JJvee6KZEz/ZxtPKhMP+Ga8xfj
         oQ/XewBnmxhDz7AI9/S/MyXRHVAc2FxKKAg0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=owYj+wA6q6BW0VEPf/GnEXcBMz3KtF7dsCOFP2/Hm2Q=;
        b=UHXEBXYUZALI1O7UrwBCJIyhrPCbD3C6X7792fOWWWRutV5WYV7EPPr+qkQpaU9V4q
         2aqQA7X09RUR9mcmmWQ6Ad9Mp2nxnDaDpFRsdtOki+0p0xottnAV7HYB7lAi0L7uT5n/
         ARpbpuBIIb3N+dXBI2HLdi493ruwt7atfhKP2I557Xleh05Yvx6J934OkVeuPiySalnM
         3p2YmbFUf5ZQi+x/IhTaIGGU/qmjz6Q0rwdTPECSSyKKg/kOIgSYcoqywSd20Z0gvW7X
         hAjEgoEmku9NwfQxJxe6zuRTIG7iSgK15QHICDDiBtcDfwA1iJhY5UTPGISDV3NJFWYV
         aGkg==
X-Gm-Message-State: APzg51CW62Hk/TMUcGocT9aezPwmTBjxqGFtel24trqnXDUaul/X7grF
        edOfc6ZOdbDhKSbnkOSiAOgoPooJU/YPiShwsryYrA==
X-Google-Smtp-Source: ANB0VdafomU4+uWqfEh9uOa0VMb8LofdPexdN+g9TdWfeMWM09yxNvUqWxvHLPSvSQCPQooXX8t2vzyLGRoFaKJsUfs=
X-Received: by 2002:a6b:450f:: with SMTP id s15-v6mr6346041ioa.60.1534858494229;
 Tue, 21 Aug 2018 06:34:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 06:34:53
 -0700 (PDT)
In-Reply-To: <32f5ce9b26a386e81857afcd7d135bad@agner.ch>
References: <20180809164042.210675-1-astrachan@google.com> <32f5ce9b26a386e81857afcd7d135bad@agner.ch>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 Aug 2018 15:34:53 +0200
Message-ID: <CAKv+Gu_3ePOs=Ng-vjD4_LE5vF_wCXZ74c7anQ=6fnYvj-vQng@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: arm: support building with clang
To:     Stefan Agner <stefan@agner.ch>
Cc:     Alistair Strachan <astrachan@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 August 2018 at 10:49, Stefan Agner <stefan@agner.ch> wrote:
> On 09.08.2018 18:40, Alistair Strachan wrote:
>> When building with CONFIG_EFI and CONFIG_EFI_STUB on ARM, the libstub
>> Makefile would use -mno-single-pic-base without checking it was
>> supported by the compiler. As the ARM (32-bit) clang backend does not
>> support this flag, the build would fail.
>>
>> This changes the Makefile to check the compiler's support for
>> -mno-single-pic-base before using it, similar to c1c386681bd7 ("ARM:
>> 8767/1: add support for building ARM kernel with clang").
>
> Looks good to me:
>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
>


Thanks. I will queue this after the merge window closes

>>
>> Cc: Stefan Agner <stefan@agner.ch>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: linux-efi@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Alistair Strachan <astrachan@google.com>
>> ---
>>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/Makefile
>> b/drivers/firmware/efi/libstub/Makefile
>> index a34e9290a699..91339d13f2a1 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)                += -m$(BITS) -D__KERNEL__ -O2 \
>>
>>  cflags-$(CONFIG_ARM64)               := $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
>>  cflags-$(CONFIG_ARM)         := $(subst -pg,,$(KBUILD_CFLAGS)) \
>> -                                -fno-builtin -fpic -mno-single-pic-base
>> +                                -fno-builtin -fpic \
>> +                                $(call cc-option,-mno-single-pic-base)
>>
>>  cflags-$(CONFIG_EFI_ARMSTUB) += -I$(srctree)/scripts/dtc/libfdt
