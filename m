Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F3C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B64621653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Dp57EzJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B64621653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbeHNFO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:14:28 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:25277 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeHNFO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:14:28 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7E2T6f4016158
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 11:29:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7E2T6f4016158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534213747;
        bh=XD0xCrJagqP7YLdbWOWgS4FU/L6VI7PvNv0CL1Bj45Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Dp57EzJWQxAaefZqeKY++tTC3Jz9aH5szsQCCSsRyFFIM1RsatybxCXf6jTCYxcLh
         HOiaSE0CKT187JgksoXpRgdNCdy8OYKh0Z5w8iFv6qm8wxy9dNWDR2PGVFKb3yPxD8
         T7vsKNLPX05ky+zE5eB1dHz6im/IJIYTXAgfCLAu5GKlEAmZM0PH74HPZBxzl5DtMC
         V0BP5w7D/wx1EdK9ZBs6SR8JOSEFCBMmKd0nfFG/gQR5R9uWbMgJNwCfPMP8SnS3gH
         amm0bXF7wEDrlf5FkG8ftYyg87Bjrfz4QiKgoOXPMQO77BiEH/Z8uYvyKYj49k7E/i
         rSgAEiRVRxJPw==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id o11-v6so11516594uak.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 19:29:07 -0700 (PDT)
X-Gm-Message-State: AOUpUlGkCsOCj3NtsrID50SQwNRDmBOxuOZy1p+p8UGKlQy0RWz0xLoJ
        0NaCje7DunHfEYmZfSkNUcBuinf/crPvgQBlwzI=
X-Google-Smtp-Source: AA+uWPwz4NQ0Svg3bEOaqOcxATE7p+HgFmEb3JTNfT0IBAiVYYRlu54cJCW5lzlaqG3qvvtFS1+FfcnLyln3URt0UqA=
X-Received: by 2002:ab0:4705:: with SMTP id h5-v6mr13019764uac.140.1534213746198;
 Mon, 13 Aug 2018 19:29:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 19:28:25
 -0700 (PDT)
In-Reply-To: <7aac5c23415baa357197d11d5ef7cf2f@agner.ch>
References: <20180811094853.32167-1-stefan@agner.ch> <CAK7LNAQ2THEDLB8so3zahGykH_BWaWAU7Tg_2yGEPKo+ApsxHg@mail.gmail.com>
 <CAGXu5jKHbx-L+n+CCExshtW1uQqkRX6MS5SoEH068DzoB+oKEg@mail.gmail.com>
 <CAGXu5jJ_XZ0Rwve_JKsWtPpdVDed4jYT=Qrg-XkmQqMuJZQmgQ@mail.gmail.com> <7aac5c23415baa357197d11d5ef7cf2f@agner.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 14 Aug 2018 11:28:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQiy2QDMSm6+XDPVrxk4DmrcHB1Sc-9bXYiWb8srvzzgQ@mail.gmail.com>
Message-ID: <CAK7LNAQiy2QDMSm6+XDPVrxk4DmrcHB1Sc-9bXYiWb8srvzzgQ@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: require GCC
To:     Stefan Agner <stefan@agner.ch>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <jbacik@fb.com>, Emese Revfy <re.emese@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-14 6:29 GMT+09:00 Stefan Agner <stefan@agner.ch>:
> On 13.08.2018 22:18, Kees Cook wrote:
>> On Mon, Aug 13, 2018 at 1:10 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Mon, Aug 13, 2018 at 12:38 AM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2018-08-11 18:48 GMT+09:00 Stefan Agner <stefan@agner.ch>:
>>>>> Unsurprisingly GCC plugins require GCC as a compiler. This avoids
>>>>> GCC plugins being selectable when using clang.
>>>>>
>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>> ---
>>>>>  arch/Kconfig | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>>> index 1aa59063f1fd..8c693a837ed7 100644
>>>>> --- a/arch/Kconfig
>>>>> +++ b/arch/Kconfig
>>>>> @@ -422,7 +422,7 @@ config HAVE_GCC_PLUGINS
>>>>>
>>>>>  menuconfig GCC_PLUGINS
>>>>>         bool "GCC plugins"
>>>>> -       depends on HAVE_GCC_PLUGINS
>>>>> +       depends on HAVE_GCC_PLUGINS && CC_IS_GCC
>>>>>         depends on PLUGIN_HOSTCC != ""
>>>>>         help
>>>>>           GCC plugins are loadable modules that provide extra features to the
>>>>> --
>>>>> 2.18.0
>>>>>
>>>>
>>>> I guess the more correct way is to fix
>>>> scripts/gcc-plugin.sh
>>>>
>>>> This shell script should exit 0
>>>> only when GCC plugin is supported.
>>>
>>> I'm of two minds: we already have the gcc test in Kconfig so we might
>>> want to avoid redundant checks, but maybe the script should be a
>>> "complete" test. I guess the latter. I will send a patch.
>>
>> Actually, how about we do the test in Kconfig, but ahead of the
>> script? That will reduce redundancy:
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 1aa59063f1fd..18f518624e41 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -409,7 +409,7 @@ preferred-plugin-hostcc := $(if-success,[
>> $(gcc-version) -ge 40800 ],$(HOSTCXX),
>>
>>  config PLUGIN_HOSTCC
>>         string
>> -       default "$(shell,$(srctree)/scripts/gcc-plugin.sh
>> "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")"
>> +       default "$(shell,$(srctree)/scripts/gcc-plugin.sh
>> "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")" if CC_IS_GCC
>>         help
>>           Host compiler used to build GCC plugins.  This can be $(HOSTCXX),
>>           $(HOSTCC), or a null string if GCC plugin is unsupported.
>
> I like this better. A script which is called gcc-plugin.sh should only
> be called if gcc is used...
>

This does not work like that.

$(shell,$(srctree)/scripts/gcc-plugin.sh "$(preferred-plugin-hostcc)"
"$(HOSTCXX)" "$(CC)")

is expanded in the parse stage regardless of CC_IS_GCC.




If nobody comes up with a better way, I am fine with this.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




> --
> Stefan
>
>>
>>
>> -Kees



-- 
Best Regards
Masahiro Yamada
